import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rathnaveri_kavitha_fan_page/main.dart';
import 'package:rathnaveri_kavitha_fan_page/screens/home_screen.dart';
import 'package:rathnaveri_kavitha_fan_page/screens/experiments_hub_screen.dart';
import 'package:rathnaveri_kavitha_fan_page/models/fan_models.dart';
import 'package:rathnaveri_kavitha_fan_page/widgets/rk_widgets.dart';

void main() {
  testWidgets('Smoke test: MaterialApp, NavigationBar, and HomeScreen load', (WidgetTester tester) async {
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

  testWidgets('Custom DigitalMemberCardWidget renders member information', (WidgetTester tester) async {
    final card = FanMemberCard(
      id: 'RK-2026-VIP-999',
      name: 'Rathnaveri Fan Tester',
      district: 'Warangal',
      phone: '+91 98480 11223',
      bloodGroup: 'O+',
      tier: MemberTier.royalVip,
      joinedDate: DateTime(2026, 1, 1),
      qrData: 'QR-TEST-DATA',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitalMemberCardWidget(card: card),
        ),
      ),
    );

    expect(find.text('Rathnaveri Fan Tester'), findsOneWidget);
    expect(find.text('Warangal'), findsOneWidget);
    expect(find.text('O+'), findsOneWidget);
    expect(find.text('RK-2026-VIP-999'), findsOneWidget);
    expect(find.byType(RKEmblemCrest), findsWidgets);
  });

  testWidgets('ExperimentsHubScreen lists all 10 curriculum experiments', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ExperimentsHubScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Flutter Lab Experiments'), findsOneWidget);
    expect(find.text('E1'), findsOneWidget);
    expect(find.text('E2'), findsOneWidget);
    expect(find.text('E3'), findsOneWidget);
    expect(find.text('E4'), findsOneWidget);
    expect(find.text('E5'), findsOneWidget);
    expect(find.text('E6'), findsOneWidget);
    expect(find.text('E7'), findsOneWidget);
    expect(find.text('E8'), findsOneWidget);
    expect(find.text('E9'), findsOneWidget);
    expect(find.text('E10'), findsOneWidget);
  });
}
