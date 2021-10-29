/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The SBOM file support class.
/// Provides convenience methods for file listings, SHA1 generation etc.
class SbomFileSupport {
  /// Construction
  SbomFileSupport(this._topLevelPath);

  /// Package top level
  final String _topLevelPath;

  /// Gets a list of Dart files in a package directory from the lib and
  /// bin directories.
  /// Returns a list of absolute file paths or null if none found or
  /// an exception is raised.
  List<String> getPackageDartFiles() {
    var output = <String>[];
    try {
      // Lib
      final libDir = Directory(path.join(_topLevelPath, SbomConstants.libDir));
      final libFiles = libDir.listSync(recursive: true);
      for (final entity in libFiles) {
        if (entity is File) {
          var file = entity.absolute;
          if (path.extension(file.path) == SbomConstants.dartFiletype) {
            output.add(file.path);
          }
        }
      }
      // Bin
      final binDir = Directory(path.join(_topLevelPath, SbomConstants.binDir));
      final binFiles = binDir.listSync(recursive: true);
      for (final entity in binFiles) {
        if (entity is File) {
          var file = entity.absolute;
          if (path.extension(file.path) == SbomConstants.dartFiletype) {
            output.add(file.path);
          }
        }
      }
    } catch (e) {
      SbomUtilities.error(
          'File Support - exception $e thrown getting package files, the SBOM generation will be incorrect');
      return output;
    }
    return output;
  }
}
