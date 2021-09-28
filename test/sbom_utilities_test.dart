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
  group('Logging', () {
    test('Error', () {
      SbomUtilities.verbosity = SbomConstants.off;
      SbomUtilities.error('Error Text');
      expect(SbomUtilities.last, '\u001b[31mERROR: Error Text');
    });
    test('Warning', () {
      SbomUtilities.verbosity = SbomConstants.off;
      SbomUtilities.warning('Warning Text');
      expect(SbomUtilities.last, '\u001b[33mWARN: Warning Text');
    });
    test('Verbosity - Off', () {
      SbomUtilities.verbosity = SbomConstants.off;
      SbomUtilities.last = '';
      SbomUtilities.loud('Loud Text');
      expect(SbomUtilities.last.isEmpty, isTrue);
      SbomUtilities.loud('Louder Text');
      expect(SbomUtilities.last.isEmpty, isTrue);
    });
    test('Verbosity - Loud', () {
      SbomUtilities.verbosity = SbomConstants.loud;
      SbomUtilities.loud('Loud Text');
      expect(SbomUtilities.last, 'Loud Text');
    });
    test('Verbosity - Louder', () {
      SbomUtilities.verbosity = SbomConstants.louder;
      SbomUtilities.louder('Louder Text');
      expect(SbomUtilities.last, 'Louder Text');
      SbomUtilities.last = '';
      SbomUtilities.verbosity = SbomConstants.loud;
      SbomUtilities.louder('Loud Text');
      expect(SbomUtilities.last, 'Loud Text');
    });
  });
}
