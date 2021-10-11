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
  SbomSpdxOutputGenerator(this.configuration);

  /// SBOM configuration.
  final SbomConfiguration configuration;

  /// SPDX tags.
  final spdxTags = SbomSpdxTags(SbomSpdxTagBuilder());

  /// Update a tags value from a list.
  void _updateTagListValue(YamlMap section, String key) {
    for (final val in section[key]) {
      spdxTags.tagByName(key).value = val;
    }
  }

  /// Document creation.
  bool _documentCreation() {
    SbomUtilities.louder('Building SPDX Document Creation section');
    // If we have a document creation section in the SBOM configuration process it
    if (configuration.sbomConfigurationContents[SbomConstants.sbomSpdx]
        .containsKey(SbomSpdxSectionNames.documentCreation)) {
      final section =
          configuration.sbomConfigurationContents[SbomConstants.sbomSpdx]
              [SbomSpdxSectionNames.documentCreation];
      // Process each tag found in the section
      for (final key in section.keys) {
        if (spdxTags.exists(key)) {
          // If the tag value is set by the tag builder it cannot be overridden by the configuration
          if (spdxTags.tagByName(key).isSet()) {
            SbomUtilities.warning(
                'SPDX tag $key cannot be overridden by configuration');
          } else {
            // Update the tag value from configuration, checking for list values
            if (section.key is YamlList) {
              _updateTagListValue(section, key);
            } else {
              spdxTags.tagByName(key).value = section[key];
            }
          }
        } else {
          SbomUtilities.warning(
              'SPDX document creation tag ${section[key]} is not a valid SPDX tag name - not processing');
        }
      }
    }
    return false;
  }

  /// Build
  @override
  bool build() {
    SbomUtilities.loud('Building SPDX sections');
    if (!configuration.sbomConfigurationContents
        .containsKey(SbomConstants.sbomSpdx)) {
      SbomUtilities.error(
          'Cannot build SPDX sections, no spdx tag in SBOM configuration file');
      return false;
    }
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
