/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 25/09/2021
 * Copyright :  S.Hamblett
 */

import 'dart:io';

import 'package:sbom/sbom.dart';
import 'package:test/test.dart';

@TestOn('VM')
void main() {
  group('Document creation section', () {
    test('Document Configuration', () {
      final config = SbomConfiguration(
          ['-p', 'test/sbom/spdx/generation/documentcreation/configuration']);
      config.parseConfigurationFile();
      config.parsePubspecFile();
      expect(config.valid, isTrue);
      expect(config.outputType, SbomType.spdx);
      final generator = SbomGenerator(config);
      generator.generate();
      expect(generator.valid, isTrue);
      expect(
          generator.tags
              .sectionTags(SbomSpdxSectionNames.documentCreation)
              .length,
          11);
      expect(generator.tags.tagByName('DC-SPDXVersion').values[0], 'SPDX-2.2');
      expect(generator.tags.tagByName('DC-DataLicense').values[0], 'CC0-1.0');
      expect(
          generator.tags.tagByName('DC-SPDXID').values[0], 'SPDXRef-DOCUMENT');
      expect(generator.tags.tagByName('DC-DocumentName').values[0],
          'Document name from configuration');
      expect(generator.tags.tagByName('DC-DocumentNamespace').values[0],
          'Document name space from configuration');
      expect(
          generator.tags.tagByName('DC-ExternalDocumentRef').values.length, 2);
      expect(generator.tags.tagByName('DC-ExternalDocumentRef').values[0],
          'External Doc Ref 1');
      expect(generator.tags.tagByName('DC-ExternalDocumentRef').values[1],
          'External Doc Ref 2');
      expect(
          generator.tags.tagByName('DC-LicenseListVersion').values[0], '3.8');
      expect(generator.tags.tagByName('DC-Creator').values[0],
          'Tool: https://pub.dev/packages/sbom');
      expect(generator.tags.tagByName('DC-Creator').values[1],
          'Person: Steve Hamblett <steve.hamblett@linux.com');
      expect(generator.tags.tagByName('DC-Creator').values[2],
          'Not a real creator value');
      expect(generator.tags.tagByName('DC-Created').values[0].endsWith('Z'),
          isTrue);
      expect(generator.tags.tagByName('DC-CreatorComment').values[0],
          'Creator comment from configuration');
      expect(generator.tags.tagByName('DC-DocumentComment').values[0],
          'Document comment from configuration');
      expect(
          generator.tags.sectionValid('DC-documentCreation').isEmpty, isTrue);
      final sbom = File(generator.sbomFilePath);
      expect(sbom.existsSync(), isTrue);
    });
    test('Document Environment', () {
      final config = SbomConfiguration([
        '-p',
        'test/sbom/spdx/generation/documentcreation/environment',
        '-L'
      ]);
      config.parseConfigurationFile();
      config.parsePubspecFile();
      expect(config.valid, isTrue);
      expect(config.outputType, SbomType.spdx);
      final generator = SbomGenerator(config);
      generator.generate();
      expect(generator.valid, isTrue);
      expect(
          generator.tags
              .sectionTags(SbomSpdxSectionNames.documentCreation)
              .length,
          11);
      expect(generator.tags.tagByName('DC-SPDXVersion').values[0], 'SPDX-2.2');
      expect(generator.tags.tagByName('DC-DataLicense').values[0], 'CC0-1.0');
      expect(
          generator.tags.tagByName('DC-SPDXID').values[0], 'SPDXRef-DOCUMENT');
      expect(generator.tags.tagByName('DC-DocumentName').values[0], 'sbom');
      expect(generator.tags.tagByName('DC-DocumentNamespace').values[0],
          'https://pub.dev/packages/sbom');
      expect(
          generator.tags.tagByName('DC-ExternalDocumentRef').values.length, 2);
      expect(generator.tags.tagByName('DC-ExternalDocumentRef').values[0],
          'External Doc Ref 1');
      expect(generator.tags.tagByName('DC-ExternalDocumentRef').values[1],
          'External Doc Ref 2');
      expect(
          generator.tags.tagByName('DC-LicenseListVersion').values[0], '3.8');
      expect(generator.tags.tagByName('DC-Creator').values[0],
          'Tool: https://pub.dev/packages/sbom');
      expect(generator.tags.tagByName('DC-Creator').values[1],
          'Person: Steve Hamblett <steve.hamblett@linux.com>');
      expect(generator.tags.tagByName('DC-Created').values[0].endsWith('Z'),
          isTrue);
      expect(generator.tags.tagByName('DC-CreatorComment').values[0],
          '<text>Creator comment from configuration</text>');
      expect(generator.tags.tagByName('DC-DocumentComment').values[0],
          '<text>Document comment from configuration</text>');
      expect(generator.tags.sectionValid('documentCreation').isEmpty, isTrue);
      final sbom = File(generator.sbomFilePath);
      expect(sbom.existsSync(), isTrue);
    });
    test('Document Validation fail', () {
      final config = SbomConfiguration([
        '-p',
        'test/sbom/spdx/generation/documentcreation/environmentinvalid',
        '-L'
      ]);
      config.parseConfigurationFile();
      config.parsePubspecFile();
      expect(config.valid, isTrue);
      expect(config.outputType, SbomType.spdx);
      final generator = SbomGenerator(config);
      generator.generate();
      expect(generator.valid, isFalse);
      expect(generator.tags.tagByName('DC-DocumentName').isSet(), isFalse);
      expect(generator.tags.tagByName('DC-DocumentNamespace').isSet(), isFalse);
      expect(generator.sbomFilePath.isEmpty, isTrue);
    });
  });
  group('Package Section', () {
    test('Package Configuration', () {
      final config = SbomConfiguration(
          ['-p', 'test/sbom/spdx/generation/package/configuration']);
      config.parseConfigurationFile();
      config.parsePubspecFile();
      expect(config.valid, isTrue);
      expect(config.outputType, SbomType.spdx);
      final generator = SbomGenerator(config);
      generator.generate();
      expect(generator.valid, isTrue);
      expect(
          generator.tags.sectionTags(SbomSpdxSectionNames.package).length, 23);
      expect(generator.tags.tagByName('P-PackageName').values[0], 'sbom');
      expect(generator.tags.tagByName('P-SPDXID').values[0],
          'SPDXRef-Package-sbom');
      expect(generator.tags.tagByName('P-PackageVersion').values[0], '1.0.0');
      expect(generator.tags.tagByName('P-PackageFileName').values[0],
          'The package filename');
      expect(generator.tags.tagByName('P-PackageSupplier').values[0],
          'Organization: The package supplier');
      expect(generator.tags.tagByName('P-PackageOriginator').values[0],
          'Person: The package originator');
      expect(generator.tags.tagByName('P-PackageDownloadLocation').values[0],
          'https://pub.dev/packages/sbom');
      expect(generator.tags.tagByName('P-FilesAnalyzed').values[0], 'true');
      expect(
          generator.tags
              .tagByName('P-PackageVerificationCode')
              .values[0]
              .length,
          40);
      expect(generator.tags.tagByName('P-PackageChecksum').values[0],
          'The package checksum');
      expect(generator.tags.tagByName('P-PackageHomePage').values[0],
          'https://pub.dev/packages/sbom');
      expect(generator.tags.tagByName('P-PackageSourceInfo').values[0],
          '<text>The package source info</text>');
      expect(generator.tags.tagByName('P-PackageLicenseConcluded').values[0],
          'MIT');
      expect(
          generator.tags.tagByName('P-PackageLicenseInfoFromFiles').values[0],
          'NOASSERTION');
      expect(generator.tags.tagByName('P-PackageLicenseDeclared').values[0],
          'NOASSERTION');
      expect(generator.tags.tagByName('P-PackageLicenseComments').values[0],
          '<text>The package license comments</text>');
      expect(generator.tags.tagByName('P-PackageCopyrightText').values[0],
          'NOASSERTION');
      expect(generator.tags.tagByName('P-PackageSummary').values[0],
          '<text>A Software Bill of Materials generator for Dart packages.</text>');
      expect(generator.tags.tagByName('P-PackageDescription').values[0],
          '<text>The package description.</text>');
      expect(generator.tags.tagByName('P-PackageComment').values[0],
          '<text>The package comment</text>');
      expect(generator.tags.tagByName('P-ExternalRef').values[0],
          'SECURITY cpe23Type The package external ref');
      expect(generator.tags.tagByName('P-ExternalRefComment').values[0],
          '<text>The package external ref comment<text>');
      expect(generator.tags.tagByName('P-PackageAttributionText').values[0],
          'The package attribution text');
    });
  });
}
