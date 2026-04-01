import 'package:flutter/material.dart';

// ─── Theme Constants ──────────────────────────────────────────────────────────

class AppColors {
  static const primary = Color(0xFF1B5E20);
  static const accent = Color(0xFFD4A017);
  static const fieldFill = Color(0xFFF5F2E4);
  static const border = Color(0xFFE8E8E0);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B6B6B);
  static const textHint = Color(0xFFAAAAAA);
}

// ─────────────────────────────────────────────────────────────────────────────
// DIALOG 1 : Manual Escrow Release
// ─────────────────────────────────────────────────────────────────────────────

class ManualEscrowReleaseDialog extends StatefulWidget {
  final double escrowAmount;
  final VoidCallback? onCancel;
  final void Function(String reason, bool notifySeller, bool notifyBuyer)?
      onConfirm;

  const ManualEscrowReleaseDialog({
    super.key,
    this.escrowAmount = 2450,
    this.onCancel,
    this.onConfirm,
  });

  @override
  State<ManualEscrowReleaseDialog> createState() =>
      _ManualEscrowReleaseDialogState();
}

class _ManualEscrowReleaseDialogState extends State<ManualEscrowReleaseDialog> {
  final _reasonCtrl = TextEditingController();
  bool _notifySeller = false;
  bool _notifyBuyer = false;

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Manual Escrow Release',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Escrow amount
          Text(
            'Escrow Amount: \$${widget.escrowAmount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 22),

          // Reason label
          const Text(
            'Reason',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Reason text area
          _InputField(
            controller: _reasonCtrl,
            hintText: 'Write reason here...',
            maxLines: 4,
          ),
          const SizedBox(height: 20),

          // Notify checkboxes — horizontal row
          Row(
            children: [
              _CheckboxRow(
                label: 'Notify Seller',
                value: _notifySeller,
                onChanged: (v) => setState(() => _notifySeller = v),
              ),
              const SizedBox(width: 28),
              _CheckboxRow(
                label: 'Notify Buyer',
                value: _notifyBuyer,
                onChanged: (v) => setState(() => _notifyBuyer = v),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Buttons
          _DialogActions(
            confirmLabel: 'Confirm Release',
            onCancel: widget.onCancel ?? () => Navigator.of(context).pop(),
            onConfirm: () => widget.onConfirm?.call(
              _reasonCtrl.text,
              _notifySeller,
              _notifyBuyer,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DIALOG 2 : Reject Listing
// ─────────────────────────────────────────────────────────────────────────────

class RejectListingDialog extends StatefulWidget {
  final VoidCallback? onCancel;
  final void Function(
    String category,
    String subReason,
    String reason,
    bool sendEmail,
  )? onSubmit;

  const RejectListingDialog({
    super.key,
    this.onCancel,
    this.onSubmit,
  });

  @override
  State<RejectListingDialog> createState() => _RejectListingDialogState();
}

class _RejectListingDialogState extends State<RejectListingDialog> {
  final _reasonCtrl = TextEditingController();

  final List<String> _categories = [
    'Policy Violation',
    'Counterfeit',
    'Prohibited Item',
    'Scam',
    'Misleading',
  ];

  final Map<String, List<String>> _subReasons = {
    'Policy Violation': ['Fake brand', 'Duplicate listing', 'Wrong category'],
    'Counterfeit': ['Brand impersonation', 'Replica product'],
    'Prohibited Item': ['Illegal item', 'Restricted item'],
    'Scam': ['Phishing', 'Fraud attempt'],
    'Misleading': ['Wrong description', 'False images'],
  };

  String _selectedCategory = 'Policy Violation';
  String _selectedSubReason = 'Fake brand';
  bool _sendEmail = false;

  List<String> get _currentSubReasons => _subReasons[_selectedCategory] ?? [];

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Reject Listing',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 22),

          // Reason Category label
          const Text(
            'Reason Category',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Category dropdown
          _DropdownField<String>(
            value: _selectedCategory,
            items: _categories,
            onChanged: (v) => setState(() {
              _selectedCategory = v!;
              _selectedSubReason = _subReasons[v]?.first ?? '';
            }),
          ),
          const SizedBox(height: 18),

          // Sub Reason label
          const Text(
            'Sub Reason',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Sub Reason dropdown
          _DropdownField<String>(
            value: _selectedSubReason,
            items: _currentSubReasons,
            onChanged: (v) => setState(() => _selectedSubReason = v!),
          ),
          const SizedBox(height: 18),

          // Reason for rejection label
          const Text(
            'Reason for rejection',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          _InputField(
            controller: _reasonCtrl,
            hintText: 'Write reason here...',
            maxLines: 4,
          ),
          const SizedBox(height: 20),

          // Notify Seller section
          const Text(
            'Notify Seller',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),

          _CheckboxRow(
            label: 'Send email notification',
            value: _sendEmail,
            onChanged: (v) => setState(() => _sendEmail = v),
            bold: true,
          ),
          const SizedBox(height: 28),

          // Buttons
          _DialogActions(
            confirmLabel: 'Submit Reject',
            onCancel: widget.onCancel ?? () => Navigator.of(context).pop(),
            onConfirm: () => widget.onSubmit?.call(
              _selectedCategory,
              _selectedSubReason,
              _reasonCtrl.text,
              _sendEmail,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DIALOG 3 : Policy Violation
// ─────────────────────────────────────────────────────────────────────────────

enum _Severity { high, medium, low }

class PolicyViolationDialog extends StatefulWidget {
  final VoidCallback? onWarnSeller;
  final void Function(
    List<String> violations,
    String severity,
    String reason,
  )? onRemoveListing;

  const PolicyViolationDialog({
    super.key,
    this.onWarnSeller,
    this.onRemoveListing,
  });

  @override
  State<PolicyViolationDialog> createState() => _PolicyViolationDialogState();
}

class _PolicyViolationDialogState extends State<PolicyViolationDialog> {
  final _reasonCtrl = TextEditingController();

  final List<String> _violationOptions = [
    'Counterfeit',
    'Prohibited',
    'Scam',
    'Misleading',
  ];

  final Set<String> _selectedViolations = {};
  _Severity? _severity;

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Policy Violation',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),

          // Violation checkboxes
          ..._violationOptions.map((option) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _CheckboxRow(
                  label: option,
                  value: _selectedViolations.contains(option),
                  onChanged: (v) => setState(() {
                    if (v) {
                      _selectedViolations.add(option);
                    } else {
                      _selectedViolations.remove(option);
                    }
                  }),
                  bold: true,
                ),
              )),

          const SizedBox(height: 6),

          // Severity label
          const Text(
            'Severity:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // Severity options — horizontal
          Row(
            children: [
              _CheckboxRow(
                label: 'High',
                value: _severity == _Severity.high,
                onChanged: (_) => setState(() => _severity = _Severity.high),
                bold: true,
              ),
              const SizedBox(width: 24),
              _CheckboxRow(
                label: 'Medium',
                value: _severity == _Severity.medium,
                onChanged: (_) => setState(() => _severity = _Severity.medium),
                bold: true,
              ),
              const SizedBox(width: 24),
              _CheckboxRow(
                label: 'Low',
                value: _severity == _Severity.low,
                onChanged: (_) => setState(() => _severity = _Severity.low),
                bold: true,
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Reason text area
          _InputField(
            controller: _reasonCtrl,
            hintText: 'Write reason here...',
            maxLines: 4,
          ),
          const SizedBox(height: 28),

          // Buttons — Warn Seller (text) + Remove Listing (filled)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.onWarnSeller,
                child: const Text(
                  'Warn Seller',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => widget.onRemoveListing?.call(
                  _selectedViolations.toList(),
                  _severity?.name ?? '',
                  _reasonCtrl.text,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Remove Listing',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

/// White rounded dialog shell
class _BaseDialog extends StatelessWidget {
  final Widget child;
  const _BaseDialog({required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
          child: child,
        ),
      ),
    );
  }
}

/// Warm-beige textarea / text field
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const _InputField({
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: AppColors.textHint),
        filled: true,
        fillColor: AppColors.fieldFill,
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

/// Warm-beige dropdown
class _DropdownField<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

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
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textPrimary, size: 22),
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.textPrimary,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(item.toString()),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/// Square outline checkbox + label
class _CheckboxRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool bold;

  const _CheckboxRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Custom square checkbox
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(
                color: value ? AppColors.primary : AppColors.textSecondary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
              color: value ? AppColors.primary : Colors.transparent,
            ),
            child: value
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Cancel + confirm button row
class _DialogActions extends StatelessWidget {
  final String confirmLabel;
  final VoidCallback onCancel;
  final VoidCallback? onConfirm;

  const _DialogActions({
    required this.confirmLabel,
    required this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: Text(
            confirmLabel,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HOW TO SHOW EACH DIALOG
// ─────────────────────────────────────────────────────────────────────────────
//
// 1) Manual Escrow Release:
//    showDialog(
//      context: context,
//      builder: (_) => ManualEscrowReleaseDialog(
//        escrowAmount: 2450,
//        onCancel: () => Navigator.pop(context),
//        onConfirm: (reason, notifySeller, notifyBuyer) {
//          Navigator.pop(context);
//        },
//      ),
//    );
//
// 2) Reject Listing:
//    showDialog(
//      context: context,
//      builder: (_) => RejectListingDialog(
//        onCancel: () => Navigator.pop(context),
//        onSubmit: (category, subReason, reason, sendEmail) {
//          Navigator.pop(context);
//        },
//      ),
//    );
//
// 3) Policy Violation:
//    showDialog(
//      context: context,
//      builder: (_) => PolicyViolationDialog(
//        onWarnSeller: () => Navigator.pop(context),
//        onRemoveListing: (violations, severity, reason) {
//          Navigator.pop(context);
//        },
//      ),
//    );
