/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX section names from the SPDX specification.
class SbomSpdxSectionNames {

  static const String documentCreation = 'documentCreation';
  static const String package = 'package';
  static const String file = 'file';
  static const String snippet = 'snippet';
  static const String otherLicensing = 'otherLicensing';
  static const String annotations = 'annotations';

}
