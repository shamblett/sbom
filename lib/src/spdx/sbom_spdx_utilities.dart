/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX utilities
class SbomSpdxUtilities {
  /// Created time in SPDX format.
  static String createdAt() =>
      '${DateTime.now().toIso8601String().split('.')[0]}Z';

  /// Gets the real(specification defined) tag name.
  static String getSpecTagName(String name) => name.split('-')[1];
}
