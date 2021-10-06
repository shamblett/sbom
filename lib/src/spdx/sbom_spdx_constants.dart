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
  dataLicense,
  identifier,
  documentName,
  documentNamespace,
  externalDocumentRefs,
  licenseListVersion
}

/// SPDX constants
class SbomSpdxConstants {
  // Specification tag value constants.
  static const String version = 'SPDX-2.2';
  static const String license = 'CC0-1.0';
  static const String idReference = 'SPDXRef-DOCUMENT';
  static const String licenseListVersion = '3.8';

  /// Output Format
  static const String spdxOutputFormatDirective = 'SPDXFormat';
  static const String spdxOutputTagValue = 'tagvalue';
  static const String spdxOutputJson = 'json';

  /// Format specific
  static const String spdxTagValueSeparator = ':';
}
