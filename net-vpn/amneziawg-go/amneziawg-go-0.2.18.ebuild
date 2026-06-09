# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/f4f4c999267437c3eb909e8d0e5278fb4596d9a7 -> amneziawg-go-0.2.18-f4f4c99.tar.gz
https://direct.funtoo.org/03/72/00/0372008ab6c86c8e94a1f4136196e6a06353adf00fbb4827a5412b5a656e9b76c20caac18db003d675da0caed493ec8369038edb984b28ed22bc5df271dbcdb3 -> amneziawg-go-0.2.18-funtoo-go-bundle-99c1d5c1c21d33e7cef36a4c81f738d58234a139bfc266761f377e000ee7fda6d9280e59329edd1d1d9d73ed33d4f2b28bf910bbdf2a4af06436e2dfc9ea0c92.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}