/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// SBOM tag class.
/// T Type
/// S Section
abstract class SbomTag<T, S> {
  /// Construction
  SbomTag(this.type, this.name, this.section, this.position);

  SbomTag.mandatory(this.type, this.name, this.section, this.position) {
    _mandatory = true;
  }

  /// Type
  final T type;

  /// Name.
  final String name;

  /// Mandatory, true indicates mandatory.
  bool _mandatory = false;
  bool get mandatory => _mandatory;

  /// Value.
  final List<String> _value = <String>[];
  List<String> get values => _value;
  set value(String text) => _value.add(text);

  /// Document section.
  final S section;

  /// Thr position in the document section.
  final int position;
}
