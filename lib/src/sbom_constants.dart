/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of '../sbom.dart';

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
  static const String reset = '\u001b[0m';

  /// File names
  static const String sbomConfigurationFile = 'sbom.yaml';
  static const String sbomPubspecFile = 'pubspec.yaml';
  static const String sbomLicenseFile = 'LICENSE';

  /// SBOM Configuration file fields
  static const String sbomType = 'type';

  /// SBOM Configuration file values.
  static const String sbomSpdx = 'spdx';

  /// This package name
  static const String package = 'sbom';

  /// Pubspec names.
  static const String pubspecName = 'name';
  static const String pubspecVersion = 'version';
  static const String pubspecDescription = 'description';

  /// Site names.
  static const String pubUrl = 'https://pub.dev/packages/';

  /// Package directories
  static const libDir = 'lib';
  static const binDir = 'bin';

  /// Dart file type
  static const dartFiletype = '.dart';

  /// Default package name we are generating for.
  static const String defaultPackageName = 'ERROR - name not set';
}
