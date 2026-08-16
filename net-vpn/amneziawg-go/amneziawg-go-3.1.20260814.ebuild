# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/1b86b2ae0e493e7ea93f8c1a0f0cb6735b1551f1 -> amneziawg-go-3.1.20260814-1b86b2a.tar.gz
https://direct.funtoo.org/fb/95/37/fb95373bb347a819c892a3ac8aa8b04eb4288f04f49d34f4dd35fb0d088235d218972689d80a550619cecf02e60d7200812719bbe79a26a4938253706ff6eec7 -> amneziawg-go-3.1.20260814-funtoo-go-bundle-87d2e780d7a1f43637dfd35dafae8c628d374d60575af8e0d2356b8792a94022fac4e2bc41fc143c261b8759e27a386fd559dc00fd1b4d6c25e4d167a3c28ad6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}