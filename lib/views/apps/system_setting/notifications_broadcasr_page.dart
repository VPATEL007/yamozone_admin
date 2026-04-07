import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:yamazone/views/layouts/layout.dart';

// ─── Color Palette ───────────────────────────────────────────────────────────
const kPrimaryGreen = Color(0xFF1A3C34);
const kAccentGold = Color(0xFFD4A017);
const kActiveBadge = Color(0xFF2E7D32);
const kBgCream = Color(0xFFF9F6EE);
const kCardWhite = Color(0xFFFFFFFF);
const kTextDark = Color(0xFF1A1A1A);
const kTextMuted = Color(0xFF6B7280);
const kBorderColor = Color(0xFFE5E7EB);
const kCheckGreen = Color(0xFF4CAF50);

// ─── Main Page ────────────────────────────────────────────────────────────────
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _selectedTab = 0; // 0=Templates, 1=Broadcast, 2=History
  String _selectedTemplate = 'KYC Verification';
  String _selectedAudience = 'All Users';
  bool _pushEnabled = true;
  bool _smsEnabled = true;
  final _titleCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgCream,
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              _TopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TabRow(
                        selected: _selectedTab,
                        onTap: (i) => setState(() => _selectedTab = i),
                      ),
                      const SizedBox(height: 20),
                      if (_selectedTab == 0) ...[
                        _TemplatesGrid(),
                        const SizedBox(height: 32),
                        _BroadcastSection(
                          selectedTemplate: _selectedTemplate,
                          selectedAudience: _selectedAudience,
                          pushEnabled: _pushEnabled,
                          smsEnabled: _smsEnabled,
                          titleCtrl: _titleCtrl,
                          msgCtrl: _msgCtrl,
                          onTemplateChanged:
                              (v) => setState(() => _selectedTemplate = v),
                          onAudienceChanged:
                              (v) => setState(() => _selectedAudience = v),
                          onPushToggle: (v) => setState(() => _pushEnabled = v),
                          onSmsToggle: (v) => setState(() => _smsEnabled = v),
                        ),
                      ],
                      if (_selectedTab == 1)
                        _BroadcastSection(
                          selectedTemplate: _selectedTemplate,
                          selectedAudience: _selectedAudience,
                          pushEnabled: _pushEnabled,
                          smsEnabled: _smsEnabled,
                          titleCtrl: _titleCtrl,
                          msgCtrl: _msgCtrl,
                          onTemplateChanged:
                              (v) => setState(() => _selectedTemplate = v),
                          onAudienceChanged:
                              (v) => setState(() => _selectedAudience = v),
                          onPushToggle: (v) => setState(() => _pushEnabled = v),
                          onSmsToggle: (v) => setState(() => _smsEnabled = v),
                        ),
                      if (_selectedTab == 2)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(48),
                            child: Text(
                              'No history yet.',
                              style: TextStyle(color: kTextMuted),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Left Drawer (stub — user replaces with own) ─────────────────────────────
class _LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: kPrimaryGreen,
      child: const Center(
        child: Text(
          '← Your Drawer',
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
      ),
    );
  }
}

// ─── Top Bar ─────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: kCardWhite,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          const Text(
            'Notifications & Broadcast',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kTextDark,
            ),
          ),
          const Spacer(),
          _GreenButton(
            icon: Icons.download_outlined,
            label: 'Export Report',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ─── Tab Row ─────────────────────────────────────────────────────────────────
class _TabRow extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;
  const _TabRow({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      (Icons.grid_view_rounded, 'Templates'),
      (Icons.campaign_outlined, 'Broadcast'),
      (Icons.history_rounded, 'History'),
    ];
    return Row(
      children: [
        Row(
          children: List.generate(tabs.length, (i) {
            final active = i == selected;
            return GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: active ? kPrimaryGreen : kCardWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: active ? kPrimaryGreen : kBorderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      tabs[i].$1,
                      size: 16,
                      color: active ? Colors.white : kTextMuted,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tabs[i].$2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: active ? Colors.white : kTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const Spacer(),
        _GreenButton(icon: Icons.add, label: 'Create Template', onTap: () {}),
      ],
    );
  }
}

// ─── Templates Grid ──────────────────────────────────────────────────────────
class _TemplatesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final templates = [
      _TemplateData(
        icon: Icons.verified_user_outlined,
        iconColor: kAccentGold,
        title: 'KYC Verification',
        subtitle: 'User identity verification',
        hasPush: true,
        hasSms: true,
        msgTitle: 'KYC Status Update',
        msgBody: 'Your KYC verification has been {status}. {details}',
      ),
      _TemplateData(
        icon: Icons.local_shipping_outlined,
        iconColor: kAccentGold,
        title: 'Order Updates',
        subtitle: 'Order status notifications',
        hasPush: true,
        hasSms: true,
        msgTitle: 'Order #{order_id}',
        msgBody: 'Your order is now {status}. Track: {tracking_link}',
      ),
      _TemplateData(
        icon: Icons.build_outlined,
        iconColor: kAccentGold,
        title: 'Dispute Resolution',
        subtitle: 'Dispute status updates',
        hasPush: true,
        hasSms: true,
        msgTitle: 'Dispute #{dispute_id}',
        msgBody: 'Your dispute has been {action}. Resolution: {details}',
      ),
      _TemplateData(
        icon: Icons.key_outlined,
        iconColor: kAccentGold,
        title: 'OTP Verification',
        subtitle: 'One-time password',
        hasPush: true,
        hasSms: true,
        msgTitle: 'Verification Code',
        msgBody: 'Your OTP is {code}. Valid for {duration} minutes.',
        smsDisabled: true,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        double aspectRatio;

        if (width > 1200) {
          aspectRatio = 3.2; // large screens
        } else if (width > 800) {
          aspectRatio = 2.5; // medium screens
        } else {
          aspectRatio = 1.8; // small screens
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: aspectRatio,
          ),
          itemCount: templates.length,
          itemBuilder: (_, i) => _TemplateCard(data: templates[i]),
        );
      },
    );
  }
}

