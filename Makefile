.PHONY: qa lint cs csf phpstan tests coverage

vendor: composer.json composer.lock
	composer install

qa: tests lint phpstan cs

lint: vendor
	vendor/bin/linter src Tests

cs: vendor
	vendor/bin/codesniffer src Tests

csf: vendor
	vendor/bin/codefixer --standard=ruleset.xml src Tests

phpstan: vendor
	vendor/bin/phpstan analyse -l 2 -c phpstan.neon src --memory-limit=-1

tests: vendor
	./vendor/bin/phpunit

coverage: tests
	php ./vendor/bin/php-coveralls --config ./Tests/.coveralls.yml  --verbose
