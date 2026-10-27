import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/rk_widgets.dart';

/// Experiments Hub: Interactive showcase of Experiments 1 to 10
class ExperimentsHubScreen extends StatefulWidget {
  const ExperimentsHubScreen({super.key});

  @override
  State<ExperimentsHubScreen> createState() => _ExperimentsHubScreenState();
}

class _ExperimentsHubScreenState extends State<ExperimentsHubScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _showExpDemo(BuildContext context, int expNumber) {
    switch (expNumber) {
      case 1:
        _showInfoDialog(
          context,
          'Exp 1: Dart Basics & SDK',
          'Demonstrated in:\n• bin/dart_basics.dart\n\nCovers: Variables, Types, Lists, Maps, Conditionals, Loops, Classes, and Methods.',
        );
        break;
      case 2:
        _showInfoDialog(
          context,
          'Exp 2: Widgets & Layouts',
          'Demonstrated in:\n• lib/widgets/rk_widgets.dart\n• lib/screens/home_screen.dart\n\nCovers: Text, Container, Row, Column, Stack with Positioned overlays, and CustomPaint.',
        );
        break;
      case 3:
        _showInfoDialog(
          context,
          'Exp 3: Responsive UI & MediaQueries',
          'Current Screen Width: ${MediaQuery.of(context).size.width.toStringAsFixed(1)} px\n'
              'Device Type: ${ResponsiveLayout.isMobile(context) ? "Mobile (<650px)" : (ResponsiveLayout.isTablet(context) ? "Tablet (650-1000px)" : "Desktop (>1000px)")}\n\n'
              'Demonstrated in lib/widgets/responsive_layout.dart using LayoutBuilder & MediaQuery.',
        );
        break;
      case 4:
        Navigator.pushNamed(context, '/api-feed');
        break;
      case 5:
        _showInfoDialog(
          context,
          'Exp 5: State Management',
          'Demonstrated in:\n• lib/providers/fan_provider.dart\n• lib/providers/theme_provider.dart\n\nUses: ChangeNotifier, MultiProvider, Consumer, and setState for local component states.',
        );
        break;
      case 6:
        _showInfoDialog(
          context,
          'Exp 6: Custom Widgets & Theming',
          'Demonstrated in:\n• lib/widgets/rk_widgets.dart (RKEmblemCrest, DigitalMemberCardWidget, PulseCheerButton)\n• lib/theme/app_theme.dart (Material 3 Dark & Light theme tokens).',
        );
        break;
      case 7:
        Navigator.pushNamed(context, '/fan-id');
        break;
      case 8:
        _animCtrl.reset();
        _animCtrl.forward();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✨ Triggered FadeTransition & SlideTransition!'),
            backgroundColor: RKTheme.emerald,
          ),
        );
        break;
      case 9:
        Navigator.pushNamed(context, '/api-feed');
        break;
      case 10:
        _showInfoDialog(
          context,
          'Exp 10: Unit & Widget Testing',
          'Test suite files:\n• test/unit/fan_models_test.dart\n• test/unit/fan_provider_test.dart\n• test/unit/theme_provider_test.dart\n• test/widget_test.dart\n\nRun with: flutter test',
        );
        break;
    }
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? RKTheme.cardDark : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w800)),
        content: Text(content, style: const TextStyle(fontFamily: 'Outfit', fontSize: 14, height: 1.45)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(backgroundColor: RKTheme.primary),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final experiments = [
      {'num': 1, 'title': 'Dart SDK & Language Basics', 'sub': 'bin/dart_basics.dart, OOP & types', 'tag': 'Dart'},
      {'num': 2, 'title': 'Widgets & Layout Structures', 'sub': 'Row, Column, Stack & Containers', 'tag': 'Layout'},
      {'num': 3, 'title': 'Responsive UI & Breakpoints', 'sub': 'MediaQuery & ResponsiveLayout', 'tag': 'Responsive'},
      {'num': 4, 'title': 'Navigator & Named Routes', 'sub': 'Declarative route navigation', 'tag': 'Routing'},
      {'num': 5, 'title': 'State Management', 'sub': 'setState & MultiProvider architecture', 'tag': 'State'},
      {'num': 6, 'title': 'Custom Widgets & Theming', 'sub': 'RKEmblemCrest & Material 3 themes', 'tag': 'Theme'},
      {'num': 7, 'title': 'Forms & Input Validation', 'sub': 'FormKey, Regex, TextFormField', 'tag': 'Forms'},
      {'num': 8, 'title': 'Animations Framework', 'sub': 'Fade, Slide & Scale transitions', 'tag': 'Animation'},
      {'num': 9, 'title': 'REST API Live Integration', 'sub': 'http GET/POST with 3 UI states', 'tag': 'REST API'},
      {'num': 10, 'title': 'Unit & Widget Testing', 'sub': 'test/unit & test/widget suites', 'tag': 'Testing'},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('🧪 Flutter Lab Experiments (1 - 10)'),
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            itemCount: experiments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final exp = experiments[index];
              final num = exp['num'] as int;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? RKTheme.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: RKTheme.rubyGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'E$num',
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: RKTheme.gold.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  exp['tag'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: RKTheme.goldDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exp['title'] as String,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            exp['sub'] as String,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 12,
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _showExpDemo(context, num),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RKTheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Test', style: TextStyle(fontFamily: 'Outfit', fontSize: 12)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
