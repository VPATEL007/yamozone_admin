import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Theme Constants (reuse from your existing AppColors) ─────────────────────

class AppColors {
  static const primary = Color(0xFF1B5E20);
  static const accent = Color(0xFFD4A017);
  static const background = Color(0xFFFAFAF7);
  static const fieldFill = Color(0xFFF5F2E4); // warm beige input bg
  static const border = Color(0xFFE8E8E0);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B6B6B);
  static const textHint = Color(0xFFAAAAAA);
}

// ─────────────────────────────────────────────────────────────────────────────
// DIALOG 1 & 2 : Partial Refund
// (Images 1 and 2 are identical — same widget)
// ─────────────────────────────────────────────────────────────────────────────

class PartialRefundDialog extends StatefulWidget {
  final double escrowAmount;
  final VoidCallback? onCancel;
  final void Function(double amount, String reason)? onProcess;

  const PartialRefundDialog({
    super.key,
    this.escrowAmount = 2450,
    this.onCancel,
    this.onProcess,
  });

  @override
  State<PartialRefundDialog> createState() => _PartialRefundDialogState();
}

class _PartialRefundDialogState extends State<PartialRefundDialog> {
  final _amountCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();
  double _refundAmount = 0;

  double get _sellerReceives => (_refundAmount > widget.escrowAmount
              ? widget.escrowAmount
              : _refundAmount) ==
          0
      ? 0
      : widget.escrowAmount - _refundAmount.clamp(0, widget.escrowAmount);

  double get _buyerRefund => _refundAmount.clamp(0, widget.escrowAmount);
  double get _escrowRemaining =>
      (widget.escrowAmount - _refundAmount).clamp(0, widget.escrowAmount);

  @override
  void dispose() {
    _amountCtrl.dispose();
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
            'Partial Refund',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),

