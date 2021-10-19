# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit pam

DESCRIPTION="Provides access to Netware services using the NCP protocol"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/ncpfs/"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~x86"
IUSE="nls pam php"

DEPEND="
	nls? ( sys-devel/gettext )
	pam? ( virtual/pam )
	php? ( || ( dev-lang/php:* virtual/httpd-php:* ) )"

RDEPEND="${DEPEND}"

MY_PATCHES=(
	# PHP extension sandbox violation.
	"${FILESDIR}"/${PN}-2.2.5-php.patch
	"${FILESDIR}"/${P}-gcc4.patch
	"${FILESDIR}"/${P}-missing-includes.patch

	# Add a patch to fix multiple vulnerabilities.
	# CVE-2010-0788, CVE-2010-0790, & CVE-2010-0791.
	# http://seclists.org/fulldisclosure/2010/Mar/122
	"${FILESDIR}"/${P}-multiple-vulns.patch

	# Add a patch that removes the __attribute__((packed)); directive
	# from several struct members in include/ncp/ncplib.h.  This will
	# cut down on a large number of compile warnings generated by modern
	# gcc releases.
	"${FILESDIR}"/${P}-remove-packed-attrib.patch

	# Misc patches borrowed from Mageia.
	"${FILESDIR}"/${P}-align-fix.patch
	"${FILESDIR}"/${P}-getuid-fix.patch
	"${FILESDIR}"/${P}-pam_ncp_auth-fix.patch
	"${FILESDIR}"/${P}-servername-array-fix.patch

	# Misc patches borrowed from Debian.
	# Fixes Bug #497278
	"${FILESDIR}"/${P}-drop-kernel-check.patch
	"${FILESDIR}"/${P}-drop-mtab-support.patch
	"${FILESDIR}"/${P}-no-suid-root.patch
	"${FILESDIR}"/${P}-remove-libncp_atomic-header.patch

	# Support LDFLAGS.
	"${FILESDIR}"/${P}-ldflags-support.patch

	# Bug 446696.  This might need re-diffing if additional Makefile
	# fixes are added.
	"${FILESDIR}"/${P}-makefile-fix-soname-link.patch

	# bug 522444
	"${FILESDIR}"/${P}-zend_function_entry.patch
)

DOCS=( FAQ README )

src_prepare() {
	default

	# Bug #273484.
	sed -i '/ldconfig/d' lib/Makefile.in || die

	epatch "${MY_PATCHES[@]}"
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable pam pam "$(getpam_mod_dir)") \
		$(use_enable php)
}

src_install() {
	dodir $(getpam_mod_dir) /usr/sbin /sbin

	# Install main software and headers.
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" install-dev

	# Install a startup script in /etc/init.d and a conf file in /etc/conf.d
	newconfd "${FILESDIR}"/ipx.confd ipx
	newinitd "${FILESDIR}"/ipx.init ipx

	einstalldocs
}
