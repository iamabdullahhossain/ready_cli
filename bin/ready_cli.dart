import 'dart:io';

import 'package:ready_cli/ready_cli.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print("Please provide project name");
    return;
  }

  final projectName = arguments.first;
  print("Creating Flutter project: $projectName");
  await Process.run("flutter", ["create", projectName]);
  print("Project created successfully!");

  createStructure(projectName);


}
