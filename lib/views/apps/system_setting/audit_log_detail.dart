import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:webkit/views/layouts/layout.dart';

// ─────────────────────────────────────────────
// AUDIT LOG DETAIL SCREEN
// Drop this widget as the body of your Scaffold
// (your existing drawer goes in the drawer: slot)
// ─────────────────────────────────────────────

class AuditLogDetailScreen extends StatelessWidget {
  const AuditLogDetailScreen({super.key});

  // ── Brand colours (match the golden/olive palette in the screenshot) ──
  static const Color kPrimary = Color(0xFF8B6914); // deep gold
  static const Color kAccent = Color(0xFFD4A017); // bright gold
  static const Color kBg = Color(0xFFF9F6F0); // warm off-white
  static const Color kCard = Color(0xFFFFFFFF);
  static const Color kBorder = Color(0xFFEDE8DC);
  static const Color kText = Color(0xFF1A1A1A);
  static const Color kSubtext = Color(0xFF6B6B6B);
  static const Color kGreen = Color(0xFF2ECC71);
  static const Color kRed = Color(0xFFE74C3C);
  static const Color kOrange = Color(0xFFF39C12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // ── Scrollable body ─────────────────────────────────────────────
        body: Layout(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Log header card
              _LogHeaderCard(),
              const SizedBox(height: 16),

              // 2. Action / Module / User row
              _ActionRowCard(),
              const SizedBox(height: 16),

              // 3. Performed By  +  Reason  (side by side on wide, stacked on narrow)
              LayoutBuilder(builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _PerformedByCard()),
                      const SizedBox(width: 16),
                      Expanded(child: _ReasonCard()),
                    ],
                  );
                }
                return Column(children: [
                  _PerformedByCard(),
                  const SizedBox(height: 16),
                  _ReasonCard(),
                ]);
              }),
              const SizedBox(height: 16),

              // 4. Before / After comparison
              LayoutBuilder(builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _StateCard(isBefore: true)),
                      const SizedBox(width: 16),
                      Expanded(child: _StateCard(isBefore: false)),
                    ],
                  );
                }
                return Column(children: [
                  _StateCard(isBefore: true),
                  const SizedBox(height: 16),
                  _StateCard(isBefore: false),
                ]);
              }),
              const SizedBox(height: 16),

              // 5. Linked Records  +  Review Timeline
              LayoutBuilder(builder: (_, constraints) {
                if (constraints.maxWidth >= 600) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _LinkedRecordsCard()),
                      const SizedBox(width: 16),
                      Expanded(child: _ReviewTimelineCard()),
                    ],
                  );
                }
                return Column(children: [
                  _LinkedRecordsCard(),
                  const SizedBox(height: 16),
                  _ReviewTimelineCard(),
                ]);
              }),
              const SizedBox(height: 24),

              // 6. Bottom action buttons
              _BottomActions(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ));
  }
}

// ══════════════════════════════════════════════
// SECTION WIDGETS
// ══════════════════════════════════════════════

