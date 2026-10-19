
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nabzai/pages/welcomePage.dart';
import 'package:nabzai/utilitise/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _heartbeatController;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _navigationTimer = Timer(
      const Duration(milliseconds: 4200),
          () {
        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, animation, secondaryAnimation) =>
            const WelcomeScreen(),
            transitionsBuilder:
                (_, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration:
            const Duration(milliseconds: 600),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _introController.dispose();
    _heartbeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTeal,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.45, -0.75),
            radius: 1.5,
            colors: [
              Color(0xFF087D70),
              Color(0xFF04564E),
              Color(0xFF022F2B),
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxHeight < 700;

              return Stack(
                children: [
                  // Soft decorative background glows.
                  const Positioned(
                    top: 70,
                    left: 35,
                    child: _GlowDot(size: 5),
                  ),
                  const Positioned(
                    top: 180,
                    right: 42,
                    child: _GlowDot(size: 4),
                  ),
                  const Positioned(
                    bottom: 150,
                    left: 55,
                    child: _GlowDot(size: 3),
                  ),

                  // Main splash content.
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 20,
                      ),
                      child: FadeTransition(
                        opacity: CurvedAnimation(
                          parent: _introController,
                          curve: Curves.easeOut,
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.045),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _introController,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: compact ? 8 : 20),

                              // The actual brand logo is the focal point.
                              AnimatedBuilder(
                                animation: _heartbeatController,
                                builder: (context, child) {
                                  final t =
                                      _heartbeatController.value;
                                  final pulse =
                                  (1 +
                                      (t < 0.15
                                          ? t / 0.15
                                          : (t < 0.30
                                          ? (0.30 - t) /
                                          0.15
                                          : 0)) *
                                          0.025);

                                  return Transform.scale(
                                    scale: pulse,
                                    child: Container(
                                      width: compact ? 132 : 154,
                                      height: compact ? 132 : 154,
                                      padding:
                                      const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(38),
                                        border: Border.all(
                                          color: mint.withValues(
                                            alpha: 0.7,
                                          ),
                                          width: 1.2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: mint.withValues(
                                              alpha: 0.12,
                                            ),
                                            blurRadius: 38,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: child,
                                    ),
                                  );
                                },
                                child: const NabzLogo(size: 130),
                              ),

                              SizedBox(height: compact ? 22 : 30),

                              Text(
                                'نبض هوشمند',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: compact ? 28 : 32,
                                  fontWeight: FontWeight.w800,
                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 7),

                              const Text(
                                'N A B Z   A I',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: mint,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.4,
                                ),
                              ),

                              SizedBox(height: compact ? 18 : 26),

                              // Animated ECG accent.
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: AnimatedBuilder(
                                  animation: _heartbeatController,
                                  builder: (context, child) {
                                    return CustomPaint(
                                      painter: _HeartbeatPainter(
                                        progress:
                                        _heartbeatController.value,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(height: compact ? 18 : 24),

                              const Text(
                                'سلامتی شما، اولویت ما',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFE0F3EF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                'خدمات صحی، نزدیک‌تر به شما.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFB7DCD5),
                                  fontSize: 14,
                                  height: 1.7,
                                ),
                              ),

                              SizedBox(height: compact ? 28 : 40),

                              // Quiet loading indicator.
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: List.generate(3, (index) {
                                  return AnimatedBuilder(
                                    animation: _heartbeatController,
                                    builder: (context, child) {
                                      final active =
                                          (_heartbeatController.value *
                                              3)
                                              .floor() %
                                              3 ==
                                              index;

                                      return AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 250,
                                        ),
                                        margin:
                                        const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        width: active ? 9 : 6,
                                        height: active ? 9 : 6,
                                        decoration: BoxDecoration(
                                          color: active
                                              ? mint
                                              : mint.withValues(
                                            alpha: 0.35,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Brand signature at the bottom.
                  const Positioned(
                    bottom: 14,
                    left: 12,
                    right: 12,
                    child: Text(
                      'N A B Z   A I   •   HEALTHCARE, REIMAGINED',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF8FC8BE),
                        fontSize: 9,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GlowDot extends StatelessWidget {
  final double size;

  const _GlowDot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: mint,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: mint.withValues(alpha: 0.55),
            blurRadius: 12,
          ),
        ],
      ),
    );
  }
}

class _HeartbeatPainter extends CustomPainter {
  final double progress;

  _HeartbeatPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.55)
      ..lineTo(size.width * 0.27, size.height * 0.55)
      ..lineTo(size.width * 0.35, size.height * 0.55)
      ..lineTo(size.width * 0.41, size.height * 0.19)
      ..lineTo(size.width * 0.47, size.height * 0.84)
      ..lineTo(size.width * 0.54, size.height * 0.38)
      ..lineTo(size.width * 0.60, size.height * 0.55)
      ..lineTo(size.width, size.height * 0.55);

    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;

    final metric = metrics.first;
    final p = progress.clamp(0.0, 1.0);
    final length = metric.length * p;
    final visiblePath = metric.extractPath(0, length);

    final glow = Paint()
      ..color = mint.withValues(alpha: 0.20)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final line = Paint()
      ..color = mint
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(visiblePath, glow);
    canvas.drawPath(visiblePath, line);

    final point = metric.getTangentForOffset(length)?.position;

    if (point != null) {
      canvas.drawCircle(
        point,
        5,
        Paint()..color = mint.withValues(alpha: 0.20),
      );
      canvas.drawCircle(
        point,
        2.5,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HeartbeatPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Shared logo widget used by the splash screen.
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