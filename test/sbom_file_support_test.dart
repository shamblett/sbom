/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 25/09/2021
 * Copyright :  S.Hamblett
 */

@TestOn('vm')

import 'package:sbom/sbom.dart';
import 'package:test/test.dart';

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
  test('SHA1 Digest - As string', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.packageDartFiles();
    expect(files.length, 6);
    for (final file in files) {
      expect(fileSupport.sha1DigestAsString(file).length, 40);
    }
  });
  test('SHA1 Digest - As bytes', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.packageDartFiles();
    expect(files.length, 6);
    for (final file in files) {
      expect(fileSupport.sha1DigestAsBytes(file).length, 20);
    }
  });
  test('Package verification code', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    expect(fileSupport.packageVerificationCode().length, 40);
  });

  test('License generation - valid MIT', () async {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final license = fileSupport.licenceFileContents();
    expect(license.isNotEmpty, isTrue);
    final spdxLicense = SbomSpdxLicense();
    final id = spdxLicense.licenseId(license);
    expect(id, 'MIT');
  });
  test('License generation - NOASSERTION', () async {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/nofiles']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final license = fileSupport.licenceFileContents();
    expect(license.isNotEmpty, isTrue);
    final spdxLicense = SbomSpdxLicense();
    final id = spdxLicense.licenseId(license);
    expect(id, 'NOASSERTION');
  });
}
