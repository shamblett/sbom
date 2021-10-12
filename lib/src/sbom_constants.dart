/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The main sbom constants class
class SbomConstants {
  /// General off/none indicator for integers
  static const int off = 0;

  /// Verbosity(Loudness)
  static const int loud = 1;
  static const int louder = 2;

  /// Terminal colours
  static const String yellow = '\u001b[33m';
  static const String red = '\u001b[31m';

  /// File names
  static const String sbomConfigurationFile = 'sbom.yaml';
  static const String sbomPubspecFile = 'pubspec.yaml';

  /// SBOM Configuration file fields
  static const String sbomType = 'type';

  /// SBOM Configuration file values.
  static const String sbomSpdx = 'spdx';

  /// This package name
  static const String package = 'sbom';
}
