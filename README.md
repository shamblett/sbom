# sbom
[![Build Status](https://github.com/shamblett/sbom/actions/workflows/ci.yml/badge.svg)](https://github.com/shamblett/sbom/actions/workflows/ci.yml)

A Software Bill Of Materials(SBOM) generator for Dart packages.

This package will generate an SBOM specifically for a Dart package. 

The SBOM is generated from the Dart files contained in the package plus the pubspec.yaml, no other files 
included in the package are currently considered.

Generation is controlled by a configuration file named sbom.yaml which must be present in the top level directory of the package.
This file allows setting of the SBOM format, generation directives and field overrides. Generation is effectively a merge of any field ovverides
in this file and data generated from the package environment and its pubspec file. It is also assumed that the package either is or will be uploaded to pub
for the purposes of download links, homepage information etc.

Please read the [example.md](/example/example.md) for usage information.

Currently, only the Software Package Data Exchange(SPDX) format is supported at specification version 2.2,
see [here](https://en.wikipedia.org/wiki/Software_Package_Data_Exchange) for further details. More detailed information
of the specific implementation of this specification in this package can be found in the SPDX [readme document](SPDX.md)

Support for other SBOM format types such as CycloneDX and SWID will be aded in future releases.