/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tag names as defined by the SPDX specification.
class SbomSpdxTagNames {

  // Common
  static const String identifier = 'SPDXID';

  // Document creation
  static const String version = 'SPDXVersion';
  static const String dataLicense = 'DataLicense';
  static const String documentName = 'DocumentName';
  static const String documentNamespace = 'DocumentNamespace';
  static const String externalDocumentRefs = 'ExternalDocumentRef';
  static const String licenseListVersion = 'LicenseListVersion';
  static const String creator = 'Creator';
  static const String created = 'Created';
  static const String creatorComment = 'CreatorComment';
  static const String documentComment = 'DocumentComment';

  // Package
  static const String packageName = 'PackageName';
  static const String packageVersion = 'PackageVersion';
  static const String packageFileName = 'PackageFileName';
  static const String packageSupplier = 'PackageSupplier';
  static const String packageOriginator = 'PackageOriginator';
  static const String packageDownloadLocation = 'PackageDownloadLocation';
  static const String packageFilesAnalyzed = 'FilesAnalyzed';
  static const String packageVerificationCode = 'PackageVerificationCode';
  static const String packageChecksum = 'PackageChecksum';
  static const String packageHomePage = 'PackageHomePage';
  static const String packageSourceInfo = 'PackageSourceInfo';
  static const String packageLicenseConcluded = 'PackageLicenseConcluded';
  static const String packageLicenseInfoFromFiles = 'PackageLicenseInfoFromFiles';
  static const String packageLicenseDeclared = 'PackageLicenseDeclared';
  static const String packageLicenseComments = 'PackageLicenseComments';
  static const String packageCopyrightText = 'PackageCopyrightText';
  static const String packageSummary = 'PackageSummary';
  static const String packageDescription = 'PackageDescription';
  static const String packageComment = 'PackageComment';
  static const String packageExternalRef = 'ExternalRef';
  static const String packageExternalRefComment = 'ExternalRefComment';
  static const String packageAttributionText = 'PackageAttributionText';

}
