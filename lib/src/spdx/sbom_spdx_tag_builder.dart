/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tag builder.
/// Builds the SPDX tags as per the specification.
class SbomSpdxTagBuilder {
  /// Build the database.
  List<SbomSpdxTag> build() {
    final List<SbomSpdxTag> tags = <SbomSpdxTag>[];
    // Document creation
    tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.version, 'SPDXVersion',
        SbomSpdxSection.documentCreation, 1));
    // Version is pre defined.
    tags[0].value = SbomSpdxConstants.spdxVersion;
    tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.license, 'DataLicense',
        SbomSpdxSection.documentCreation, 2));
    // License is predefined
    tags[1].value = SbomSpdxConstants.spdxLicense;

    return tags;
  }
}
