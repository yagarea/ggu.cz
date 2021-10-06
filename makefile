SHELL=/usr/bin/sh

.PHONY: deploy

deploy: build upload

build:
	bundle exec jekyll clean --trace
	bundle exec jekyll build --trace
	tree _site -C -d | sed 's/^/                    /'

upload:
	echo Start upload
	rsync -varhIu -e "ssh -p 222" --progress --delete _site/ ggu.cz:/userdata/groups/uzu8/Homepage/
