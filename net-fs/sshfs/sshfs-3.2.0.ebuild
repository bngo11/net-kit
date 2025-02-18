# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Fuse-filesystem utilizing the sftp service"
HOMEPAGE="https://github.com/libfuse/sshfs"
SRC_URI="https://github.com/libfuse/sshfs/releases/download/sshfs-3.2.0/sshfs-3.2.0.tar.gz -> sshfs-3.2.0.tar.gz"

LICENSE="GPL-2"
KEYWORDS="*"
SLOT="0"

DEPEND="sys-fs/fuse:3
	dev-libs/glib"
RDEPEND="${DEPEND}
	net-misc/openssh"
BDEPEND="dev-python/docutils
	virtual/pkgconfig"

# requires root privs and specific localhost sshd setup
RESTRICT="test"

DOCS=( AUTHORS ChangeLog.rst README.rst )

src_unpack() {
	default
	rm -rf ${S}
	mv ${WORKDIR}/libfuse-sshfs-* ${S} || die
}