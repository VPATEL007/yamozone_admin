import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:webkit/helpers/services/auth_services.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;
  String? _errorMessage;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // ── Colors ──
  static const Color _bg = Color(0xFF0C0E14);
  static const Color _panel = Color(0xFF13161F);
  static const Color _accent = Color(0xFF4F7EF8);
  static const Color _muted = Color(0xFF6B7185);
  static const Color _inputBg = Color(0xFF0E1118);
  static const Color _border = Color(0xFF1E2130);
  static const Color _error = Color(0xFFF85F5F);
  static const Color _textColor = Color(0xFFE8EAF0);

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate API call — replace with your real auth logic
    await Future.delayed(const Duration(seconds: 2));

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    AuthService.isLoggedIn = true;
    Get.toNamed("/dashboard");

    // if (email == 'admin@example.com' && password == 'admin123') {
    //   // Navigate to your dashboard
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //         content: Text('Login successful! Redirecting...'),
    //         backgroundColor: Color(0xFF22C55E),
    //       ),
    //     );
    //     AuthService.isLoggedIn = true;
    //     Get.toNamed("/dashboard");
    //   }
    // } else {
    //   setState(() {
    //     _errorMessage = 'Invalid email or password. Please try again.';
    //   });
    // }

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          // Background grid pattern
          CustomPaint(
            size: Size.infinite,
            painter: _GridPainter(),
          ),
          // Ambient glow at top
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 500,
                height: 400,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color(0x1F4F7EF8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 420),
                    decoration: BoxDecoration(
                      color: _panel,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 60,
                          spreadRadius: 0,
                          offset: const Offset(0, 20),
                        ),
                        BoxShadow(
                          color: _accent.withOpacity(0.06),
                          blurRadius: 60,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36, vertical: 44),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildLogo(),
                            const SizedBox(height: 32),
                            const Divider(color: _border, height: 1),
                            const SizedBox(height: 32),
                            _buildEmailField(),
                            const SizedBox(height: 16),
                            _buildPasswordField(),
                            // const SizedBox(height: 20),
                            // _buildRememberForgot(),
                            const SizedBox(height: 24),
                            _buildLoginButton(),
                            if (_errorMessage != null) ...[
                              const SizedBox(height: 16),
                              _buildErrorMessage(),
                            ],
                            const SizedBox(height: 24),
                            _buildFooter(),
                          ],
                        ),
                      ),
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

  // ── Logo Section ──
  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E2A4A), Color(0xFF0E1420)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _accent.withOpacity(0.35)),
            boxShadow: [
              BoxShadow(
                color: _accent.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: const Icon(Icons.lock_rounded, color: _accent, size: 28),
        ),
        const SizedBox(height: 16),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: _textColor,
            ),
            children: [
              TextSpan(text: 'Admin'),
              TextSpan(
                text: 'Panel',
                style: TextStyle(color: _accent),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Secure Administrator Access',
          style: TextStyle(
            color: _muted,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // ── Email Field ──
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'EMAIL ADDRESS',
          style: TextStyle(
            color: _muted,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: _textColor, fontSize: 14.5),
          cursorColor: _accent,
          decoration: _inputDecoration(
            hint: 'admin@example.com',
            icon: Icons.email_outlined,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                .hasMatch(value.trim())) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ── Password Field ──
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PASSWORD',
          style: TextStyle(
            color: _muted,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          style: const TextStyle(color: _textColor, fontSize: 14.5),
          cursorColor: _accent,
          decoration: _inputDecoration(
            hint: 'Enter your password',
            icon: Icons.lock_outline_rounded,
            suffix: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: _muted,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ── Remember / Forgot ──
  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() => _rememberMe = !_rememberMe),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: _rememberMe ? _accent : _inputBg,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: _rememberMe ? _accent : _border,
                  ),
                ),
                child: _rememberMe
                    ? const Icon(Icons.check, color: Colors.white, size: 12)
                    : null,
              ),
              const SizedBox(width: 8),
              const Text(
                'Remember me',
                style: TextStyle(color: _muted, fontSize: 13.5),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle forgot password
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              color: _accent,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // ── Login Button ──
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          disabledBackgroundColor: _accent.withOpacity(0.7),
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: _accent.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Sign In to Dashboard',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
      ),
    );
  }

  // ── Error Message ──
  Widget _buildErrorMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: _error.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _error.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: _error, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _errorMessage!,
              style: const TextStyle(color: _error, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ── Footer ──
  Widget _buildFooter() {
    return const Text(
      'Protected area — Authorized personnel only',
      style: TextStyle(color: Color(0xFF3A3E52), fontSize: 12),
      textAlign: TextAlign.center,
    );
  }

  // ── Input Decoration ──
  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF3A3E52), fontSize: 14),
      prefixIcon: Icon(icon, color: _muted, size: 18),
      suffixIcon: suffix,
      filled: true,
      fillColor: _inputBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _accent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: _error, width: 1.5),
      ),
      errorStyle: const TextStyle(color: _error, fontSize: 12),
    );
  }
}

// ── Background Grid Painter ──
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4F7EF8).withOpacity(0.04)
      ..strokeWidth = 1;

    const spacing = 48.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
