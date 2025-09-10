# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/f32329577fd5e3fe19908f8a9ba5c76aafb45bf6 -> coredns-1.12.4-f323295.tar.gz
https://direct.funtoo.org/7f/2a/05/7f2a052c476730e95265fbf2d5eb1a45a79ef63c56e9776574935dfbf5757b40bc383a3bd9a5a21733b925107316a28cc93819046a67ac31c42800605e17ebb2 -> coredns-1.12.4-funtoo-go-bundle-f492a95718a7bc9547fedc988501489fdaa8af556823f7e9dc9f16332c6ac895eb5f68299191b7afa6bff7b4874217a1e3c3c799db8d5885fe3135f8522ae0b4.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-f323295"

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