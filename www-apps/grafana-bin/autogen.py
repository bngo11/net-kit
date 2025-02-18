#!/usr/bin/env python3

import json

async def generate(hub, **pkginfo):
	github_user = github_repo = "grafana"
	json_data = await hub.pkgtools.fetch.get_page(f"https://api.github.com/repos/{github_user}/{github_repo}/releases", is_json=True)
	version = None

	for item in json_data:
		try:
			if item["prerelease"] or item["draft"]:
				continue

			version = item["tag_name"].lstrip("v")
			list(map(int, version.split(".")))
			amd64url = f"https://dl.grafana.com/oss/release/grafana-{version}.linux-amd64.tar.gz"
			arm64url = f"https://dl.grafana.com/oss/release/grafana-{version}.linux-arm64.tar.gz"
			break

		except (KeyError, IndexError, ValueError):
			continue

	if version:
		ebuild = hub.pkgtools.ebuild.BreezyBuild(
			**pkginfo,
			version=version,
			artifacts=[
				hub.pkgtools.ebuild.Artifact(url=amd64url, final_name=amd64url.rsplit("/", 1)[-1]),
				hub.pkgtools.ebuild.Artifact(url=arm64url, final_name=arm64url.rsplit("/", 1)[-1]),
			]
		)
		ebuild.push()

# vim: ts=4 sw=4 noet
