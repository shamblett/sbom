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

  /// Output generator
  late SbomIOutputGenerator output;

  /// The generated tags.
  SbomTags get tags => output.tags;

  /// Path(absolute) to the generated SBOM file.
  /// Set on successful generation.
  String sbomFilePath = '';

  /// Generate.
  void generate() {
    // Generate according to type

    switch (configuration.outputType) {
      case SbomType.spdx:
        {
          output = SbomSpdxOutputGenerator(configuration);
          print('SBOM type is SPDX');
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
    if (!result) {
      SbomUtilities.error('Failed to build SBOM for type SPDX.');
      valid = false;

      return;
    }
    result = output.validate();
    if (!result) {
      SbomUtilities.error('Failed to validate SBOM for type SPDX.');
      valid = false;

      return;
    }
    result = output.generate();
    if (!result) {
      SbomUtilities.error('Failed to generate SBOM for type SPDX.');
      valid = false;

      return;
    }
    sbomFilePath = output.sbomFilePath;
    valid = true;
  }
}
