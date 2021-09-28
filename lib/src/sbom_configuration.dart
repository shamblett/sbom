/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The main sbom configuration class
class SbomConfiguration {
  /// Construction
  SbomConfiguration(List<String> args) {
    _buildConfiguration(args);
  }

  /// Configuration valid
  bool valid = false;

  /// Top level package path.
  /// This must be a standard Dart package directory with pubspec.yaml,
  /// the standard package directory structure and an sbom.yaml file
  /// if needed.
  /// If not supplied on the command line this is defaulted to where
  /// sbom was invoked.
  /// Note this is always an absolute path.
  String packageTopLevel = path.current;

  void _buildConfiguration(args) {
    // Parse the arguments
    final argParser = ArgParser();
    argParser.addFlag('help', abbr: 'h', negatable: false);
    argParser.addFlag('loud',
        abbr: 'l', help: 'Loud: section processing output', negatable: false);
    argParser.addFlag('louder',
        abbr: 'L',
        help: 'Louder: detailed section processing output',
        negatable: false);
    argParser.addOption(
      'abspath',
      abbr: 'P',
      help: 'The absolute path of the package top level directory',
    );
    argParser.addOption(
      'relpath',
      abbr: 'p',
      help: 'The relative path to the package top level directory',
    );

    late ArgResults results;
    try {
      results = argParser.parse(args);
    } on ArgParserException catch (e) {
      print(e.message);
      return;
    }

    // Help
    if (results['help']) {
      print('Usage: sbom -l -L');
      print('');
      print(argParser.usage);
      valid = false;
      return;
    }

    // Verbose
    if (results['loud']) {
      SbomUtilities.verbosity = SbomConstants.loud;
    }

    if (results['louder']) {
      SbomUtilities.verbosity = SbomConstants.louder;
    }

    // Package absolute path
    if (results['abspath'] != null && results['abspath'].isNotEmpty) {
      packageTopLevel = results['abspath'];
    }

    // Package relative path
    if (results['relpath'] != null && results['relpath'].isNotEmpty) {
      packageTopLevel = _getAbsolutePath(results['relpath']);
    }
    valid = true;
  }

  /// Get the absolute path to the package top level if a relative one is supplied.
  String _getAbsolutePath(String relativePath) =>
      path.join(path.current, relativePath);
}
