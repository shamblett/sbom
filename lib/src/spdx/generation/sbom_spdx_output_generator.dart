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
  SbomSpdxOutputGenerator(this.configuration) {
    fileSupport = SbomFileSupport(configuration.packageTopLevel);
  }

  /// SBOM configuration.
  final SbomConfiguration configuration;

  /// File support
  late SbomFileSupport fileSupport;

  /// SPDX formatter type, default is tag/value.
  String formatType = SbomSpdxConstants.spdxOutputTagValue;

  /// Update a tags value from a list.
  void _updateTagListValue(
      YamlMap section, String sectionKey, String sectionId) {
    for (final val in section[sectionKey]) {
      tags.tagByName('$sectionId$sectionKey').value = val;
    }
  }

  /// Process tags from the section configuration, tags already set by
  /// the tag builder cannot be overridden by configuration unless
  /// specified.
  void _processSectionTags(dynamic section, String sectionId) {
    if (section == null) {
      return;
    }
    // Process each tag found in the section
    for (final sectionKey in section.keys) {
      // Prepend the section identifier
      final key = '$sectionId$sectionKey';
      if (tags.exists(key)) {
        // If the tag value is set by the tag builder it cannot be overridden by the configuration
        // unless this option is specified
        if (!tags.tagByName(key).canBeOverridden) {
          SbomUtilities.warning(
              'SPDX tag $key cannot be overridden by configuration');
        } else {
          // Update the tag value from configuration, checking for list values
          if (section[sectionKey] is YamlList) {
            _updateTagListValue(section, sectionKey, sectionId);
          } else {
            tags.tagByName(key).value = section[sectionKey];
          }
        }
      } else {
        SbomUtilities.warning(
            'SPDX document creation tag "${SbomSpdxUtilities.getSpecTagName(key)}" is not a valid SPDX tag name - not processing');
      }
    }
  }

  /// Build the package section.
  bool _buildPackage() {
    SbomUtilities.louder('Building SPDX Package section');
    // If we have a package section in the SBOM configuration process it
    if (configuration.sbomConfigurationContents[SbomConstants.sbomSpdx]
        .containsKey(SbomSpdxSectionNames.package)) {
      final section =
          configuration.sbomConfigurationContents[SbomConstants.sbomSpdx]
              [SbomSpdxSectionNames.package];
      _processSectionTags(section, SbomSpdxTagNames.packageSectionId);
    }
    // Package name
    tags.tagByName(SbomSpdxTagNames.packageName).value =
        configuration.packageName;
    // SPDXID
    tags.tagByName(SbomSpdxTagNames.packageIdentifier).value =
        '${SbomSpdxConstants.idReference}Package-${configuration.packageName}';
    // Version
    if (configuration.sbomPubspecContents
        .containsKey(SbomConstants.pubspecVersion)) {
      tags.tagByName(SbomSpdxTagNames.packageVersion).value =
          configuration.sbomPubspecContents[SbomConstants.pubspecVersion];
    } else {
      SbomUtilities.error(
          'Version key not found in pubspec.yaml - cannot continue');
      return false;
    }
    // Download location
    tags.tagByName(SbomSpdxTagNames.packageDownloadLocation).value =
        '${SbomConstants.pubUrl}${configuration.packageName}';
    // Package verification code
    tags.tagByName(SbomSpdxTagNames.packageVerificationCode).value =
        fileSupport.packageVerificationCode();
    // Package home page
    tags.tagByName(SbomSpdxTagNames.packageHomePage).value =
        '${SbomConstants.pubUrl}${configuration.packageName}';
    // Concluded license
    final license = fileSupport.licenceFileContents();
    tags.tagByName(SbomSpdxTagNames.packageLicenseConcluded).value =
        SbomSpdxLicense().licenseId(license);

    return true;
  }

  /// Build the document creation section.
  bool _buildDocumentCreation() {
    SbomUtilities.louder('Building SPDX Document Creation section');
    // If we have a document creation section in the SBOM configuration process it
    if (configuration.sbomConfigurationContents[SbomConstants.sbomSpdx]
        .containsKey(SbomSpdxSectionNames.documentCreation)) {
      final section =
          configuration.sbomConfigurationContents[SbomConstants.sbomSpdx]
              [SbomSpdxSectionNames.documentCreation];
      _processSectionTags(section, SbomSpdxTagNames.documentCreationSectionId);
    }
    // Build the environment tags
    // Document name and namespace, only if we have a package name
    if (configuration.packageName != SbomConstants.defaultPackageName) {
      tags.tagByName(SbomSpdxTagNames.documentName).value =
          configuration.packageName;
      tags.tagByName(SbomSpdxTagNames.documentNamespace).value =
          '${SbomConstants.pubUrl}${configuration.packageName}';
    }
    return true;
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
    // Build the tag list
    tags = SbomSpdxTags(SbomSpdxTagBuilder());
    bool result = _buildDocumentCreation();
    if (!result) {
      SbomUtilities.error('Failed to build SPDX Document Creation section.');
      return false;
    }
    result = _buildPackage();
    if (!result) {
      SbomUtilities.error('Failed to build SPDX Package section.');
      return false;
    }
    return true;
  }

  /// Validate the document creation section.
  /// True indicates validation succeeded.
  bool _validateDocumentCreation() {
    final result = tags.sectionValid(SbomSpdxSectionNames.documentCreation);
    if (result.isNotEmpty) {
      SbomUtilities.error(
          'Failed to validate SPDX Document Creation section, failed tags are ${SbomUtilities.tagsToString(result)}');
      return false;
    }
    // Check for any potential specification violations, only warn these.
    // Document creator
    final tag = tags.tagByName(SbomSpdxTagNames.creator);
    for (final value in tag.values) {
      if (!value.contains(SbomSpdxConstants.creatorTool) &&
          !value.contains(SbomSpdxConstants.creatorPerson) &&
          !value.contains(SbomSpdxConstants.creatorOrganisation)) {
        SbomUtilities.warning(
            'SPDX document creation section has invalid creator tag values - "$value"');
      }
    }
    return true;
  }

  /// Validate
  @override
  bool validate() {
    SbomUtilities.loud('Validating SPDX sections');
    SbomUtilities.louder('Validating SPDX Document Creation section');
    final result = _validateDocumentCreation();
    if (!result) {
      return false;
    }
    return true;
  }

  /// Generate
  @override
  bool generate() {
    SbomUtilities.loud('Generating SPDX SBOM');
    // Create the sbom output file
    final outputFileName = path.join(
        configuration.packageTopLevel, SbomSpdxConstants.outputFileName);
    final outputFile = File(outputFileName);
    if (outputFile.existsSync()) {
      try {
        outputFile.deleteSync();
      } on Exception {
        SbomUtilities.error(
            'SPDX SBOM generation - unable to delete existing sbom file at $outputFileName - aborting generation');
        return false;
      }
    }
    try {
      outputFile.createSync();
    } on FileSystemException {
      SbomUtilities.error(
          'SPDX SBOM generation - unable to create output sbom file at $outputFileName - aborting generation');
      return false;
    }

    // Create the formatter
    late SbomSpdxIOutputFormatter formatter;
    formatType = configuration.sbomConfigurationContents[SbomConstants.sbomSpdx]
        [SbomSpdxConstants.spdxOutputFormatDirective];
    SbomUtilities.loud('SPDX format type is tag/value');
    switch (formatType) {
      case SbomSpdxConstants.spdxOutputTagValue:
        {
          formatter = SbomSpdxOutputTagvalueFormatter(outputFile, tags);
        }
        break;
      default:
        formatter = SbomSpdxOutputTagvalueFormatter(outputFile, tags);
    }

    var result = formatter.format();
    if (!result) {
      SbomUtilities.error(
          'SPDX SBOM generation - unable to generate a formatted SPDX file at $outputFileName - aborting generation');
      return false;
    }
    sbomFilePath = outputFileName;

    return true;
  }
}
