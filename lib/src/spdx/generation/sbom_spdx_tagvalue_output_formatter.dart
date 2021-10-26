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
    bool result = _generateDocumentCreation();
    if (!result) {
      SbomUtilities.error(
          'SPDX SBOM Formatting - unable to generate a formatted SPDX document creation section in file $outputFile');
      return false;
    }
    return true;
  }

  /// Format and generate the document creation section.
  bool _generateDocumentCreation() {
    SbomUtilities.louder('Generating SPDX Document Creation section');
    try {
      final sectionTags =
          tags.sectionTags(SbomSpdxSectionNames.documentCreation);
      for (final tag in sectionTags) {
        if (tag.isSet()) {
          for (final value in tag.values) {
            // Remove the prepended section identifier from the tag name constant to get the tag
            // name
            final str =
                '${SbomSpdxUtilities.getSpecTagName(tag.name)}${SbomSpdxConstants.spdxTagValueSeparator}$value\r';
            outputFile.writeAsStringSync(str, mode: FileMode.append);
          }
        }
      }
    } on FileSystemException {
      return false;
    }
    // Blank line at the end of the section
    outputFile.writeAsStringSync('', mode: FileMode.append);

    return true;
  }
}
