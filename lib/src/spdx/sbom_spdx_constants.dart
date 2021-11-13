/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX constants
class SbomSpdxConstants {
  // Specification tag value constants.
  static const String version = 'SPDX-2.2';
  static const String license = 'CC0-1.0';
  static const String idReference = 'SPDXRef-';
  static const String licenseListVersion = '3.8';
  static const String creatorPerson = 'Person: ';
  static const String creatorTool = 'Tool: ';
  static const String creatorOrganisation = 'Organisation: ';
  static const String textStart = '<text>';
  static const String textEnd = '</text>';

  // External reference category
  static const String externalRefCategorySecurity = 'SECURITY';
  static const String externalRefCategoryPm = 'PACKAGE-MANAGER';
  static const String externalRefCategoryPersistent = 'PERSISTENT-ID';
  static const String externalRefCategoryOther = 'OTHER';

  // External reference type
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
  static const String spdxTagValueSeparator = ': ';

  /// SPDX sbom file name
  static const String outputFileName = 'sbom.spdx';

  /// License
  static const licenseIsDeprecatedId = 'isDeprecatedLicenseId';
  static const licenseIsFsfLibre = 'isFsfLibre';
  static const licenseText = 'licenseText';
  static const licenseStandardHeaderTemplate = 'standardLicenseHeaderTemplate';
  static const licenseStandardTemplate = 'standardLicenseTemplate';
  static const licenseName = 'name';
  static const licenseComments = 'licenseComments';
  static const licenseId = 'licenseId';
  static const licenseStandardHeader = 'standardLicenseHeader';
  static const licenseSeeAlso = 'seeAlso';
  static const licenseIsOsiApproved = 'isOsiApproved';
  static const licenceDirectory = 'lib/src/spdx/licences';
  static const licenseNoAssertion = 'NOASSERTION';
}
