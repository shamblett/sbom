/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tag class
class SbomSpdxTag {
  /// Construction
  SbomSpdxTag(this.name, this.section);

  SbomSpdxTag.mandatory(this.name, this.section) {
    _mandatory = true;
  }

  /// Name.
  final String name;

  /// Mandatory, true indicates mandatory.
  bool _mandatory = false;
  bool get mandatory => _mandatory;

  /// Value.
  String value = '';

  /// Document section.
  final String section;
}
