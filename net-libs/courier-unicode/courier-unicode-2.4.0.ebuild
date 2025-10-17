# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Unicode library used by the courier mail server"
HOMEPAGE="https://www.courier-mta.org/"
SRC_URI="https://sourceforge.net/projects/courier/files/courier-unicode/2.4.0/courier-unicode-2.4.0.tar.bz2 -> courier-unicode-2.4.0.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
	dodoc AUTHORS ChangeLog README
}