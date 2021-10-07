/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 25/09/2021
 * Copyright :  S.Hamblett
 */
import 'package:sbom/sbom.dart';
import 'package:test/test.dart';

@TestOn('VM')
void main() {
  group('SPDX', () {
    test('Tag by type', () {
      final builder = SbomSpdxTagBuilder();
      final tags = SbomSpdxTags(builder);
      tags.tags.clear();
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.version,
          'SPDXVersion', SbomSpdxSection.documentCreation, 1));
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.dataLicense,
          'DataLicense', SbomSpdxSection.documentCreation, 2));
      expect(tags.tags.length, 2);
      final tag = tags.tagByType(SbomSpdxTagType.dataLicense);
      expect(tag, isNotNull);
      expect(tag.type, SbomSpdxTagType.dataLicense);
    });
    test('Tag by name', () {
      final builder = SbomSpdxTagBuilder();
      final tags = SbomSpdxTags(builder);
      tags.tags.clear();
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.version,
          'SPDXVersion', SbomSpdxSection.documentCreation, 1));
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.dataLicense,
          'DataLicense', SbomSpdxSection.documentCreation, 2));
      expect(tags.tags.length, 2);
      final tag = tags.tagByName('SPDXVersion');
      expect(tag, isNotNull);
      expect(tag.name, 'SPDXVersion');
    });
    test('Section valid - not valid', () {
      final builder = SbomSpdxTagBuilder();
      final tags = SbomSpdxTags(builder);
      tags.tags.clear();
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.version,
          'SPDXVersion', SbomSpdxSection.documentCreation, 1));
      tags.tags[0].value(SbomSpdxConstants.version);
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.dataLicense,
          'DataLicense', SbomSpdxSection.documentCreation, 2));
      expect(tags.tags.length, 2);
      final valid = tags.sectionValid(SbomSpdxSection.documentCreation);
      expect(valid.isEmpty, isFalse);
      expect(valid.length, 1);
      expect(valid[0].type, SbomSpdxTagType.dataLicense);
    });
    test('Section valid - valid', () {
      final builder = SbomSpdxTagBuilder();
      final tags = SbomSpdxTags(builder);
      tags.tags.clear();
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.version,
          'SPDXVersion', SbomSpdxSection.documentCreation, 1));
      tags.tags[0].value(SbomSpdxConstants.version);
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.dataLicense,
          'DataLicense', SbomSpdxSection.documentCreation, 2));
      tags.tags[1].value(SbomSpdxConstants.license);
      expect(tags.tags.length, 2);
      final valid = tags.sectionValid(SbomSpdxSection.documentCreation);
      expect(valid.isEmpty, isTrue);
    });
    test('Section tags', () {
      final builder = SbomSpdxTagBuilder();
      final tags = SbomSpdxTags(builder);
      tags.tags.clear();
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.version,
          'SPDXVersion', SbomSpdxSection.documentCreation, 1));
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.documentName, 'sbom',
          SbomSpdxSection.documentCreation, 4));
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.identifier,
          'SPDXRef-DOCUMENT', SbomSpdxSection.documentCreation, 3));
      tags.tags.add(SbomSpdxTag.mandatory(SbomSpdxTagType.dataLicense,
          'DataLicense', SbomSpdxSection.documentCreation, 2));
      expect(tags.tags.length, 4);
      final section = tags.sectionTags(SbomSpdxSection.documentCreation);
      expect(section.isEmpty, isFalse);
      expect(section.length, 4);
      expect(section[0].position, 1);
      expect(section[1].position, 2);
      expect(section[2].position, 3);
      expect(section[3].position, 4);
    });
  });
}
