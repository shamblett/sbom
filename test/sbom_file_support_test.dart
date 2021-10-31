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
    final files = fileSupport.packageDartFiles();
    expect(files.isEmpty, isTrue);
  });
  test('Package Dart files - valid', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.packageDartFiles();
    expect(files.length, 6);
    for (final file in files) {
      expect(file.contains('dummy'), isFalse);
      expect(file.endsWith('.dart'), isTrue);
    }
  });
  test('SHA1 Digest', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.packageDartFiles();
    expect(files.length, 6);
    expect(fileSupport.sha1Digest(files[0]),
        'fc4b3c6ec9c2708401b1f8dd8a9b781ab016373b');
    expect(fileSupport.sha1Digest(files[2]),
        '2281882324d5ae54dd2073e0a627402fa332a6c7');
    expect(fileSupport.sha1Digest(files[5]),
        'f2ed8ee3c7eda2c419ef837dcad7fab298983183');
  });
}
