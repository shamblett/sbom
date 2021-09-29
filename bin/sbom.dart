/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

import 'package:sbom/sbom.dart';

/// SBOM
int main(List<String> args) {
  // Announce
  print('SBOM generator for Dart packages');
  // Construct the SBOM configuration
  final configuration = SbomConfiguration(args);

  // Check validity, if not valid then return.
  // The user may have just asked for usage or some other
  // error occurred.
  if (!configuration.valid) {
    return 0;
  }

  // Parse the SBOM configuration file
  configuration.parseSbomFile();
  if (!configuration.valid) {
    return -1;
  }

  // Finish
  print('SBOM generation complete');
  return 0;
}
