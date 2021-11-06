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
  SbomSpdxLicenseDetails();

  SbomSpdxLicenseDetails.fromJson(Map<String, dynamic> json) {
    isDeprecatedLicenseId = json[SbomSpdxConstants.licenseIsDeprecatedId];
    isFsfLibre = json[SbomSpdxConstants.licenseIsFsfLibre];
    licenseText = json[SbomSpdxConstants.licenseText];
    standardLicenseHeaderTemplate =
        json[SbomSpdxConstants.licenseStandardHeaderTemplate];
    standardLicenseTemplate = json[SbomSpdxConstants.licenseStandardTemplate];
    name = json[SbomSpdxConstants.licenseName];
    licenseComments = json[SbomSpdxConstants.licenseComments];
    licenseId = json[SbomSpdxConstants.licenseId];
    standardLicenseHeader = json[SbomSpdxConstants.licenseStandardHeader];
    seeAlso = json[SbomSpdxConstants.licenseSeeAlso].cast<String>();
    isOsiApproved = json[SbomSpdxConstants.licenseIsOsiApproved];
  }

  /// License description fields
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
}

/// Main license class
class SbomSpdxLicense {
  SbomSpdxLicense() {
    _licenseList();
  }

  /// Current version of the license list
  String licenseListVersion = SbomSpdxConstants.licenseListVersion;

  /// Licence details
  late Map<String, SbomSpdxLicenseDetails> licenses;

  void _licenseList() {
    final licenseDirectoryPath =
        path.join(path.current, SbomSpdxConstants.licenceDirectory);
    final licenseDir = Directory(licenseDirectoryPath);
    final files = licenseDir.listSync();
    for (final file in files) {
      final contents = File(file.path).readAsStringSync();
      final details = SbomSpdxLicenseDetails.fromJson(json.decode(contents));
      licenses[details.name] = details;
    }
  }
}
