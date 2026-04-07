import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:yamazone/views/layouts/layout.dart';

// ─────────────────────────────────────────────
// THEME CONSTANTS
// ─────────────────────────────────────────────
const Color kPrimary = Color(0xFF8B7355); // warm brown/gold
const Color kPrimaryLight = Color(0xFFF5F0E8); // cream background
const Color kAccentGold = Color(0xFFD4A853);
const Color kActiveBadge = Color(0xFF4CAF50);
const Color kCardBg = Color(0xFFFFFDF7);
const Color kBorder = Color(0xFFE8E0D0);
const Color kTextDark = Color(0xFF2C2416);
const Color kTextMid = Color(0xFF6B5E4A);
const Color kTextLight = Color(0xFF9E8E78);

// ─────────────────────────────────────────────
// MAIN SCREEN (wraps drawer + content)
// ─────────────────────────────────────────────
class SystemSettingsPage extends StatelessWidget {
  const SystemSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLight,
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SystemSettingsContent(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SYSTEM SETTINGS CONTENT
// ─────────────────────────────────────────────
class SystemSettingsContent extends StatefulWidget {
  const SystemSettingsContent({super.key});

  @override
  State<SystemSettingsContent> createState() => _SystemSettingsContentState();
}

class _SystemSettingsContentState extends State<SystemSettingsContent> {
  // Controllers – Platform Fees
  final _sellerCommCtrl = TextEditingController(text: '2.5');
  final _buyerFeeCtrl = TextEditingController(text: '1.5');
  final _driverCommCtrl = TextEditingController(text: '15.0');

  // Escrow
  final _timeoutCtrl = TextEditingController(text: '10');
  bool _autoRelease = true;

  // Return Policy
  final _returnWindowCtrl = TextEditingController(text: '30');
  final _refundProcessCtrl = TextEditingController(text: '5');
  bool _originalCondition = true;
  bool _originalPackaging = true;
  bool _partialRefunds = false;

  // API Keys
  final _twilioSidCtrl = TextEditingController(
    text: 'AC************************',
  );
  final _twilioTokenCtrl = TextEditingController(
    text: '****************************',
  );
  final _sgApiKeyCtrl = TextEditingController(
    text: 'SG.**********************',
  );
  final _fromEmailCtrl = TextEditingController(text: 'noreply@platform.com');
  final _stripePublicCtrl = TextEditingController(
    text: 'pk_live_************************',
  );
  final _stripeSecretCtrl = TextEditingController(
    text: 'sk_live_************************',
  );

  @override
  void dispose() {
    for (final c in [
      _sellerCommCtrl,
      _buyerFeeCtrl,
      _driverCommCtrl,
      _timeoutCtrl,
      _returnWindowCtrl,
      _refundProcessCtrl,
      _twilioSidCtrl,
      _twilioTokenCtrl,
      _sgApiKeyCtrl,
      _fromEmailCtrl,
      _stripePublicCtrl,
      _stripeSecretCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(onSave: () {}),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _platformFeesSection(),
                const SizedBox(height: 24),
                _escrowSection(),
                const SizedBox(height: 24),
                _returnPolicySection(),
                const SizedBox(height: 24),
                _providerApiKeysSection(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── SECTION: Platform Fees & Commissions ───
  Widget _platformFeesSection() {
    return _SectionCard(
      icon: Icons.percent_rounded,
      iconColor: kPrimary,
      title: 'Platform Fees & Commissions',
      subtitle: 'Configure commission rates for different user types',
      badge: _ActiveBadge(),
      child: Row(
        children: [
          Expanded(
            child: _NumberField(
              label: 'Seller Commission (%)',
              hint: 'Commission charged to sellers per transaction',
              controller: _sellerCommCtrl,
              suffix: '%',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _NumberField(
              label: 'Buyer Service Fee (%)',
              hint: 'Service fee charged to buyers',
              controller: _buyerFeeCtrl,
              suffix: '%',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _NumberField(
              label: 'Driver Commission (%)',
              hint: 'Commission for delivery drivers',
              controller: _driverCommCtrl,
              suffix: '%',
            ),
          ),
        ],
      ),
    );
  }

  // ── SECTION: Escrow Settings ────────────────
  Widget _escrowSection() {
    return _SectionCard(
      icon: Icons.shield_rounded,
      iconColor: kAccentGold,
      title: 'Escrow Settings',
      subtitle: 'Configure payment protection and timeout periods',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _NumberField(
              label: 'Default Timeout (Days)',
              hint: 'Days before funds are automatically released',
              controller: _timeoutCtrl,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _CheckboxCard(
              title: 'Auto-Release',
              items: [
                _CheckItem(
                  label: 'Enable automatic fund release',
                  sublabel: 'Automatically release funds after timeout period',
                  value: _autoRelease,
                  onChanged: (v) => setState(() => _autoRelease = v!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── SECTION: Return Policy Rules ────────────
  Widget _returnPolicySection() {
    return _SectionCard(
      icon: Icons.replay_rounded,
      iconColor: kPrimary,
      title: 'Return Policy Rules',
      subtitle: 'Configure return and refund policies',
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _NumberField(
                  label: 'Return Window (Days)',
                  hint: 'Days customers have to initiate returns',
                  controller: _returnWindowCtrl,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _CheckboxCard(
                  title: 'Return Conditions',
                  items: [
                    _CheckItem(
                      label: 'Item must be in original condition',
                      value: _originalCondition,
                      onChanged: (v) => setState(() => _originalCondition = v!),
                    ),
                    _CheckItem(
                      label: 'Original packaging required',
                      value: _originalPackaging,
                      onChanged: (v) => setState(() => _originalPackaging = v!),
                    ),
                    _CheckItem(
                      label: 'Allow partial refunds',
                      value: _partialRefunds,
                      onChanged: (v) => setState(() => _partialRefunds = v!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _NumberField(
                  label: 'Refund Processing (Days)',
                  hint: 'Days to process approved refunds',
                  controller: _refundProcessCtrl,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  // ── SECTION: Provider API Keys ───────────────
  Widget _providerApiKeysSection() {
    return _SectionCard(
      icon: Icons.key_rounded,
      iconColor: kAccentGold,
      title: 'Provider API Keys',
      subtitle: 'Configure SMS, Email, and Payment provider settings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SMS Provider
          _ProviderSubHeader(
            icon: Icons.sms_outlined,
            label: 'SMS Provider (Twilio)',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _LabeledField(
                  label: 'Account SID',
                  controller: _twilioSidCtrl,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _LabeledField(
                  label: 'Auth Token',
                  controller: _twilioTokenCtrl,
                  obscure: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: kBorder),
          const SizedBox(height: 20),

          // Email Provider
          _ProviderSubHeader(
            icon: Icons.email_outlined,
            label: 'Email Provider (SendGrid)',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _LabeledField(
                  label: 'API Key',
                  controller: _sgApiKeyCtrl,
                  obscure: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _LabeledField(
                  label: 'From Email',
                  controller: _fromEmailCtrl,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: kBorder),
          const SizedBox(height: 20),

          // Payment Provider
          _ProviderSubHeader(
            icon: Icons.credit_card_outlined,
            label: 'Payment Provider (Stripe)',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _LabeledField(
                  label: 'Publishable Key',
                  controller: _stripePublicCtrl,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _LabeledField(
                  label: 'Secret Key',
                  controller: _stripeSecretCtrl,
                  obscure: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TOP BAR
// ─────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final VoidCallback onSave;
  const _TopBar({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: kBorder)),
      ),
      child: Row(
        children: [
          const Text(
            'System Settings',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: kTextDark,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save_rounded, size: 18),
            label: const Text('Save Changes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C5F2E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Section Card
// ─────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget child;
  final Widget? badge;

  const _SectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.child,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
        boxShadow: [
          BoxShadow(
            color: kPrimary.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kTextDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(fontSize: 12, color: kTextLight),
                      ),
                    ],
                  ),
                ),
                if (badge != null) badge!,
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: kBorder, height: 1),
          Padding(padding: const EdgeInsets.all(20), child: child),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Active Badge
// ─────────────────────────────────────────────
class _ActiveBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: kActiveBadge.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kActiveBadge.withOpacity(0.3)),
      ),
      child: const Text(
        'Active',
        style: TextStyle(
          color: kActiveBadge,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Number Input Field
// ─────────────────────────────────────────────
class _NumberField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? suffix;

  const _NumberField({
    required this.label,
    required this.hint,
    required this.controller,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: kTextMid,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: kTextDark,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (suffix != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    suffix!,
                    style: const TextStyle(
                      color: kTextLight,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(hint, style: const TextStyle(fontSize: 11, color: kTextLight)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Labeled Text Field
// ─────────────────────────────────────────────
class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;

  const _LabeledField({
    required this.label,
    required this.controller,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: kTextMid,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kBorder),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(
              fontSize: 13,
              color: kTextDark,
              fontWeight: FontWeight.w400,
              fontFamily: 'monospace',
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Checkbox Card
// ─────────────────────────────────────────────
class _CheckItem {
  final String label;
  final String? sublabel;
  final bool value;
  final ValueChanged<bool?> onChanged;

  _CheckItem({
    required this.label,
    this.sublabel,
    required this.value,
    required this.onChanged,
  });
}

class _CheckboxCard extends StatelessWidget {
  final String title;
  final List<_CheckItem> items;

  const _CheckboxCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kPrimaryLight,
        border: Border.all(color: kBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kTextMid,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: item.value,
                      onChanged: item.onChanged,
                      activeColor: kAccentGold,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 12,
                            color: kTextDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (item.sublabel != null)
                          Text(
                            item.sublabel!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: kTextLight,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Provider Sub-Header
// ─────────────────────────────────────────────
class _ProviderSubHeader extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProviderSubHeader({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: kAccentGold),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: kTextDark,
          ),
        ),
      ],
    );
  }
}
