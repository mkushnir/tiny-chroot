prefix= tiny-chroot
version= 0.1
pkgrev= 1
name= ${prefix}-${version}
OS!= uname -s

all:
	if test "${OS}" = "FreeBSD"; \
	then \
	    package_name=${name}.tgz; \
	    echo "Creating ${name} ..."; \
	    rm -Rf ${name} && mkdir -p ${name}; \
	    install -d ${name}/bin/; \
	    install -d ${name}/man/; \
	    install bin/setup-chroot-freebsd ${name}/bin/setup-chroot; \
	    install bin/cleanup-chroot-freebsd ${name}/bin/cleanup-chroot; \
	    install man/tiny-chroot.1 ${name}/man/; \
	    pkg_create -c pkg-descr.pre -d pkg-descr.pre -s `pwd` -f pkg-plist.pre $${package_name}; \
	    sha256 $${package_name} > port/distinfo; \
	    echo "SIZE ($${package_name}) = `cksum $${package_name} | awk '{print $$2;}'`" >> port/distinfo; \
	else \
	    echo "Platform ${OS} is not supported"; \
	    exit 1; \
	fi;

clean:
	if test "${OS}" = "FreeBSD"; \
	then \
	    package_name=${name}.tgz; \
	else \
	    echo "Platform ${OS} is not supported"; \
	    exit 1; \
	fi; \
	rm -Rf ${name} $${package_name};

