import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const NabzAiApp());
}

const Color deepTeal = Color(0xFF075B53);
const Color darkTeal = Color(0xFF033D38);
const Color emerald = Color(0xFF168F80);
const Color mint = Color(0xFFB7F7E7);

class NabzAiApp extends StatelessWidget {
  const NabzAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NABZ AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: deepTeal),
        scaffoldBackgroundColor: darkTeal,
      ),
      // Dari and Persian are written from right to left.
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child ?? const SizedBox.shrink(),
      ),
      home: const SplashScreen(),
    );
  }
}

// -------------------- SPLASH SCREEN --------------------

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _heartController;
  late final AnimationController _lineController;
  late final AnimationController _logoController;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    // Repeats a soft double heartbeat.
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..repeat();

    // Draws the ECG line from left to right.
    _lineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..repeat();

    // Fades in the logo and app name.
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    Future.delayed(const Duration(milliseconds: 650), () {
      if (mounted) _logoController.forward();
    });

    // Opens the welcome screen after the intro.
    _navigationTimer = Timer(const Duration(milliseconds: 4200), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) =>
          const WelcomeScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            final slide = Tween<Offset>(
              begin: const Offset(0, 0.035),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slide, child: child),
            );
          },
          transitionDuration: const Duration(milliseconds: 650),
        ),
      );
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _heartController.dispose();
    _lineController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 1.1,
            colors: [Color(0xFF0C776A), darkTeal],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned(
                top: 90,
                left: 35,
                child: GlowDot(size: 5),
              ),
              const Positioned(
                top: 170,
                right: 48,
                child: GlowDot(size: 4),
              ),
              const Positioned(
                bottom: 180,
                left: 65,
                child: GlowDot(size: 3),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _heartController,
                        builder: (context, child) {
                          // Makes two quick pulses followed by a short pause.
                          final t = _heartController.value;
                          final beat = t < 0.16
                              ? Curves.easeOut.transform(t / 0.16)
                              : t < 0.32
                              ? 1 - Curves.easeIn.transform((t - 0.16) / 0.16)
                              : t < 0.45
                              ? Curves.easeOut.transform((t - 0.32) / 0.13)
                              : t < 0.60
                              ? 1 - Curves.easeIn.transform((t - 0.45) / 0.15)
                              : 0.0;

                          return Transform.scale(
                            scale: 1 + beat * 0.13,
                            child: Container(
                              width: 132,
                              height: 132,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: mint.withValues(alpha: 0.12 + beat * 0.22),
                                    blurRadius: 20 + beat * 24,
                                    spreadRadius: 2 + beat * 5,
                                  ),
                                ],
                              ),
                              child: child,
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.favorite_rounded,
                          size: 112,
                          color: mint,
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 76,
                        child: AnimatedBuilder(
                          animation: _lineController,
                          builder: (context, child) => CustomPaint(
                            painter: EcgPainter(progress: _lineController.value),
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _logoController,
                          curve: Curves.easeIn,
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.12),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _logoController,
                            curve: Curves.easeOutCubic,
                          )),
                          child: Column(
                            children: const [
                              NabzLogo(size: 112),
                              SizedBox(height: 18),
                              Text(
                                'نبض هوشمند',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'N A B Z   A I',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: mint,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'سلامتی شما، اولویت ما',
                                style: TextStyle(
                                  color: Color(0xFFD1EAE5),
                                  fontSize: 15,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

class GlowDot extends StatelessWidget {
  final double size;
  const GlowDot({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: mint,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: mint.withValues(alpha: 0.7), blurRadius: 12),
        ],
      ),
    );
  }
}

class EcgPainter extends CustomPainter {
  final double progress;
  EcgPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.56)
      ..lineTo(size.width * 0.23, size.height * 0.56)
      ..lineTo(size.width * 0.31, size.height * 0.56)
      ..lineTo(size.width * 0.38, size.height * 0.24)
      ..lineTo(size.width * 0.45, size.height * 0.84)
      ..lineTo(size.width * 0.52, size.height * 0.39)
      ..lineTo(size.width * 0.58, size.height * 0.56)
      ..lineTo(size.width, size.height * 0.56);

    final metric = path.computeMetrics().first;
    final length = metric.length * progress;
    final drawnPath = metric.extractPath(0, length);

    final glowPaint = Paint()
      ..color = mint.withValues(alpha: 0.25)
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final linePaint = Paint()
      ..color = mint
      ..strokeWidth = 2.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(drawnPath, glowPaint);
    canvas.drawPath(drawnPath, linePaint);

    final point = metric.getTangentForOffset(length)?.position;
    if (point != null) {
      canvas.drawCircle(
        point,
        8,
        Paint()..color = mint.withValues(alpha: 0.18),
      );
      canvas.drawCircle(point, 3.5, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant EcgPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// -------------------- WELCOME SCREEN --------------------

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  Animation<Offset> _slide(double start, double end) {
    return Tween<Offset>(
      begin: Offset(0, start),
      end: Offset(0, end),
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.12, 1, curve: Curves.easeOutCubic),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [emerald, Color(0xFF087267), darkTeal],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 42,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        FadeTransition(
                          opacity: _entranceController,
                          child: const NabzLogo(size: 124),
                        ),
                        const SizedBox(height: 20),
                        SlideTransition(
                          position: _slide(0.12, 0),
                          child: FadeTransition(
                            opacity: _entranceController,
                            child: const Text(
                              'نبض هوشمند',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 31,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'N A B Z   A I',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Color(0xFFD0F0E9),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'خدمات صحی، نزدیک‌تر به شما.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFE0F3EF),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'داکتران، کلینیک‌ها و شفاخانه‌های تأییدشده را پیدا کنید و آنلاین نوبت بگیرید.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFE0F3EF),
                            fontSize: 16,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 25),
                        _AnimatedFeature(
                          controller: _entranceController,
                          delay: 0.15,
                          icon: Icons.search_rounded,
                          title: 'جستجوی داکتر تأییدشده',
                          subtitle: 'داکتران در ولایت‌های مختلف',
                        ),
                        const SizedBox(height: 12),
                        _AnimatedFeature(
                          controller: _entranceController,
                          delay: 0.32,
                          icon: Icons.calendar_month_rounded,
                          title: 'نوبت‌گیری آنلاین',
                          subtitle: 'بدون تماس تلفونی، بدون نوبت دوباره',
                        ),
                        const SizedBox(height: 12),
                        _AnimatedFeature(
                          controller: _entranceController,
                          delay: 0.49,
                          icon: Icons.auto_awesome_rounded,
                          title: 'دستیار هوشمند نبض',
                          subtitle: 'علایم خود را مرتب کنید',
                        ),
                        const Spacer(),
                        const SizedBox(height: 26),
                        FadeTransition(
                          opacity: CurvedAnimation(
                            parent: _entranceController,
                            curve: const Interval(0.58, 1, curve: Curves.easeIn),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 62,
                                child: ElevatedButton(
                                  onPressed: () => _showMessage(
                                    context,
                                    'صفحه ثبت‌نام را در مرحله بعد می‌سازیم.',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: deepTeal,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: const Text(
                                    'شروع کنید',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                height: 62,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const SignInScreen(),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: const BorderSide(
                                      color: Color(0xFF6CB1A7),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: const Text(
                                    'قبلاً حساب دارم',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'با ادامه، شما شرایط استفاده و سیاست حفظ حریم خصوصی نبض هوشمند را می‌پذیرید.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFB7D8D2),
                            fontSize: 11.5,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _AnimatedFeature extends StatelessWidget {
  final AnimationController controller;
  final double delay;
  final IconData icon;
  final String title;
  final String subtitle;

  const _AnimatedFeature({
    required this.controller,
    required this.delay,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(delay, 1, curve: Curves.easeOutCubic),
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.16),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.17),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFFD1EAE5),
                        fontSize: 13,
                        height: 1.4,
                      ),
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


class NabzLogo extends StatelessWidget {
  final double size;

  const NabzLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/nabz_logo.jpg',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}


// -------------------- SIGN-IN PAGE --------------------

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers =
  List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    _phoneController.dispose();
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _socialButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 62,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: const Color(0xFF172D30)),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF172D30),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFDCE9E6)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFF3F9F8);
    const borderColor = Color(0xFFDCE9E6);
    const textColor = Color(0xFF172D30);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top row: language and back button.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () =>
                        _showMessage('تغییر زبان در آینده اضافه می‌شود.'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: deepTeal,
                      side: const BorderSide(color: borderColor),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('دری'),
                  ),
                  IconButton(
                    tooltip: 'بازگشت',
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    color: textColor,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                'ورود به حساب',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'شماره تلفون خود را وارد کنید. یک کد تأییدی برای شما ارسال می‌شود.',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.8,
                  color: Color(0xFF7C9292),
                ),
              ),
              const SizedBox(height: 26),

              // Phone number card.
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: deepTeal.withValues(alpha: 0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'شماره تلفون',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF829493),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: '۷۹۰ ۱۲۳ ۴۵۶',
                          prefixText: '+93  ',
                          prefixIcon:
                          const Icon(Icons.phone_android_rounded),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                            const BorderSide(color: borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                            const BorderSide(color: borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: emerald,
                              width: 1.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 62,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_phoneController.text.trim().isEmpty) {
                            _showMessage(
                              'لطفاً شماره تلفون خود را وارد کنید.',
                            );
                          } else {
                            _showMessage(
                              'ارسال کد تأییدی هنوز فعال نشده است.',
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: emerald,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: const Text(
                          'ارسال کد تأیید',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              // Divider between phone and social sign-in.
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'یا ادامه با',
                      style: TextStyle(color: Colors.blueGrey.shade400),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              _socialButton(
                label: 'ادامه با Google',
                icon: Icons.language_rounded,
                onPressed: () =>
                    _showMessage('ورود با Google هنوز فعال نشده است.'),
              ),
              const SizedBox(height: 12),
              _socialButton(
                label: 'ادامه با Apple',
                icon: Icons.phone_iphone_rounded,
                onPressed: () =>
                    _showMessage('ورود با Apple هنوز فعال نشده است.'),
              ),
              const SizedBox(height: 26),

              // Free account information.
              Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF9F6),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFFBDE6DD),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: deepTeal,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'حساب شما رایگان است. مریضان می‌توانند اعضای خانواده خود را به همین حساب اضافه کنند — بدون ایجاد حساب جداگانه.',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF356B65),
                          height: 1.8,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Verification-code section shown in the reference design.
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'کود چهار رقمی',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF829493),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 52,
                            height: 58,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 3),
                              child: TextField(
                                controller: _otpControllers[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: '—',
                                  filled: true,
                                  fillColor: const Color(0xFFF3F9F8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: borderColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: emerald,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => _showMessage(
                          'ارسال دوباره کد هنوز فعال نشده است.',
                        ),
                        child: const Text('ارسال دوباره کد'),
                      ),
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

