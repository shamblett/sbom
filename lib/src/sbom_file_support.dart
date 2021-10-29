/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The SBOM file support class.
/// Provides convenience methods for file listings, SHA1 generation etc.
class SbomFileSupport {
  /// Construction
  SbomFileSupport(this._topLevelPath);

  /// Package top level
  final String _topLevelPath;
}
