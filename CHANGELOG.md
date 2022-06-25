# Changelog

## [v3.3.1-3] - 2022-06-25

- Re-introduce Snyk-based Docker vulnerability scanning (#172)

## [v3.3.1-2] - 2022-06-25

- Release process changes (#168)
  - Dynamically determine the grocy app version based on git tag (#169)
  - Publish images using two tags: the grocy app version, and the git tag (#170)
  - Temporarily remove Snyk container scanning support (#170)
    - This will move into the GitHub Actions workflows in future

## [v3.3.1-1] - 2022-06-25

- Fix: GitHub Actions container build version had not been updated to v3.3.1 (was: v3.3.0)
  - This means that Docker Hub image 2507e6e6f77a44cbe58915296aab590ee8bee501fb0d4605024e7dfbc7b5760c - tagged as v3.3.1 - in fact contains Grocy v3.3.0

## [v3.3.1-0] - 2022-06-13

- Upgrade to grocy v3.3.1

## [v3.3.0-1] - 2022-05-26

- Rebuild container images with Alpine 3.16.0

## [v3.3.0-0] - 2022-05-03

- Upgrade to grocy v3.3.0
- Rebuild container images with Alpine 3.15.4

## [v3.2.0-1] - 2022-03-20

- Rebuild container images with Alpine 3.15.1

## [v3.2.0-0] - 2022-02-11

- Upgrade to grocy v3.2.0

## [v3.1.3-1] - 2021-12-15

- Add continuous integration support for multi-architecture container builds
- Rebuild container images with Alpine 3.15.0

## [v3.1.3-0] - 2021-11-23

- Upgrade to grocy v3.1.3
- Rebuild container images with Alpine 3.14.3

## [v3.1.2-0] - 2021-10-05

- Upgrade to grocy v3.1.2
- Changes to the Makefile
  - The `build` target now only builds the image, but does not start it.
  - The `create` target (re)creates a pod for grocy, but does not start it.
  - The `run` target depends on `create` and then starts the created pod.
  - The host prefixes of the images are now set to match the official images on Docker hub and can be overriden using the IMAGE_PREFIX variable.
  - The image tags are now generated from `git describe`, but can be overridden using the IMAGE_TAG variable.
- Rebuild container images with Alpine 3.14.2

## [v3.1.1-1] - 2021-09-02

- Fixup: use correct GROCY_VERSION (v3.1.1) for backend in docker-compose.yml (thank you, @Kritzefitz)

## [v3.1.1-0] - 2021-08-21

- Upgrade to grocy v3.1.1

## [v3.1.0-0] - 2021-08-21

- Rebuild container images with Alpine 3.14.0
- Use more meaningful container names
  - 'grocy/grocy' becomes 'grocy/backend'
  - 'grocy/nginx' becomes 'grocy/frontend'
- Upgrade to grocy v3.1.0 and PHP8 (thank you, @HamburgerJungeJr)

## [v3.0.1-12] - 2021-08-21*

### Changed

- Rebuild container images to resolve CVE-2021-21705
- [Minor] Update snyk vulnerability scan

*This was a late release; this should have been released on 2021-07-18 per the changelog; unfortunately it was not, and this was only noticed today, 2021-08-21

## [v3.0.1-11] - 2021-05-02

### Changed

- Rebuild container images with new Alpine 3.13.5 release
- [Minor] Update snyk vulnerability scan

## [v3.0.1-10] - 2021-03-25

### Changed

- Rebuild container images with new Alpine 3.13.3 release
- [Minor] Update snyk vulnerability scan

## [v3.0.1-9] - 2020-02-18

### Added

- Experimental support for multi-architecture OCI image builds

### Changed

- Rebuild container images with new Alpine 3.13.2 release

## [v3.0.1-8] - 2020-01-29

### Changed

- Rebuild container images with new Alpine 3.13.1 release

## [v3.0.1-7] - 2020-01-15

### Changed

- Migrate to a release-initiated GitHub Actions workflow
- Consistency: remove custom naming from docker/login-action step

## [v3.0.1-6] - 2020-01-15

### Changed

- Really this time.

## [v3.0.1-5] - 2020-01-15

### Changed

- Remove `GITHUB_API_TOKEN` from container build arguments

## [v3.0.1-4] - 2020-01-15

### Changed

- Cleanup for GitHub Actions workflow

## [v3.0.1-3] - 2020-01-15

### Changed

- Fixup for GitHub Actions workflow: include image tag during 'docker-push' step

## [v3.0.1-2] - 2020-01-15

### Changed

- Rebuild container images with new Alpine 3.13.0 release

## [v3.0.1-1] - 2021-01-05

### Changed

- Upgrade to grocy release v3.0.1

## [v3.0.0-2] - 2021-01-02

### Added

- Docker Hub container upload automation using GitHub Actions

### Changed

- Supply PHP EXIF and LDAP library dependencies at build-time
- [Minor] Update snyk vulnerability scan
- [Minor] Refresh package-lock.json version, and remove container version suffix
- Run vulnerability scans using 'latest' container image tag

## [v3.0.0-1] - 2020-12-22

### Changed

- Upgrade to grocy release v3.0.0

## [v2.7.1-5] - 2020-12-22

### Changed

- Rebuild container images with new Alpine 3.12.3 release

## [v2.7.1-4] - 2020-09-02

### Changed

- Perform `apk update` prior to Alpine Linux package installation
- Rebuild container images with new Alpine 3.12.0 release

## [v2.7.1-3] - 2020-04-27

### Changed

- Rebuild container images with new Alpine 3.11.6 release

## [v2.7.1-2] - 2020-04-21

### Changed

- Rebuild nginx image with new Alpine 'openssl' package
- Was: 'OpenSSL 1.1.1d  10 Sep 2019'
- Now: 'OpenSSL 1.1.1g  21 Apr 2020 (Library: OpenSSL 1.1.1d  10 Sep 2019)'

## [v2.7.1-1] - 2020-04-18

### Added

- Upgrade to grocy release v2.7.1

## [v2.7.0-1] - 2020-04-17

### Added

- Upgrade to grocy release v2.7.0

## [v2.6.2-4] - 2020-04-07

### Removed

- Shared 'www-static' volume

## [v2.6.2-3] - 2020-04-06

### Changed

- Introduced a handful of Docker Hub image best-practices

## [v2.6.2-2] - 2020-04-04

### Changed

- Pull in upstream grocy v2.6.2 fix

## [v2.6.2-1] - 2020-04-04

### Changed

- Ensure that the application is bound to 127.0.0.1 by default

## [v2.6.2] - 2020-04-03

### Added

- Upgrade to grocy release v2.6.2
- Support for GitHub API tokens at build-time
- Log volumes added for grocy and nginx
- Optional support for OCI image builds

### Changed

- Breaking change: Image names are now: grocy/nginx, grocy/grocy
- Breaking change: Application database volume contents and name updated
- Image filesystems are read-only
