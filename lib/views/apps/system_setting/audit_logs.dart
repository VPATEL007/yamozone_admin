import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:webkit/views/apps/system_setting/audit_log_detail.dart';
import 'package:webkit/views/layouts/layout.dart';

// ─────────────────────────────────────────────
//  THEME CONSTANTS  (matches the dark-green / gold palette)
// ─────────────────────────────────────────────
const kPrimary = Color(0xFF1A3C2E); // dark green (sidebar bg)
const kAccent = Color(0xFFD4A017); // gold / amber accent
const kBg = Color(0xFFF9F7F2); // warm off-white page bg
const kCardBg = Color(0xFFFFFFFF);
const kTextDark = Color(0xFF1A1A1A);
const kTextMid = Color(0xFF5A5A5A);
const kTextLight = Color(0xFF9A9A9A);
const kSuccess = Color(0xFF2E7D32);
const kSuccessBg = Color(0xFFE8F5E9);
const kBorder = Color(0xFFE8E4DC);

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
class AuditLog {
  final String timestamp;
  final String adminName;
  final String adminRole;
  final String action;
  final String actionType; // delete | approve | update | resolve | create
  final String module;
  final String entity;
  final String entityDetail;
  final String ip;
  final String status;

  const AuditLog({
    required this.timestamp,
    required this.adminName,
    required this.adminRole,
    required this.action,
    required this.actionType,
    required this.module,
    required this.entity,
    required this.entityDetail,
    required this.ip,
    required this.status,
  });
}

const _logs = [
  AuditLog(
    timestamp: '2024-01-04\n11:23:45 AM',
    adminName: 'John Anderson',
    adminRole: 'Super Admin',
    action: 'Delete',
    actionType: 'delete',
    module: 'User Management',
    entity: 'User #45823',
    entityDetail: 'michael.brown@email.com',
    ip: '192.168.1.105',
    status: 'Success',
  ),
  AuditLog(
    timestamp: '2024-01-04\n11:18:22 AM',
    adminName: 'Sarah Mitchell',
    adminRole: 'KYC Manager',
    action: 'Approve',
    actionType: 'approve',
    module: 'KYC Approvals',
    entity: 'KYC Request #8923',
    entityDetail: 'Driver verification',
    ip: '192.168.1.112',
    status: 'Success',
  ),
  AuditLog(
    timestamp: '2024-01-04\n11:12:08 AM',
    adminName: 'David Chen',
    adminRole: 'Moderator',
    action: 'Update',
    actionType: 'update',
    module: 'Listing Moderation',
    entity: 'Listing #12456',
    entityDetail: 'Status changed to approved',
    ip: '192.168.1.108',
    status: 'Success',
  ),
  AuditLog(
    timestamp: '2024-01-04\n11:05:33 AM',
    adminName: 'Robert Wilson',
    adminRole: 'Support Lead',
    action: 'Resolve',
    actionType: 'resolve',
    module: 'Dispute Center',
    entity: 'Dispute #5634',
    entityDetail: 'Refund issued to buyer',
    ip: '192.168.1.120',
    status: 'Success',
  ),
  AuditLog(
    timestamp: '2024-01-04\n10:58:17 AM',
    adminName: 'Emily Rodriguez',
    adminRole: 'Admin',
    action: 'Create',
    actionType: 'create',
    module: 'System Settings',
    entity: 'New Fee Structure',
    entityDetail: 'Commission rate updated',
    ip: '192.168.1.115',
    status: 'Success',
  ),
];

// ─────────────────────────────────────────────
//  MAIN SCREEN
// ─────────────────────────────────────────────
class AuditLogsScreen extends StatefulWidget {
  const AuditLogsScreen({super.key});

  @override
  State<AuditLogsScreen> createState() => _AuditLogsScreenState();
}

