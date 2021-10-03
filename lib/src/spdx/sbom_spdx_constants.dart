/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX sections
enum SbomSpdxSection {
  documentCreation,
  package,
  file,
  snippet,
  otherLicensing,
}

/// SPDX tag type.
enum SbomSpdxTagType {
  // Document creation
  version,
  license
}

/// SPDX constants
class SbomSpdxConstants {
  // Specification constants.
  static const String spdxVersion = 'SPDX-2.2';
  static const String spdxLicense = 'CC0-1.0';

  /// Output Format
  static const String spdxOutputFormatDirective = 'SPDXFormat';
  static const String spdxOutputTagValue = 'tagvalue';
  static const String spdxOutputJson = 'json';

  /// Format specific
  static const String spdxTagValueSeparator = ':';
}
