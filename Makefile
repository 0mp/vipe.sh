PREFIX=		/usr/local
MANPREFIX=	${PREFIX}

VIPE_SH_CMD=	vipe.sh
VIPE_SH_MAN=	vipe.sh.1

.PHONY: install
install:
	mkdir -p -- "${DESTDIR}${PREFIX}/bin/"
	install -m 755 "${VIPE_SH_CMD}" "${DESTDIR}${PREFIX}/bin/"
	mkdir -p -- "${DESTDIR}${MANPREFIX}/man/man1"
	install -m 444 "${VIPE_SH_MAN}" "${DESTDIR}${MANPREFIX}/man/man1"

.PHONY: regenerate-readme
regenerate-readme:
	mandoc -Tmarkdown "${VIPE_SH_MAN}" | awk 'NR > 2 {print}' \
		| sed '$$d' | sed '$$d' > README.md