class _AuditLogsScreenState extends State<AuditLogsScreen> {
  String _actionType = 'All Actions';
  String _module = 'All Modules';
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBg,
        body: Layout(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Page Title ──────────────────────────────────
                  const Text(
                    'Audit Logs',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: kTextDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Filter Bar ──────────────────────────────────
                  _FilterBar(
                    searchCtrl: _searchCtrl,
                    actionType: _actionType,
                    module: _module,
                    onActionChanged: (v) => setState(() => _actionType = v),
                    onModuleChanged: (v) => setState(() => _module = v),
                  ),
                  const SizedBox(height: 20),

                  // ── Action Buttons ──────────────────────────────
                  Row(
                    children: [
                      _PrimaryButton(
                        icon: Icons.filter_alt,
                        label: 'Apply Filters',
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      _OutlineButton(
                        icon: Icons.refresh,
                        label: 'Reset',
                        onTap: () {},
                      ),
                      const Spacer(),
                      _PrimaryButton(
                        icon: Icons.download,
                        label: 'Export CSV',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // ── Stats Cards ─────────────────────────────────
                  Row(
                    children: const [
                      Expanded(
                        child: _StatCard(
                          label: 'Total Actions',
                          value: '24,582',
                          sub: '↑ 12% vs last month',
                          subColor: kSuccess,
                          icon: Icons.description_outlined,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _StatCard(
                          label: "Today's Actions",
                          value: '342',
                          sub: 'Last 24 hours',
                          subColor: kTextLight,
                          icon: Icons.access_time,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _StatCard(
                          label: 'Active Admins',
                          value: '18',
                          sub: 'Currently online',
                          subColor: kTextLight,
                          icon: Icons.people_alt_outlined,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _StatCard(
                          label: 'Critical Actions',
                          value: '23',
                          sub: '⚠ Requires review',
                          subColor: kAccent,
                          icon: Icons.warning_amber_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // ── Recent Activity Logs Table ──────────────────
                  _ActivityTable(),
                ],
              ),
            ),
          ),
        ));
  }
}

// ─────────────────────────────────────────────
//  FILTER BAR
// ─────────────────────────────────────────────
class _FilterBar extends StatelessWidget {
  final TextEditingController searchCtrl;
  final String actionType;
  final String module;
  final ValueChanged<String> onActionChanged;
  final ValueChanged<String> onModuleChanged;

  const _FilterBar({
    required this.searchCtrl,
    required this.actionType,
    required this.module,
    required this.onActionChanged,
    required this.onModuleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
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
          // Search field
          Expanded(
            flex: 3,
            child: _buildLabel(
              'Search',
              TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search by admin, action, or entity...',
                  hintStyle: const TextStyle(color: kTextLight, fontSize: 13),
                  prefixIcon:
                      const Icon(Icons.search, color: kTextLight, size: 18),
                  filled: true,
                  fillColor: kBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: kBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: kBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: kAccent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Action Type dropdown
          Expanded(
            flex: 2,
            child: _buildLabel(
              'Action Type',
              _Dropdown(
                value: actionType,
                items: const [
                  'All Actions',
                  'Delete',
                  'Approve',
                  'Update',
                  'Resolve',
                  'Create'
                ],
                onChanged: onActionChanged,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Module dropdown
          Expanded(
            flex: 2,
            child: _buildLabel(
              'Module',
              _Dropdown(
                value: module,
                items: const [
                  'All Modules',
                  'User Management',
                  'KYC Approvals',
                  'Listing Moderation',
                  'Dispute Center',
                  'System Settings',
                ],
                onChanged: onModuleChanged,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Date From
          Expanded(
            flex: 2,
            child: _buildLabel('Date From', _DateField()),
          ),
          const SizedBox(width: 16),

          // Date To
          Expanded(
            flex: 2,
            child: _buildLabel('Date To', _DateField()),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: kTextMid,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  DROPDOWN
// ─────────────────────────────────────────────
class _Dropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _Dropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: kBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        dropdownColor: kBg,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down, color: kTextMid, size: 18),
        style: const TextStyle(fontSize: 13, color: kTextDark),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DATE FIELD
// ─────────────────────────────────────────────
class _DateField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: kBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              'mm/dd/yyyy',
              style: TextStyle(fontSize: 13, color: kTextLight),
            ),
          ),
          Icon(Icons.calendar_today_outlined, size: 16, color: kTextMid),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  BUTTONS
// ─────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
      icon: Icon(icon, size: 16),
      label: Text(label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      style: OutlinedButton.styleFrom(
        foregroundColor: kTextMid,
        side: const BorderSide(color: kBorder),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  STAT CARD
// ─────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final Color subColor;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.subColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kTextMid,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: kTextDark,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sub,
                  style: TextStyle(
                    fontSize: 12,
                    color: subColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kAccent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kAccent, size: 22),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ACTIVITY TABLE
// ─────────────────────────────────────────────
class _ActivityTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorder),
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
          // Table header bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                const Text(
                  'Recent Activity Logs',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kTextDark,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Show:',
                  style: TextStyle(fontSize: 13, color: kTextMid),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: kBorder),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: DropdownButton<String>(
                    value: '50',
                    underline: const SizedBox(),
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: kTextDark),
                    items: ['25', '50', '100']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),

          // Column headers
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: kBg,
            child: Row(
              children: const [
                _ColHeader('Timestamp', flex: 2),
                _ColHeader('Admin', flex: 2),
                _ColHeader('Action', flex: 1),
                _ColHeader('Module', flex: 2),
                _ColHeader('Entity', flex: 3),
                _ColHeader('IP Address', flex: 2),
                _ColHeader('Status', flex: 1),
                _ColHeader('Details', flex: 1),
              ],
            ),
          ),

          const Divider(height: 1, color: kBorder),

          // Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _logs.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: kBorder),
            itemBuilder: (context, i) => _LogRow(log: _logs[i]),
          ),
        ],
      ),
    );
  }
}

class _ColHeader extends StatelessWidget {
  final String text;
  final int flex;

  const _ColHeader(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: kTextMid,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TABLE ROW
// ─────────────────────────────────────────────
class _LogRow extends StatelessWidget {
  final AuditLog log;

  const _LogRow({required this.log});

  Color get _actionBg {
    switch (log.actionType) {
      case 'delete':
        return const Color(0xFFFFF3E0);
      case 'approve':
        return kSuccessBg;
      case 'update':
        return const Color(0xFFE3F2FD);
      case 'resolve':
        return const Color(0xFFF3E5F5);
      case 'create':
        return const Color(0xFFE8F5E9);
      default:
        return kBg;
    }
  }

  Color get _actionColor {
    switch (log.actionType) {
      case 'delete':
        return const Color(0xFFE65100);
      case 'approve':
        return kSuccess;
      case 'update':
        return const Color(0xFF1565C0);
      case 'resolve':
        return const Color(0xFF6A1B9A);
      case 'create':
        return kSuccess;
      default:
        return kTextMid;
    }
  }

  IconData get _actionIcon {
    switch (log.actionType) {
      case 'delete':
        return Icons.delete_outline;
      case 'approve':
        return Icons.check;
      case 'update':
        return Icons.edit_outlined;
      case 'resolve':
        return Icons.flash_on;
      case 'create':
        return Icons.add;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timestamp
          Expanded(
            flex: 2,
            child: Text(
              log.timestamp,
              style:
                  const TextStyle(fontSize: 12, color: kTextMid, height: 1.5),
            ),
          ),

          // Admin
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.adminName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kTextDark,
                  ),
                ),
                Text(
                  log.adminRole,
                  style: const TextStyle(fontSize: 11, color: kTextLight),
                ),
              ],
            ),
          ),

          // Action chip
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _actionBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_actionIcon, size: 12, color: _actionColor),
                  const SizedBox(width: 4),
                  Text(
                    log.action,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _actionColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),

          // Module
          Expanded(
            flex: 2,
            child: Text(
              log.module,
              style: const TextStyle(fontSize: 12, color: kTextDark),
            ),
          ),

          // Entity
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.entity,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kTextDark,
                  ),
                ),
                Text(
                  log.entityDetail,
                  style: const TextStyle(fontSize: 11, color: kTextLight),
                ),
              ],
            ),
          ),

          // IP
          Expanded(
            flex: 2,
            child: Text(
              log.ip,
              style: const TextStyle(fontSize: 12, color: kTextMid),
            ),
          ),

          // Status
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: kSuccessBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, size: 12, color: kSuccess),
                  SizedBox(width: 4),
                  Text(
                    'Success',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kSuccess,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          // Details
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.toNamed("/audit/detail");
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.visibility_outlined, size: 14, color: kTextMid),
                  SizedBox(width: 4),
                  Text(
                    'View',
                    style: TextStyle(
                      fontSize: 12,
                      color: kTextMid,
                      fontWeight: FontWeight.w500,
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
//  USAGE EXAMPLE — wrap with your existing drawer
// ─────────────────────────────────────────────
//
//  Scaffold(
//    drawer: YourExistingDrawer(),      // ← your existing drawer
//    body: Row(
//      children: [
//        YourExistingDrawer(),           // if it's a persistent side rail
//        Expanded(child: AuditLogsScreen()),
//      ],
//    ),
//  )
//
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: Scaffold(
        backgroundColor: kBg,
        body: const AuditLogsScreen(),
      ),
    ),
  );
}
