# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="Open-source implementation of the Secure Real-time Transport Protocol (SRTP)"
HOMEPAGE="https://github.com/cisco/libsrtp"
SRC_URI="https://github.com/cisco/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="2/1"
KEYWORDS="*"
IUSE="debug doc libressl nss openssl static-libs test"
RESTRICT="!test? ( test )"
REQUIRED_USE="?? ( nss openssl )"

RDEPEND="
	openssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
	nss? ( >=dev-libs/nss-3.52 )
"
DEPEND="${RDEPEND}"

DOCS=( CHANGES )

#PATCHES=( "${FILESDIR}/${P}-pcap-automagic-r0.patch" )

src_configure() {
	local crypto_lib="none"
	use openssl && crypto_lib="openssl"
	use nss && crypto_lib="nss"

	# stdout: default error output for messages in debug
	# openssl-kdf: OpenSSL 1.1.0+
	local emesonargs=(
		-Dcrypto-library=${crypto_lib}
		-Dcrypto-library-kdf=disabled
		-Dfuzzer=disabled
		-Dlog-stdout=true
		-Dpcap-tests=disabled
		-Ddefault_library=$(usex static-libs both shared)

		$(meson_feature test tests)
		$(meson_feature doc)
		$(meson_use debug debug-logging)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
	if use doc; then
		meson_src_compile doc/html
	fi
}


src_install() {
	if use doc; then
		dodoc -r html
	fi
	meson_src_install

	local DOCS=( CHANGES )
	einstalldocs
}
