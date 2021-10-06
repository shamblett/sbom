/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The SBOM SPDX output generator class.
class SbomSpdxOutputGenerator extends SbomIOutputGenerator {
  /// Construction
  SbomSpdxOutputGenerator(this.spdx);

  /// SBOM configuration.
  final SbomConfiguration spdx;

  /// Build
  @override
  bool build() {
    return false;
  }

  /// Validate
  @override
  bool validate() {
    return false;
  }

  /// Generate
  @override
  bool generate() {
    return false;
  }
}
