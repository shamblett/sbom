/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tag builder.
/// Builds the SPDX tags as per the specification.
class SbomSpdxTagBuilder extends SbomITagBuilder {
  final List<SbomSpdxTag> _tags = <SbomSpdxTag>[];

  /// Build the database.
  @override
  List<SbomSpdxTag> build() {
    _documentCreation();
    _package();
    return _tags;
  }

  /// Document creation section.
  void _documentCreation() {
    _add(SbomSpdxTag.mandatory(
        SbomSpdxTagNames.version, SbomSpdxSectionNames.documentCreation, 1));
    // Version is pre defined.
    _tags[0].value = SbomSpdxConstants.version;
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.dataLicense,
        SbomSpdxSectionNames.documentCreation, 2));
    // License is predefined
    _tags[1].value = SbomSpdxConstants.license;
    _add(SbomSpdxTag.mandatory(
        SbomSpdxTagNames.identifier, SbomSpdxSectionNames.documentCreation, 3));
    // Identifier is predefined
    _tags[2].value = '${SbomSpdxConstants.idReference}DOCUMENT';
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.documentName,
        SbomSpdxSectionNames.documentCreation, 4, true));
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.documentNamespace,
        SbomSpdxSectionNames.documentCreation, 5, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.externalDocumentRefs,
        SbomSpdxSectionNames.documentCreation, 6, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.licenseListVersion,
        SbomSpdxSectionNames.documentCreation, 7));
    // License list version is predefined
    _tags[6].value = SbomSpdxConstants.licenseListVersion;
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.creator,
        SbomSpdxSectionNames.documentCreation, 8, true));
    // Tool creator is predefined
    _tags[7].value =
        '${SbomSpdxConstants.creatorTool}${SbomConstants.pubUrl}${SbomConstants.package}';
    _add(SbomSpdxTag.mandatory(
        SbomSpdxTagNames.created, SbomSpdxSectionNames.documentCreation, 9));
    // Created time is predefined
    _tags[8].value = SbomSpdxUtilities.createdAt();
    _add(SbomSpdxTag(SbomSpdxTagNames.creatorComment,
        SbomSpdxSectionNames.documentCreation, 10, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.documentComment,
        SbomSpdxSectionNames.documentCreation, 11, true));
  }

  /// Package section
  void _package() {
    _add(SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageName, SbomSpdxSectionNames.package, 1));
    _add(SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageIdentifier, SbomSpdxSectionNames.package, 2));
    _add(SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageVersion, SbomSpdxSectionNames.package, 3));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageFileName,
        SbomSpdxSectionNames.package, 4, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageSupplier,
        SbomSpdxSectionNames.package, 5, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageOriginator,
        SbomSpdxSectionNames.package, 6, true));
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.packageDownloadLocation,
        SbomSpdxSectionNames.package, 7));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageFilesAnalyzed,
        SbomSpdxSectionNames.package, 8));
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.packageVerificationCode,
        SbomSpdxSectionNames.package, 9));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageChecksum,
        SbomSpdxSectionNames.package, 10, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageHomePage,
        SbomSpdxSectionNames.package, 11, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageSourceInfo,
        SbomSpdxSectionNames.package, 12, true));
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.packageLicenseConcluded,
        SbomSpdxSectionNames.package, 13, true));
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.packageLicenseInfoFromFiles,
        SbomSpdxSectionNames.package, 14, true));
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.packageLicenseDeclared,
        SbomSpdxSectionNames.package, 15, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageLicenseComments,
        SbomSpdxSectionNames.package, 16, true));
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.packageCopyrightText,
        SbomSpdxSectionNames.package, 17, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageSummary,
        SbomSpdxSectionNames.package, 18, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageDescription,
        SbomSpdxSectionNames.package, 19, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageComment,
        SbomSpdxSectionNames.package, 20, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageExternalRef,
        SbomSpdxSectionNames.package, 21, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageExternalRefComment,
        SbomSpdxSectionNames.package, 22, true));
    _add(SbomSpdxTag(SbomSpdxTagNames.packageAttributionText,
        SbomSpdxSectionNames.package, 23, true));
  }

  /// Add a tag, checking the tag type and position is not already present.
  void _add(SbomSpdxTag tag) {
    if (_tags.where((e) => e.name == tag.name).isNotEmpty) {
      throw Exception(
          'SpdxTagBuilder: ERROR duplicate tag type found ${tag.name}');
    }
    if (_tags
        .where((e) => e.section == tag.section && e.position == tag.position)
        .isNotEmpty) {
      throw Exception(
          'SpdxTagBuilder: ERROR duplicate position found ${tag.position} in section ${tag.section}');
    }
    _tags.add(tag);
  }
}
