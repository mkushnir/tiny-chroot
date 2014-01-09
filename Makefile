prefix= tiny-chroot
version= 0.1
pkgrev= 1
name= ${prefix}-${version}
OS!= uname -s

all:
	if test "${OS}" = "FreeBSD"; \
	then \
	    package_name=${name}.txz; \
	    echo "Creating ${name} ..."; \
	    rm -Rf ${name} && mkdir -p ${name}; \
	    rm -Rf work && mkdir work; \
	    install -d ${name}/usr/local/bin/; \
	    install -d ${name}/usr/local/man/; \
	    install bin/setup-chroot ${name}/usr/local/bin/; \
	    install bin/cleanup-chroot ${name}/usr/local/bin/; \
	    install man/tiny-chroot.1 ${name}/usr/local/man/; \
	    cp +MANIFEST.pre ${name}/+MANIFEST; \
	    pkg create -r ${name}/ -o work -m ${name}; \
	    sha256 work/$${package_name} > port/distinfo; \
	    echo "SIZE ($${package_name}) = `cksum work/$${package_name} | awk '{print $$2;}'`" >> port/distinfo; \
	else \
	    echo "Platform ${OS} is not supported"; \
	    exit 1; \
	fi;

clean:
	if test "${OS}" = "FreeBSD"; \
	then \
	    package_name=${name}.txz; \
	else \
	    echo "Platform ${OS} is not supported"; \
	    exit 1; \
	fi; \
	rm -Rf ${name} work;

