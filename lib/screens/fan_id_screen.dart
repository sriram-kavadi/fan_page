import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/fan_models.dart';
import '../providers/fan_provider.dart';
import '../widgets/rk_widgets.dart';

class FanIdScreen extends StatefulWidget {
  const FanIdScreen({super.key});

  @override
  State<FanIdScreen> createState() => _FanIdScreenState();
}

class _FanIdScreenState extends State<FanIdScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  String _selectedDistrict = 'Hyderabad';
  String _selectedBlood = 'O+';
  MemberTier _selectedTier = MemberTier.royalVip;

  final List<String> _districts = const [
    'Hyderabad',
    'Warangal',
    'Karimnagar',
    'Nizamabad',
    'Khammam',
    'Nalgonda',
    'Mahabubnagar',
    'Adilabad',
    'Medak',
    'Ranga Reddy',
    'Bengaluru Chapter',
  ];

  final List<String> _bloodGroups = const [
    'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
  ];

  @override
  void initState() {
    super.initState();
    final fan = context.read<FanProvider>();
    _nameCtrl = TextEditingController(text: fan.userCard.name);
    _phoneCtrl = TextEditingController(text: fan.userCard.phone);
    _selectedDistrict = fan.userCard.district;
    _selectedBlood = fan.userCard.bloodGroup;
    _selectedTier = fan.userCard.tier;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  bool _saveCard(FanProvider fan) {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please correct validation errors before saving.'),
          backgroundColor: RKTheme.primary,
        ),
      );
      return false;
    }
    fan.updateUserCard(
      name: _nameCtrl.text.trim(),
      district: _selectedDistrict,
      phone: _phoneCtrl.text.trim(),
      bloodGroup: _selectedBlood,
      tier: _selectedTier,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✨ Member Card details validated & updated successfully!'),
        backgroundColor: RKTheme.emerald,
      ),
    );
    return true;
  }

  void _showDownloadSuccess(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? RKTheme.cardDark : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: const [
            Icon(Icons.verified, color: RKTheme.gold, size: 28),
            SizedBox(width: 10),
            Text('ID Pass Ready!', style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w800)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your official digital membership pass has been generated with a verified cryptographic QR code.',
              style: TextStyle(fontFamily: 'Outfit', fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: RKTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: RKTheme.primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.shield_outlined, color: RKTheme.primary, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Valid for all state rallies & priority youth summits.',
                      style: TextStyle(fontFamily: 'Outfit', fontSize: 12, fontWeight: FontWeight.w600, color: RKTheme.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(backgroundColor: RKTheme.primary),
            child: const Text('Great, Done!'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fan = context.watch<FanProvider>();

    // Live preview card based on local form state
    final previewCard = FanMemberCard(
      id: fan.userCard.id,
      name: _nameCtrl.text.isEmpty ? 'Your Full Name' : _nameCtrl.text,
      district: _selectedDistrict,
      phone: _phoneCtrl.text.isEmpty ? '+91 90000 00000' : _phoneCtrl.text,
      bloodGroup: _selectedBlood,
      tier: _selectedTier,
      joinedDate: fan.userCard.joinedDate,
      qrData: fan.userCard.qrData,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Digital Fan ID Pass'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live 3D Card Preview
            DigitalMemberCardWidget(card: previewCard),

            const SizedBox(height: 24),

            // Tier Selector
            Text(
              'Select Membership Tier',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _TierChip(
                  label: 'VIP Patron',
                  tier: MemberTier.royalVip,
                  isSelected: _selectedTier == MemberTier.royalVip,
                  activeColor: RKTheme.gold,
                  onTap: () => setState(() => _selectedTier = MemberTier.royalVip),
                ),
                const SizedBox(width: 8),
                _TierChip(
                  label: 'Gold Lead',
                  tier: MemberTier.gold,
                  isSelected: _selectedTier == MemberTier.gold,
                  activeColor: const Color(0xFFFFD166),
                  onTap: () => setState(() => _selectedTier = MemberTier.gold),
                ),
                const SizedBox(width: 8),
                _TierChip(
                  label: 'Silver',
                  tier: MemberTier.silver,
                  isSelected: _selectedTier == MemberTier.silver,
                  activeColor: Colors.white70,
                  onTap: () => setState(() => _selectedTier = MemberTier.silver),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Personal Information Inputs (Experiment 7: Form & Validation)
            Text(
              'Card Details (Form Validation)',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  // Name Field
                  TextFormField(
                    controller: _nameCtrl,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'Member Full Name *',
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: 'e.g. K. Vikram Reddy',
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Member full name is required';
                      }
                      if (val.trim().length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      if (!RegExp(r"^[a-zA-Z\s.'-]+$").hasMatch(val.trim())) {
                        return 'Name should only contain letters & spaces';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  // Phone Field
                  TextFormField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'Phone Number (10 Digits) *',
                      prefixIcon: Icon(Icons.phone_outlined),
                      hintText: 'e.g. 9848012345',
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      final digits = val.replaceAll(RegExp(r'\D'), '');
                      if (digits.length != 10) {
                        return 'Enter a 10-digit mobile number';
                      }
                      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(digits)) {
                        return 'Enter a valid Indian mobile number starting 6-9';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  // District & Blood Group Row
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          value: _selectedDistrict,
                          decoration: const InputDecoration(
                            labelText: 'District',
                            prefixIcon: Icon(Icons.location_on_outlined),
                          ),
                          dropdownColor: isDark ? RKTheme.cardDark : Colors.white,
                          items: _districts.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                          onChanged: (v) => setState(() => _selectedDistrict = v!),
                          validator: (v) => v == null ? 'Select district' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: _selectedBlood,
                          decoration: const InputDecoration(
                            labelText: 'Blood',
                            prefixIcon: Icon(Icons.bloodtype_outlined),
                          ),
                          dropdownColor: isDark ? RKTheme.cardDark : Colors.white,
                          items: _bloodGroups.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                          onChanged: (v) => setState(() => _selectedBlood = v!),
                          validator: (v) => v == null ? 'Select blood group' : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _saveCard(fan),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: RKTheme.primary, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.save_outlined, color: RKTheme.primary),
                    label: const Text('Save Details', style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w700, color: RKTheme.primary)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_saveCard(fan)) {
                        _showDownloadSuccess(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RKTheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.download_rounded, color: Colors.white),
                    label: const Text('Download Pass', style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _TierChip extends StatelessWidget {
  final String label;
  final MemberTier tier;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  const _TierChip({
    required this.label,
    required this.tier,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor.withValues(alpha: 0.2)
                : (isDark ? RKTheme.cardDark : Colors.white),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? activeColor : (isDark ? Colors.white12 : Colors.black12),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.stars_rounded,
                size: 20,
                color: isSelected ? activeColor : (isDark ? Colors.white38 : Colors.black38),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? activeColor : (isDark ? Colors.white70 : Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
