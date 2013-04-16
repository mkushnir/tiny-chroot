# $FreeBSD$
PORTNAME=	tiny-chroot
PORTVERSION=	0.1
CATEGORIES=	misc
MASTER_SITES=	http://localhost:8000/distfiles/
#MASTER_SITES=	https://raw.github.com/mkushnir/distfiles/master/
EXTRACT_SUFX=	.tgz
NO_WRKSUBDIR=	yes

MAINTAINER=	markiyan.kushnir@gmail.com
COMMENT=	A tool to amke lightweight chroot environments

MAN1=		tiny-chroot.1
MANCOMPRESSED=	no

do-build:
	@echo "Nothing to build"

do-install:
	@install -d ${LOCALBASE}/bin
	@install -d ${MANPREFIX}/man
	@install ${WRKDIR}/bin/setup-chroot ${LOCALBASE}/bin
	@install ${WRKDIR}/bin/cleanup-chroot ${LOCALBASE}/bin
	@${INSTALL_MAN} ${WRKDIR}/man/tiny-chroot.1 ${MANPREFIX}/man/man1

.include <bsd.port.options.mk>

.include <bsd.port.mk>
