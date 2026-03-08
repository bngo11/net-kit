# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/dd1df4f5db93767a44e37638df44969503b320d2 -> coredns-1.14.2-dd1df4f.tar.gz
https://direct.funtoo.org/67/46/84/6746842d5a504cfb5139f9af1a81286f4aba7fcf015871386c4749f24d39160eb3bf2530b48a827cac1cd2e74363aeb7a2daa76335410bf467b57a1083fb4e23 -> coredns-1.14.2-funtoo-go-bundle-4cafd1e74e4be3a6f21c15d26acc2ef3e804b9172400d2c2c32bb3a3f60553c0fc5ac83f763225192f50ad72c09b458f7140c8a4b5687afcf7d0a51f01d9c875.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-dd1df4f"

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