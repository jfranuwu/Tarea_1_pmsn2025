import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarea_1/main.dart' as main_app;
import 'package:tarea_1/screens/explore.dart' as explore_screen;

void main() {
  testWidgets('Verificar que la aplicación se construye correctamente', (WidgetTester tester) async {
    // Construir la aplicación usando la versión de MyApp de main.dart
    await tester.pumpWidget(const main_app.MyApp());

    // Verificar que el título principal existe
    expect(find.text('Aspen'), findsOneWidget);

    // Verificar que el subtítulo existe
    expect(find.text('Explore'), findsOneWidget);
  });

  testWidgets('Verificar que la pantalla de exploración se construye correctamente', (WidgetTester tester) async {
    // Construir solo la pantalla de exploración sin conflictos
    await tester.pumpWidget(const MaterialApp(home: explore_screen.ExploreScreen()));

    // Verificar que el campo de búsqueda existe
    expect(find.byType(TextField), findsOneWidget);

    // Verificar que los botones de categorías existen
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('Hotels'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Adventure'), findsOneWidget);
    expect(find.text('Culture'), findsOneWidget);
    expect(find.text('Shopping'), findsOneWidget);
    expect(find.text('Nightlife'), findsOneWidget);
  });
}
