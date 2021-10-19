#!/usr/bin/env python3

import json
from datetime import timedelta

async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page("https://api.github.com/repos/yarnpkg/yarn/releases")
	json_list = json.loads(json_data)
	version = None
	url = None

	for item in json_list:
		if not item['prerelease']:
			try:
				version = item['tag_name'].strip('v')

				for asset in item['assets']:
					url = asset['browser_download_url']

					if url.endswith('tar.gz'):
						break
				else:
					continue

				break

			except (IndexError, AttributeError, KeyError):
				continue

	if version:
		final_name = f"yarn-{version}.tar.gz"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
