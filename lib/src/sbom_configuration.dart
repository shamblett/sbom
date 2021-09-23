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
    argParser.addFlag('verbose',
        abbr: 'l',
        help: 'Verbose: section processing indication',
        negatable: false);
    argParser.addFlag('veryverbose',
        abbr: 'L',
        help: 'Detailed verbose: detailed section processing indication',
        negatable: false);

    late ArgResults results;
    try {
      results = argParser.parse(args);
    } on FormatException catch (e) {
      print(e.message);
    }

    // Help
    if (results['help']) {
      print('Usage: sbom -v(v)');
      print('');
      print(argParser.usage);
    }

    // Verbose
    if (results['verbose']) {
      verbosity = SbomConstants.verbose;
      valid = true;
    }

    if (results['veryverbose']) {
      verbosity = SbomConstants.veryVerbose;
      valid = true;
    }
  }
}
