/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The SBOM SPDX output formatter class for tag/value formats.
class SbomSpdxOutputTagvalueFormatter extends SbomSpdxIOutputFormatter {
  SbomSpdxOutputTagvalueFormatter(File outputFile, SbomTags tags)
      : super(outputFile, tags);

  /// The formatting processor.
  @override
  bool format() {
    bool result = _generateSection(SbomSpdxSectionNames.documentCreation);
    if (!result) {
      SbomUtilities.error(
          'SPDX SBOM Formatting - unable to generate a formatted SPDX document creation section in file $outputFile');
      return false;
    }
    result = _generateSection(SbomSpdxSectionNames.package);
    if (!result) {
      SbomUtilities.error(
          'SPDX SBOM Formatting - unable to generate a formatted SPDX package section in file $outputFile');
      return false;
    }
    result = _generateSection(SbomSpdxSectionNames.file);
    if (!result) {
      SbomUtilities.error(
          'SPDX SBOM Formatting - unable to generate a formatted SPDX file section in file $outputFile');
      return false;
    }
    return true;
  }

  /// Format and generate the document creation section.
  bool _generateSection(String section) {
    SbomUtilities.louder('Generating SPDX $section section');
    try {
      final sectionTags = tags.sectionTags(section);
      for (final tag in sectionTags) {
        if (tag.isSet()) {
          for (final value in tag.values) {
            // Remove the prepended section identifier from the tag name constant to get the tag
            // name
            final str =
                '${SbomSpdxUtilities.getSpecTagName(tag.name)}${SbomSpdxConstants.tagValueSeparator}$value\r';
            outputFile.writeAsStringSync(str, mode: FileMode.append);
            // If its the file section put a new line between each file
            if (section == SbomSpdxSectionNames.file) {
              if (tag.position % SbomSpdxConstants.numberOfFileTags == 0) {
                outputFile.writeAsStringSync('\n\n', mode: FileMode.append);
              }
            }
          }
        }
      }
    } on FileSystemException {
      return false;
    }
    // Blank line at the end of the section unless its the file section
    if (section != SbomSpdxSectionNames.file) {
      outputFile.writeAsStringSync('\n\n', mode: FileMode.append);
    }

    return true;
  }
}
