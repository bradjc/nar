LS = ./node_modules/.bin/lsc
LS_MODULE = ./node_modules/LiveScript/
MOCHA = ./node_modules/.bin/mocha

default: all
all: test
test: compile mocha

mkdir:
	mkdir -p lib/commands

clean:
	rm -rf lib

compile: clean mkdir
	cat src/nar.ls | $(LS) -c -s -b > ./lib/nar.js
	cat src/cli.ls | $(LS) -c -s -b > ./lib/cli.js
	cat src/extract.ls | $(LS) -c -s -b > ./lib/extract.js
	cat src/pack.ls | $(LS) -c -s -b > ./lib/pack.js
	cat src/unpack.ls | $(LS) -c -s -b > ./lib/unpack.js
	cat src/list.ls | $(LS) -c -s -b > ./lib/list.js
	cat src/utils.ls | $(LS) -c -s -b > ./lib/utils.js
	cat src/create.ls | $(LS) -c -s -b > ./lib/create.js
	cat src/create-exec.ls | $(LS) -c -s -b > ./lib/create-exec.js
	cat src/run.ls | $(LS) -c -s -b > ./lib/run.js
	cat src/download.ls | $(LS) -c -s -b > ./lib/download.js
	cat src/install.ls | $(LS) -c -s -b > ./lib/install.js
	cat src/status.ls | $(LS) -c -s -b > ./lib/status.js
	cat src/commands/create.ls | $(LS) -c -s -b > ./lib/commands/create.js
	cat src/commands/extract.ls | $(LS) -c -s -b > ./lib/commands/extract.js
	cat src/commands/run.ls | $(LS) -c -s -b > ./lib/commands/run.js
	cat src/commands/list.ls | $(LS) -c -s -b > ./lib/commands/list.js
	cat src/commands/install.ls | $(LS) -c -s -b > ./lib/commands/install.js
	cat src/commands/get.ls | $(LS) -c -s -b > ./lib/commands/get.js
	cat src/commands/common.ls | $(LS) -c -s -b > ./lib/commands/common.js

mocha:
	cat test/lib/helper.ls | $(LS) -c -s -b > ./test/lib/helper.js
	$(MOCHA) --bail --timeout 50000 --bail --reporter spec --ui tdd --compilers ls:$(LS_MODULE)

publish: test
	git push --tags origin HEAD:master
	npm publish

loc:
	wc -l src/*
