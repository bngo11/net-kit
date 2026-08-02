# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/cf9d2dd202821301f7039093b0a1b3d4b574c47c -> amneziawg-go-3.0.3-cf9d2dd.tar.gz
https://direct.funtoo.org/8f/a1/79/8fa17917783490fe0e5e2a3e236b79ab0831ed530a360cefc99e00b4be5ddd34259dd55189cfdc2c98ed1cf219ecf0a810f79e303c1c769230cd1541a5db6c19 -> amneziawg-go-3.0.3-funtoo-go-bundle-87d2e780d7a1f43637dfd35dafae8c628d374d60575af8e0d2356b8792a94022fac4e2bc41fc143c261b8759e27a386fd559dc00fd1b4d6c25e4d167a3c28ad6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}