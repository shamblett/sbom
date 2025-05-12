// ignore_for_file: avoid-global-state

/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of '../sbom.dart';

/// Utility functions for the SBOM package.
class SbomUtilities {
  /// Verbosity(Loudness)
  static var verbosity = SbomConstants.off;

  /// Last output, for testing.
  static var last = '';

  /// Loud verbosity logging.
  static void loud(String text) {
    if (verbosity >= SbomConstants.loud) {
      print(text);
      last = text;
    }
  }

  /// Louder verbosity logging.
  static void louder(String text) {
    if (verbosity >= SbomConstants.louder) {
      print(text);
      last = text;
    }
  }

  /// Warning
  static void warning(String text) {
    final out = 'WARN: $text';
    print('${SbomConstants.yellow}$out');
    last = out;
  }

  /// Error
  static void error(String text) {
    final out = 'ERROR: $text';
    print('${SbomConstants.red}$out');
    last = out;
  }

  /// Tag names to string for logging.
  static String tagsToString(List tags) {
    var output = '';
    for (final tag in tags) {
      output += '${tag.name},';
    }

    return '${output.characters.getRange(0, output.length - 1)}';
  }
}
