#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	json_data = await hub.pkgtools.fetch.get_page("https://api.github.com/repos/hashicorp/terraform/releases", is_json=True)
	version = None

	for item in json_data:
		if not item['prerelease']:
			try:
				version = item['tag_name'].strip('v')
				break

			except (IndexError, AttributeError, KeyError):
				continue

	if version:
		final_name = f"terraform-{version}.tar.gz"
		url = f"https://github.com/hashicorp/terraform/archive/v{version}.tar.gz"
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[hub.pkgtools.ebuild.Artifact(url=url, final_name=final_name)]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
