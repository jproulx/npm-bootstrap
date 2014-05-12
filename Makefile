all: clean install test

clean:
	-rm -fr node_modules

install:
	npm install

.PHONY : test

test-cov:
	@$(MAKE) lint
	@NODE_ENV=test ./node_modules/.bin/mocha -u tdd \
		--require blanket \
		--reporter travis-cov

lint:
	./node_modules/.bin/jshint ./error.js

test:
	@$(MAKE) lint
	@NODE_ENV=test ./node_modules/.bin/mocha -u tdd \
		--require blanket
		--reporter spec

test-coveralls:
	@NODE_ENV=test YOURPACKAGE_COVERAGE=1 ./node_modules/.bin/mocha -u tdd \
		--require blanket \
		--reporter mocha-lcov-reporter \
	| ./node_modules/coveralls/bin/coveralls.js

test-all: test test-cov test-coveralls
