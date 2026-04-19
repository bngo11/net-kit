# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/12a012205e3c444be02aba91a840455f74c127e1 -> amneziawg-go-0.2.17-12a0122.tar.gz
https://direct.funtoo.org/66/c4/df/66c4dffb21ed3bd2813190925cc466c8f30d3fea778ec94309a1a3fc2fd405b7eef48ade7ff6e648a792b66452e0d59545b21ab5d3291d162e622f5bfa3d5de9 -> amneziawg-go-0.2.17-funtoo-go-bundle-99c1d5c1c21d33e7cef36a4c81f738d58234a139bfc266761f377e000ee7fda6d9280e59329edd1d1d9d73ed33d4f2b28bf910bbdf2a4af06436e2dfc9ea0c92.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}