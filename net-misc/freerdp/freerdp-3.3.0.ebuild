# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

SRC_URI="https://github.com/FreeRDP/FreeRDP/releases/download/3.3.0/freerdp-3.3.0.tar.gz -> freerdp-3.3.0.tar.gz"
KEYWORDS="*"

DESCRIPTION="FreeRDP is a free remote desktop protocol library and clients"
HOMEPAGE="http://www.freerdp.com/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="alsa cpu_flags_arm_neon cups debug doc +ffmpeg +fuse gstreamer jpeg openh264 pulseaudio sdl server smartcard systemd test usb wayland X xinerama xv"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/openssl:0=
	sys-libs/zlib:0
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	usb? (
		virtual/libudev:0=
		sys-apps/util-linux:0=
		dev-libs/dbus-glib:0=
		virtual/libusb:1=
	)
	X? (
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrender
		xinerama? ( x11-libs/libXinerama )
		xv? ( x11-libs/libXv )
	)
	ffmpeg? ( media-video/ffmpeg:0= )
	!ffmpeg? (
		x11-libs/cairo:0=
	)
	fuse? ( sys-fs/fuse:3 )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		x11-libs/libXrandr
	)
	jpeg? ( virtual/jpeg:0 )
	openh264? ( media-libs/openh264:0= )
	pulseaudio? ( media-sound/pulseaudio )
	sdl? (
		media-libs/libsdl2
		media-libs/sdl2-ttf
	)
	server? (
		X? (
			x11-libs/libXcursor
			x11-libs/libXdamage
			x11-libs/libXext
			x11-libs/libXfixes
			x11-libs/libXrandr
			x11-libs/libXtst
			xinerama? ( x11-libs/libXinerama )
		)
	)
	smartcard? (
		dev-libs/pkcs11-helper
		sys-apps/pcsc-lite
	)
	systemd? ( sys-apps/systemd:0= )
	wayland? (
		dev-libs/wayland
		x11-libs/libxkbcommon
	)
	X? (
		x11-libs/libX11
		x11-libs/libxkbfile
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	X? ( doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto
	) )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
		-DCHANNEL_URBDRC=$(usex usb ON OFF)
		-DWITH_AAD=OFF
		-DWITH_ALSA=$(usex alsa ON OFF)
		-DWITH_CCACHE=OFF
		-DWITH_CLIENT_SDL=$(usex sdl ON OFF)
		-DWITH_CUPS=$(usex cups ON OFF)
		-DWITH_DEBUG_ALL=$(usex debug ON OFF)
		-DWITH_MANPAGES=$(usex doc ON OFF)
		-DWITH_FFMPEG=$(usex ffmpeg ON OFF)
		-DWITH_FREERDP_DEPRECATED_COMMANDLINE=ON
		-DWITH_SWSCALE=$(usex ffmpeg ON OFF)
		-DWITH_CAIRO=$(usex ffmpeg OFF ON)
		-DWITH_DSP_FFMPEG=$(usex ffmpeg ON OFF)
		-DWITH_FUSE=$(usex fuse ON OFF)
		-DWITH_GSTREAMER_1_0=$(usex gstreamer ON OFF)
		-DWITH_JPEG=$(usex jpeg ON OFF)
		-DWITH_NEON=$(usex cpu_flags_arm_neon ON OFF)
		-DWITH_OPENH264=$(usex openh264 ON OFF)
		-DWITH_PULSE=$(usex pulseaudio ON OFF)
		-DWITH_SERVER=$(usex server ON OFF)
		-DWITH_PCSC=$(usex smartcard ON OFF)
		-DWITH_PKCS11=$(usex smartcard ON OFF)
		-DWITH_LIBSYSTEMD=$(usex systemd ON OFF)
		-DWITH_X11=$(usex X ON OFF)
		-DWITH_XINERAMA=$(usex xinerama ON OFF)
		-DWITH_XV=$(usex xv ON OFF)
		-DWITH_WAYLAND=$(usex wayland ON OFF)
		-DWITH_WEBVIEW=OFF
	)
	cmake_src_configure
}