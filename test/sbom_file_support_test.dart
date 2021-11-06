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
  test('SHA1 Digest - As string', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.packageDartFiles();
    expect(files.length, 6);
    expect(fileSupport.sha1DigestAsString(files[0]),
        '6b7afa3b0510fd07df5565208107bb4294eba8d4');
    expect(fileSupport.sha1DigestAsString(files[2]),
        'e53e74ca097d763f86e10402f1ae0e3798be8a76');
    expect(fileSupport.sha1DigestAsString(files[5]),
        'a392811c4acfe246df84eef651963df8ca767e25');
  });
  test('SHA1 Digest - As bytes', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.packageDartFiles();
    expect(files.length, 6);
    expect(fileSupport.sha1DigestAsBytes(files[0]), [
      107,
      122,
      250,
      59,
      5,
      16,
      253,
      7,
      223,
      85,
      101,
      32,
      129,
      7,
      187,
      66,
      148,
      235,
      168,
      212
    ]);
    expect(fileSupport.sha1DigestAsBytes(files[2]), [
      229,
      62,
      116,
      202,
      9,
      125,
      118,
      63,
      134,
      225,
      4,
      2,
      241,
      174,
      14,
      55,
      152,
      190,
      138,
      118
    ]);
    expect(fileSupport.sha1DigestAsBytes(files[5]), [
      163,
      146,
      129,
      28,
      74,
      207,
      226,
      70,
      223,
      132,
      238,
      246,
      81,
      150,
      61,
      248,
      202,
      118,
      126,
      37
    ]);
  });
  test('Package verification code', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    expect(fileSupport.packageVerificationCode(),
        '96ccbe02e55ceaab52873b6322a1e2142e6a45fc');
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
