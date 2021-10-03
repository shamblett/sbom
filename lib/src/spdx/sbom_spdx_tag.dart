/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tag class.
class SbomSpdxTag extends SbomTag<SbomSpdxTagType, SbomSpdxSection> {
  /// Construction
  SbomSpdxTag(type, name, section, position)
      : super(type, name, section, position);

  SbomSpdxTag.mandatory(type, name, section, position)
      : super.mandatory(type, name, section, position);
}
