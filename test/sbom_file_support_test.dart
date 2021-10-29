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
    test('Package Dart files', () {
      final config = SbomConfiguration([]);
      expect(config.valid, isTrue);
      expect(SbomUtilities.verbosity, SbomConstants.off);
    });
}
