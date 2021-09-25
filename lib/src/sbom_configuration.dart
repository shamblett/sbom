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

  /// Verbosity
  int verbosity = SbomConstants.off;

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
      return;
    }

    // Verbose
    if (results['loud']) {
      verbosity = SbomConstants.loud;
    }

    if (results['louder']) {
      verbosity = SbomConstants.louder;
    }

    valid = true;
  }
}
