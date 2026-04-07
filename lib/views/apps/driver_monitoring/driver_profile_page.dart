import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:yamazone/views/apps/driver_monitoring/widget/proof_of_delivery_dialog.dart';
import 'package:yamazone/views/layouts/layout.dart';

// ─────────────────────────────────────────────
//  THEME CONSTANTS
// ─────────────────────────────────────────────
const Color kPrimary = Color(0xFFC8A84B); // golden/amber
const Color kPrimaryLight = Color(0xFFF5EDD0);
const Color kGreen = Color(0xFF4CAF50);
const Color kGreenLight = Color(0xFFE8F5E9);
const Color kOrange = Color(0xFFFF9800);
const Color kOrangeLight = Color(0xFFFFF3E0);
const Color kBg = Color(0xFFF9F7F2);
const Color kCardBg = Colors.white;
const Color kTextDark = Color(0xFF1A1A1A);
const Color kTextGrey = Color(0xFF757575);
const Color kDivider = Color(0xFFEEEEEE);

// ─────────────────────────────────────────────
//  ENTRY POINT  (remove if integrating into existing app)
// ─────────────────────────────────────────────

// ─────────────────────────────────────────────
//  MAIN PAGE
// ─────────────────────────────────────────────
class DriverProfileDetailPage extends StatelessWidget {
  const DriverProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,

      // Replace with your existing drawer widget
      body: Layout(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _DriverHeader(),
                    SizedBox(height: 24),
                    _KycSection(),
                    SizedBox(height: 24),
                    _VehicleDocumentsSection(),
                    SizedBox(height: 24),
                    _PayoutSection(),
                    SizedBox(height: 32),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TOP BAR
// ─────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 800;
    return Container(
      height: 56,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (isNarrow)
            Builder(
              builder:
                  (ctx) => IconButton(
                    icon: const Icon(Icons.menu, color: kTextDark),
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                  ),
            ),
          const Text(
            'Driver Profile Detail',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: kTextDark,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DRIVER HEADER CARD
// ─────────────────────────────────────────────
class _DriverHeader extends StatelessWidget {
  const _DriverHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.person, size: 36, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          // Name & ID
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Rajesh Kumar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kTextDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Driver ID: DRV001234',
                  style: TextStyle(fontSize: 13, color: kTextGrey),
                ),
              ],
            ),
          ),
          // Active badge
          _StatusBadge(label: 'Active', color: kGreen, bgColor: kGreenLight),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  KYC SECTION
// ─────────────────────────────────────────────
class _KycSection extends StatelessWidget {
  const _KycSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'KYC Details',
      trailing: _StatusBadge(
        label: 'Approved',
        color: kPrimary,
        bgColor: kPrimaryLight,
        icon: Icons.check_circle_outline,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 500;
          final cards = [
            _KycDocCard(
              imageWidget: _DocThumbnail(
                icon: Icons.credit_card,
                color: Colors.deepOrange.shade100,
              ),
              title: 'ID Proof',
              subtitle: 'Aadhaar Card',
            ),
            _KycDocCard(
              imageWidget: _DocThumbnail(
                icon: Icons.badge_outlined,
                color: Colors.blue.shade100,
              ),
              title: 'Driving License',
              subtitle: 'DL1234567890',
            ),
          ];
          return isWide
              ? Row(children: cards.map((c) => Expanded(child: c)).toList())
              : Column(children: cards);
        },
      ),
    );
  }
}

class _KycDocCard extends StatelessWidget {
  final Widget imageWidget;
  final String title;
  final String subtitle;

  const _KycDocCard({
    required this.imageWidget,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kDivider),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(width: 72, height: 52, child: imageWidget),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: kTextDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: kTextGrey),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _OutlineButton(
                      icon: Icons.visibility_outlined,
                      label: 'View',
                    ),
                    const SizedBox(width: 8),
                    _OutlineButton(icon: Icons.zoom_in, label: 'Zoom'),
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
//  VEHICLE DOCUMENTS SECTION
// ─────────────────────────────────────────────
class _VehicleDocumentsSection extends StatelessWidget {
  const _VehicleDocumentsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Vehicle Documents',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          // Vehicle type & number row
          LayoutBuilder(
            builder: (ctx, constraints) {
              final isWide = constraints.maxWidth > 400;
              final info = [
                _LabelValue(label: 'Vehicle Type', value: 'Auto Rickshaw'),
                _LabelValue(label: 'Vehicle Number', value: 'MH 12 AB 1234'),
              ];
              return isWide
                  ? Row(children: info.map((w) => Expanded(child: w)).toList())
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: info,
                  );
            },
          ),
          const SizedBox(height: 20),
          // Three document cards
          LayoutBuilder(
            builder: (ctx, constraints) {
              final isWide = constraints.maxWidth > 600;
              final docs = [
                _VehicleDocCard(
                  icon: Icons.description_outlined,
                  iconBg: const Color(0xFFFFF8E1),
                  iconColor: kPrimary,
                  title: 'RC Book',
                  subtitle: 'Registration Certificate',
                ),
                _VehicleDocCard(
                  icon: Icons.shield_outlined,
                  iconBg: const Color(0xFFE3F2FD),
                  iconColor: Colors.blue,
                  title: 'Insurance',
                  subtitle: 'Policy Certificate',
                  hasCarImage: true,
                ),
                _VehicleDocCard(
                  icon: Icons.directions_bike_outlined,
                  iconBg: const Color(0xFFF3E5F5),
                  iconColor: Colors.purple,
                  title: 'Vehicle Photo',
                  subtitle: 'Front View',
                  hasVehicleImage: true,
                ),
              ];
              return isWide
                  ? Row(children: docs.map((d) => Expanded(child: d)).toList())
                  : Column(children: docs);
            },
          ),
        ],
      ),
    );
  }
}

