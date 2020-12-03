import 'dart:io';
import 'dart:typed_data';

String fixture(String name) => File('test/testData/$name').readAsStringSync();

Future<Uint8List> fixtureAsByte(String name) =>
    File('test/testData/$name').readAsBytes();