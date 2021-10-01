/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tag type
enum SbomSpdxTagType {
  // Document creation
  version,
  license
}

/// SPDX tags
class SbomSpdxTags {
  /// Construction
  SbomSpdxTags() {
    _buildDatabase();
  }

  /// The tag database.
  final List<SbomSpdxTag> tags = <SbomSpdxTag>[];

  /// Build the tag database.
  void _buildDatabase() {
    tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.version, 'SPDXVersion',
        SbomSpdxSection.documentCreation, 1));
    // Version is pre defined.
    tags[0].value = SbomSpdxConstants.spdxVersion;
    tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.license, 'DataLicense',
        SbomSpdxSection.documentCreation, 2));
    // License is predefined
    tags[1].value = SbomSpdxConstants.spdxLicense;
  }

  /// Get all tags for a specified section in section order.
  List<SbomSpdxTag> sectionTags(SbomSpdxSection section) {
    var selection =
        tags.where((element) => element.section == section).toList();
    selection.sort((a, b) => a.position.compareTo(b.position));
    return selection;
  }
}
