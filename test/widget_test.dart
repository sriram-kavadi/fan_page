import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rathnaveri_kavitha_fan_page/main.dart';
import 'package:rathnaveri_kavitha_fan_page/screens/home_screen.dart';

void main() {
  testWidgets('Rathnaveri Kavitha Fan Page smoke test & navigation bar', (WidgetTester tester) async {
    await tester.pumpWidget(const RathnaveriKavithaFanApp());
    await tester.pump();

    // Verify MaterialApp title and shell
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    // Verify all 5 navigation destinations exist
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Fan ID'), findsOneWidget);
    expect(find.text('Fan Wall'), findsOneWidget);
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('Journey'), findsOneWidget);

    // Verify Home screen is loaded initially
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
