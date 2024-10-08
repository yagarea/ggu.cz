SHELL=/usr/bin/env sh

.PHONY: run

run:
	bundle exec jekyll serve --trace

deploy: build upload

build:
	bundle exec jekyll clean --trace
	bundle exec jekyll build --trace
	tree _site -C -d | sed 's/^/                    /'

install:
	bundle config set --local path '.vendor/bundle'
	bundle install

upload: build
	echo Start upload
	rsync -varhIu -e "ssh -p 222" --progress --delete _site/ ggu:/userdata/groups/uzu8/Web/Homepage

