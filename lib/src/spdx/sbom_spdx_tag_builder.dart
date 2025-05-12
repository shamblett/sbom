/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of '../../sbom.dart';

/// SPDX tag builder.
/// Builds the SPDX tags as per the specification.
class SbomSpdxTagBuilder extends SbomITagBuilder {
  /// Tag positions

  static const version = 1;
  static const dataLicence = 2;
  static const identifier = 3;
  static const documentName = 4;
  static const documentNamespace = 5;
  static const externalDocumentRefs = 6;
  static const licenseListVersion = 7;
  static const creator = 8;
  static const created = 9;
  static const creatorComment = 10;
  static const documentComment = 11;

  static const packageName = 1;
  static const packageIdentifier = 2;
  static const packageVersion = 3;
  static const packageFileName = 4;
  static const packageSupplier = 5;
  static const packageOriginator = 6;
  static const packageDownloadLocation = 7;
  static const packageFilesAnalyzed = 8;
  static const packageVerificationCode = 9;
  static const packageChecksum = 10;
  static const packageHomePage = 11;
  static const packageSourceInfo = 12;
  static const packageLicenseConcluded = 13;
  static const packageLicenseInfoFromFiles = 14;
  static const packageLicenseDeclared = 15;
  static const packageLicenseComments = 16;
  static const packageCopyrightText = 17;
  static const packageSummary = 18;
  static const packageDescription = 19;
  static const packageComment = 20;
  static const packageExternalRef = 21;
  static const packageExternalRefComment = 22;
  static const packageAttributionText = 23;

  final List<SbomSpdxTag> _tags = <SbomSpdxTag>[];

  /// Build the database.
  @override
  List<SbomSpdxTag> build() {
    _documentCreation();
    _package();

    return _tags;
  }

  /// Document creation section.
  void _documentCreation() {
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.version,
        SbomSpdxSectionNames.documentCreation,
        version,
      ),
    );
    // Version is predefined.
    _tags.first.value = SbomSpdxConstants.version;
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.dataLicense,
        SbomSpdxSectionNames.documentCreation,
        dataLicence,
      ),
    );
    // License is predefined.
    _tags[1].value = SbomSpdxConstants.license;
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.identifier,
        SbomSpdxSectionNames.documentCreation,
        identifier,
      ),
    );
    // Identifier is predefined.
    _tags[2].value = '${SbomSpdxConstants.idReference}DOCUMENT';
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.documentName,
        SbomSpdxSectionNames.documentCreation,
        documentName,
        true,
      ),
    );
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.documentNamespace,
        SbomSpdxSectionNames.documentCreation,
        documentNamespace,
        false,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.externalDocumentRefs,
        SbomSpdxSectionNames.documentCreation,
        externalDocumentRefs,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.licenseListVersion,
        SbomSpdxSectionNames.documentCreation,
        licenseListVersion,
      ),
    );
    // License list version is predefined.
    _tags[6].value = SbomSpdxConstants.licenseListVersion;
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.creator,
        SbomSpdxSectionNames.documentCreation,
        creator,
        true,
      ),
    );
    // Tool creator is predefined
    _tags[7].value =
        '${SbomSpdxConstants.creatorTool}${SbomConstants.pubUrl}${SbomConstants.package}';
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.created,
        SbomSpdxSectionNames.documentCreation,
        created,
      ),
    );
    // Created time is predefined
    _tags[8].value = SbomSpdxUtilities.createdAt();
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.creatorComment,
        SbomSpdxSectionNames.documentCreation,
        creatorComment,
        true,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.documentComment,
        SbomSpdxSectionNames.documentCreation,
        documentComment,
        true,
      ),
    );
  }

  /// Package section
  void _package() {
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageName,
        SbomSpdxSectionNames.package,
        packageName,
      ),
    );
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageIdentifier,
        SbomSpdxSectionNames.package,
        packageIdentifier,
      ),
    );
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageVersion,
        SbomSpdxSectionNames.package,
        packageVersion,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageFileName,
        SbomSpdxSectionNames.package,
        packageFileName,
        true,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageSupplier,
        SbomSpdxSectionNames.package,
        packageSupplier,
        true,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageOriginator,
        SbomSpdxSectionNames.package,
        packageOriginator,
        true,
      ),
    );
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageDownloadLocation,
        SbomSpdxSectionNames.package,
        packageDownloadLocation,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageFilesAnalyzed,
        SbomSpdxSectionNames.package,
        packageFilesAnalyzed,
      ),
    );
    // Files are always analyzed
    _tags[18].value = 'true';
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageVerificationCode,
        SbomSpdxSectionNames.package,
        packageVerificationCode,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageChecksum,
        SbomSpdxSectionNames.package,
        packageChecksum,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageHomePage,
        SbomSpdxSectionNames.package,
        packageHomePage,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageSourceInfo,
        SbomSpdxSectionNames.package,
        packageSourceInfo,
        true,
      ),
    );
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageLicenseConcluded,
        SbomSpdxSectionNames.package,
        packageLicenseConcluded,
      ),
    );
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageLicenseInfoFromFiles,
        SbomSpdxSectionNames.package,
        packageLicenseInfoFromFiles,
      ),
    );
    // Package license Info from files is always NOASSERTION
    _tags[24].value = SbomSpdxConstants.noAssertion;
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageLicenseDeclared,
        SbomSpdxSectionNames.package,
        packageLicenseDeclared,
      ),
    );
    // Package license declared is always NOASSERTION
    _tags[25].value = SbomSpdxConstants.noAssertion;
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageLicenseComments,
        SbomSpdxSectionNames.package,
        packageLicenseComments,
        true,
      ),
    );
    _add(
      SbomSpdxTag.mandatory(
        SbomSpdxTagNames.packageCopyrightText,
        SbomSpdxSectionNames.package,
        packageCopyrightText,
      ),
    );
    // Package copyright text is always NOASSERTION
    _tags[27].value = SbomSpdxConstants.noAssertion;
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageSummary,
        SbomSpdxSectionNames.package,
        packageSummary,
        true,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageDescription,
        SbomSpdxSectionNames.package,
        packageDescription,
        true,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageComment,
        SbomSpdxSectionNames.package,
        packageComment,
        true,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageExternalRef,
        SbomSpdxSectionNames.package,
        packageExternalRef,
        true,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageExternalRefComment,
        SbomSpdxSectionNames.package,
        packageExternalRefComment,
        true,
      ),
    );
    _add(
      SbomSpdxTag(
        SbomSpdxTagNames.packageAttributionText,
        SbomSpdxSectionNames.package,
        packageAttributionText,
        true,
      ),
    );
  }

  /// Add a tag, checking the tag type and position is not already present.
  void _add(SbomSpdxTag tag) {
    if (_tags.where((e) => e.name == tag.name).isNotEmpty) {
      throw Exception(
        'SpdxTagBuilder: ERROR duplicate tag type found ${tag.name}',
      );
    }
    if (_tags
        .where((e) => e.section == tag.section && e.position == tag.position)
        .isNotEmpty) {
      throw Exception(
        'SpdxTagBuilder: ERROR duplicate position found ${tag.position} in section ${tag.section}',
      );
    }
    _tags.add(tag);
  }
}
