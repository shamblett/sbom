/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// Tag builder interface class.
abstract class SbomITagBuilder {
  /// Build the database.
  List<SbomTag> build();
}
