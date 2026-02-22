import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final parser = ArgParser();

  if (arguments.isEmpty) {
    print("Usage: ready create <project_name>");
    return;
  }

  final command = arguments[0];

  if (command == "create") {
    if (arguments.length < 2) {
      print("Please provide project name");
      return;
    }

    final projectName = arguments[1];
    await createProject(projectName);
  } else {
    print("Unknown command");
  }
}

Future<void> createProject(String name) async {
  print("Creating Flutter project...");

  await Process.run("flutter", ["create", name]);

  createStructure(name);
  await addDependencies(name);
  replaceMainFile(name);

  print("Project $name created successfully!");
}

void createStructure(String name) {
  final base = "$name/lib";

  Directory("$base/core/config").createSync(recursive: true);
  Directory("$base/core/theme").createSync(recursive: true);
  Directory("$base/features").createSync(recursive: true);
  Directory("$base/shared").createSync(recursive: true);
}

Future<void> addDependencies(String name) async {
  await Process.run("flutter", ["pub", "add", "flutter_riverpod"], workingDirectory: name);
  await Process.run("flutter", ["pub", "add", "go_router"], workingDirectory: name);
  await Process.run("flutter", ["pub", "add", "dio"], workingDirectory: name);
}

void replaceMainFile(String name) {
  File("$name/lib/main.dart").writeAsStringSync("""
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text("Ready App")),
      ),
    );
  }
}
""");
}