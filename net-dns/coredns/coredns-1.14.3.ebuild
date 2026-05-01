# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/17fceec6d93fd1dde5ba6888c363f131ff6d647f -> coredns-1.14.3-17fceec.tar.gz
https://direct.funtoo.org/1e/e9/29/1ee929d8303a5485e376756df57699d9f43b32c7196a1047a6d08c6b361215bcca7cbd5c62ad6f401ced572681f2683be03a3b43b2c79d96478ea0ce871a22f7 -> coredns-1.14.3-funtoo-go-bundle-55c16da0ab96be15a278a19b8868c794ee7ccf38664deaf85335d0842e2f1967737fae1f372d083b95b825318b87d59fedd6c156527ef6ce3fed8c1e4c1f3395.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-17fceec"

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