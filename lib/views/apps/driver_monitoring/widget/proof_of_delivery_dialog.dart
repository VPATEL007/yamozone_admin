import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

// ─────────────────────────────────────────────
// COLORS
// ─────────────────────────────────────────────
const kPrimary = Color(0xFF1B5E20);
const kAccentGold = Color(0xFFD4A017);
const kGoldBg = Color(0xFFFFF8DC);
const kBorder = Color(0xFFE0E0E0);
const kDashedBorder = Color(0xFFCCCCCC);
const kTextDark = Color(0xFF1A1A1A);
const kTextMed = Color(0xFF555555);
const kTextLight = Color(0xFF999999);
const kVerifiedGreen = Color(0xFF2E7D32);

// ─────────────────────────────────────────────
// ENTRY POINT  (for standalone testing)
// ─────────────────────────────────────────────

// ─────────────────────────────────────────────
// PUBLIC METHOD — call this from anywhere
// ─────────────────────────────────────────────
Future<void> showProofOfDeliveryDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (_) => const ProofOfDeliveryDialog(),
  );
}

// ─────────────────────────────────────────────
// DIALOG WIDGET
// ─────────────────────────────────────────────
class ProofOfDeliveryDialog extends StatelessWidget {
  const ProofOfDeliveryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: Get.width * 0.40,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Scrollable body ──
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'Proof of Delivery',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kTextDark,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── DELIVERY PHOTOS ──
                      _SectionHeader(
                        icon: Icons.camera_alt_rounded,
                        label: 'Delivery Photos',
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _PhotoCard(
                              label: 'Delivery Location',
                              child: _MockDeliveryPhoto(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _PhotoCard(
                              label: 'Package Details',
                              child: _MockPackagePhoto(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: kBorder),
                      const SizedBox(height: 20),

                      // ── OTP USED ──
                      _SectionHeader(
                        icon: Icons.vpn_key_rounded,
                        label: 'OTP Used',
                        iconColor: kAccentGold,
                      ),
                      const SizedBox(height: 14),
                      _OtpSection(),
                      const SizedBox(height: 24),
                      const Divider(color: kBorder),
                      const SizedBox(height: 20),

                      // ── SIGNATURE ──
                      _SectionHeader(
                        icon: Icons.draw_rounded,
                        label: 'Signature',
                        iconColor: kAccentGold,
                      ),
                      const SizedBox(height: 14),
                      _SignatureBox(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // ── FOOTER ──
              _DialogFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SECTION HEADER  (icon + label)
// ─────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _SectionHeader({
    required this.icon,
    required this.label,
    this.iconColor = kAccentGold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: kGoldBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kTextDark,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// PHOTO CARD
// ─────────────────────────────────────────────
class _PhotoCard extends StatelessWidget {
  final String label;
  final Widget child;
  const _PhotoCard({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: child,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: kTextMed),
        ),
      ],
    );
  }
}

// ── Mock photo: house/door scene ──
class _MockDeliveryPhoto extends StatelessWidget {
  const _MockDeliveryPhoto();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8B6914), Color(0xFF6D4C0A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Sky
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Container(color: const Color(0xFF87CEEB)),
          ),
          // House front
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 40,
            child: Container(color: const Color(0xFFD2B48C)),
          ),
          // Door
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 40,
                height: 65,
                decoration: BoxDecoration(
                  color: const Color(0xFF5D3A1A),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ),
            ),
          ),
          // Packages
          Positioned(
            bottom: 4,
            left: 20,
            child: Row(
              children: [
                _Box(width: 22, height: 18, color: const Color(0xFFD4A017)),
                const SizedBox(width: 3),
                _Box(width: 18, height: 22, color: const Color(0xFFB8860B)),
                const SizedBox(width: 3),
                _Box(width: 20, height: 16, color: const Color(0xFFCD853F)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final double width, height;
  final Color color;
  const _Box({required this.width, required this.height, required this.color});
  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      );
}

// ── Mock photo: package/label ──
class _MockPackagePhoto extends StatelessWidget {
  const _MockPackagePhoto();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8C97A),
      child: Stack(
        children: [
          // Tape strips
          Positioned(
            top: 20,
            left: 10,
            right: 10,
            child: Column(
              children: List.generate(
                4,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8A050).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Label
          Positioned(
            top: 14,
            right: 10,
            child: Container(
              width: 60,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  5,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      height: 5,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OTP SECTION
// ─────────────────────────────────────────────
class _OtpSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kGoldBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8D080)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '4 Digit OTP',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: kTextDark,
                ),
              ),
              // Verified badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kAccentGold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 13, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Verified',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              4,
              (i) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _OtpBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        '*',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kTextDark,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SIGNATURE BOX
// ─────────────────────────────────────────────
class _SignatureBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: kDashedBorder,
          style: BorderStyle.solid,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          // Signature canvas area
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kBorder),
            ),
            clipBehavior: Clip.hardEdge,
            child: CustomPaint(
              painter: _SignaturePainter(),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Digital Signature Captured',
            style: TextStyle(fontSize: 12, color: kTextMed),
          ),
          const SizedBox(height: 2),
          const Text(
            'Timestamp: 2024-01-15 14:30:22',
            style: TextStyle(fontSize: 12, color: kTextLight),
          ),
        ],
      ),
    );
  }
}

