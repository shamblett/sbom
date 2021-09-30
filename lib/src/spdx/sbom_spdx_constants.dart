/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SPDX constants
class SbomSPDXConstants {
  /// Output Format
  static const String spdxOutputFormatDirective = 'SPDXFormat';
  static const String spdxOutputTagValue = 'tagvalue';
  static const String spdxOutputJson = 'json';

  /// Format specific
  static const String spdxTagValueSeparator = ':';
}
