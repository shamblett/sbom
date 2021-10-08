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
  group('Document creation section', () {
    test('Valid file', () {
      final config =
          SbomConfiguration(['-p', 'test/sbom/spdx/generation']);
      config.parseConfigurationFile();
      expect(config.valid, isTrue);
      expect(config.outputType, SbomType.spdx);
      final generator = SbomGenerator(config);
      generator.generate();
      expect(generator.valid, isTrue);
    });
  });
}
