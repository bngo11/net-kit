# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python2+ )
inherit bash-completion-r1 distutils-r1 readme.gentoo-r1

DESCRIPTION="Download videos from YouTube.com (and more sites...)"
HOMEPAGE="http://ytdl-org.github.io/youtube-dl/"
SRC_URI="https://github.com/ytdl-org/youtube-dl/releases/download/2021.12.17/youtube-dl-2021.12.17.tar.gz"
LICENSE="public-domain"

KEYWORDS="*"
RESTRICT="test"
SLOT="0"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="
	${DEPEND}
	|| (
		dev-python/pycryptodome[${PYTHON_USEDEP}]
		dev-python/pycrypto[${PYTHON_USEDEP}]
	)
"
S="${WORKDIR}/${PN}"

src_compile() {
	distutils-r1_src_compile
}

python_install_all() {
	dodoc README.txt
	doman ${PN}.1

	newbashcomp ${PN}.bash-completion ${PN}

	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}

	insinto /usr/share/fish/vendor_completions.d
	doins ${PN}.fish

	distutils-r1_python_install_all

	rm -r "${ED}"/usr/etc || die
	rm -r "${ED}"/usr/share/doc/youtube_dl || die
}

pkg_postinst() {
	elog "${PN}(1) / https://bugs.gentoo.org/355661 /"
	elog "https://github.com/rg3/${PN}/blob/master/README.md#faq :"
	elog
	elog "${PN} works fine on its own on most sites. However, if you want"
	elog "to convert video/audio, you'll need avconf (media-video/libav) or"
	elog "ffmpeg (media-video/ffmpeg). On some sites - most notably YouTube -"
	elog "videos can be retrieved in a higher quality format without sound."
	elog "${PN} will detect whether avconv/ffmpeg is present and"
	elog "automatically pick the best option."
	elog
	elog "Videos or video formats streamed via RTMP protocol can only be"
	elog "downloaded when rtmpdump (media-video/rtmpdump) is installed."
	elog
	elog "Downloading MMS and RTSP videos requires either mplayer"
	elog "(media-video/mplayer) or mpv (media-video/mpv) to be installed."
	elog
	elog "If you want ${PN} to embed thumbnails from the metadata into the"
	elog "resulting MP4 files, consider installing media-video/atomicparsley"
}