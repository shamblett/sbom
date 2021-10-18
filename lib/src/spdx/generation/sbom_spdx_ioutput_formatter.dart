/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The SBOM SPDX output formatter interface class.
abstract class SbomSpdxIOutputFormatter {
  /// Construction
  SbomSpdxIOutputFormatter(this.outputFile, this.tags);

  /// The file to output to
  File outputFile;

  /// The tags to output
  SbomTags tags;

  /// The formatting processor.
  bool format();
}
