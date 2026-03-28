import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// COLORS
// ─────────────────────────────────────────────
const kPrimary = Color(0xFF1B5E20);
const kAccentGold = Color(0xFFD4A017);
const kGoldBg = Color(0xFFFFF8DC);
const kFieldBg = Color(0xFFF7F4E8);
const kBorder = Color(0xFFE0E0E0);
const kTextDark = Color(0xFF1A1A1A);
const kTextMed = Color(0xFF555555);
const kTextLight = Color(0xFF999999);
const kRed = Color(0xFFD32F2F);
const kGreenCheck = Color(0xFF2E7D32);

class _TestScreen extends StatelessWidget {
  const _TestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('KYC Dialogs')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showRejectKycDialog(context),
              child: const Text('1. Reject KYC Dialog'),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => showRequestMoreInfoDialog(context),
              child: const Text('2. Request More Info Dialog'),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => showKycHistoryDialog(context),
              child: const Text('3. KYC History Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DIALOG 1 — REJECT KYC
// ═══════════════════════════════════════════════════════════════
Future<void> showRejectKycDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => const RejectKycDialog(),
  );
}

class RejectKycDialog extends StatefulWidget {
  const RejectKycDialog({super.key});
  @override
  State<RejectKycDialog> createState() => _RejectKycDialogState();
}

class _RejectKycDialogState extends State<RejectKycDialog> {
  String _selectedCategory = 'Invalid Document';
  final _reasonController = TextEditingController();

  final List<String> _categories = [
    'Invalid Document',
    'Blurry Image',
    'Expired Document',
    'Mismatch Information',
    'Incomplete Submission',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 520,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Body ──
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Reject KYC',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kTextDark,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Reason Category
                    const Text(
                      'Reason Category',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kTextDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _KycDropdown(
                      value: _selectedCategory,
                      items: _categories,
                      onChanged: (v) => setState(() => _selectedCategory = v!),
                    ),
                    const SizedBox(height: 24),

                    // Reason for rejection
                    const Text(
                      'Reason for rejection',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kTextDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: kFieldBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kBorder),
                      ),
                      child: TextField(
                        controller: _reasonController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'Write reason here...',
                          hintStyle: TextStyle(color: kTextLight, fontSize: 14),
                          contentPadding: EdgeInsets.all(14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Footer ──
              _DialogFooterRow(
                onCancel: () => Navigator.pop(context),
                confirmLabel: 'Submit Reject',
                onConfirm: () => Navigator.pop(context),
                confirmColor: kPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DIALOG 2 — REQUEST MORE INFORMATION
// ═══════════════════════════════════════════════════════════════
Future<void> showRequestMoreInfoDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => const RequestMoreInfoDialog(),
  );
}

class RequestMoreInfoDialog extends StatefulWidget {
  const RequestMoreInfoDialog({super.key});
  @override
  State<RequestMoreInfoDialog> createState() => _RequestMoreInfoDialogState();
}

class _RequestMoreInfoDialogState extends State<RequestMoreInfoDialog> {
  final _messageController = TextEditingController();
  DateTime? _deadline;
  final Map<String, bool> _docs = {
    'New ID': false,
    'Address Proof': false,
    'Business License': false,
  };
  final Map<String, _DocMeta> _docMeta = {
    'New ID': _DocMeta(
        Icons.badge_outlined, 'Government-issued identification document'),
    'Address Proof': _DocMeta(Icons.home_outlined,
        'Utility bill or bank statement (within 3 months)'),
    'Business License':
        _DocMeta(Icons.work_outline, 'Valid business registration certificate'),
  };

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 540,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Scrollable body ──
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'Request More Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kTextDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Request additional documents from the user',
                        style: TextStyle(fontSize: 13, color: kTextMed),
                      ),
                      const SizedBox(height: 24),

                      // Message to User
                      Row(
                        children: const [
                          Text(
                            'Message to User',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: kTextDark),
                          ),
                          SizedBox(width: 4),
                          Text('*',
                              style: TextStyle(color: kRed, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: kBorder),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6)
                          ],
                        ),
                        child: TextField(
                          controller: _messageController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText:
                                'Please provide a detailed message explaining why these documents are required...',
                            hintStyle:
                                TextStyle(color: kTextLight, fontSize: 13),
                            contentPadding: EdgeInsets.all(14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _InfoHint(
                          label: 'Provide clear instructions for the user'),
                      const SizedBox(height: 22),

                      // Required Documents
                      Row(
                        children: const [
                          Text(
                            'Required Documents',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: kTextDark),
                          ),
                          SizedBox(width: 4),
                          Text('*',
                              style: TextStyle(color: kRed, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ..._docs.keys.map((key) => _DocCheckTile(
                            icon: _docMeta[key]!.icon,
                            title: key,
                            subtitle: _docMeta[key]!.subtitle,
                            checked: _docs[key]!,
                            onChanged: (v) =>
                                setState(() => _docs[key] = v ?? false),
                          )),
                      const SizedBox(height: 22),

                      // Submission Deadline
                      Row(
                        children: const [
                          Text(
                            'Submission Deadline',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: kTextDark),
                          ),
                          SizedBox(width: 4),
                          Text('*',
                              style: TextStyle(color: kRed, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _pickDate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: kBorder),
                          ),
                          child: Row(
                            children: [
                              Text(
                                _deadline == null
                                    ? 'mm/dd/yyyy'
                                    : '${_deadline!.month.toString().padLeft(2, '0')}/${_deadline!.day.toString().padLeft(2, '0')}/${_deadline!.year}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _deadline == null
                                      ? kTextLight
                                      : kTextDark,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.calendar_month_rounded,
                                  color: kAccentGold, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _InfoHint(label: 'User will be notified of the deadline'),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // ── Footer ──
              _DialogFooterRow(
                onCancel: () => Navigator.pop(context),
                confirmLabel: 'Send Request',
                confirmIcon: Icons.send_rounded,
                onConfirm: () => Navigator.pop(context),
                confirmColor: kPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocMeta {
  final IconData icon;
  final String subtitle;
  const _DocMeta(this.icon, this.subtitle);
}

class _DocCheckTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool checked;
  final ValueChanged<bool?> onChanged;
  const _DocCheckTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.checked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: checked ? const Color(0xFFF0F7F0) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: checked ? kPrimary.withOpacity(0.4) : kBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: onChanged,
            activeColor: kPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kGoldBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: kAccentGold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: kTextDark)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: kTextMed)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DIALOG 3 — KYC HISTORY & RESUBMISSION DETAILS
// ═══════════════════════════════════════════════════════════════
Future<void> showKycHistoryDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => const KycHistoryDialog(),
  );
}

class KycHistoryDialog extends StatelessWidget {
  const KycHistoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 520,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Scrollable body ──
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'KYC History & Resubmission Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kTextDark,
                        ),
                      ),
                      const SizedBox(height: 22),

                      // User Info
                      const Text(
                        'User: Michael Anderson',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kTextDark),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'User ID: USR-204-00847',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kTextDark),
                      ),
                      const SizedBox(height: 26),

                      // Decision History
                      const Text(
                        'Decision History',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kTextDark),
                      ),
                      const SizedBox(height: 14),
                      _HistoryEntry(
                        date: 'Jan 10, 2024',
                        items: const [
                          _HistoryLine('Status:', 'Rejected',
                              isStatus: true, statusRed: true),
                          _HistoryLine('Reason:', 'Blurry document'),
                          _HistoryLine('By:', 'Admin John'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _HistoryEntry(
                        date: 'Jan 12, 2024',
                        items: const [
                          _HistoryLine('Status:', 'More Info Requested',
                              isStatus: true),
                          _HistoryLine('Docs:', 'ID Proof + Selfie'),
                        ],
                      ),
                      const SizedBox(height: 26),

                      // Latest Resubmission
                      const Text(
                        'Latest Resubmission',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kTextDark),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Submitted On: Jan 14, 2024',
                        style: TextStyle(fontSize: 14, color: kTextMed),
                      ),
                      const SizedBox(height: 22),

                      // Documents Uploaded
                      const Text(
                        'Documents Uploaded:',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: kTextDark),
                      ),
                      const SizedBox(height: 10),
                      ...[
                        'ID Front',
                        'ID Back',
                        'Selfie',
                      ].map(
                        (doc) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.check,
                                  size: 16, color: kGreenCheck),
                              const SizedBox(width: 8),
                              Text(doc,
                                  style: const TextStyle(
                                      fontSize: 14, color: kTextDark)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // ── Footer (Close only) ──
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: kBorder)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kTextDark,
                        side: const BorderSide(color: kBorder),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Close',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryEntry extends StatelessWidget {
  final String date;
  final List<_HistoryLine> items;
  const _HistoryEntry({required this.date, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bullet
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: kTextDark,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kTextDark)),
            const SizedBox(height: 4),
            ...items.map((line) => _HistoryLineWidget(line: line)),
          ],
        ),
      ],
    );
  }
}