// ── 1. Log Header ────────────────────────────
class _LogHeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Log ID: AUD-23984',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: AuditLogDetailScreen.kText,
                  ),
                ),
                const SizedBox(height: 10),
                _CriticalBadge(),
              ],
            ),
          ),
          const Text(
            '12 Mar 2024  04:15 PM',
            style: TextStyle(
              color: AuditLogDetailScreen.kSubtext,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _CriticalBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AuditLogDetailScreen.kRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AuditLogDetailScreen.kRed.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.error, color: AuditLogDetailScreen.kRed, size: 14),
          SizedBox(width: 5),
          Text(
            'Critical',
            style: TextStyle(
              color: AuditLogDetailScreen.kRed,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ── 2. Action Row ─────────────────────────────
class _ActionRowCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          // Action
          _ActionChip(
            icon: Icons.block,
            iconColor: Colors.white,
            iconBg: AuditLogDetailScreen.kRed,
            label: 'Action',
            value: 'USER BLOCK',
          ),
          const Spacer(),
          // Module
          _ActionChip(
            icon: Icons.people_outline,
            iconColor: AuditLogDetailScreen.kAccent,
            iconBg: AuditLogDetailScreen.kAccent.withOpacity(0.12),
            label: '',
            value: 'User Management',
          ),
          const Spacer(),
          // User
          _ActionChip(
            icon: Icons.person_outline,
            iconColor: AuditLogDetailScreen.kAccent,
            iconBg: AuditLogDetailScreen.kAccent.withOpacity(0.12),
            label: '',
            value: 'USR-45891',
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor, iconBg;
  final String label, value;
  const _ActionChip({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label.isNotEmpty)
              Text(label,
                  style: const TextStyle(
                      color: AuditLogDetailScreen.kSubtext, fontSize: 11)),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AuditLogDetailScreen.kText)),
          ],
        ),
      ],
    );
  }
}

// ── 3a. Performed By ─────────────────────────
class _PerformedByCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Performed By',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AuditLogDetailScreen.kText)),
          const SizedBox(height: 14),
          Row(
            children: [
              // Avatar circle
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AuditLogDetailScreen.kAccent.withOpacity(0.2),
                ),
                child: const Icon(Icons.person,
                    color: AuditLogDetailScreen.kAccent, size: 28),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('John Admin',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AuditLogDetailScreen.kText)),
                  const Text('Super Admin',
                      style: TextStyle(
                          color: AuditLogDetailScreen.kSubtext, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.computer,
                          size: 12, color: AuditLogDetailScreen.kSubtext),
                      SizedBox(width: 4),
                      Text('192.168.1.24',
                          style: TextStyle(
                              color: AuditLogDetailScreen.kSubtext,
                              fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── 3b. Reason ───────────────────────────────
class _ReasonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reason',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AuditLogDetailScreen.kText)),
          const SizedBox(height: 12),
          // Reason chip
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuditLogDetailScreen.kBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('Repeated fraud complaints',
                style:
                    TextStyle(color: AuditLogDetailScreen.kText, fontSize: 13)),
          ),
          const SizedBox(height: 12),
          // Admin Notes
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AuditLogDetailScreen.kAccent.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: AuditLogDetailScreen.kAccent.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Admin Notes',
                    style: TextStyle(
                        color: AuditLogDetailScreen.kAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text('Blocked for 30 days. Review after investigation.',
                    style: TextStyle(
                        color: AuditLogDetailScreen.kText, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── 4. Before / After State Card ─────────────
class _StateCard extends StatelessWidget {
  final bool isBefore;
  const _StateCard({required this.isBefore});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                isBefore ? Icons.history : Icons.access_time,
                color: AuditLogDetailScreen.kAccent,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                isBefore ? 'BEFORE' : 'AFTER',
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: AuditLogDetailScreen.kText),
              ),
            ],
          ),
          const Divider(height: 20),

          // Rows
          _StateRow(
            label: 'Status',
            value: isBefore ? 'Active' : 'Blocked',
            valueColor: isBefore
                ? AuditLogDetailScreen.kGreen
                : AuditLogDetailScreen.kRed,
            icon: isBefore ? Icons.check_circle_outline : Icons.block,
          ),
          const SizedBox(height: 10),
          _StateRow(
            label: 'Login Access',
            value: isBefore ? 'Enabled' : 'Disabled',
            valueColor: isBefore
                ? AuditLogDetailScreen.kGreen
                : AuditLogDetailScreen.kRed,
            icon: isBefore ? Icons.check_circle_outline : Icons.cancel_outlined,
          ),
          const SizedBox(height: 10),
          _StateRow(
            label: 'KYC Status',
            value: 'Verified',
            valueColor: AuditLogDetailScreen.kOrange,
            icon: Icons.verified_outlined,
          ),
          const SizedBox(height: 10),
          _StateRow(
            label: 'Wallet Balance',
            value: '\$2,450',
            valueColor: AuditLogDetailScreen.kText,
            icon: null,
          ),
        ],
      ),
    );
  }
}

