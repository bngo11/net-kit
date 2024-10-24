# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Modern open source high performance RPC framework"
HOMEPAGE="https://www.grpc.io"
SRC_URI="https://api.github.com/repos/grpc/grpc/tarball/v1.44.0 -> grpc-1.44.0.tar.gz"

LICENSE="Apache-2.0"
# format is 0/${CORE_SOVERSION//./}.${CPP_SOVERSION//./} , check top level CMakeLists.txt
SLOT="0/22.144"
KEYWORDS="*"
IUSE="doc examples test"

# look for submodule versions in third_party dir
# TODO: Parse deps dynamically from package
RDEPEND="
	=dev-cpp/abseil-cpp-20210324*:=
	>=dev-libs/re2-2021.04.01:=
	>=dev-libs/openssl-1.1.1:0=[-bindist(-)]
	>=dev-libs/protobuf-3.15.8:=
	dev-libs/xxhash
	>=net-dns/c-ares-1.15.0:=
	sys-libs/zlib:=
"

DEPEND="${RDEPEND}
	test? (
		dev-cpp/benchmark
		dev-cpp/gflags
	)
"

BDEPEND="virtual/pkgconfig"

# requires sources of many google tools
RESTRICT="test"

fix_src_dirs() {
	pushd "${WORKDIR}"
	mv grpc-grpc-* grpc-1.44.0
	popd
}

src_unpack() {
	default
	fix_src_dirs
}

src_prepare() {
	cmake_src_prepare

	# un-hardcode libdir
	sed -i "s@lib/pkgconfig@$(get_libdir)/pkgconfig@" CMakeLists.txt || die
	sed -i "s@/lib@/$(get_libdir)@" cmake/pkg-config-template.pc.in || die

}

src_configure() {
	local mycmakeargs=(
		-DgRPC_INSTALL=ON
		-DgRPC_ABSL_PROVIDER=package
		-DgRPC_BACKWARDS_COMPATIBILITY_MODE=OFF
		-DgRPC_CARES_PROVIDER=package
		-DgRPC_INSTALL_CMAKEDIR="$(get_libdir)/cmake/${PN}"
		-DgRPC_INSTALL_LIBDIR="$(get_libdir)"
		-DgRPC_PROTOBUF_PROVIDER=package
		-DgRPC_RE2_PROVIDER=package
		-DgRPC_SSL_PROVIDER=package
		-DgRPC_ZLIB_PROVIDER=package
		-DgRPC_BUILD_TESTS=$(usex test)
		-DCMAKE_CXX_STANDARD=17
		$(usex test '-DgRPC_GFLAGS_PROVIDER=package' '')
		$(usex test '-DgRPC_BENCHMARK_PROVIDER=package' '')
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use examples; then
		find examples -name '.gitignore' -delete || die
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	if use doc; then
		find doc -name '.gitignore' -delete || die
		local DOCS=( AUTHORS CONCEPTS.md README.md TROUBLESHOOTING.md doc/. )
	fi

	einstalldocs
}