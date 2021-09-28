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
      expect(SbomUtilities.verbosity, SbomConstants.off);
    });
    test('Loud', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-l']);
      expect(config.valid, isTrue);
      expect(SbomUtilities.verbosity, SbomConstants.loud);
    });
    test('Louder', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-L']);
      expect(config.valid, isTrue);
      expect(SbomUtilities.verbosity, SbomConstants.louder);
    });
    test('Absolute path', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-P', '/absolute/path']);
      expect(config.valid, isTrue);
      expect(config.packageTopLevel, '/absolute/path');
      expect(SbomUtilities.verbosity, SbomConstants.off);
    });
    test('Relative path', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-p', '/relative/path']);
      expect(config.valid, isTrue);
      expect(config.packageTopLevel, path.join(path.current, '/relative/path'));
      expect(SbomUtilities.verbosity, SbomConstants.off);
    });
    test('Help - Single', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-h']);
      expect(config.valid, isFalse);
      expect(SbomUtilities.verbosity, SbomConstants.off);
    });
    test('Help- Mixed', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-l', '-h']);
      expect(config.valid, isFalse);
      expect(SbomUtilities.verbosity, SbomConstants.off);
    });
    test('Format Error', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-l=true']);
      expect(config.valid, isFalse);
      expect(SbomUtilities.verbosity, SbomConstants.off);
    });
    test('Argument Error', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-l -l']);
      expect(config.valid, isFalse);
      expect(SbomUtilities.verbosity, SbomConstants.off);
    });
    test('Multiple', () {
      SbomUtilities.verbosity = SbomConstants.off;
      final config = SbomConfiguration(['-p', '/relative/path', '-l']);
      expect(config.valid, isTrue);
      expect(config.packageTopLevel, path.join(path.current, '/relative/path'));
      expect(SbomUtilities.verbosity, SbomConstants.loud);
    });
  });
}
