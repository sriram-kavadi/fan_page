import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nikhils_fantasy_studio/main.dart';
import 'package:nikhils_fantasy_studio/screens/home_screen.dart';

void main() {
  testWidgets('Fantasy Studio app smoke test & navigation bar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FantasyStudioApp());
    await tester.pump();

    // Verify MaterialApp title and shell
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    // Verify all 5 navigation destinations exist
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Templates'), findsOneWidget);
    expect(find.text('Studio'), findsOneWidget);
    expect(find.text('My Work'), findsOneWidget);
    expect(find.text('Packs'), findsOneWidget);

    // Verify Home screen is loaded initially
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
