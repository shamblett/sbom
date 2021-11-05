/*
* Package : sbom
* Author : S. Hamblett <steve.hamblett@linux.com>
* Date   : 22/09/2021
* Copyright :  S.Hamblett
*
* Ported originally from https://github.com/adaptant-labs/spdx-licenses-dart
*/

part of sbom;

/// License details class
class SbomSpdxLicenseDetails {
  late bool isDeprecatedLicenseId;
  late bool isFsfLibre;
  late String licenseText;
  late String standardLicenseHeaderTemplate;
  late String standardLicenseTemplate;
  late String name;
  late String licenseComments;
  late String licenseId;
  late String standardLicenseHeader;
  late List<String> seeAlso;
  late bool isOsiApproved;

  SbomSpdxLicenseDetails();

  SbomSpdxLicenseDetails.fromJson(Map<String, dynamic> json) {
    isDeprecatedLicenseId = json['isDeprecatedLicenseId'];
    isFsfLibre = json['isFsfLibre'];
    licenseText = json['licenseText'];
    standardLicenseHeaderTemplate = json['standardLicenseHeaderTemplate'];
    standardLicenseTemplate = json['standardLicenseTemplate'];
    name = json['name'];
    licenseComments = json['licenseComments'];
    licenseId = json['licenseId'];
    standardLicenseHeader = json['standardLicenseHeader'];
    seeAlso = json['seeAlso'].cast<String>();
    isOsiApproved = json['isOsiApproved'];
  }
}

/// Main license class
class SbomSpdxLicense {
  SbomSpdxLicense();

  /// Current version of the license list
  String licenseListVersion = SbomSpdxConstants.licenseListVersion;

  /// Licence details
  late Map<String,SbomSpdxLicenseDetails> licenses;

  _licenseList() {}
}
