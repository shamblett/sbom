/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of '../sbom.dart';

/// SBOM types.
enum SbomType { none, spdx }

/// The main sbom configuration class
class SbomConfiguration {
  /// Construction
  SbomConfiguration(List<String> args) {
    _buildConfiguration(args);
  }

  /// Configuration valid
  bool valid = false;

  /// Output type.
  SbomType outputType = SbomType.none;

  /// Top level package path.
  /// This must be a standard Dart package directory with pubspec.yaml,
  /// the standard package directory structure and an sbom.yaml file
  /// if needed.
  /// If not supplied on the command line this is defaulted to where
  /// sbom was invoked.
  /// Note this is always an absolute path.
  String packageTopLevel = path.current;

  /// SBOM configuration file contents as parsed by the YAML package
  var sbomConfigurationContents = YamlMap();

  /// Package pubspec file contents as parsed by the YAML package
  var sbomPubspecContents = YamlMap();

  /// The name of the package being analysed from the pubspec.
  String packageName = SbomConstants.defaultPackageName;

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

  /// Parse the SBOM configuration file.
  void parseConfigurationFile() {
    final sbomFilepath =
        path.join(packageTopLevel, SbomConstants.sbomConfigurationFile);
    var sbomConfiguration = '';
    try {
      sbomConfiguration = File(sbomFilepath).readAsStringSync();
    } on FileSystemException {
      valid = false;
      SbomUtilities.error(
          'Cannot read SBOM configuration file, path is $sbomFilepath,  cannot continue');

      return;
    }
    var contents = loadYaml(sbomConfiguration);
    if (contents == null || contents.isEmpty) {
      valid = false;
      SbomUtilities.error(
          'SBOM configuration file is empty, path is $sbomFilepath,  cannot continue');

      return;
    }
    if (!contents.containsKey(SbomConstants.sbomType)) {
      valid = false;
      SbomUtilities.error(
          'No type specified in SBOM configuration file, cannot continue');

      return;
    }
    _setType(contents[SbomConstants.sbomType]);
    sbomConfigurationContents = contents;
  }

  /// Parse the package pubspec file.
  void parsePubspecFile() {
    // Parse the package pubspec file
    final pubspecFilepath =
        path.join(packageTopLevel, SbomConstants.sbomPubspecFile);
    var sbomPubspec = '';
    try {
      sbomPubspec = File(pubspecFilepath).readAsStringSync();
    } on FileSystemException {
      valid = false;
      SbomUtilities.error(
          'Cannot read package pubspec file, path is $pubspecFilepath,  cannot continue');

      return;
    }

    var contents = loadYaml(sbomPubspec);
    if (contents == null || contents.isEmpty) {
      valid = false;
      SbomUtilities.error(
          'Package pubspec file is empty, path is $pubspecFilepath,  cannot continue');

      return;
    }
    // Package name
    if (contents.containsKey(SbomConstants.pubspecName)) {
      packageName = contents[SbomConstants.pubspecName];
    } else {
      SbomUtilities.warning(
          'Package name not found in pubspec.yaml file, using default - your SBOM will not validate correctly');
    }
    sbomPubspecContents = contents;
  }

  /// Parse the SBOM configuration file and the package pubspec file.
  void parseSbomFiles() {
    parseConfigurationFile();
    parsePubspecFile();
  }

  /// Set the SBOM type.
  void _setType(String type) {
    switch (type) {
      case SbomConstants.sbomSpdx:
        {
          outputType = SbomType.spdx;
        }
        break;
      default:
        {
          valid = false;
          SbomUtilities.error(
              'Invalid type specified in SBOM configuration file, $type - cannot continue');
        }
    }
  }
}
