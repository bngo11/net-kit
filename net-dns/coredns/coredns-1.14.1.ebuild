# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/80527fd389841310a728cf862491129321c8a112 -> coredns-1.14.1-80527fd.tar.gz
https://direct.funtoo.org/46/0a/91/460a912e84bbcbe8cbaa6c5be5d67f563dca5d8c177c5b4cd3672f038593cb81b4f374ffc0a15c0667ab57eebac525c686dd8681f819de9c6860b0402af5d7c9 -> coredns-1.14.1-funtoo-go-bundle-ce1a6d5202eb0af324208a05d1cd384a4c13e06d3410760cb28f28f014c1247f02a24045a85fb584f8a795007f7650106c3793f586b881e308e08710ea59ed5b.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-80527fd"

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