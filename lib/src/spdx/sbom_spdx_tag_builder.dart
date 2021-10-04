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
    // Document creation
    _add(SbomSpdxTag.mandatory(SbomSpdxTagType.version, 'SPDXVersion',
        SbomSpdxSection.documentCreation, 1));
    // Version is pre defined.
    _tags[0].value = SbomSpdxConstants.spdxVersion;
    _add(SbomSpdxTag.mandatory(SbomSpdxTagType.dataLicense, 'DataLicense',
        SbomSpdxSection.documentCreation, 2));
    // License is predefined
    _tags[1].value = SbomSpdxConstants.spdxLicense;

    return _tags;
  }

  /// Add a tag, checking the tag type is not already present.
  void _add(SbomSpdxTag tag) {
    if (_tags.where((e) => e.type == tag.type).isNotEmpty) {
      throw Exception(
          'SpdxTagBuilder: ERROR duplicate tag type found ${tag.type.toString().split('.')[1]}');
    }
    _tags.add(tag);
  }
}
