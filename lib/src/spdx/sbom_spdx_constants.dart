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