class _HistoryLine {
  final String label;
  final String value;
  final bool isStatus;
  final bool statusRed;
  const _HistoryLine(this.label, this.value,
      {this.isStatus = false, this.statusRed = false});
}

class _HistoryLineWidget extends StatelessWidget {
  final _HistoryLine line;
  const _HistoryLineWidget({required this.line});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: kTextMed),
          children: [
            TextSpan(text: '${line.label} '),
            TextSpan(
              text: line.value,
              style: TextStyle(
                color: line.isStatus
                    ? (line.statusRed ? kRed : kAccentGold)
                    : kTextDark,
                fontWeight: line.isStatus ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SHARED WIDGETS
// ─────────────────────────────────────────────

/// Dropdown styled to match screenshots
class _KycDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _KycDropdown(
      {required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: kFieldBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: kTextDark),
          style: const TextStyle(
              fontSize: 15, color: kTextDark, fontFamily: 'Roboto'),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/// Gold info hint row
class _InfoHint extends StatelessWidget {
  final String label;
  const _InfoHint({required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.info_outline_rounded, size: 14, color: kAccentGold),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: kTextMed)),
      ],
    );
  }
}

/// Shared footer row: Cancel + Confirm button
class _DialogFooterRow extends StatelessWidget {
  final VoidCallback onCancel;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final Color confirmColor;
  final IconData? confirmIcon;

  const _DialogFooterRow({
    required this.onCancel,
    required this.confirmLabel,
    required this.onConfirm,
    required this.confirmColor,
    this.confirmIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: kBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Cancel
          TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(
              foregroundColor: kTextDark,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
            child: const Text('Cancel',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 10),
          // Confirm
          ElevatedButton.icon(
            onPressed: onConfirm,
            icon: confirmIcon != null
                ? Icon(confirmIcon, size: 15)
                : const SizedBox.shrink(),
            label: Text(confirmLabel,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
