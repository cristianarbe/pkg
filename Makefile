all: pkg

pkg: pkg.sh
	cat pkg.sh > pkg
	chmod a+x pkg

install:
	mv pkg /usr/local/bin/

clean:
	rm -f pkg