class _TemplateData {
  final IconData icon;
  final Color iconColor;
  final String title, subtitle, msgTitle, msgBody;
  final bool hasPush, hasSms, smsDisabled;
  const _TemplateData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.msgTitle,
    required this.msgBody,
    this.hasPush = false,
    this.hasSms = false,
    this.smsDisabled = false,
  });
}

class _TemplateCard extends StatelessWidget {
  final _TemplateData data;
  const _TemplateCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: kAccentGold.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(data.icon, color: data.iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: kTextDark,
                      ),
                    ),
                    Text(
                      data.subtitle,
                      style: const TextStyle(fontSize: 12, color: kTextMuted),
                    ),
                  ],
                ),
              ),
              _ActiveBadge(),
            ],
          ),
          const SizedBox(height: 10),
          // Channel rows
          _ChannelRow(
            icon: Icons.phone_android,
            label: 'Push Notification',
            enabled: data.hasPush,
          ),
          const SizedBox(height: 4),
          _ChannelRow(
            icon: Icons.sms_outlined,
            label: 'SMS',
            enabled: data.hasSms,
            disabled: data.smsDisabled,
          ),
          const SizedBox(height: 10),
          // Message preview
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: kTextDark),
              children: [
                const TextSpan(
                  text: 'Title: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: data.msgTitle),
              ],
            ),
          ),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: kTextDark),
              children: [
                const TextSpan(
                  text: 'Message: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: data.msgBody),
              ],
            ),
          ),
          const Spacer(),
          // Buttons
          Row(
            children: [
              Expanded(
                child: _GreenButton(
                  icon: Icons.edit_outlined,
                  label: 'Edit',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _OutlineButton(
                  icon: Icons.visibility_outlined,
                  label: 'Preview',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: kActiveBadge.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kActiveBadge.withOpacity(0.3)),
      ),
      child: const Text(
        'Active',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: kActiveBadge,
        ),
      ),
    );
  }
}

class _ChannelRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled, disabled;
  const _ChannelRow({
    required this.icon,
    required this.label,
    required this.enabled,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: kAccentGold),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: kTextMuted)),
        const Spacer(),
        if (disabled)
          const Icon(Icons.close, size: 14, color: Colors.red)
        else if (enabled)
          const Icon(Icons.check, size: 14, color: kCheckGreen),
      ],
    );
  }
}

// ─── Broadcast Section ───────────────────────────────────────────────────────
class _BroadcastSection extends StatelessWidget {
  final String selectedTemplate, selectedAudience;
  final bool pushEnabled, smsEnabled;
  final TextEditingController titleCtrl, msgCtrl;
  final ValueChanged<String> onTemplateChanged, onAudienceChanged;
  final ValueChanged<bool> onPushToggle, onSmsToggle;

  const _BroadcastSection({
    required this.selectedTemplate,
    required this.selectedAudience,
    required this.pushEnabled,
    required this.smsEnabled,
    required this.titleCtrl,
    required this.msgCtrl,
    required this.onTemplateChanged,
    required this.onAudienceChanged,
    required this.onPushToggle,
    required this.onSmsToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Send Broadcast',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: kTextDark,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Send notifications to specific user segments',
          style: TextStyle(fontSize: 13, color: kTextMuted),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left form
            Expanded(
              flex: 3,
              child: _BroadcastForm(
                selectedTemplate: selectedTemplate,
                selectedAudience: selectedAudience,
                pushEnabled: pushEnabled,
                smsEnabled: smsEnabled,
                titleCtrl: titleCtrl,
                msgCtrl: msgCtrl,
                onTemplateChanged: onTemplateChanged,
                onAudienceChanged: onAudienceChanged,
                onPushToggle: onPushToggle,
                onSmsToggle: onSmsToggle,
              ),
            ),
            const SizedBox(width: 20),
            // Right stats
            Expanded(flex: 2, child: _ReachStats()),
          ],
        ),
      ],
    );
  }
}

