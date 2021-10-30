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
  test('Package Dart files - no files', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/nofiles']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.getPackageDartFiles();
    expect(files.isEmpty, isTrue);
  });
  test('Package Dart files - valid', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.getPackageDartFiles();
    expect(files.length, 6);
    for (final file in files) {
      expect(file.contains('dummy'), isFalse);
    }
  });
}
