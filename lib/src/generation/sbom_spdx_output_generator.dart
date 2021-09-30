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

  /// The SPDX class
  final SbomSpdx spdx;

  /// Build
  @override
  void build() {}

  /// Generate
  @override
  void generate() {}
}
