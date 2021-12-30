# [docker-wixtoolset](https://github.com/vtavernier/docker-wixtoolset)

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/vtavernier/docker-wixtoolset/build)](https://github.com/vtavernier/docker-wixtoolset/actions/workflows/build.yaml)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/vtavernier/docker-wixtoolset?sort=semver)](https://github.com/vtavernier/docker-wixtoolset/releases)
[![Docker Image Version](https://img.shields.io/docker/v/vtavernier/wixtoolset)](https://hub.docker.com/r/vtavernier/wixtoolset)
[![GitHub](https://img.shields.io/github/license/vtavernier/docker-wixtoolset)](LICENSE)


This Docker image provides the [WiX Toolset](https://wixtoolset.org/) on a
Fedora base image, using Wine to run the (Windows-native) binaries.

## Usage

```bash
# Run candle
docker run --rm -it -v $PWD:/src vtavernier/wixtoolset candle Main.wxs

# Run light
# Note: we have to skip MSI validation because of issues with Wine
docker run --rm -it -v $PWD:/src vtavernier/wixtoolset light -sval Main.wixobj
```

## Author

Vincent Tavernier <vince.tavernier@gmail.com>

## License

This project is licensed under the [MIT license](LICENSE). Note that the
license applies to the files developed as part of the Docker image, and not the
respective projects used by the image.
