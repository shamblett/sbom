/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The SBOM SPDX output generator class.
class SbomSpdxOutputGenerator extends SbomIOutputGenerator {
  /// Construction
  SbomSpdxOutputGenerator(this.spdx);

  /// SBOM configuration.
  final SbomConfiguration spdx;

  /// SPDX tags.
  final spdxTags = SbomSpdxTags(SbomSpdxTagBuilder());

  /// Document creation.
  bool _documentCreation() {
    SbomUtilities.louder('Building SPDX Document Creation section');
    // SPDX version and data licence are preset.
    // SPDX Id
    if (spdx.sbomConfigurationContents[spdx]
        .containsKey(SbomSpdxConstants.tagIdentifier)) {
      spdxTags.tagByType(SbomSpdxTagType.identifier).value =
          spdx.sbomConfigurationContents[SbomSpdxConstants.tagIdentifier];
    }
    return false;
  }

  /// Build
  @override
  bool build() {
    SbomUtilities.loud('Building SPDX sections');
    bool result = _documentCreation();
    if (!result) {
      SbomUtilities.error('Failed to build SPDX Document Creation section.');
      return false;
    }
    return true;
  }

  /// Validate
  @override
  bool validate() {
    SbomUtilities.loud('Validating SPDX sections');
    return false;
  }

  /// Generate
  @override
  bool generate() {
    SbomUtilities.loud('Generating SPDX SBOM');
    return false;
  }
}
