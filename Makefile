all: pkg

pkg: pkg.sh
	s2s -o pkg pkg.sh

install:
	cp pkg /usr/local/bin/

clean:
	rm -f pkg
