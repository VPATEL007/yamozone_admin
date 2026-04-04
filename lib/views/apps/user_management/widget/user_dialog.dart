import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class BlockUserDialog extends StatefulWidget {
  final String userName;
  final String userId;

  const BlockUserDialog({
    super.key,
    required this.userName,
    required this.userId,
  });

  @override
  State<BlockUserDialog> createState() => _BlockUserDialogState();
}

class _BlockUserDialogState extends State<BlockUserDialog> {
  // Dropdown options
  final List<String> _reasons = [
    'Fraud activity',
    'Suspicious behaviour',
    'Policy violation',
    'Spam',
    'Other',
  ];

  String _selectedReason = 'Fraud activity';

  // ── Colours ──────────────────────────────────
  static const Color _darkGreen = Color(0xFF2D5016);
  static const Color _midGreen = Color(0xFF3D6B20);
  static const Color _lightCream = Color(0xFFFDF8EE);
  static const Color _dropdownBg = Color(0xFF4A7A2A);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Container(
        width: Get.width * 0.40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ─────────────────────────
            _buildHeader(),

            // ── User Info ──────────────────────
            _buildUserInfo(),

            // ── Reason Dropdown ────────────────
            _buildReasonSection(),

            // ── Action Buttons ─────────────────
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
      child: Text(
        'Block User',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: Colors.grey.shade900,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  // ── User Info ──────────────────────────────────
  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 22, 28, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow('User:', widget.userName),
          const SizedBox(height: 10),
          _infoRow('User ID:', widget.userId),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF1A1A1A),
          fontFamily: 'Georgia',
        ),
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  // ── Reason Section ─────────────────────────────
  Widget _buildReasonSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reason',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          _buildDropdown(),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: _dropdownBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: _darkGreen.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedReason,
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          borderRadius: BorderRadius.circular(14),
          dropdownColor: _dropdownBg,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 26,
          ),
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Georgia',
          ),
          items:
              _reasons.map((reason) {
                return DropdownMenuItem<String>(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) setState(() => _selectedReason = value);
          },
        ),
      ),
    );
  }

  // ── Action Buttons ─────────────────────────────
  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
      child: Row(
        children: [
          // Cancel
          Expanded(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Confirm Block
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: implement block logic
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _darkGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                shadowColor: _darkGreen.withOpacity(0.4),
              ),
              child: const Text(
                'Confirm Block',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
