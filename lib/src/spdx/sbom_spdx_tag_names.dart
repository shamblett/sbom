/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tag names as defined by the SPDX specification.
class SbomSpdxTagNames {

  // Document creation
  static const String version = 'SPDXVersion';
  static const String dataLicense = 'DataLicense';
  static const String identifier = 'SPDXID';
  static const String documentName = 'DocumentName';
  static const String documentNamespace = 'DocumentNamespace';
  static const String externalDocumentRefs = 'ExternalDocumentRef';
  static const String licenseListVersion = 'LicenseListVersion';
  static const String creator = 'Creator';
  static const String created = 'Created';
  static const String creatorComment = 'CreatorComment';
  static const String documentComment = 'DocumentComment';

}