class _SignaturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Realistic signature path
    final path = Path();
    final cx = size.width * 0.15;
    final cy = size.height * 0.45;

    // Big C loop
    path.moveTo(cx + 80, cy - 30);
    path.cubicTo(
      cx + 20,
      cy - 70,
      cx - 20,
      cy + 10,
      cx + 10,
      cy + 50,
    );
    path.cubicTo(
      cx + 40,
      cy + 80,
      cx + 90,
      cy + 60,
      cx + 100,
      cy + 20,
    );

    // Inner loop 'o'
    path.moveTo(cx + 100, cy + 20);
    path.cubicTo(
      cx + 110,
      cy - 10,
      cx + 140,
      cy - 15,
      cx + 150,
      cy + 5,
    );
    path.cubicTo(
      cx + 160,
      cy + 25,
      cx + 145,
      cy + 45,
      cx + 130,
      cy + 40,
    );

    // 'i' strokes
    path.moveTo(cx + 140, cy + 30);
    path.cubicTo(
      cx + 155,
      cy + 15,
      cx + 175,
      cy - 5,
      cx + 190,
      cy,
    );
    path.cubicTo(
      cx + 205,
      cy + 5,
      cx + 200,
      cy + 35,
      cx + 195,
      cy + 38,
    );

    // 'n'
    path.moveTo(cx + 195, cy + 10);
    path.cubicTo(
      cx + 210,
      cy - 15,
      cx + 230,
      cy - 20,
      cx + 240,
      cy,
    );
    path.cubicTo(
      cx + 255,
      cy + 20,
      cx + 250,
      cy + 40,
      cx + 248,
      cy + 38,
    );

    // Trailing flourish
    path.moveTo(cx + 248, cy + 20);
    path.cubicTo(
      cx + 265,
      cy - 10,
      cx + 285,
      cy - 15,
      cx + 310,
      cy + 5,
    );

    // Underline
    path.moveTo(cx + 60, cy + 65);
    path.lineTo(cx + 310, cy + 65);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
// DIALOG FOOTER
// ─────────────────────────────────────────────
class _DialogFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: kBorder)),
      ),
      child: Row(
        children: [
          // Left: Delivery status
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: kGoldBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: kAccentGold, width: 1.5),
                ),
                child: const Icon(Icons.check, size: 13, color: kAccentGold),
              ),
              const SizedBox(width: 8),
              const Text(
                'Delivery Verified & Complete',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: kTextMed,
                ),
              ),
            ],
          ),
          const Spacer(),

          // Download PDF button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_rounded, size: 15),
            label: const Text('Download PDF',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: kAccentGold,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(width: 10),

          // Share Proof button
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.share_rounded, size: 15),
            label: const Text('Share Proof',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
