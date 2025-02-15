import "package:args/args.dart";

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag("help", abbr: "h", negatable: false, help: "Show Usage")
    ..addOption("section", abbr: "s", help: "Section to run");

  try {
    final results = parser.parse(arguments);

    if (results["help"]) {
      printUsage(parser);
      return;
    }

    final section = results['section'] ?? '1';
  } catch (e) {
    print("Error: $e");
  }
}

void printUsage(ArgParser parser) {
  print("Usage: dart run bin/dart_playground.dart [options]");
  print(parser.usage);
}
