# frozen_string_literal: true
# Source: https://github.com/syldexiahime/jekyll-webring

require 'feedjira'
require 'httparty'
require 'sanitize'
require 'yaml'
require 'fileutils'

module JekyllWebring
	TEMPLATE = <<~HTML
		<section class="webring">
			<h3>Articles from blogs I follow around the net</h3>
			<section class="articles">
				{% for item in webring %}
				<div class="article">
					<h4 class="title">
						<a href="{{ item.url }}" target="_blank" rel="noopener">{{ item.title }}</a>
					</h4>
					<p class="summary">{{ item.summary }}</p>
					<small class="source">
						via <a href="{{ item.source_url }}">{{ item.source_title }}</a>
					</small>
					<small class="date">{{ item.date }}</small>
				</div>
				{% endfor %}
			</section>
		</section>
	HTML

	def self.set_config (context)
 		jekyll_config = context.registers[:site].config
		config = jekyll_config['webring'] || {}

		@config ||= {
			'feeds'                     => config['feeds'] || [],
			'layout_file'               => config['layout_file'] ? "#{ jekyll_config['layouts_dir'] }/#{ config['layout_file'] }.html" : '',
			'data_file'                 => config['data_file']   ? "#{ jekyll_config['data_dir'] }/#{ config['data_file'] }.yml" : '',
			'date_format'               => jekyll_config['date_format'] || config['date_format'] || "%-d %B, %Y",
			'max_summary_length'        => config['max_summary_length'] || 256,
			'no_item_at_date_behaviour' => config['no_item_at_date_behaviour'],
			'num_items'                 => config['num_items'] || 3,
		}
	end

	def self.config ()
		@config
	end

	@feeds = [];
	def self.feeds ()
		urls = config['feeds']

		if urls.empty?
			return [];
		end

		if @feeds.empty?
			Jekyll.logger.info("Webring:", "fetching rss feeds")

			urls.each do |url|
				Jekyll.logger.debug("Webring:",
					"fetching feed at #{ url }")

				feed = []

				begin
					xml = HTTParty.get(url).body
				rescue
					Jekyll.logger.error("Webring:",
						"unable to fetch feed at #{ url }")
					next
				end

				begin
					raw_feed = Feedjira.parse(xml)
				rescue
					Jekyll.logger.error("Webring:",
						"unable to parse feed fetched from #{ url }")
					next
				end

				raw_feed.entries.each do |item|
					sanitized = Sanitize.fragment(
						item.content || item.summary)

					summary = sanitized.length > config['max_summary_length'] ?
						"#{ sanitized[0 ... config['max_summary_length']] }..." : sanitized

					feed_item = {
						'source_title' => raw_feed.title,
						'source_url'   => raw_feed.url,
						'title'        => item.title,
						'url'          => item.url,
						'_date'        => item.published,
						'summary'      => summary,
					}

					feed << feed_item
				end
                feed.sort_by! { |item| item['_date'] }.reverse!
				@feeds << feed
			end
		end

		@feeds
	end

	@data = nil
	def self.get_data (site)
		unless @data
			@data = site.data['webring'] || {}
		end

		@data
	end
end

module Jekyll
	class WebringTag < Liquid::Tag
		def initialize (tag_name, text, tokens)
			super
			@text = text
		end

		def get_value (context, expression)
			result = nil

			unless expression.empty?
				lookup_path = expression.split('.')
				result = context
				lookup_path.each do |variable|
					result = result[variable] if result
				end
			end

			result
		end

		def get_items_from_feeds (param)
			items = []

			feeds = JekyllWebring.feeds
			case param
				when 'random'
					feeds.each do |feed_items|
						items << feed_items.sample
					end
				when Time, '', nil
					date = param || Time.now
					feeds.each do |feed_items|
						item_to_add = nil

						feed_items.each do |item|
							if item['_date'] < date
								item_to_add = item
								break
							end
						end

						if item_to_add
							items << item_to_add
							next
						end

						case JekyllWebring::config['no_item_at_date_behaviour']
							when 'use_oldest'
								items << feed_items.last
							when 'use_latest'
								items << feed_items.first
							when 'random'
								items << feed_items.sample
							when 'ignore', ''
								next
						end
					end
			end

			items = items.sort_by { |item| item['_date'] }

			items
		end

		def render (context)
			JekyllWebring::set_config(context)

			site = context.registers[:site]
			param = get_value(context, @text.strip)

			webring_data = JekyllWebring.get_data(site)

			if webring_data[param]
				items = webring_data[param]
			else
				items = get_items_from_feeds(param)
				webring_data[param] = items if param

				if JekyllWebring::config['data_file']
					filename = JekyllWebring::config['data_file']
					dirname = File.dirname filename
					unless File.directory? dirname
						FileUtils.mkdir_p dirname
					end

					File.open(filename, 'w') do |file|
						file.write(webring_data.to_yaml)
					end
				end
			end

			liquid_opts = site.config['liquid']

			content = JekyllWebring::TEMPLATE
			payload = context

			# stuff beyond this point mainly hacked together from jekyll internals
			filename = JekyllWebring::config['layout_file']
			if File.file? filename
				begin
					content = File.read filename
					if content =~ Document::YAML_FRONT_MATTER_REGEXP
						content = $POSTMATCH
						payload = payload.merge SafeYAML.load(Regexp.last_match(1))
					end
				rescue Psych::SyntaxError => e
					Jekyll.logger.warn "YAML Exception reading #{filename}: #{e.message}"
					raise e if site.config["strict_front_matter"]
				rescue StandardError => e
					Jekyll.logger.warn "Error reading file #{filename}: #{e.message}"
					raise e if site.config["strict_front_matter"]
				end
			end

			template = site.liquid_renderer.file((File.file? filename) ? filename : '').parse(content)

			info = {
				:registers        => { :site => site, :page => context['page'] },
				:strict_filters   => liquid_opts['strict_filters'],
				:strict_variables => liquid_opts['strict_variables'],
			}

			webring_items = items.take(JekyllWebring::config['num_items'])
			webring_items.each { |item| item['date'] = item['_date'].strftime(JekyllWebring::config['date_format']) }

			payload['webring'] = webring_items

			template.render!(payload, info)
		end
	end
end

Liquid::Template.register_tag('webring', Jekyll::WebringTag)
