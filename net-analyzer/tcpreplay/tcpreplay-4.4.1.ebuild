# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="utilities for editing and replaying previously captured network traffic"
HOMEPAGE="http://tcpreplay.appneta.com/ https://github.com/appneta/tcpreplay"
LICENSE="BSD GPL-3"
SRC_URI="https://github.com/appneta/tcpreplay/releases/download/v4.4.1/tcpreplay-4.4.1.tar.xz -> tcpreplay-4.4.1.tar.xz"

SLOT="0"
KEYWORDS="*"
IUSE="debug pcapnav +tcpdump"

DEPEND="
	>=sys-devel/autogen-5.18.4[libopts]
	dev-libs/libdnet
	>=net-libs/libpcap-0.9
	tcpdump? ( net-analyzer/tcpdump )
	pcapnav? ( net-libs/libpcapnav )
"
RDEPEND="${DEPEND}"

DOCS=(
	docs/{CHANGELOG,CREDIT,HACKING,TODO}
)
PATCHES=(
	"${FILESDIR}"/${PN}-4.3.0-enable-pcap_findalldevs.patch
)

S=${WORKDIR}/${P/_/-}

src_prepare() {
	default

	sed -i \
		-e 's|#include <dnet.h>|#include <dnet/eth.h>|g' \
		src/common/sendpacket.c || die
	sed -i \
		-e 's|@\([A-Z_]*\)@|$(\1)|g' \
		-e '/tcpliveplay_CFLAGS/s|$| $(LDNETINC)|g' \
		-e '/tcpliveplay_LDADD/s|$| $(LDNETLIB)|g' \
		src/Makefile.am || die

	eautoreconf
}

src_configure() {
	# By default it uses static linking. Avoid that, bug 252940
	econf \
		$(use_enable debug) \
		$(use_with pcapnav pcapnav-config /usr/bin/pcapnav-config) \
		$(use_with tcpdump tcpdump /usr/sbin/tcpdump) \
		--enable-dynamic-link \
		--enable-local-libopts \
		--enable-shared \
		--with-libdnet \
		--with-testnic2=lo \
		--with-testnic=lo
}

src_test() {
	if [[ ! ${EUID} -eq 0 ]]; then
		ewarn "Some tests were disabled due to FEATURES=userpriv"
		ewarn "To run all tests issue the following command as root:"
		ewarn " # make -C ${S}/test"
		emake -j1 -C test tcpprep
	else
		emake -j1 test || {
			ewarn "Note that some tests require eth0 iface to be up." ;
			die "self test failed - see ${S}/test/test.log" ; }
	fi
}