import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// YAMO DESIGN TOKENS
// ─────────────────────────────────────────────
class YamoColors {
  static const primary = Color(0xFFF5A623); // Golden amber
  static const primaryDark = Color(0xFFD4891A);
  static const danger = Color(0xFFE53E3E);
  static const dangerLight = Color(0xFFFFF5F5);
  static const dangerBorder = Color(0xFFFEB2B2);
  static const warning = Color(0xFFDD6B20);
  static const warningLight = Color(0xFFFFFAF0);
  static const warningBorder = Color(0xFFFBD38D);
  static const success = Color(0xFF38A169);
  static const successLight = Color(0xFFF0FFF4);
  static const info = Color(0xFF3182CE);
  static const infoLight = Color(0xFFEBF8FF);
  static const infoBorder = Color(0xFFBEE3F8);
  static const walletGreen = Color(0xFF1A3A2A);
  static const surface = Color(0xFFFFFFFF);
  static const background = Color(0xFFF7F8FA);
  static const border = Color(0xFFE2E8F0);
  static const textPrimary = Color(0xFF1A202C);
  static const textSecondary = Color(0xFF718096);
  static const textMuted = Color(0xFFA0AEC0);
  static const divider = Color(0xFFEDF2F7);
}

// ─────────────────────────────────────────────
// SHARED DIALOG WRAPPER
// ─────────────────────────────────────────────
class YamoDialog extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const YamoDialog({super.key, required this.child, this.maxWidth = 480});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: YamoColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DIALOG HEADER
// ─────────────────────────────────────────────
class _DialogHeader extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onClose;
  final Color? borderColor;

  const _DialogHeader({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onClose,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 20, 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderColor ?? YamoColors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: YamoColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: YamoColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: YamoColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 18,
                color: YamoColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// STYLED INPUT FIELD
// ─────────────────────────────────────────────
class _YamoInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final int maxLines;
  final bool required;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const _YamoInput({
    required this.label,
    required this.hint,
    this.controller,
    this.maxLines = 1,
    this.required = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: YamoColors.textPrimary,
              ),
            ),
            if (required) ...[
              const SizedBox(width: 3),
              const Text(
                '*',
                style: TextStyle(color: YamoColors.danger, fontSize: 13),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14, color: YamoColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: YamoColors.textMuted,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: YamoColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: YamoColors.border, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: YamoColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// USER CHIP (appears at top of most dialogs)
// ─────────────────────────────────────────────
class _UserChip extends StatelessWidget {
  const _UserChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: YamoColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: YamoColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: YamoColors.primary.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 20,
              color: YamoColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'John Anderson',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: YamoColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'john.anderson@email.com · USR-2024-45891',
                  style: TextStyle(
                    fontSize: 12,
                    color: YamoColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: YamoColors.successLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Active',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: YamoColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 1. SEND EMAIL DIALOG
// ─────────────────────────────────────────────
class SendEmailDialog extends StatefulWidget {
  const SendEmailDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => const SendEmailDialog(),
  );

  @override
  State<SendEmailDialog> createState() => _SendEmailDialogState();
}

class _SendEmailDialogState extends State<SendEmailDialog> {
  String _selectedTemplate = 'none';
  final _subjectCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();

  final _templates = {
    'none': 'No template',
    'welcome': 'Welcome Message',
    'warning': 'Account Warning',
    'kyc': 'KYC Required',
    'suspend': 'Account Suspended',
  };

  @override
  Widget build(BuildContext context) {
    return YamoDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogHeader(
            icon: Icons.mail_outline_rounded,
            iconColor: YamoColors.info,
            iconBg: YamoColors.infoLight,
            title: 'Send Email',
            subtitle: 'Compose and send email to user',
            onClose: () => Navigator.pop(context),
            borderColor: YamoColors.infoBorder,
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _UserChip(),
                  const SizedBox(height: 20),
                  // Template selector
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Template',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: YamoColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: YamoColors.background,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: YamoColors.border),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedTemplate,
                            isExpanded: true,
                            style: const TextStyle(
                              fontSize: 14,
                              color: YamoColors.textPrimary,
                            ),
                            items:
                                _templates.entries
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.key,
                                        child: Text(e.value),
                                      ),
                                    )
                                    .toList(),
                            onChanged:
                                (v) => setState(() => _selectedTemplate = v!),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _YamoInput(
                    label: 'Subject',
                    hint: 'Enter email subject',
                    controller: _subjectCtrl,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  _YamoInput(
                    label: 'Message',
                    hint: 'Write your message here...',
                    controller: _bodyCtrl,
                    maxLines: 5,
                    required: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            side: const BorderSide(color: YamoColors.border),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: YamoColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.send_rounded, size: 16),
                          label: const Text('Send Email'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: YamoColors.info,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ),
                    ],
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
// 2. FLAG ACCOUNT DIALOG
// ─────────────────────────────────────────────
class FlagAccountDialog extends StatefulWidget {
  const FlagAccountDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => const FlagAccountDialog(),
  );

  @override
  State<FlagAccountDialog> createState() => _FlagAccountDialogState();
}

class _FlagAccountDialogState extends State<FlagAccountDialog> {
  String? _selectedReason;
  final _noteCtrl = TextEditingController();

  final _reasons = [
    'Suspicious Activity',
    'Fraudulent Transactions',
    'Policy Violation',
    'Identity Concern',
    'Multiple Complaints',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return YamoDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogHeader(
            icon: Icons.flag_rounded,
            iconColor: YamoColors.warning,
            iconBg: YamoColors.warningLight,
            title: 'Flag Account',
            subtitle: 'Mark account for review',
            onClose: () => Navigator.pop(context),
            borderColor: YamoColors.warningBorder,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _UserChip(),
                const SizedBox(height: 16),
                // Warning notice
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: YamoColors.warningLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: YamoColors.warningBorder),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                        color: YamoColors.warning,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Flagging marks the account for internal review. The user will not be notified and can continue using the platform.',
                          style: TextStyle(
                            fontSize: 13,
                            color: YamoColors.warning,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Flag Reason',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: YamoColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                ..._reasons.map(
                  (r) => _ReasonTile(
                    label: r,
                    selected: _selectedReason == r,
                    color: YamoColors.warning,
                    onTap: () => setState(() => _selectedReason = r),
                  ),
                ),
                const SizedBox(height: 16),
                _YamoInput(
                  label: 'Additional Notes',
                  hint: 'Add any additional context...',
                  controller: _noteCtrl,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          side: const BorderSide(color: YamoColors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: YamoColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed:
                            _selectedReason != null
                                ? () => Navigator.pop(context)
                                : null,
                        icon: const Icon(Icons.flag_rounded, size: 16),
                        label: const Text('Flag Account'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: YamoColors.warning,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: YamoColors.border,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. SUSPEND ACCOUNT DIALOG
// ─────────────────────────────────────────────
class SuspendAccountDialog extends StatefulWidget {
  const SuspendAccountDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => const SuspendAccountDialog(),
  );

  @override
  State<SuspendAccountDialog> createState() => _SuspendAccountDialogState();
}

class _SuspendAccountDialogState extends State<SuspendAccountDialog> {
  String? _selectedReason;
  String _duration = '7days';
  bool _notifyUser = true;
  final _noteCtrl = TextEditingController();

  final _reasons = [
    'Policy Violation',
    'Fraudulent Activity',
    'User Request',
    'Multiple Disputes',
    'Chargebacks',
    'Other',
  ];

  final _durations = {
    '1day': '1 Day',
    '7days': '7 Days',
    '30days': '30 Days',
    'permanent': 'Permanent',
  };

  @override
  Widget build(BuildContext context) {
    return YamoDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogHeader(
            icon: Icons.pause_circle_outline_rounded,
            iconColor: YamoColors.danger,
            iconBg: YamoColors.dangerLight,
            title: 'Suspend Account',
            subtitle: 'Temporarily restrict account access',
            onClose: () => Navigator.pop(context),
            borderColor: YamoColors.dangerBorder,
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _UserChip(),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: YamoColors.dangerLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: YamoColors.dangerBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 18,
                          color: YamoColors.danger,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Suspending will immediately block access. Active orders and wallet funds will be frozen during suspension.',
                            style: TextStyle(
                              fontSize: 13,
                              color: YamoColors.danger,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Suspension Reason',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: YamoColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._reasons.map(
                    (r) => _ReasonTile(
                      label: r,
                      selected: _selectedReason == r,
                      color: YamoColors.danger,
                      onTap: () => setState(() => _selectedReason = r),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Duration picker
                  const Text(
                    'Suspension Duration',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: YamoColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children:
                        _durations.entries.map((e) {
                          final selected = _duration == e.key;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _duration = e.key),
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: e.key != 'permanent' ? 8 : 0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      selected
                                          ? YamoColors.danger
                                          : YamoColors.background,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        selected
                                            ? YamoColors.danger
                                            : YamoColors.border,
                                  ),
                                ),
                                child: Text(
                                  e.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        selected
                                            ? Colors.white
                                            : YamoColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 16),
                  _YamoInput(
                    label: 'Reason / Notes',
                    hint: 'Describe the reason for suspension...',
                    controller: _noteCtrl,
                    maxLines: 3,
                    required: true,
                  ),
                  const SizedBox(height: 14),
                  // Notify toggle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: YamoColors.background,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: YamoColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          size: 18,
                          color: YamoColors.textSecondary,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Notify user via email',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: YamoColors.textPrimary,
                            ),
                          ),
                        ),
                        Switch(
                          value: _notifyUser,
                          onChanged: (v) => setState(() => _notifyUser = v),
                          activeColor: YamoColors.danger,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            side: const BorderSide(color: YamoColors.border),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: YamoColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              _selectedReason != null
                                  ? () => Navigator.pop(context)
                                  : null,
                          icon: const Icon(
                            Icons.pause_circle_outline_rounded,
                            size: 16,
                          ),
                          label: const Text('Suspend Account'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: YamoColors.danger,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: YamoColors.border,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ),
                    ],
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
// 4. EDIT PROFILE DIALOG
// ─────────────────────────────────────────────
class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => const EditProfileDialog(),
  );

  @override
  Widget build(BuildContext context) {
    return YamoDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogHeader(
            icon: Icons.edit_outlined,
            iconColor: YamoColors.primary,
            iconBg: const Color(0xFFFFF8EC),
            title: 'Edit Profile',
            subtitle: 'Modify user account information',
            onClose: () => Navigator.pop(context),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar section
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: YamoColors.primary.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: YamoColors.primary.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            size: 40,
                            color: YamoColors.primary,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: YamoColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _YamoInput(
                          label: 'First Name',
                          hint: 'John',
                          required: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _YamoInput(
                          label: 'Last Name',
                          hint: 'Anderson',
                          required: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _YamoInput(
                    label: 'Email Address',
                    hint: 'john.anderson@email.com',
                    keyboardType: TextInputType.emailAddress,
                    required: true,
                    suffixIcon: const Icon(
                      Icons.verified_rounded,
                      size: 18,
                      color: YamoColors.success,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _YamoInput(
                    label: 'Phone Number',
                    hint: '+1 (555) 123-4567',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  // Account status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Account Status',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: YamoColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children:
                            ['Active', 'Inactive', 'Pending'].map((s) {
                              final isActive = s == 'Active';
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isActive
                                            ? YamoColors.successLight
                                            : YamoColors.background,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          isActive
                                              ? YamoColors.success
                                              : YamoColors.border,
                                    ),
                                  ),
                                  child: Text(
                                    s,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          isActive
                                              ? YamoColors.success
                                              : YamoColors.textSecondary,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            side: const BorderSide(color: YamoColors.border),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: YamoColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.save_rounded, size: 16),
                          label: const Text('Save Changes'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: YamoColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ),
                    ],
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
// 5. VIEW DOCUMENTS DIALOG
// ─────────────────────────────────────────────
class ViewDocumentsDialog extends StatelessWidget {
  const ViewDocumentsDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => const ViewDocumentsDialog(),
  );

  @override
  Widget build(BuildContext context) {
    final docs = [
      {
        'name': 'Identity Document',
        'type': 'Passport',
        'date': 'Mar 12, 2024',
        'status': 'Verified',
        'icon': Icons.badge_outlined,
      },
      {
        'name': 'Address Proof',
        'type': 'Utility Bill',
        'date': 'Mar 12, 2024',
        'status': 'Verified',
        'icon': Icons.home_outlined,
      },
      {
        'name': 'Selfie Verification',
        'type': 'Live Photo',
        'date': 'Mar 12, 2024',
        'status': 'Verified',
        'icon': Icons.face_outlined,
      },
      {
        'name': 'Bank Account',
        'type': 'Bank Statement',
        'date': 'Mar 12, 2024',
        'status': 'Verified',
        'icon': Icons.account_balance_outlined,
      },
    ];

    return YamoDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogHeader(
            icon: Icons.folder_outlined,
            iconColor: YamoColors.primary,
            iconBg: const Color(0xFFFFF8EC),
            title: 'KYC Documents',
            subtitle: 'Verified on March 12, 2024 by Admin Team',
            onClose: () => Navigator.pop(context),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Verified badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: YamoColors.successLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF9AE6B4)),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.verified_rounded,
                          size: 18,
                          color: YamoColors.success,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'All KYC documents verified',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: YamoColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...docs.map((doc) => _DocumentTile(doc: doc)),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, size: 16),
                      label: const Text('Close'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        side: const BorderSide(color: YamoColors.border),
                        foregroundColor: YamoColors.textSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
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

class _DocumentTile extends StatelessWidget {
  final Map<String, dynamic> doc;
  const _DocumentTile({required this.doc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: YamoColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: YamoColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: YamoColors.successLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              doc['icon'] as IconData,
              size: 20,
              color: YamoColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc['name'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: YamoColors.textPrimary,
                  ),
                ),
                Text(
                  '${doc['type']} · ${doc['date']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: YamoColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: YamoColors.successLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 12,
                      color: YamoColors.success,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Verified',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: YamoColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.visibility_outlined,
                size: 18,
                color: YamoColors.textMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 6. BLOCK USER DIALOG
// ─────────────────────────────────────────────
class BlockUserDialog extends StatefulWidget {
  const BlockUserDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => const BlockUserDialog(),
  );

  @override
  State<BlockUserDialog> createState() => _BlockUserDialogState();
}

class _BlockUserDialogState extends State<BlockUserDialog> {
  String? _selectedReason;
  bool _confirmChecked = false;

  final _reasons = [
    'Severe Policy Violation',
    'Fraudulent Activity',
    'Chargeback Abuse',
    'Harassment / Threats',
    'Illegal Activity',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final canBlock = _selectedReason != null && _confirmChecked;

    return YamoDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogHeader(
            icon: Icons.block_rounded,
            iconColor: YamoColors.danger,
            iconBg: YamoColors.dangerLight,
            title: 'Block User',
            subtitle: 'Permanently block account access',
            onClose: () => Navigator.pop(context),
            borderColor: YamoColors.dangerBorder,
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _UserChip(),
                  const SizedBox(height: 16),
                  // Critical warning
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5F5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: YamoColors.dangerBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.dangerous_rounded,
                              size: 18,
                              color: YamoColors.danger,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'This action is permanent',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: YamoColors.danger,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...[
                          'Account access will be permanently revoked',
                          'All active orders will be immediately cancelled',
                          'Wallet balance will be frozen pending review',
                          'User will receive a permanent block notification',
                        ].map(
                          (t) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '• ',
                                  style: TextStyle(
                                    color: YamoColors.danger,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    t,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: YamoColors.danger,
                                      height: 1.4,
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
                  const SizedBox(height: 20),
                  const Text(
                    'Reason for Block',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: YamoColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._reasons.map(
                    (r) => _ReasonTile(
                      label: r,
                      selected: _selectedReason == r,
                      color: YamoColors.danger,
                      onTap: () => setState(() => _selectedReason = r),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Confirm checkbox
                  GestureDetector(
                    onTap:
                        () =>
                            setState(() => _confirmChecked = !_confirmChecked),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color:
                            _confirmChecked
                                ? YamoColors.dangerLight
                                : YamoColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              _confirmChecked
                                  ? YamoColors.dangerBorder
                                  : YamoColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color:
                                  _confirmChecked
                                      ? YamoColors.danger
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color:
                                    _confirmChecked
                                        ? YamoColors.danger
                                        : YamoColors.border,
                                width: 1.5,
                              ),
                            ),
                            child:
                                _confirmChecked
                                    ? const Icon(
                                      Icons.check_rounded,
                                      size: 13,
                                      color: Colors.white,
                                    )
                                    : null,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'I understand this action is irreversible and confirm blocking this account.',
                              style: TextStyle(
                                fontSize: 13,
                                color: YamoColors.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            side: const BorderSide(color: YamoColors.border),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: YamoColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              canBlock ? () => Navigator.pop(context) : null,
                          icon: const Icon(Icons.block_rounded, size: 16),
                          label: const Text('Block User'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: YamoColors.danger,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: YamoColors.border,
                            disabledForegroundColor: YamoColors.textMuted,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                        ),
                      ),
                    ],
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
// SHARED: REASON TILE
// ─────────────────────────────────────────────
class _ReasonTile extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _ReasonTile({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.06) : YamoColors.background,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected ? color.withOpacity(0.4) : YamoColors.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? color : Colors.white,
                border: Border.all(
                  color: selected ? color : YamoColors.border,
                  width: 1.5,
                ),
              ),
              child:
                  selected
                      ? const Icon(
                        Icons.check_rounded,
                        size: 11,
                        color: Colors.white,
                      )
                      : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? color : YamoColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DEMO APP
// ─────────────────────────────────────────────
void main() => runApp(const YamoDialogDemoApp());

class YamoDialogDemoApp extends StatelessWidget {
  const YamoDialogDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yamo Admin Dialogs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.fromSeed(seedColor: YamoColors.primary),
        useMaterial3: true,
      ),
      home: const _DemoScreen(),
    );
  }
}

class _DemoScreen extends StatelessWidget {
  const _DemoScreen();

  @override
  Widget build(BuildContext context) {
    final actions = [
      (
        'Send Email',
        Icons.mail_outline_rounded,
        YamoColors.info,
        YamoColors.infoLight,
        () => SendEmailDialog.show(context),
      ),
      (
        'Flag Account',
        Icons.flag_rounded,
        YamoColors.warning,
        YamoColors.warningLight,
        () => FlagAccountDialog.show(context),
      ),
      (
        'Suspend Account',
        Icons.pause_circle_outline_rounded,
        YamoColors.danger,
        YamoColors.dangerLight,
        () => SuspendAccountDialog.show(context),
      ),
      (
        'Edit Profile',
        Icons.edit_outlined,
        YamoColors.primary,
        const Color(0xFFFFF8EC),
        () => EditProfileDialog.show(context),
      ),
      (
        'View Documents',
        Icons.folder_outlined,
        YamoColors.primary,
        const Color(0xFFFFF8EC),
        () => ViewDocumentsDialog.show(context),
      ),
      (
        'Block User',
        Icons.block_rounded,
        YamoColors.danger,
        YamoColors.dangerLight,
        () => BlockUserDialog.show(context),
      ),
    ];

    return Scaffold(
      backgroundColor: YamoColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: YamoColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.diamond_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        title: const Text(
          'Yamo Admin',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: YamoColors.textPrimary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: YamoColors.border, height: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dialog Components',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: YamoColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap any button to preview the dialog',
              style: TextStyle(fontSize: 14, color: YamoColors.textSecondary),
            ),
            const SizedBox(height: 20),
            ...actions.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: a.$5,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: YamoColors.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: a.$4,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(a.$2, color: a.$3, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            a.$1,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: YamoColors.textPrimary,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: YamoColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
