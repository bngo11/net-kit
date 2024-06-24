# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"aead.dev/minisign v0.2.0"
	"aead.dev/minisign v0.2.0/go.mod"
	"github.com/!burnt!sushi/toml v0.3.1/go.mod"
	"github.com/!vivid!cortex/ewma v1.2.0"
	"github.com/!vivid!cortex/ewma v1.2.0/go.mod"
	"github.com/acarl005/stripansi v0.0.0-20180116102854-5a71ef0e047d"
	"github.com/acarl005/stripansi v0.0.0-20180116102854-5a71ef0e047d/go.mod"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1/go.mod"
	"github.com/beorn7/perks v1.0.1"
	"github.com/beorn7/perks v1.0.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.3.0"
	"github.com/cespare/xxhash/v2 v2.3.0/go.mod"
	"github.com/charmbracelet/bubbles v0.18.0"
	"github.com/charmbracelet/bubbles v0.18.0/go.mod"
	"github.com/charmbracelet/bubbletea v0.25.0"
	"github.com/charmbracelet/bubbletea v0.25.0/go.mod"
	"github.com/charmbracelet/lipgloss v0.10.0"
	"github.com/charmbracelet/lipgloss v0.10.0/go.mod"
	"github.com/cheggaaa/pb v1.0.29"
	"github.com/cheggaaa/pb v1.0.29/go.mod"
	"github.com/containerd/console v1.0.4"
	"github.com/containerd/console v1.0.4/go.mod"
	"github.com/coreos/go-semver v0.3.1"
	"github.com/coreos/go-semver v0.3.1/go.mod"
	"github.com/coreos/go-systemd/v22 v22.5.0"
	"github.com/coreos/go-systemd/v22 v22.5.0/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/decred/dcrd/crypto/blake256 v1.0.1/go.mod"
	"github.com/decred/dcrd/dcrec/secp256k1/v4 v4.2.0/go.mod"
	"github.com/decred/dcrd/dcrec/secp256k1/v4 v4.3.0"
	"github.com/decred/dcrd/dcrec/secp256k1/v4 v4.3.0/go.mod"
	"github.com/dustin/go-humanize v1.0.1"
	"github.com/dustin/go-humanize v1.0.1/go.mod"
	"github.com/fatih/color v1.9.0/go.mod"
	"github.com/fatih/color v1.16.0"
	"github.com/fatih/color v1.16.0/go.mod"
	"github.com/fatih/structs v1.1.0"
	"github.com/fatih/structs v1.1.0/go.mod"
	"github.com/go-ole/go-ole v1.2.6/go.mod"
	"github.com/go-ole/go-ole v1.3.0"
	"github.com/go-ole/go-ole v1.3.0/go.mod"
	"github.com/goccy/go-json v0.10.2"
	"github.com/goccy/go-json v0.10.2/go.mod"
	"github.com/godbus/dbus/v5 v5.0.4/go.mod"
	"github.com/gogo/protobuf v1.3.2"
	"github.com/gogo/protobuf v1.3.2/go.mod"
	"github.com/golang-jwt/jwt/v4 v4.5.0"
	"github.com/golang-jwt/jwt/v4 v4.5.0/go.mod"
	"github.com/golang/protobuf v1.2.0/go.mod"
	"github.com/golang/protobuf v1.5.4"
	"github.com/golang/protobuf v1.5.4/go.mod"
	"github.com/google/go-cmp v0.5.6/go.mod"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/google/shlex v0.0.0-20191202100458-e7afc7fbc510"
	"github.com/google/shlex v0.0.0-20191202100458-e7afc7fbc510/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/hashicorp/errwrap v1.0.0/go.mod"
	"github.com/hashicorp/errwrap v1.1.0"
	"github.com/hashicorp/errwrap v1.1.0/go.mod"
	"github.com/hashicorp/go-multierror v1.0.0/go.mod"
	"github.com/hashicorp/go-multierror v1.1.1"
	"github.com/hashicorp/go-multierror v1.1.1/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jedib0t/go-pretty/v6 v6.5.8"
	"github.com/jedib0t/go-pretty/v6 v6.5.8/go.mod"
	"github.com/juju/ratelimit v1.0.2"
	"github.com/juju/ratelimit v1.0.2/go.mod"
	"github.com/kisielk/errcheck v1.5.0/go.mod"
	"github.com/kisielk/gotool v1.0.0/go.mod"
	"github.com/klauspost/compress v1.17.8"
	"github.com/klauspost/compress v1.17.8/go.mod"
	"github.com/klauspost/cpuid/v2 v2.0.1/go.mod"
	"github.com/klauspost/cpuid/v2 v2.2.7"
	"github.com/klauspost/cpuid/v2 v2.2.7/go.mod"
	"github.com/kr/pretty v0.2.1/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/lestrrat-go/backoff/v2 v2.0.8"
	"github.com/lestrrat-go/backoff/v2 v2.0.8/go.mod"
	"github.com/lestrrat-go/blackmagic v1.0.2"
	"github.com/lestrrat-go/blackmagic v1.0.2/go.mod"
	"github.com/lestrrat-go/httpcc v1.0.1"
	"github.com/lestrrat-go/httpcc v1.0.1/go.mod"
	"github.com/lestrrat-go/iter v1.0.2"
	"github.com/lestrrat-go/iter v1.0.2/go.mod"
	"github.com/lestrrat-go/jwx v1.2.29"
	"github.com/lestrrat-go/jwx v1.2.29/go.mod"
	"github.com/lestrrat-go/option v1.0.0/go.mod"
	"github.com/lestrrat-go/option v1.0.1"
	"github.com/lestrrat-go/option v1.0.1/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/lufia/plan9stats v0.0.0-20211012122336-39d0f177ccd0/go.mod"
	"github.com/lufia/plan9stats v0.0.0-20240408141607-282e7b5d6b74"
	"github.com/lufia/plan9stats v0.0.0-20240408141607-282e7b5d6b74/go.mod"
	"github.com/mattn/go-colorable v0.1.4/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-ieproxy v0.0.11"
	"github.com/mattn/go-ieproxy v0.0.11/go.mod"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/mattn/go-isatty v0.0.11/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mattn/go-localereader v0.0.1"
	"github.com/mattn/go-localereader v0.0.1/go.mod"
	"github.com/mattn/go-runewidth v0.0.4/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.15"
	"github.com/mattn/go-runewidth v0.0.15/go.mod"
	"github.com/matttproud/golang_protobuf_extensions v1.0.4"
	"github.com/matttproud/golang_protobuf_extensions v1.0.4/go.mod"
	"github.com/minio/cli v1.24.2"
	"github.com/minio/cli v1.24.2/go.mod"
	"github.com/minio/colorjson v1.0.7"
	"github.com/minio/colorjson v1.0.7/go.mod"
	"github.com/minio/filepath v1.0.0"
	"github.com/minio/filepath v1.0.0/go.mod"
	"github.com/minio/madmin-go/v3 v3.0.55-0.20240603092915-420a67132c32"
	"github.com/minio/madmin-go/v3 v3.0.55-0.20240603092915-420a67132c32/go.mod"
	"github.com/minio/md5-simd v1.1.2"
	"github.com/minio/md5-simd v1.1.2/go.mod"
	"github.com/minio/minio-go/v7 v7.0.72-0.20240618070918-0b004e328e1e"
	"github.com/minio/minio-go/v7 v7.0.72-0.20240618070918-0b004e328e1e/go.mod"
	"github.com/minio/mux v1.9.0"
	"github.com/minio/mux v1.9.0/go.mod"
	"github.com/minio/pkg/v3 v3.0.0"
	"github.com/minio/pkg/v3 v3.0.0/go.mod"
	"github.com/minio/selfupdate v0.6.0"
	"github.com/minio/selfupdate v0.6.0/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6"
	"github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6/go.mod"
	"github.com/muesli/cancelreader v0.2.2"
	"github.com/muesli/cancelreader v0.2.2/go.mod"
	"github.com/muesli/reflow v0.3.0"
	"github.com/muesli/reflow v0.3.0/go.mod"
	"github.com/muesli/termenv v0.15.2"
	"github.com/muesli/termenv v0.15.2/go.mod"
	"github.com/olekukonko/tablewriter v0.0.5"
	"github.com/olekukonko/tablewriter v0.0.5/go.mod"
	"github.com/philhofer/fwd v1.1.2"
	"github.com/philhofer/fwd v1.1.2/go.mod"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pkg/xattr v0.4.9"
	"github.com/pkg/xattr v0.4.9/go.mod"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2"
	"github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2/go.mod"
	"github.com/posener/complete v1.2.3"
	"github.com/posener/complete v1.2.3/go.mod"
	"github.com/power-devops/perfstat v0.0.0-20210106213030-5aafc221ea8c/go.mod"
	"github.com/power-devops/perfstat v0.0.0-20240221224432-82ca36839d55"
	"github.com/power-devops/perfstat v0.0.0-20240221224432-82ca36839d55/go.mod"
	"github.com/prometheus/client_golang v1.19.0"
	"github.com/prometheus/client_golang v1.19.0/go.mod"
	"github.com/prometheus/client_model v0.6.1"
	"github.com/prometheus/client_model v0.6.1/go.mod"
	"github.com/prometheus/common v0.53.0"
	"github.com/prometheus/common v0.53.0/go.mod"
	"github.com/prometheus/procfs v0.14.0"
	"github.com/prometheus/procfs v0.14.0/go.mod"
	"github.com/prometheus/prom2json v1.3.3"
	"github.com/prometheus/prom2json v1.3.3/go.mod"
	"github.com/rivo/uniseg v0.1.0/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.7"
	"github.com/rivo/uniseg v0.4.7/go.mod"
	"github.com/rjeczalik/notify v0.9.3"
	"github.com/rjeczalik/notify v0.9.3/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/rogpeppe/go-internal v1.10.0"
	"github.com/rogpeppe/go-internal v1.10.0/go.mod"
	"github.com/rs/xid v1.5.0"
	"github.com/rs/xid v1.5.0/go.mod"
	"github.com/safchain/ethtool v0.3.0"
	"github.com/safchain/ethtool v0.3.0/go.mod"
	"github.com/secure-io/sio-go v0.3.1"
	"github.com/secure-io/sio-go v0.3.1/go.mod"
	"github.com/shirou/gopsutil/v3 v3.24.4"
	"github.com/shirou/gopsutil/v3 v3.24.4/go.mod"
	"github.com/shoenig/go-m1cpu v0.1.6"
	"github.com/shoenig/go-m1cpu v0.1.6/go.mod"
	"github.com/shoenig/test v0.6.4"
	"github.com/shoenig/test v0.6.4/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/objx v0.5.2/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"github.com/stretchr/testify v1.9.0"
	"github.com/stretchr/testify v1.9.0/go.mod"
	"github.com/tidwall/gjson v1.17.1"
	"github.com/tidwall/gjson v1.17.1/go.mod"
	"github.com/tidwall/match v1.1.1"
	"github.com/tidwall/match v1.1.1/go.mod"
	"github.com/tidwall/pretty v1.2.0/go.mod"
	"github.com/tidwall/pretty v1.2.1"
	"github.com/tidwall/pretty v1.2.1/go.mod"
	"github.com/tinylib/msgp v1.1.9"
	"github.com/tinylib/msgp v1.1.9/go.mod"
	"github.com/tklauser/go-sysconf v0.3.12/go.mod"
	"github.com/tklauser/go-sysconf v0.3.14"
	"github.com/tklauser/go-sysconf v0.3.14/go.mod"
	"github.com/tklauser/numcpus v0.6.1/go.mod"
	"github.com/tklauser/numcpus v0.8.0"
	"github.com/tklauser/numcpus v0.8.0/go.mod"
	"github.com/vbauerster/mpb/v8 v8.7.3"
	"github.com/vbauerster/mpb/v8 v8.7.3/go.mod"
	"github.com/yuin/goldmark v1.1.27/go.mod"
	"github.com/yuin/goldmark v1.2.1/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"github.com/yusufpapurcu/wmi v1.2.4"
	"github.com/yusufpapurcu/wmi v1.2.4/go.mod"
	"go.etcd.io/etcd/api/v3 v3.5.13"
	"go.etcd.io/etcd/api/v3 v3.5.13/go.mod"
	"go.etcd.io/etcd/client/pkg/v3 v3.5.13"
	"go.etcd.io/etcd/client/pkg/v3 v3.5.13/go.mod"
	"go.etcd.io/etcd/client/v3 v3.5.13"
	"go.etcd.io/etcd/client/v3 v3.5.13/go.mod"
	"go.uber.org/goleak v1.3.0"
	"go.uber.org/goleak v1.3.0/go.mod"
	"go.uber.org/multierr v1.11.0"
	"go.uber.org/multierr v1.11.0/go.mod"
	"go.uber.org/zap v1.27.0"
	"go.uber.org/zap v1.27.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20210220033148-5ea612d1eb83/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.0.0-20211209193657-4570a0811e8b/go.mod"
	"golang.org/x/crypto v0.19.0/go.mod"
	"golang.org/x/crypto v0.21.0/go.mod"
	"golang.org/x/crypto v0.23.0"
	"golang.org/x/crypto v0.23.0/go.mod"
	"golang.org/x/mod v0.2.0/go.mod"
	"golang.org/x/mod v0.3.0/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.8.0/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20200226121028-0de0cce0169b/go.mod"
	"golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.6.0/go.mod"
	"golang.org/x/net v0.10.0/go.mod"
	"golang.org/x/net v0.21.0/go.mod"
	"golang.org/x/net v0.25.0"
	"golang.org/x/net v0.25.0/go.mod"
	"golang.org/x/sync v0.0.0-20181221193216-37e7f081c4d4/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20190911185100-cd5d95a43a6e/go.mod"
	"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.1.0/go.mod"
	"golang.org/x/sync v0.7.0"
	"golang.org/x/sync v0.7.0/go.mod"
	"golang.org/x/sys v0.0.0-20180926160741-c2ed4eda69e7/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190916202348-b4ddaad3f8a3/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20201204225414-ed752295db88/go.mod"
	"golang.org/x/sys v0.0.0-20210228012217-479acdf4ea46/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220408201424-a24fb2fb8a0f/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/sys v0.5.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.8.0/go.mod"
	"golang.org/x/sys v0.11.0/go.mod"
	"golang.org/x/sys v0.17.0/go.mod"
	"golang.org/x/sys v0.18.0/go.mod"
	"golang.org/x/sys v0.19.0/go.mod"
	"golang.org/x/sys v0.20.0"
	"golang.org/x/sys v0.20.0/go.mod"
	"golang.org/x/term v0.0.0-20201117132131-f5c789dd3221/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.5.0/go.mod"
	"golang.org/x/term v0.8.0/go.mod"
	"golang.org/x/term v0.17.0/go.mod"
	"golang.org/x/term v0.18.0/go.mod"
	"golang.org/x/term v0.20.0"
	"golang.org/x/term v0.20.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.7.0/go.mod"
	"golang.org/x/text v0.9.0/go.mod"
	"golang.org/x/text v0.14.0/go.mod"
	"golang.org/x/text v0.15.0"
	"golang.org/x/text v0.15.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.0.0-20200619180055-7c47624df98f/go.mod"
	"golang.org/x/tools v0.0.0-20210106214847-113979e3529a/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/tools v0.6.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"google.golang.org/genproto/googleapis/api v0.0.0-20240509183442-62759503f434"
	"google.golang.org/genproto/googleapis/api v0.0.0-20240509183442-62759503f434/go.mod"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20240509183442-62759503f434"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20240509183442-62759503f434/go.mod"
	"google.golang.org/grpc v1.63.2"
	"google.golang.org/grpc v1.63.2/go.mod"
	"google.golang.org/protobuf v1.34.1"
	"google.golang.org/protobuf v1.34.1/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/ini.v1 v1.67.0"
	"gopkg.in/ini.v1 v1.67.0/go.mod"
	"gopkg.in/urfave/cli.v1 v1.20.0/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"

)

