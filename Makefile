.PHONY: test

# HELP sourced from https://gist.github.com/prwhite/8168133

# Add help text after each target name starting with '\#\#'
# A category can be added with @category

HELP_FUNC = \
    %help; \
    while(<>) { \
        if(/^([a-z0-9_-]+):.*\#\#(?:@(\w+))?\s(.*)$$/) { \
            push(@{$$help{$$2}}, [$$1, $$3]); \
        } \
    }; \
    print "usage: make [target]\n\n"; \
    for ( sort keys %help ) { \
        print "$$_:\n"; \
        printf("  %-30s %s\n", $$_->[0], $$_->[1]) for @{$$help{$$_}}; \
        print "\n"; \
    }

help:           ##@miscellaneous Show this help.
	@perl -e '$(HELP_FUNC)' $(MAKEFILE_LIST)

run:	##@dev run your application
	clj -m cljboot.core

test:	##@dev run tests
	@clj -A\:test

clean:	##@dev clean project
	rm -rf target

uberjar: ##@dev package your app as a jar
	clj -A\:uberjar

run-uberjar: uberjar ##@dev package your app and run it
	java -jar target/cljboot.jar -m cljboot.core

nrepl:	##@dev run an nrepl server
	clj -R:nrepl:cider bin/nrepl.clj
