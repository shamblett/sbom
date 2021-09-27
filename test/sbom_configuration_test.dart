/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 25/09/2021
 * Copyright :  S.Hamblett
 */
import 'package:sbom/sbom.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

@TestOn('VM')
void main() {
  group('Arguments', () {
    test('None', () {
      final config = SbomConfiguration([]);
      expect(config.valid, isTrue);
      expect(config.verbosity, SbomConstants.off);
    });
    test('Loud', () {
      final config = SbomConfiguration(['-l']);
      expect(config.valid, isTrue);
      expect(config.verbosity, SbomConstants.loud);
    });
    test('Louder', () {
      final config = SbomConfiguration(['-L']);
      expect(config.valid, isTrue);
      expect(config.verbosity, SbomConstants.louder);
    });
    test('Absolute path', () {
      final config = SbomConfiguration(['-P', '/absolute/path']);
      expect(config.valid, isTrue);
      expect(config.packageTopLevel, '/absolute/path');
      expect(config.verbosity, SbomConstants.off);
    });
    test('Relative path', () {
      final config = SbomConfiguration(['-p', '/relative/path']);
      expect(config.valid, isTrue);
      expect(config.packageTopLevel, path.join(path.current, '/relative/path'));
      expect(config.verbosity, SbomConstants.off);
    });
    test('Help - Single', () {
      final config = SbomConfiguration(['-h']);
      expect(config.valid, isFalse);
      expect(config.verbosity, SbomConstants.off);
    });
    test('Help- Mixed', () {
      final config = SbomConfiguration(['-l', '-h']);
      expect(config.valid, isFalse);
      expect(config.verbosity, SbomConstants.off);
    });
    test('Format Error', () {
      final config = SbomConfiguration(['-l=true']);
      expect(config.valid, isFalse);
      expect(config.verbosity, SbomConstants.off);
    });
    test('Argument Error', () {
      final config = SbomConfiguration(['-l -l']);
      expect(config.valid, isFalse);
      expect(config.verbosity, SbomConstants.off);
    });
    test('Multiple', () {
      final config = SbomConfiguration(['-p', '/relative/path', '-l']);
      expect(config.valid, isTrue);
      expect(config.packageTopLevel, path.join(path.current, '/relative/path'));
      expect(config.verbosity, SbomConstants.loud);
    });
  });
}
