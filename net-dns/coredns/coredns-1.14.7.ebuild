# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/427fc80ed9ca47f354585eb30a3f1332950856c4 -> coredns-1.14.7-427fc80.tar.gz
https://direct.funtoo.org/2c/c0/db/2cc0dba12aa38038d0182277f0e06d1b79321650ee7492420f55c918c4c53f618c2177900cdb6a232844adc7322950175cf4f68e0c063bfd8c863b83ea14c212 -> coredns-1.14.7-funtoo-go-bundle-750d0b43e1ad11d6979cec0d0ed93d1f56f31979c2b11a62d340d7d49534d6ee104e5975036c7b1a1782e2b8fb9134b80f859d63e659113035da18b1aa0abd9f.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-427fc80"

src_compile() {
	FORCE_HOST_GO=yes
	emake
}

src_install() {
	dobin ${PN}
	insinto /etc/"${PN}"
	doins "${FILESDIR}"/Corefile
	dodoc README.md
	doman man/*

	newinitd "${FILESDIR}"/"${PN}".initd ${PN}
	newconfd "${FILESDIR}"/"${PN}".confd ${PN}
	keepdir /var/log/"${PN}"
}