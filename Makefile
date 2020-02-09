all: pkg

pkg: pkg.sh
	cat pkg.sh > pkg
	chmod a+x pkg

install:
	cp pkg /usr/local/bin/

clean:
	rm -f pkg
