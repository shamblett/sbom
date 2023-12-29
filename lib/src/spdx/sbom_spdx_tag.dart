/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of '../../sbom.dart';

/// SPDX tag class.
class SbomSpdxTag extends SbomTag<String> {
  /// Construction
  SbomSpdxTag(super.name, super.section, super.position,
      [this.canBeOverridden = false]);

  // ignore: use_super_parameters
  SbomSpdxTag.mandatory(name, section, position, [this.canBeOverridden = false])
      : super.mandatory(name, section, position);

  /// Indicates the tag can be overridden by configuration.
  bool canBeOverridden = false;
}
