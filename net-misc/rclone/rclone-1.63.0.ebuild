# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit bash-completion-r1 go-module

EGO_SUM=(
)

go-module_set_globals

KEYWORDS="*"
SRC_URI="https://github.com/rclone/rclone/tarball/e90537b2e93d194848560b83e2c5164641a02595 -> rclone-1.63.0-e90537b.tar.gz"

DESCRIPTION="A program to sync files to and from various cloud storage providers"
HOMEPAGE="https://rclone.org/"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT"
SLOT="0"
IUSE="+mount"

post_src_unpack() {
	mv ${WORKDIR}/rclone-* "${S}" || die
}

src_compile() {
	go build -mod=mod . || die "compile failed"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc README.md

	./rclone genautocomplete bash ${PN}.bash || die
	newbashcomp ${PN}.bash ${PN}

	./rclone genautocomplete zsh ${PN}.zsh || die
	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}

	use mount && insinto /usr/bin && \
		doins ${FILESDIR}/rclonefs && \
		fperms +x /usr/bin/rclonefs
}