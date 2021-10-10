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
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.documentName,
        SbomSpdxSectionNames.documentCreation, 4));
    _add(SbomSpdxTag.mandatory(SbomSpdxTagNames.documentNamespace,
        SbomSpdxSectionNames.documentCreation, 5));
    _add(SbomSpdxTag(SbomSpdxTagNames.externalDocumentRefs,
        SbomSpdxSectionNames.documentCreation, 6));
    _add(SbomSpdxTag(SbomSpdxTagNames.licenseListVersion,
        SbomSpdxSectionNames.documentCreation, 7));
    // License list version is predefined
    _tags[6].value = SbomSpdxConstants.licenseListVersion;
    _add(SbomSpdxTag.mandatory(
        SbomSpdxTagNames.creator, SbomSpdxSectionNames.documentCreation, 8));
    _add(SbomSpdxTag.mandatory(
        SbomSpdxTagNames.created, SbomSpdxSectionNames.documentCreation, 9));
    _add(SbomSpdxTag(SbomSpdxTagNames.creatorComment,
        SbomSpdxSectionNames.documentCreation, 10));
    _add(SbomSpdxTag(SbomSpdxTagNames.documentComment,
        SbomSpdxSectionNames.documentCreation, 11));
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
