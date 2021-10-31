/*
 * Package : sbom
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 22/09/2021
 * Copyright :  S.Hamblett
 */

part of sbom;

/// The SBOM file support class.
/// Provides convenience methods for file listings, SHA1 generation of file contents etc.
class SbomFileSupport {
  /// Construction
  SbomFileSupport(this._topLevelPath);

  /// Package top level
  final String _topLevelPath;

  /// Gets a list of Dart files in a package directory from the lib and
  /// bin directories.
  /// Returns a list of absolute file paths, empty if none found or
  /// an exception is raised.
  List<String> packageDartFiles() {
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
    }
    return output;
  }

  /// Get the SHA1 digest of a supplied absolute file path.
  /// Returns the digest or empty if it could not be calculated.
  String sha1Digest(String path) {
    var output = '';
    try {
      final file = File(path);
      final bytes = file.readAsBytesSync();
      output = sha1.convert(bytes).toString();
    } catch (e) {
      SbomUtilities.warning(
          'File Support - exception $e thrown generating sha1 digest for $path, the SBOM generation will be incorrect');
    }
    return output;
  }
}
