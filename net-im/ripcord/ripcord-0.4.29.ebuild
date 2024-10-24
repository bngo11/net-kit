# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop xdg-utils

DESCRIPTION="Desktop chat client for Slack and Discord (not web-based)."
HOMEPAGE="https://cancel.fm/ripcord"
SRC_URI="https://cancel.fm/dl/Ripcord-0.4.29-x86_64.AppImage"

LICENSE="Ripcord"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libsodium
	dev-qt/qtconcurrent:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[gstreamer]
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwebsockets:5
	dev-qt/qtwidgets:5
	media-libs/opus
	virtual/opengl
"

QA_PREBUILT="/opt/${PN}/Ripcord /opt/${PN}/plugins/*/*.so"
DOCS=( additional_license_information.txt )

src_unpack() {
	cd "${WORKDIR}"
	cp "${DISTDIR}"/"Ripcord-0.4.29-x86_64.AppImage" .

	chmod +x ./"Ripcord-0.4.29-x86_64.AppImage"
	./"Ripcord-0.4.29-x86_64.AppImage" --appimage-extract &>/dev/null

	mv squashfs-root "${P}"
}

src_install() {
	LIBSODIUM_SLOT=$(objdump -p /usr/$(get_libdir)/libsodium.so | grep SONAME | grep -o [0-9]*)
	sed -r -e "s/libsodium\.so\.[[:digit:]]+/libsodium.so.${LIBSODIUM_SLOT}/g" -i "Ripcord"

	exeinto /opt/${PN}
	doexe "Ripcord"
	dosym ../../opt/${PN}/Ripcord usr/bin/${PN}

	insinto /opt/${PN}
	doins twemoji.ripdb

	insinto /usr/share/qt5/translations/
	doins translations/"${PN}_en.qm"

	newicon -s 512 "Ripcord_Icon.png" "${PN}.png"
	make_desktop_entry "${PN}" "Ripcord" "$PN" "Network;InstantMessaging;"

	einstalldocs

	cat > ${ED}/opt/${PN}/qt.conf <<-EOF
		[Paths]
		Prefix = ./

		[Paths]
		Prefix = /usr/lib64/qt5
		EOF
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}