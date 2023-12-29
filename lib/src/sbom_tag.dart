/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of '../sbom.dart';

/// SBOM tag class.
/// S Section
abstract class SbomTag<S> {
  /// Construction
  SbomTag(this.name, this.section, this.position);

  SbomTag.mandatory(this.name, this.section, this.position) {
    _mandatory = true;
  }

  /// Name.
  final String name;

  /// Mandatory, true indicates mandatory.
  bool _mandatory = false;
  bool get mandatory => _mandatory;

  /// Value.
  final List<String> _value = <String>[];
  List<String> get values => _value;
  set value(String text) => _value.add(text);

  /// Value is set.
  bool isSet() => _value.isNotEmpty;

  /// Document section.
  final S section;

  /// Thr position in the document section.
  final int position;
}
