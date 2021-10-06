/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The main SBOM output generator class.
class SbomGenerator {
  /// Construction.
  SbomGenerator(this.configuration);

  /// The valid SBOM configuration.
  final SbomConfiguration configuration;

  /// Validity
  bool valid = false;

  /// Generate.
  void generate() {
    // Generate according to type
    SbomIOutputGenerator output;
    switch (configuration.outputType) {
      case SbomType.spdx:
        {
          output = SbomSpdxOutputGenerator(configuration);
        }
        break;
      default:
        {
          SbomUtilities.error('SBOM Type is invalid or not set.');
          valid = false;
          return;
        }
    }
    var result = output.build();
    if ( !result) {
      SbomUtilities.error('Failed to build SBOM for type SPDX.');
      valid = false;
      return;
    }
  }
}
