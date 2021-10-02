/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tags
class SbomSpdxTags {
  /// Construction
  SbomSpdxTags();

  /// The tag database.
  final List<SbomSpdxTag> tags = SbomSpdxTagBuilder().build();

  /// Get all tags for a specified section in section position order.
  List<SbomSpdxTag> sectionTags(SbomSpdxSection section) {
    var selection =
        tags.where((element) => element.section == section).toList();
    selection.sort((a, b) => a.position.compareTo(b.position));
    return selection;
  }

  /// Get a tag by its type.
  SbomSpdxTag tagByType(SbomSpdxTagType type) =>
      tags.where((e) => e.type == type).single;

  /// Get a tag by its name
  SbomSpdxTag tagByName(String name) =>
      tags.where((e) => e.name == name).single;

  /// Check if a section is valid, i.e all its mandatory tags have values.
  /// Returns a list of mandatory tags that do not have values, empty
  /// indicating the section is valid.
  List<SbomSpdxTag> sectionValid(SbomSpdxSection section) =>
      sectionTags(section)
          .where((e) => e.mandatory && e.values.isEmpty)
          .toList();
}
