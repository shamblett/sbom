# SPDX format SBOM

To create an SPDX tag value formatted SBOM please use either the minimal SPDX [sbom.yaml](/example/yaml/spdx/sbom-minimal.yaml) or if you wish to use 
your own field overrides the [all overrides](/example/yaml/spdx/sbom-alloverrides.yaml) example edited as appropriate. Other SPDX formats such as JSON will be supported
in future versions of the package.

The SPDX tags used are named as per the [SPDX Specification 2.2](https://spdx.github.io/spdx-spec/), this spec should be 
consulted for the format of the values of these tags although the all overrides sbom example documents these
also.

To generate the SBOM follow the instructions in the [example readme](/example/example.md) selecting the command line options you need if any.
The output of the generation is a sbom.spdx file in the top level directory of the package. 

The sbom.spdx file can be validated using this [online validator](https://tools.spdx.org/app/validate/) and selecting the tag value format.
Note that if any warnings are output during the generation then the sbom.spdx file may not pass validation, the warnings should 
inform you of what the problem may be.

Only the document creation, package and file sections of the SPDX specification are generated,
this results in a minimal SPDX document that will pass validation. All section mandatory SPDX fields are generated either
from the package information or known constants, mandatory fields that are not deducible are defaulted, usually to the
NOASSERTION tag value.

The package verification code is generated from the SHA1 digests of a combination of all the Dart files in the 
package with that of the pubspec.yaml file.  The algorithm used is from section 3.9.4 of the SPDX 2.2 specification.



