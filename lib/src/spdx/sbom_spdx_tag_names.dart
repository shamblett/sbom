/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of '../../sbom.dart';

/// SPDX tag names as defined by the SPDX specification.
/// A shortened version of the document section name is prepended to
/// ensure uniqueness.
class SbomSpdxTagNames {
  static const String documentCreationSectionId = 'DC-';
  static const String packageSectionId = 'P-';
  static const String fileSectionId = 'F-';
  static const String relationshipId = 'R-';

  /// Document creation
  static const String version = '${documentCreationSectionId}SPDXVersion';
  static const String dataLicense = '${documentCreationSectionId}DataLicense';
  static const String identifier = '${documentCreationSectionId}SPDXID';
  static const String documentName = '${documentCreationSectionId}DocumentName';
  static const String documentNamespace =
      '${documentCreationSectionId}DocumentNamespace';
  static const String externalDocumentRefs =
      '${documentCreationSectionId}ExternalDocumentRef';
  static const String licenseListVersion =
      '${documentCreationSectionId}LicenseListVersion';
  static const String creator = '${documentCreationSectionId}Creator';
  static const String created = '${documentCreationSectionId}Created';
  static const String creatorComment =
      '${documentCreationSectionId}CreatorComment';
  static const String documentComment =
      '${documentCreationSectionId}DocumentComment';

  /// Package
  static const String packageName = '${packageSectionId}PackageName';
  static const String packageIdentifier = '${packageSectionId}SPDXID';
  static const String packageVersion = '${packageSectionId}PackageVersion';
  static const String packageFileName = '${packageSectionId}PackageFileName';
  static const String packageSupplier = '${packageSectionId}PackageSupplier';
  static const String packageOriginator =
      '${packageSectionId}PackageOriginator';
  static const String packageDownloadLocation =
      '${packageSectionId}PackageDownloadLocation';
  static const String packageFilesAnalyzed = '${packageSectionId}FilesAnalyzed';
  static const String packageVerificationCode =
      '${packageSectionId}PackageVerificationCode';
  static const String packageChecksum = '${packageSectionId}PackageChecksum';
  static const String packageHomePage = '${packageSectionId}PackageHomePage';
  static const String packageSourceInfo =
      '${packageSectionId}PackageSourceInfo';
  static const String packageLicenseConcluded =
      '${packageSectionId}PackageLicenseConcluded';
  static const String packageLicenseInfoFromFiles =
      '${packageSectionId}PackageLicenseInfoFromFiles';
  static const String packageLicenseDeclared =
      '${packageSectionId}PackageLicenseDeclared';
  static const String packageLicenseComments =
      '${packageSectionId}PackageLicenseComments';
  static const String packageCopyrightText =
      '${packageSectionId}PackageCopyrightText';
  static const String packageSummary = '${packageSectionId}PackageSummary';
  static const String packageDescription =
      '${packageSectionId}PackageDescription';
  static const String packageComment = '${packageSectionId}PackageComment';
  static const String packageExternalRef = '${packageSectionId}ExternalRef';
  static const String packageExternalRefComment =
      '${packageSectionId}ExternalRefComment';
  static const String packageAttributionText =
      '${packageSectionId}PackageAttributionText';

  /// File
  static const String fileFileName = '${fileSectionId}FileName';
  static const String filePackageIdentifier = '${fileSectionId}SPDXID';
  static const String fileFileType = '${fileSectionId}FileType';
  static const String fileFileChecksum = '${fileSectionId}FileChecksum';
  static const String fileLicenceConcluded = '${fileSectionId}LicenseConcluded';
  static const String fileLicenseInfoInFile =
      '${fileSectionId}LicenseInfoInFile';
  static const String fileLicenseComments = '${fileSectionId}LicenseComments';
  static const String fileCopyrightText = '${fileSectionId}FileCopyrightText';

  /// Relationship
  static const String relationship = '${relationshipId}Relationship';
}
