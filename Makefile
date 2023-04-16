build:
	swift build

update:
	swift package update

release:
	swift build -c release
	
test:
	swift test --parallel

clean:
	rm -rf .build
	
install: release
	@install ./.build/release/feather /usr/local/bin/feather && \
	install ./.build/release/feather-test /usr/local/bin/feather-test

uninstall:
	@rm /usr/local/bin/feather && \
	rm /usr/local/bin/feather-test
