# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module tmpfiles

VERSION_SHORT="1.86.0"
VERSION_LONG="1.86.0-tef24c2d22"

DESCRIPTION="Tailscale vpn client"
HOMEPAGE="https://tailscale.com"
SRC_URI="https://github.com/tailscale/tailscale/tarball/ef24c2d2272b80a337bcf43e937326b9f0f3c91a -> tailscale-1.86.0-ef24c2d.tar.gz
https://direct.funtoo.org/89/b5/c1/89b5c1785757d239b4946a594d3863419aeefdaf27b92a1c0ad5c350f2c387ed3019cc52a23c5ab3bdd76f5c007d5796de53e3afe3d7dc51db4ebcc472c44a3c -> tailscale-1.86.0-funtoo-go-bundle-8e01b275dd21df997da7c5d284b0bf3c2d919dbaac7fcffeb396a3a688ac3fba44302e8aeaf94ad0de85e6a1aae54bf8cc20e8371f9f0962dee2731c5fd63169.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="net-firewall/iptables"
S="${WORKDIR}/tailscale-tailscale-ef24c2d"

# This translates the build command from upstream's build_dist.sh to an
# ebuild equivalent.
build_dist() {
	go build -tags xversion -ldflags "
		-X tailscale.com/version.longStamp=${VERSION_LONG}
		-X tailscale.com/version.shortStamp=${VERSION_SHORT}" "$@"
}

src_compile() {
	build_dist ./cmd/tailscale
	build_dist ./cmd/tailscaled
}

src_install() {
	dosbin tailscaled
	dobin tailscale

	insinto /etc/default
	newins cmd/tailscaled/tailscaled.defaults tailscaled
	keepdir /var/lib/${PN}
	fperms 0750 /var/lib/${PN}

	newtmpfiles "${FILESDIR}/${PN}.tmpfiles" ${PN}.conf

	newinitd "${FILESDIR}/${PN}d.initd" ${PN}
	newconfd "${FILESDIR}/${PN}d.confd" ${PN}
}

pkg_postinst() {
	tmpfiles_process ${PN}.conf
}