class _StateRow extends StatelessWidget {
  final String label, value;
  final Color valueColor;
  final IconData? icon;
  const _StateRow({
    required this.label,
    required this.value,
    required this.valueColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: AuditLogDetailScreen.kSubtext, fontSize: 13)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: valueColor),
              const SizedBox(width: 4),
            ],
            Text(value,
                style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ],
        ),
      ],
    );
  }
}

// ── 5a. Linked Records ───────────────────────
class _LinkedRecordsCard extends StatelessWidget {
  final _records = const [
    {'icon': Icons.person_outline, 'label': 'User Profile'},
    {'icon': Icons.shopping_cart_outlined, 'label': 'Order – ORD-8891'},
    {'icon': Icons.warning_amber_outlined, 'label': 'Dispute – DSP-445'},
  ];

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Linked Records',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AuditLogDetailScreen.kText)),
          const SizedBox(height: 12),
          ..._records.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(r['icon'] as IconData,
                        size: 18, color: AuditLogDetailScreen.kSubtext),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(r['label'] as String,
                          style: const TextStyle(
                              color: AuditLogDetailScreen.kText, fontSize: 13)),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text('View',
                              style: TextStyle(
                                  color: AuditLogDetailScreen.kAccent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                          SizedBox(width: 2),
                          Icon(Icons.arrow_forward,
                              size: 13, color: AuditLogDetailScreen.kAccent),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ── 5b. Review Timeline ──────────────────────
class _ReviewTimelineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Review Timeline',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AuditLogDetailScreen.kText)),
          const SizedBox(height: 14),
          _TimelineItem(
            dot: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                  color: AuditLogDetailScreen.kAccent, shape: BoxShape.circle),
            ),
            title: 'Created by John Admin',
            subtitle: '04:15 PM',
            isLast: false,
          ),
          _TimelineItem(
            dot: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                  color: AuditLogDetailScreen.kAccent, shape: BoxShape.circle),
            ),
            title: 'Reviewed by Compliance',
            subtitle: '05:02 PM',
            isLast: false,
          ),
          _TimelineItem(
            dot: Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                  color: AuditLogDetailScreen.kGreen, shape: BoxShape.circle),
              child: const Icon(Icons.check, color: Colors.white, size: 10),
            ),
            title: 'Finalized',
            subtitle: '',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Widget dot;
  final String title, subtitle;
  final bool isLast;
  const _TimelineItem({
    required this.dot,
    required this.title,
    required this.subtitle,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              dot,
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AuditLogDetailScreen.kBorder,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AuditLogDetailScreen.kText)),
                  if (subtitle.isNotEmpty)
                    Text(subtitle,
                        style: const TextStyle(
                            color: AuditLogDetailScreen.kSubtext,
                            fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 6. Bottom Actions ────────────────────────
class _BottomActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Export Log (outlined)
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_outlined,
                color: AuditLogDetailScreen.kText, size: 18),
            label: const Text('Export Log',
                style: TextStyle(
                    color: AuditLogDetailScreen.kText,
                    fontWeight: FontWeight.w600)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: AuditLogDetailScreen.kBorder),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Mark as Reviewed (filled gold)
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 18),
            label: const Text('Mark as Reviewed',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AuditLogDetailScreen.kAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════
// SHARED CARD WRAPPER
// ══════════════════════════════════════════════
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AuditLogDetailScreen.kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AuditLogDetailScreen.kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ══════════════════════════════════════════════
// EXAMPLE: How to plug into your existing app
// ══════════════════════════════════════════════
/*
Scaffold(
  drawer: YourExistingDrawer(),   // <-- your drawer here
  body: const AuditLogDetailScreen(),
);
*/
