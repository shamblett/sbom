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

  /// Validate tag value text fields
  static void checkTagValueTextFields(SbomTag tag, String section) {
    for (final value in tag.values) {
      if ((!value.startsWith(SbomSpdxConstants.textStart)) &&
          (!value.endsWith(SbomSpdxConstants.textEnd))) {
        SbomUtilities.warning(
            'Invalid tag value found in configuration for the $section section, tag name '
            '${SbomSpdxUtilities.getSpecTagName(tag.name)} - SBOM may not pass validation');
      }
    }
  }

  /// Format a file path.
  static String formatFilePath(String path) {
    path = path.replaceAll('\\\\', '/');
    path = path.replaceAll('\\', '/');

    return '/$path';
  }
}
