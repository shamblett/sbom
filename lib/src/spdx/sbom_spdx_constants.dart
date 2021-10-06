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
  licenseListVersion,
  creator,
  created,
  creatorComment,
  documentComment
}

/// SPDX constants
class SbomSpdxConstants {
  // Specification tag names
  // Document creation
  static const String tagVersion = 'SPDXVersion';
  static const String tagDataLicense = 'DataLicense';
  static const String tagIdentifier = 'SPDXID';
  static const String tagDocumentName = 'DocumentName';
  static const String tagDocumentNamespace = 'DocumentNamespace';
  static const String tagExternalDocumentRefs = 'ExternalDocumentRef';
  static const String tagLicenseListVersion = 'LicenseListVersion';
  static const String tagCreator = 'Creator';
  static const String tagCreated = 'Created';
  static const String tagCreatorComment = 'CreatorComment';
  static const String tagDocumentComment = 'DocumentComment';

  // Specification tag value constants.
  static const String version = 'SPDX-2.2';
  static const String license = 'CC0-1.0';
  static const String idReference = 'SPDXRef-DOCUMENT';
  static const String licenseListVersion = '3.8';
  // Needs the version of sbom appending
  static const String creatorTool = 'Tool: sbom-';

  /// Output Format
  static const String spdxOutputFormatDirective = 'SPDXFormat';
  static const String spdxOutputTagValue = 'tagvalue';
  static const String spdxOutputJson = 'json';

  /// Format specific
  static const String spdxTagValueSeparator = ':';
}
