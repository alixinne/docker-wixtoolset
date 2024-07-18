# [docker-wixtoolset](https://github.com/alixinne/docker-wixtoolset)

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/alixinne/docker-wixtoolset/build)](https://github.com/alixinne/docker-wixtoolset/actions/workflows/build.yaml)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/alixinne/docker-wixtoolset?sort=semver)](https://github.com/alixinne/docker-wixtoolset/releases)
[![GitHub](https://img.shields.io/github/license/alixinne/docker-wixtoolset)](LICENSE)


This Docker image provides the [WiX Toolset](https://wixtoolset.org/) on a
Fedora base image, using Wine to run the (Windows-native) binaries.

## Usage

```bash
# Run candle
docker run --rm -it -v $PWD:/src ghcr.io/alixinne/wixtoolset candle Main.wxs

# Run light
# Note: we have to skip MSI validation because of issues with Wine
docker run --rm -it -v $PWD:/src ghcr.io/alixinne/wixtoolset light -sval Main.wixobj
```

## Author

Alixinne <alixinne@pm.me>

## License

This project is licensed under the [MIT license](LICENSE). Note that the
license applies to the files developed as part of the Docker image, and not the
respective projects used by the image.
