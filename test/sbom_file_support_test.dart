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
        'fc4b3c6ec9c2708401b1f8dd8a9b781ab016373b');
    expect(fileSupport.sha1DigestAsString(files[2]),
        '2281882324d5ae54dd2073e0a627402fa332a6c7');
    expect(fileSupport.sha1DigestAsString(files[5]),
        'f2ed8ee3c7eda2c419ef837dcad7fab298983183');
  });
  test('SHA1 Digest - As bytes', () {
    final config = SbomConfiguration(['-p', 'test/sbom/filesupport/valid']);
    config.parseConfigurationFile();
    expect(config.valid, isTrue);
    final fileSupport = SbomFileSupport(config.packageTopLevel);
    final files = fileSupport.packageDartFiles();
    expect(files.length, 6);
    expect(fileSupport.sha1DigestAsBytes(files[0]), [
      252,
      75,
      60,
      110,
      201,
      194,
      112,
      132,
      1,
      177,
      248,
      221,
      138,
      155,
      120,
      26,
      176,
      22,
      55,
      59
    ]);
    expect(fileSupport.sha1DigestAsBytes(files[2]), [
      34,
      129,
      136,
      35,
      36,
      213,
      174,
      84,
      221,
      32,
      115,
      224,
      166,
      39,
      64,
      47,
      163,
      50,
      166,
      199
    ]);
    expect(fileSupport.sha1DigestAsBytes(files[5]), [
      242,
      237,
      142,
      227,
      199,
      237,
      162,
      196,
      25,
      239,
      131,
      125,
      202,
      215,
      250,
      178,
      152,
      152,
      49,
      131
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
}
