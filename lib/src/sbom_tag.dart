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
  /// Name.
  final String name;

  /// Document section.
  final S section;

  /// Thr position in the document section.
  final int position;

  bool _mandatory = false;

  final List<String> _value = <String>[];

  /// Mandatory, true indicates mandatory.
  bool get mandatory => _mandatory;

  /// Value.
  List<String> get values => _value;

  set value(String text) => _value.add(text);

  /// Construction
  SbomTag(this.name, this.section, this.position);

  SbomTag.mandatory(this.name, this.section, this.position) {
    _mandatory = true;
  }

  /// Value is set.
  bool isSet() => _value.isNotEmpty;
}
