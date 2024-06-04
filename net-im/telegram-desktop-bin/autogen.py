#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page("https://api.github.com/repos/telegramdesktop/tdesktop/releases", is_json=True)
	version = None
	tdesktop_url = None
	tsetup_url = None

	for item in json_data:
		try:
			if item["prerelease"] or item["draft"]:
				continue

			version = item["tag_name"].strip('v')
			list(map(int, version.split(".")))

			for asset in item['assets']:
				asset_name = asset["name"]

				if asset_name.endswith("-full.tar.gz"):
					tdesktop_url = asset["browser_download_url"]
					if tsetup_url:
						break

				if asset_name.endswith(".tar.xz"):
					tsetup_url = asset["browser_download_url"]
					if tdesktop_url:
						break

			if tdesktop_url and tsetup_url:
				break

		except (KeyError, IndexError, ValueError):
			continue

	if version and tdesktop_url and tsetup_url:
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=tdesktop_url, final_name=tdesktop_url.rsplit('/', 1)[-1]),
						hub.pkgtools.ebuild.Artifact(url=tsetup_url, final_name=tsetup_url.rsplit('/', 1)[-1])]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
