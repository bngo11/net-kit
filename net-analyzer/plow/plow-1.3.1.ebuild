# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
)

go-module_set_globals

DESCRIPTION="HTTP(S) benchmarking tool, written in Golang"
HOMEPAGE="https://github.com/six-ddc/plow"
SRC_URI="https://github.com/six-ddc/plow/tarball/343b7510ccfa477d9c0f3d9aeeaa0834e118c44a -> plow-1.3.1-343b751.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv ${WORKDIR}/six-ddc-plow-* ${S} || die
}

src_compile() {
	go build -mod=mod . || die "compile failed"
}

src_install() {
	dobin ${PN}
	dodoc README.md
}