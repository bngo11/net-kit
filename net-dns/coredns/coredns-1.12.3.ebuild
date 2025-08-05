# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

go-module_set_globals

DESCRIPTION="CoreDNS is a DNS server that chains plugins"
HOMEPAGE="https://coredns.io/ https://github.com/coredns/coredns"
SRC_URI="https://github.com/coredns/coredns/tarball/463fd1c1b390ef68f638e2f4e09837721b19efba -> coredns-1.12.3-463fd1c.tar.gz
https://direct.funtoo.org/b9/67/f5/b967f59764e5d877d34cee904c8938a5d0f38fd975ec2c306127ccc47b59b670e2144fe13fb1a5c4694f97209e3f255f4cbfc5fe1e3581ef9fb8a7c15b63b3ba -> coredns-1.12.3-funtoo-go-bundle-6eb082408d3f08c5f613cab4e9d8ce9e8c9ee02c9ef9f5cd7992dd14c21a31de07b409d380e30a9ec29c14701e3c323c172d25db7f97272bb9a76193521496c7.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.21"
S="${WORKDIR}/coredns-coredns-463fd1c"

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