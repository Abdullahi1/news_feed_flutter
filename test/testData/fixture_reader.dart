import 'dart:io';

String fixture(String name) => File('test/testData/$name').readAsStringSync();
