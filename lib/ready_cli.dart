
import 'dart:io';

void createStructure(String projectName) {
  final basePath = "$projectName/lib";
  Directory("$basePath/core").createSync(recursive: true);
  Directory("$basePath/features").createSync(recursive: true);
  Directory("$basePath/shared").createSync(recursive: true);
}