class _BroadcastForm extends StatelessWidget {
  final String selectedTemplate, selectedAudience;
  final bool pushEnabled, smsEnabled;
  final TextEditingController titleCtrl, msgCtrl;
  final ValueChanged<String> onTemplateChanged, onAudienceChanged;
  final ValueChanged<bool> onPushToggle, onSmsToggle;

  const _BroadcastForm({
    required this.selectedTemplate,
    required this.selectedAudience,
    required this.pushEnabled,
    required this.smsEnabled,
    required this.titleCtrl,
    required this.msgCtrl,
    required this.onTemplateChanged,
    required this.onAudienceChanged,
    required this.onPushToggle,
    required this.onSmsToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderColor),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel('Select Template'),
          const SizedBox(height: 6),
          _DropdownField(
            value: selectedTemplate,
            items: const [
              'KYC Verification',
              'Order Updates',
              'Dispute Resolution',
              'OTP Verification',
            ],
            onChanged: onTemplateChanged,
          ),
          const SizedBox(height: 16),
          _FieldLabel('Target Audience'),
          const SizedBox(height: 6),
          _DropdownField(
            value: selectedAudience,
            items: const ['All Users', 'Buyers', 'Sellers', 'Drivers'],
            onChanged: onAudienceChanged,
          ),
          const SizedBox(height: 16),
          _FieldLabel('Notification Channels'),
          const SizedBox(height: 8),
          _ChannelCheckbox(
            icon: Icons.phone_android,
            label: 'Push Notification',
            value: pushEnabled,
            onChanged: onPushToggle,
          ),
          const SizedBox(height: 8),
          _ChannelCheckbox(
            icon: Icons.sms_outlined,
            label: 'SMS',
            value: smsEnabled,
            onChanged: onSmsToggle,
          ),
          const SizedBox(height: 16),
          _FieldLabel('Message Title'),
          const SizedBox(height: 6),
          TextField(
            controller: titleCtrl,
            decoration: _inputDeco('Enter notification title'),
          ),
          const SizedBox(height: 16),
          _FieldLabel('Message Content'),
          const SizedBox(height: 6),
          TextField(
            controller: msgCtrl,
            maxLines: 4,
            decoration: _inputDeco('Enter your message here...'),
          ),
          const SizedBox(height: 8),
          const Text(
            'Available variables: {user_name}, {order_id}, {status}, {date}',
            style: TextStyle(fontSize: 11, color: kTextMuted),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text(
                    'Send Now',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.schedule, size: 16, color: kAccentGold),
                label: const Text(
                  'Schedule',
                  style: TextStyle(
                    color: kAccentGold,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  side: const BorderSide(color: kAccentGold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDeco(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 13, color: kTextMuted),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    filled: true,
    fillColor: kBgCream,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kBorderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: kPrimaryGreen, width: 1.5),
    ),
  );
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: kTextDark,
    ),
  );
}

class _DropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  const _DropdownField({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: kBgCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: kTextMuted,
            size: 20,
          ),
          style: const TextStyle(fontSize: 13, color: kTextDark),
          items:
              items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
          onChanged: (v) => onChanged(v!),
        ),
      ),
    );
  }
}

class _ChannelCheckbox extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ChannelCheckbox({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: kPrimaryGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onChanged: (v) => onChanged(v ?? false),
        ),
        Icon(icon, size: 16, color: kAccentGold),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 13, color: kTextDark)),
      ],
    );
  }
}

// ─── Reach Stats Panel ───────────────────────────────────────────────────────
class _ReachStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Estimated reach card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kPrimaryGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Estimated Reach',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '12,847',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'users will receive this notification',
                style: TextStyle(fontSize: 12, color: Colors.white60),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Segment breakdown
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kCardWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorderColor),
          ),
          child: Column(
            children: [
              _SegmentRow(label: 'Buyers', count: 5234, fraction: 0.68),
              const SizedBox(height: 14),
              _SegmentRow(label: 'Sellers', count: 4891, fraction: 0.58),
              const SizedBox(height: 14),
              _SegmentRow(label: 'Drivers', count: 2722, fraction: 0.40),
              const SizedBox(height: 16),
              // Cost estimate
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kBgCream,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kBorderColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: kAccentGold,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Cost Estimate',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: kTextDark,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'SMS: \$128.47 (12,847 recipients)',
                          style: TextStyle(fontSize: 11, color: kTextMuted),
                        ),
                        Text(
                          'Push: Free',
                          style: TextStyle(fontSize: 11, color: kTextMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SegmentRow extends StatelessWidget {
  final String label;
  final int count;
  final double fraction;
  const _SegmentRow({
    required this.label,
    required this.count,
    required this.fraction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: kTextDark,
              ),
            ),
            Text(
              count.toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (m) => '${m[1]},',
              ),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: kTextDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: fraction,
            backgroundColor: kBorderColor,
            color: kAccentGold,
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

// ─── Shared Buttons ──────────────────────────────────────────────────────────
class _GreenButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _GreenButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 15),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 15, color: kAccentGold),
      label: Text(
        label,
        style: const TextStyle(
          color: kAccentGold,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        side: const BorderSide(color: kAccentGold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
