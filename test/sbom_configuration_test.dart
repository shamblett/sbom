/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 25/09/2021
 * Copyright :  S.Hamblett
 */

@TestOn('vm')
library;

import 'package:sbom/sbom.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

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
  group('SBOM Configuration File', () {
    test('Valid file', () {
      final config =
          SbomConfiguration(['-p', 'test/sbom/configuration/validfile']);
      config.parseConfigurationFile();
      expect(config.valid, isTrue);
      expect(config.outputType, SbomType.spdx);
      expect(config.sbomConfigurationContents.isNotEmpty, isTrue);
      expect(SbomUtilities.last, '');
    });
    test('Invalid path', () {
      final config = SbomConfiguration(['-p', 'sbom/configuration']);
      config.parseConfigurationFile();
      expect(config.valid, isFalse);
      expect(config.outputType, SbomType.none);
      expect(config.sbomConfigurationContents.isEmpty, isTrue);
      expect(
          SbomUtilities.last
              .contains('ERROR: Cannot read SBOM configuration file'),
          isTrue);
    });
    test('Empty', () {
      final config = SbomConfiguration(['-p', 'test/sbom/configuration/empty']);
      config.parseConfigurationFile();
      expect(config.valid, isFalse);
      expect(config.outputType, SbomType.none);
      expect(config.sbomConfigurationContents.isEmpty, isTrue);
      expect(
          SbomUtilities.last
              .contains('ERROR: SBOM configuration file is empty'),
          isTrue);
    });
    test('No type', () {
      final config =
          SbomConfiguration(['-p', 'test/sbom/configuration/notype']);
      config.parseConfigurationFile();
      expect(config.valid, isFalse);
      expect(config.outputType, SbomType.none);
      expect(config.sbomConfigurationContents.isEmpty, isTrue);
      expect(SbomUtilities.last,
          'ERROR: No type specified in SBOM configuration file, cannot continue');
    });
    test('No valid type', () {
      final config =
          SbomConfiguration(['-p', 'test/sbom/configuration/notype']);
      config.parseConfigurationFile();
      expect(config.valid, isFalse);
      expect(config.outputType, SbomType.none);
      expect(config.sbomConfigurationContents.isEmpty, isTrue);
      expect(SbomUtilities.last,
          'ERROR: No type specified in SBOM configuration file, cannot continue');
    });
  });

  group('Pubspec File', () {
    test('Valid file', () {
      SbomUtilities.last = '';
      final config =
          SbomConfiguration(['-p', 'test/sbom/configuration/validfile']);
      config.parsePubspecFile();
      expect(config.valid, isTrue);
      expect(config.sbomPubspecContents.isNotEmpty, isTrue);
      expect(SbomUtilities.last, '');
    });
    test('Invalid path', () {
      final config = SbomConfiguration(['-p', 'sbom/configuration']);
      config.parsePubspecFile();
      expect(config.valid, isFalse);
      expect(config.sbomPubspecContents.isEmpty, isTrue);
      expect(
          SbomUtilities.last
              .contains('ERROR: Cannot read package pubspec file'),
          isTrue);
    });
  });
}
