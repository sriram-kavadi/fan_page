import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nikhils_fantasy_studio/providers/studio_provider.dart';
import 'package:nikhils_fantasy_studio/providers/theme_provider.dart';
import 'package:nikhils_fantasy_studio/screens/template_library_screen.dart';
import 'package:nikhils_fantasy_studio/screens/packs_screen.dart';

void main() {
  group('Studio Screens Widget Tests', () {
    testWidgets('TemplateLibraryScreen renders categories and search field', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => StudioProvider()),
          ],
          child: const MaterialApp(
            home: TemplateLibraryScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('🎨 Templates'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Cosmic'), findsOneWidget);
      expect(find.text('Fantasy'), findsOneWidget);
    });

    testWidgets('PacksScreen renders all sticker pack cards and stats', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => StudioProvider()),
          ],
          child: const MaterialApp(
            home: PacksScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('📦 Sticker Packs'), findsOneWidget);
      expect(find.text('Cosmic Explorer'), findsOneWidget);
      expect(find.text('Fantasy Realm'), findsOneWidget);
      expect(find.text('Nature Force'), findsOneWidget);
    });
  });
}
