/// Experiment 1b: Simple Dart Program demonstrating Language Basics
/// Concepts: Variables, Data Types, Control Flow, Functions, OOP, Collections.

void main() {
  print('==================================================');
  print('🌟 Experiment 1b: Dart Language Basics');
  print('App: Rathnaveri Kavitha Official Fan Hub');
  print('==================================================\n');

  // 1. Variables and Data Types
  String leaderName = 'Rathnaveri Kavitha';
  int establishedYear = 2020;
  double volunteerSatisfaction = 98.5;
  bool isOfficial = true;

  print('1. Variables & Types:');
  print('Leader: $leaderName');
  print('Active Since: $establishedYear');
  print('Rating: $volunteerSatisfaction%');
  print('Verified: $isOfficial\n');

  // 2. Collections (List & Map)
  List<String> keyDistricts = ['Hyderabad', 'Warangal', 'Karimnagar', 'Nizamabad'];
  keyDistricts.add('Khammam');

  Map<String, int> volunteerCounts = {
    'Hyderabad': 3800,
    'Warangal': 2900,
    'Karimnagar': 2450,
  };

  print('2. Collections:');
  print('Key Districts: ${keyDistricts.join(", ")}');
  print('Volunteer Map: $volunteerCounts\n');

  // 3. Control Flow & Loops
  print('3. Control Flow (Volunteers > 2500):');
  for (var entry in volunteerCounts.entries) {
    if (entry.value > 2500) {
      print('  ✓ Major Chapter: ${entry.key} with ${entry.value} active volunteers');
    }
  }
  print('');

  // 4. Object-Oriented Programming (Class & Constructor)
  final samplePass = MemberPass(
    memberId: 'RK-2026-VIP-001',
    name: 'Suresh Reddy',
    tier: 'Royal Patron VIP',
  );

  print('4. Object-Oriented Programming:');
  samplePass.displayCardInfo();
}

class MemberPass {
  final String memberId;
  final String name;
  final String tier;

  MemberPass({
    required this.memberId,
    required this.name,
    required this.tier,
  });

  void displayCardInfo() {
    print('  Card ID: $memberId');
    print('  Member : $name');
    print('  Tier   : $tier');
  }
}
