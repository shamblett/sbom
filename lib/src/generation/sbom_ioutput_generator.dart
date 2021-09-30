/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The SBOM output generator interface class.
abstract class SbomIOutputGenerator {
  /// Build
  void build();

  /// Generate
  void generate();
}
