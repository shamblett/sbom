/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of '../../sbom.dart';

/// The SBOM output generator interface class.
abstract class SbomIOutputGenerator {
  /// The generated tags
  late SbomTags tags;

  /// Path(absolute) to the generated SBOM file.
  /// Set on successful generation.
  String sbomFilePath = '';

  /// Build
  bool build();

  /// Validate
  bool validate();

  /// Generate
  bool generate();
}
