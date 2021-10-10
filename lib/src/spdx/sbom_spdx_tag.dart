/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX tag class.
class SbomSpdxTag extends SbomTag<String> {
  /// Construction
  SbomSpdxTag(name, section, position) : super(name, section, position);

  SbomSpdxTag.mandatory(name, section, position)
      : super.mandatory(name, section, position);
}
