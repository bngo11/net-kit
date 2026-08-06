# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/tarball/08d68cdae27762c3e07f36bbb12d2bad32f81926 -> amneziawg-go-3.0.20260805-08d68cd.tar.gz
https://direct.funtoo.org/dd/94/d3/dd94d31ac4c5f2b18cb8411e9192a315d1e6edcca33b821054e1ffc4dd517c8d036da05f3ba21f8366ce886898f25912adfb4349095d50dfffc32591080b3494 -> amneziawg-go-3.0.20260805-funtoo-go-bundle-87d2e780d7a1f43637dfd35dafae8c628d374d60575af8e0d2356b8792a94022fac4e2bc41fc143c261b8759e27a386fd559dc00fd1b4d6c25e4d167a3c28ad6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
    mv ${WORKDIR}/amnezia-vpn-amneziawg-go-* ${S} || die
}