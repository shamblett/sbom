/*
* Package : sbom
* Author : S. Hamblett <steve.hamblett@linux.com>
* Date   : 22/09/2021
* Copyright :  S.Hamblett
*
* Ported originally from https://github.com/adaptant-labs/spdx-licenses-dart
*/

part of '../../sbom.dart';

/// License details class
class SbomSpdxLicenseDetails {
  SbomSpdxLicenseDetails();

  SbomSpdxLicenseDetails.fromJson(Map json) {
    isDeprecatedLicenseId =
        json.containsKey(SbomSpdxConstants.licenseIsDeprecatedId)
            ? json[SbomSpdxConstants.licenseIsDeprecatedId]
            : false;
    isFsfLibre = json.containsKey(SbomSpdxConstants.licenseIsFsfLibre)
        ? json[SbomSpdxConstants.licenseIsFsfLibre]
        : false;
    licenseText = json[SbomSpdxConstants.licenseText];
    standardLicenseHeaderTemplate =
        json.containsKey(SbomSpdxConstants.licenseStandardHeaderTemplate)
            ? json[SbomSpdxConstants.licenseStandardHeaderTemplate]
            : '';
    standardLicenseTemplate = json[SbomSpdxConstants.licenseStandardTemplate];
    name = json[SbomSpdxConstants.licenseName];
    licenseComments = json.containsKey(SbomSpdxConstants.licenseComments)
        ? json[SbomSpdxConstants.licenseComments]
        : '';
    licenseId = json[SbomSpdxConstants.licenseId];
    standardLicenseHeader =
        json.containsKey(SbomSpdxConstants.licenseStandardHeader)
            ? json[SbomSpdxConstants.licenseStandardHeader]
            : '';
    seeAlso = json[SbomSpdxConstants.licenseSeeAlso].cast<String>();
    isOsiApproved = json[SbomSpdxConstants.licenseIsOsiApproved];
  }

  /// License description fields
  bool isDeprecatedLicenseId = false;
  bool isFsfLibre = false;
  String licenseText = '';
  String standardLicenseHeaderTemplate = '';
  String standardLicenseTemplate = '';
  String name = '';
  String licenseComments = '';
  String licenseId = '';
  String standardLicenseHeader = '';
  List<String> seeAlso = <String>[];
  bool isOsiApproved = false;
}

/// Main license class
class SbomSpdxLicense {
  SbomSpdxLicense() {
    _buildLicenceList();
  }

  /// Current version of the license list
  String licenseListVersion = SbomSpdxConstants.licenseListVersion;

  /// Licence details
  late Map<String, SbomSpdxLicenseDetails> licenses =
      <String, SbomSpdxLicenseDetails>{};

  /// Get the license identifier of a package license.
  /// Returns the SPDX license id as defined in the SPDX Specification Appendix V
  /// or NOASSERTION if the license cannot be determined.
  String licenseId(String text) {
    var output = SbomSpdxConstants.noAssertion;
    final details =
        licenses.keys.firstWhere((e) => text.contains(e), orElse: () => '');
    if (details.isNotEmpty) {
      output = licenses[details]!.licenseId;
    }

    return output;
  }

  // Builds the licence list from the raw licence data
  void _buildLicenceList() {
    for (final entry in allLicences) {
      final details = SbomSpdxLicenseDetails.fromJson(entry);
      licenses[details.name] = details;
    }
  }

}
