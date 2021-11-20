/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX constants
class SbomSpdxConstants {
  /// Specification tag value constants.
  static const String version = 'SPDX-2.2';
  static const String license = 'CC0-1.0';
  static const String idReference = 'SPDXRef-';
  static const String licenseListVersion = '3.8';
  static const String creatorPerson = 'Person: ';
  static const String creatorTool = 'Tool: ';
  static const String creatorOrganisation = 'Organization: ';
  static const String textStart = '<text>';
  static const String textEnd = '</text>';
  static const String fileSourceType = 'SOURCE';
  static const String fileTextType = 'TEXT';
  static const String sha1Tag = 'SHA1';

  /// External reference category
  static const String externalRefCategorySecurity = 'SECURITY';
  static const String externalRefCategoryPm = 'PACKAGE-MANAGER';
  static const String externalRefCategoryPersistent = 'PERSISTENT-ID';
  static const String externalRefCategoryOther = 'OTHER';

  /// External reference type
  static const String externalRefTypeCpe22 = 'cpe22Type';
  static const String externalRefTypeCpe23 = 'cpe23Type';
  static const String externalRefTypeMaven = 'maven-central';
  static const String externalRefTypeNpm = 'npm';
  static const String externalRefTypeNuget = 'nuget';
  static const String externalRefTypeBower = 'bower';
  static const String externalRefTypePurl = 'purl';
  static const String externalRefTypeSwh = 'swh';

  /// Output Format
  static const String spdxOutputFormatDirective = 'SPDXFormat';
  static const String spdxOutputTagValue = 'tagvalue';
  static const String spdxOutputJson = 'json';

  /// Format specific
  static const String tagValueSeparator = ': ';
  static const int numberOfFileTags = 7;

  /// SPDX sbom file name
  static const String outputFileName = 'sbom.spdx';

  /// License
  static const String licenseIsDeprecatedId = 'isDeprecatedLicenseId';
  static const String licenseIsFsfLibre = 'isFsfLibre';
  static const String licenseText = 'licenseText';
  static const String licenseStandardHeaderTemplate =
      'standardLicenseHeaderTemplate';
  static const String licenseStandardTemplate = 'standardLicenseTemplate';
  static const String licenseName = 'name';
  static const String licenseComments = 'licenseComments';
  static const String licenseId = 'licenseId';
  static const String licenseStandardHeader = 'standardLicenseHeader';
  static const String licenseSeeAlso = 'seeAlso';
  static const String licenseIsOsiApproved = 'isOsiApproved';
  static const String licenceDirectory = 'lib/src/spdx/licences';
  static const String licenseNoAssertion = 'NOASSERTION';

  /// Tag value Validation
  static const List<String> packageTextTags = [
    SbomSpdxTagNames.packageLicenseComments,
    SbomSpdxTagNames.packageSummary,
    SbomSpdxTagNames.packageDescription,
    SbomSpdxTagNames.packageComment,
    SbomSpdxTagNames.packageSourceInfo,
    SbomSpdxTagNames.packageExternalRefComment,
    SbomSpdxTagNames.packageAttributionText
  ];

  static const List<String> documentTextTags = [
    SbomSpdxTagNames.creatorComment,
    SbomSpdxTagNames.documentComment
  ];

  static const Map<String, List<String>> packageExternalRefTag = {
    externalRefCategorySecurity: [externalRefTypeCpe22, externalRefTypeCpe23],
    externalRefCategoryPm: [
      externalRefTypeMaven,
      externalRefTypeNpm,
      externalRefTypeNuget,
      externalRefTypeBower,
      externalRefTypePurl
    ],
    externalRefCategoryPersistent: [externalRefTypeSwh],
    externalRefCategoryOther: []
  };
}
