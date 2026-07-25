# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/9f5d948bc72cc554791cfe0fb91527e4acfb6b79 -> amneziawg-go-3.0.1-9f5d948.tar.gz
https://direct.funtoo.org/17/61/51/176151f8d8744e628e558ad7ab24a6c18c49dddc66fb5cc86d0d9a1a14eaaa01917eeb5f5c13eba630d63815261335360fcb17b31107370e1e94a24535abdd1c -> amneziawg-go-3.0.1-funtoo-go-bundle-87d2e780d7a1f43637dfd35dafae8c628d374d60575af8e0d2356b8792a94022fac4e2bc41fc143c261b8759e27a386fd559dc00fd1b4d6c25e4d167a3c28ad6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}