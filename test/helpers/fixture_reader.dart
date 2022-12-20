import 'dart:io' show File;

String fixture(String name) => File('test/helpers/dummy_data/$name').readAsStringSync();
