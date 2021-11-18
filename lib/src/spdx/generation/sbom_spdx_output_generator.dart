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
            'SPDX $sectionId tag "${SbomSpdxUtilities.getSpecTagName(key)}" is not a valid SPDX tag name - not processing');
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
    // Package file name
    if (!tags.tagByName(SbomSpdxTagNames.packageFileName).isSet()) {
      tags.tagByName(SbomSpdxTagNames.packageFileName).value =
          configuration.packageName;
    }
    // Package supplier
    if (!tags.tagByName(SbomSpdxTagNames.packageSupplier).isSet()) {
      tags.tagByName(SbomSpdxTagNames.packageSupplier).value =
          SbomSpdxConstants.licenseNoAssertion;
    }
    // Package originator
    if (!tags.tagByName(SbomSpdxTagNames.packageOriginator).isSet()) {
      tags.tagByName(SbomSpdxTagNames.packageOriginator).value =
          SbomSpdxConstants.licenseNoAssertion;
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
    // Summary description
    if (!tags.tagByName(SbomSpdxTagNames.packageSummary).isSet()) {
      // Get the package description from the pubspec if present
      if (configuration.sbomPubspecContents
          .containsKey(SbomConstants.pubspecDescription)) {
        tags.tagByName(SbomSpdxTagNames.packageSummary).value =
            '${SbomSpdxConstants.textStart}${configuration.sbomPubspecContents[SbomConstants.pubspecDescription]}${SbomSpdxConstants.textEnd}';
      }
    }
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

  /// Build the file section.
  bool _buildFile() {
    SbomUtilities.louder('Building SPDX File section');
    // Get the Dart files and the digests from file support.
    // These will already be available as they are built by the packaging section.
    var files = fileSupport.dartFiles;
    var digests = fileSupport.digests;

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
    result = _buildFile();
    if (!result) {
      SbomUtilities.error('Failed to build SPDX File section.');
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
    // Tag value field text validation
    for (final name in SbomSpdxConstants.documentTextTags) {
      var tag = tags.tagByName(name);
      SbomSpdxUtilities.checkTagValueTextFields(tag, 'Document Creation');
    }
    return true;
  }

  /// Validate the package section.
  /// True indicates validation succeeded.
  bool _validatePackage() {
    final result = tags.sectionValid(SbomSpdxSectionNames.package);
    if (result.isNotEmpty) {
      SbomUtilities.error(
          'Failed to validate SPDX Package section, failed tags are ${SbomUtilities.tagsToString(result)}');
      return false;
    }
    // Check for any potential specification violations, only warn these.
    // Package supplier
    var tag = tags.tagByName(SbomSpdxTagNames.packageSupplier);
    for (final value in tag.values) {
      if ((!value.contains(SbomSpdxConstants.creatorOrganisation)) &&
          (!value.contains(SbomSpdxConstants.creatorPerson)) &&
          (value as String != SbomSpdxConstants.licenseNoAssertion)) {
        SbomUtilities.warning(
            'Invalid tag value found in configuration for Package section, tag name '
            '${SbomSpdxUtilities.getSpecTagName(SbomSpdxTagNames.packageSupplier)} - SBOM may not pass validation');
      }
    }
    // Package originator
    tag = tags.tagByName(SbomSpdxTagNames.packageOriginator);
    for (final value in tag.values) {
      if ((!value.contains(SbomSpdxConstants.creatorOrganisation)) &&
          (!value.contains(SbomSpdxConstants.creatorPerson)) &&
          (value as String != SbomSpdxConstants.licenseNoAssertion)) {
        SbomUtilities.warning(
            'Invalid tag value found in configuration for Package section, tag name '
            '${SbomSpdxUtilities.getSpecTagName(SbomSpdxTagNames.packageOriginator)} - SBOM may not pass validation');
      }
    }

    // Tag value field text validation
    for (final name in SbomSpdxConstants.packageTextTags) {
      var tag = tags.tagByName(name);
      SbomSpdxUtilities.checkTagValueTextFields(tag, 'Package');
    }

    // External reference value validation
    var ok = false;
    tag = tags.tagByName(SbomSpdxTagNames.packageExternalRef);
    FINISH:
    for (final category in SbomSpdxConstants.packageExternalRefTag.keys) {
      for (final value in tag.values) {
        if (value.startsWith(category)) {
          final types = SbomSpdxConstants.packageExternalRefTag[category];
          for (final type in types!) {
            if (value.contains(type)) {
              ok = true;
              break FINISH;
            }
          }
        }
      }
    }
    if (!ok) {
      SbomUtilities.warning(
          'Invalid tag value found in configuration for Package section, tag name '
          '${SbomSpdxUtilities.getSpecTagName(SbomSpdxTagNames.packageExternalRef)} - SBOM may not pass validation');
    }

    return true;
  }

  /// Validate
  @override
  bool validate() {
    SbomUtilities.loud('Validating SPDX sections');
    SbomUtilities.louder('Validating SPDX Document Creation section');
    var result = _validateDocumentCreation();
    if (!result) {
      return false;
    }
    SbomUtilities.louder('Validating SPDX Package section');
    result = _validatePackage();
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