go-module_set_globals
EGO_SKIP_TIDY=1

DESCRIPTION="Fast tool to manage MinIO clusters"
HOMEPAGE="https://min.io/ https://github.com/minio/mc"
SRC_URI="
https://api.github.com/repos/minio/mc/tarball/RELEASE.2024-06-20T14-50-54Z -> minio-client-RELEASE.2024-06-20T14-50-54Z.tar.gz
https://direct.funtoo.org/0d/45/38/0d453800e3a0c08b83d17679152ceeafeb05dd6d0d165c0b9de2ee77c9a83b384c1fe79174f313c6d9b3e0f5a87e0f9705563b7ce92f53e22cdf737f06189f15 -> minio-client-2024.06.20.14.50.54-funtoo-go-bundle-cac4c260f611c1c700d4153d98c4f260acb826fd281ed3f4e82e81cf2c02bbce53c52b685f49fc924e154b62ed4560b4638d3969019038198e463609a45c7014.tar.gz"

MY_PV="$(ver_cut 1-3)T$(ver_cut 4-7)Z"
MY_PV=${MY_PV//./-}
EGIT_COMMIT=""
IUSE=""
LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="*"

BDEPEND="dev-lang/go"

src_prepare() {
	default

	sed -i -e "s/time.Now().UTC().Format(time.RFC3339)/\"${MY_PV}\"/"\
		-e "s/-s //"\
		-e "/time/d"\
		-e "s/+ commitID()/+ \"${EGIT_COMMIT}\"/"\
		buildscripts/gen-ldflags.go || die
}

src_unpack() {
	go-module_src_unpack
	mv ${WORKDIR}/minio-mc-* ${S} || die
}

src_compile() {
	unset XDG_CACHE_HOME

	MINIO_RELEASE="${MY_PV}"
	go run buildscripts/gen-ldflags.go
	CGO_ENABLED=0 \
		go build --ldflags "$(go run buildscripts/gen-ldflags.go)" -o mc || die
}

src_install() {
	dobin mc
}

# vim: filetype=ebuild