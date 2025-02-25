// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tarea_1/main.dart';

// En widget_test.dart
void main() {
  testWidgets('Verificar que la aplicación se construye correctamente', 
      (WidgetTester tester) async {
    // Construir la aplicación sin el modificador const
    await tester.pumpWidget(MyApp());

    // Verificar que el título principal existe
    expect(find.text('Aspen'), findsOneWidget);

    // Verificar que el subtítulo existe
    expect(find.text('Your luxurious vacations'), findsOneWidget);

    // Verificar que el botón Explore existe
    expect(find.text('Explore'), findsOneWidget);
  });
}