class _VehicleDocCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool hasCarImage;
  final bool hasVehicleImage;

  const _VehicleDocCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.hasCarImage = false,
    this.hasVehicleImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: kTextDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: kTextGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: _PrimaryButton(
              label: 'View',
              icon: Icons.visibility_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PAYOUT SECTION
// ─────────────────────────────────────────────
class _PayoutSection extends StatelessWidget {
  const _PayoutSection();

  static const _rows = [
    _PayoutRow(date: '10 Jan 2024', amount: '₹500', isPaid: true),
    _PayoutRow(date: '11 Jan 2024', amount: '₹750', isPaid: false),
    _PayoutRow(date: '12 Jan 2024', amount: '₹600', isPaid: true),
    _PayoutRow(date: '13 Jan 2024', amount: '₹450', isPaid: true),
    _PayoutRow(date: '14 Jan 2024', amount: '₹820', isPaid: false),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Payout (Last 7 Days)',
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: kBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: kTextGrey,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: kTextGrey,
                    ),
                  ),
                ),
                Text(
                  'Status',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: kTextGrey,
                  ),
                ),
              ],
            ),
          ),
          ..._rows,
          const Divider(color: kDivider, height: 24),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Showing last 7 days transactions',
                style: TextStyle(fontSize: 12, color: kTextGrey),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Total Earned: ',
                      style: TextStyle(
                        fontSize: 13,
                        color: kTextGrey,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    TextSpan(
                      text: '₹3,120',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kTextDark,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PayoutRow extends StatelessWidget {
  final String date;
  final String amount;
  final bool isPaid;
  const _PayoutRow({
    required this.date,
    required this.amount,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kDivider, width: 0.8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              date,
              style: const TextStyle(fontSize: 13, color: kTextDark),
            ),
          ),
          Expanded(
            child: Text(
              amount,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: kTextDark,
              ),
            ),
          ),
          _StatusBadge(
            label: isPaid ? 'Paid' : 'Pending',
            color: isPaid ? kGreen : kOrange,
            bgColor: isPaid ? kGreenLight : kOrangeLight,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  REUSABLE WIDGETS
// ─────────────────────────────────────────────

/// Generic section card with title and optional trailing widget
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const _SectionCard({required this.title, required this.child, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kTextDark,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          child,
        ],
      ),
    );
  }
}

/// Coloured status badge  e.g. "Active", "Approved", "Paid"
class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;
  final IconData? icon;

  const _StatusBadge({
    required this.label,
    required this.color,
    required this.bgColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
          ] else ...[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Outlined icon button (View / Zoom)
class _OutlineButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _OutlineButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        showProofOfDeliveryDialog(context);
      },
      icon: Icon(icon, size: 14, color: kPrimary),
      label: Text(label, style: const TextStyle(fontSize: 12, color: kPrimary)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: kPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}

/// Full-width golden primary button (View)
class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PrimaryButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 16, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

/// Label + bold value stacked vertically
class _LabelValue extends StatelessWidget {
  final String label;
  final String value;
  const _LabelValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: kTextGrey)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kTextDark,
            ),
          ),
        ],
      ),
    );
  }
}

/// Placeholder coloured thumbnail for documents
class _DocThumbnail extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _DocThumbnail({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(child: Icon(icon, color: Colors.white, size: 28)),
    );
  }
}

// ─────────────────────────────────────────────
//  PLACEHOLDER DRAWER  (replace with your real drawer)
// ─────────────────────────────────────────────
class _PlaceholderDrawer extends StatelessWidget {
  final bool isInline;
  const _PlaceholderDrawer({this.isInline = false});

  static const _items = [
    _NavItem(icon: Icons.bar_chart, label: 'Dashboard'),
    _NavItem(icon: Icons.people_outline, label: 'User Management'),
    _NavItem(icon: Icons.verified_user_outlined, label: 'KYC Approvals'),
    _NavItem(icon: Icons.list_alt_outlined, label: 'Listing Moderation'),
    _NavItem(icon: Icons.receipt_long_outlined, label: 'Orders & Escrow'),
    _NavItem(icon: Icons.gavel_outlined, label: 'Dispute Center'),
    _NavItem(
      icon: Icons.directions_car_outlined,
      label: 'Driver Monitoring',
      isActive: true,
    ),
    _NavItem(icon: Icons.settings_outlined, label: 'System Settings'),
    _NavItem(icon: Icons.notifications_outlined, label: 'Notifications'),
    _NavItem(icon: Icons.history_outlined, label: 'Audit Logs'),
  ];

  @override
  Widget build(BuildContext context) {
    final drawer = Container(
      width: 220,
      color: const Color(0xFF1C2431),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Control Center',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12),
          const SizedBox(height: 8),
          // Nav items
          ..._items.map((item) => _DrawerItem(item: item)),
          const Spacer(),
          const Divider(color: Colors.white12),
          // Footer user
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: null,
                  backgroundColor: Color(0xFF3A4557),
                  child: Icon(Icons.person, size: 18, color: Colors.white70),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Super Admin',
                        style: TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.logout, color: Colors.white54, size: 18),
              ],
            ),
          ),
        ],
      ),
    );

    if (isInline) return drawer;
    return Drawer(child: drawer);
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final bool isActive;
  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });
}

class _DrawerItem extends StatelessWidget {
  final _NavItem item;
  const _DrawerItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: item.isActive ? kPrimary.withOpacity(0.18) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          item.icon,
          size: 18,
          color: item.isActive ? kPrimary : Colors.white60,
        ),
        title: Text(
          item.label,
          style: TextStyle(
            color: item.isActive ? kPrimary : Colors.white70,
            fontSize: 13,
            fontWeight: item.isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
