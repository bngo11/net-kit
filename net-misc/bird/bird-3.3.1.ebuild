# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A routing daemon implementing OSPF, RIPv2 & BGP for IPv4 & IPv6"
HOMEPAGE="http://bird.network.cz"
SRC_URI="https://gitlab.nic.cz/labs/bird/-/archive/v3.3.1/bird-v3.3.1.tar.gz -> bird-3.3.1.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="*"
IUSE="+client debug"
S="${WORKDIR}/${PN}-v${PV}"

RDEPEND="client? ( sys-libs/ncurses )
	client? ( sys-libs/readline )"
DEPEND="sys-devel/flex
	sys-devel/bison
	sys-devel/m4"

src_configure() {
	autoconf \
		--localstatedir="${EPREFIX}/var" \
		$(use_enable client) \
		$(use_enable debug)
}

src_install() {
	if use client; then
		dobin birdc
	fi
	dobin birdcl
	dosbin bird
	newinitd "${FILESDIR}/initd-${PN}-2" bird
	dodoc doc/bird.conf.example
}