          // Escrow amount
          Text(
            'Escrow Amount: \$${widget.escrowAmount.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 20),

          // Refund Amount label
          const Text(
            'Refund Amount',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Amount field
          _InputField(
            controller: _amountCtrl,
            hintText: 'Amount',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (v) =>
                setState(() => _refundAmount = double.tryParse(v) ?? 0),
          ),
          const SizedBox(height: 16),

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

          // Reason field
          _InputField(
            controller: _reasonCtrl,
            hintText: 'Write reason here...',
            maxLines: 4,
          ),
          const SizedBox(height: 20),

          // Impact Preview
          const Text(
            'Impact Preview:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          _ImpactRow(label: 'Seller Receives:', value: _sellerReceives),
          const SizedBox(height: 10),
          _ImpactRow(label: 'Buyer Refund:', value: _buyerRefund),
          const SizedBox(height: 10),
          _ImpactRow(label: 'Escrow Remaining:', value: _escrowRemaining),
          const SizedBox(height: 28),

          // Buttons
          _DialogActions(
            confirmLabel: 'Process Refund',
            onCancel: widget.onCancel ?? () => Navigator.of(context).pop(),
            onConfirm: () => widget.onProcess?.call(
              _refundAmount,
              _reasonCtrl.text,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DIALOG 3 : Full Refund Confirmation
// ─────────────────────────────────────────────────────────────────────────────

class FullRefundConfirmationDialog extends StatefulWidget {
  final double escrowAmount;
  final VoidCallback? onCancel;
  final void Function(String reason)? onConfirm;

  const FullRefundConfirmationDialog({
    super.key,
    this.escrowAmount = 2450,
    this.onCancel,
    this.onConfirm,
  });

  @override
  State<FullRefundConfirmationDialog> createState() =>
      _FullRefundConfirmationDialogState();
}

class _FullRefundConfirmationDialogState
    extends State<FullRefundConfirmationDialog> {
  final _reasonCtrl = TextEditingController();

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
            'Full Refund Confirmation',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),

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

          // Reason field
          _InputField(
            controller: _reasonCtrl,
            hintText: 'Write reason here...',
            maxLines: 4,
          ),
          const SizedBox(height: 18),

          // Warning text
          const Text(
            'This will cancel escrow & payout',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 28),

          // Buttons
          _DialogActions(
            confirmLabel: 'Confirm Refund',
            onCancel: widget.onCancel ?? () => Navigator.of(context).pop(),
            onConfirm: () => widget.onConfirm?.call(_reasonCtrl.text),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DIALOG 4 : Extend Escrow Hold
// ─────────────────────────────────────────────────────────────────────────────

enum _HoldOption { threeDays, fiveDays, custom }

class ExtendEscrowHoldDialog extends StatefulWidget {
  final int currentHoldDays;
  final VoidCallback? onCancel;
  final void Function(int days, String reason)? onExtend;

  const ExtendEscrowHoldDialog({
    super.key,
    this.currentHoldDays = 7,
    this.onCancel,
    this.onExtend,
  });

  @override
  State<ExtendEscrowHoldDialog> createState() => _ExtendEscrowHoldDialogState();
}

class _ExtendEscrowHoldDialogState extends State<ExtendEscrowHoldDialog> {
  _HoldOption? _selected;
  final _customCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();

  int get _selectedDays {
    switch (_selected) {
      case _HoldOption.threeDays:
        return 3;
      case _HoldOption.fiveDays:
        return 5;
      case _HoldOption.custom:
        return int.tryParse(_customCtrl.text) ?? 0;
      default:
        return 0;
    }
  }

  @override
  void dispose() {
    _customCtrl.dispose();
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
            'Extend Escrow Hold',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),

          // Current hold
          Text(
            'Current Hold: ${widget.currentHoldDays} Days',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 20),

          // Options
          _CheckboxOption(
            label: '3 Days',
            checked: _selected == _HoldOption.threeDays,
            onTap: () => setState(() => _selected = _HoldOption.threeDays),
          ),
          const SizedBox(height: 12),
          _CheckboxOption(
            label: '5 Days',
            checked: _selected == _HoldOption.fiveDays,
            onTap: () => setState(() => _selected = _HoldOption.fiveDays),
          ),
          const SizedBox(height: 12),

          // Custom row
          Row(
            children: [
              _CheckboxTile(
                checked: _selected == _HoldOption.custom,
                onTap: () => setState(() => _selected = _HoldOption.custom),
              ),
              const SizedBox(width: 10),
              const Text(
                'Custom',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 12),
              // Custom days input
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _customCtrl,
                  enabled: _selected == _HoldOption.custom,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: '',
                    filled: true,
                    fillColor: _selected == _HoldOption.custom
                        ? AppColors.fieldFill
                        : AppColors.fieldFill.withOpacity(0.5),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: AppColors.primary, width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Days',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

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

          // Reason field
          _InputField(
            controller: _reasonCtrl,
            hintText: 'Write reason here...',
            maxLines: 4,
          ),
          const SizedBox(height: 28),

          // Buttons
          _DialogActions(
            confirmLabel: 'Extend Hold',
            onCancel: widget.onCancel ?? () => Navigator.of(context).pop(),
            onConfirm: () =>
                widget.onExtend?.call(_selectedDays, _reasonCtrl.text),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared / reusable sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

/// White rounded card that wraps every dialog
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

/// Warm-beige text field
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const _InputField({
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.textHint,
        ),
        filled: true,
        fillColor: AppColors.fieldFill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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

/// Impact preview row (label + value box)
class _ImpactRow extends StatelessWidget {
  final String label;
  final double value;
  const _ImpactRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Container(
          width: 160,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.fieldFill,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value == 0 ? '\$' : '\$ ${value.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

/// Cancel + Confirm button row
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
        // Cancel
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

        // Confirm
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

/// Square checkbox tile (outline style like screenshot)
class _CheckboxTile extends StatelessWidget {
  final bool checked;
  final VoidCallback onTap;
  const _CheckboxTile({required this.checked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          border: Border.all(
            color: checked ? AppColors.primary : AppColors.textSecondary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
          color: checked ? AppColors.primary : Colors.transparent,
        ),
        child: checked
            ? const Icon(Icons.check, size: 14, color: Colors.white)
            : null,
      ),
    );
  }
}

/// Full checkbox row (tile + label)
class _CheckboxOption extends StatelessWidget {
  final String label;
  final bool checked;
  final VoidCallback onTap;
  const _CheckboxOption(
      {required this.label, required this.checked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          _CheckboxTile(checked: checked, onTap: onTap),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HOW TO SHOW EACH DIALOG
// ─────────────────────────────────────────────────────────────────────────────
//
// 1) Partial Refund:
//
//    showDialog(
//      context: context,
//      builder: (_) => PartialRefundDialog(
//        escrowAmount: 2450,
//        onCancel: () => Navigator.pop(context),
//        onProcess: (amount, reason) {
//          print('Refund \$amount | reason: \$reason');
//          Navigator.pop(context);
//        },
//      ),
//    );
//
// 2) Full Refund Confirmation:
//
//    showDialog(
//      context: context,
//      builder: (_) => FullRefundConfirmationDialog(
//        escrowAmount: 2450,
//        onCancel: () => Navigator.pop(context),
//        onConfirm: (reason) {
//          print('Full refund confirmed | reason: \$reason');
//          Navigator.pop(context);
//        },
//      ),
//    );
//
// 3) Extend Escrow Hold:
//
//    showDialog(
//      context: context,
//      builder: (_) => ExtendEscrowHoldDialog(
//        currentHoldDays: 7,
//        onCancel: () => Navigator.pop(context),
//        onExtend: (days, reason) {
//          print('Extend \$days days | reason: \$reason');
//          Navigator.pop(context);
//        },
//      ),
//    );
