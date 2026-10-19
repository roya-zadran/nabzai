
import 'package:flutter/material.dart';

// ============================================================
// NABZ AI WELCOME SCREEN
// Keeps NabzLogo public so splash_screen.dart can use it.
// ============================================================

// Official NABZ AI brand palette.
const Color primary = Color(0xFF149C8C);
const Color primaryStrong = Color(0xFF0D7D70);
const Color primaryDeep = Color(0xFF0A635A);
const Color primarySoft = Color(0xFFD9F4EF);
const Color primaryTint = Color(0xFFF0FBF9);

const Color ink = Color(0xFF0A1F26);
const Color ink3 = Color(0xFF5C7780);
const Color surface = Color(0xFFFFFFFF);

// These names must match pubspec.yaml.
const String dariFont = 'Vazirmatn';
const String englishFont = 'Inter';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDeep,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF168F81),
              Color(0xFF0D766B),
              Color(0xFF084F49),
            ],
            stops: [0.0, 0.52, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Available height inside the phone's safe area.
              final double screenHeight = constraints.maxHeight;
              final double screenWidth = constraints.maxWidth;

              // Short screens use tighter spacing and smaller elements.
              final bool compact = screenHeight < 780;
              final bool veryCompact = screenHeight < 680;

              final double logoSize = veryCompact
                  ? 88
                  : compact
                  ? 100
                  : 120;

              final double sidePadding = screenWidth < 360 ? 18 : 24;

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  sidePadding,
                  compact ? 8 : 18,
                  sidePadding,
                  compact ? 10 : 16,
                ),
                child: ConstrainedBox(
                  // Fill the available height when possible.
                  // Allow scrolling on genuinely short screens.
                  constraints: BoxConstraints(
                    minHeight: (screenHeight -
                        (compact ? 18 : 34))
                        .clamp(0.0, double.infinity),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. LOGO
                      Container(
                        width: logoSize,
                        height: logoSize,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 22,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: NabzLogo(size: logoSize - 20),
                      ),

                      SizedBox(height: compact ? 16 : 24),

                      // 2. MAIN DARI TITLE
                      Text(
                        'نبض هوشمند',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: dariFont,
                          fontSize: compact ? 29 : 32,
                          fontWeight: FontWeight.w800,
                          color: surface,
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // 3. ENGLISH BRAND NAME
                      const Text(
                        'NABZ AI',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: englishFont,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primarySoft,
                          letterSpacing: 3.0,
                        ),
                      ),

                      SizedBox(height: compact ? 18 : 24),

                      // 4. INTRODUCTION
                      Text(
                        'خدمات صحی، نزدیک‌تر به شما.',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: dariFont,
                          fontSize: compact ? 15 : 17,
                          fontWeight: FontWeight.w600,
                          color: primaryTint,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // 5. DESCRIPTION
                      Text(
                        'داکتران، کلینیک‌ها و شفاخانه‌های تأییدشده را پیدا کنید و آنلاین نوبت بگیرید.',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: dariFont,
                          fontSize: compact ? 12 : 13,
                          fontWeight: FontWeight.w400,
                          color: primarySoft,
                          height: 1.65,
                        ),
                      ),

                      SizedBox(height: compact ? 18 : 24),

                      // 6. FEATURE CARDS
                      const _WelcomeFeatureCard(
                        icon: Icons.search_rounded,
                        title: 'جستجوی داکتر تأییدشده',
                        subtitle: '۱۹ داکتر در ۶ ولایت',
                      ),

                      SizedBox(height: compact ? 8 : 10),

                      const _WelcomeFeatureCard(
                        icon: Icons.calendar_month_rounded,
                        title: 'نوبت‌گیری آنلاین',
                        subtitle: 'بدون تماس تلفونی، بدون نوبت دوباره',
                      ),

                      SizedBox(height: compact ? 8 : 10),

                      const _WelcomeFeatureCard(
                        icon: Icons.auto_awesome_rounded,
                        title: 'دستیار هوشمند نبض',
                        subtitle: 'علایم خود را مرتب کنید',
                      ),

                      SizedBox(height: compact ? 18 : 26),

                      // 7. PRIMARY BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: compact ? 54 : 58,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add registration navigation here later.
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: surface,
                            foregroundColor: primaryDeep,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'شروع کنید',
                            style: TextStyle(
                              fontFamily: dariFont,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 8. SIGN-IN BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: compact ? 52 : 56,
                        child: OutlinedButton(
                          onPressed: () {
                            // Add sign-in navigation here later.
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: surface,
                            side: BorderSide(
                              color: primarySoft.withValues(alpha: 0.40),
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'قبلاً حساب دارم',
                            style: TextStyle(
                              fontFamily: dariFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 9. PRIVACY NOTE
                      Text(
                        'با ادامه، شما شرایط استفاده و سیاست حفظ حریم خصوصی نبض هوشمند را می‌پذیرید.',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: dariFont,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w400,
                          color: primarySoft.withValues(alpha: 0.78),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ============================================================
// REUSABLE FEATURE CARD
// ============================================================

class _WelcomeFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _WelcomeFeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: surface.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: primarySoft.withValues(alpha: 0.22),
          width: 1.1,
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Icon on the right, as in the reference design.
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primarySoft.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: surface,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontFamily: dariFont,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: surface,
                    height: 1.45,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontFamily: dariFont,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: primarySoft,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SHARED LOGO
// Keep this public class because splash_screen.dart uses it.
// Do not rename or remove this class.
// ============================================================

class NabzLogo extends StatelessWidget {
  final double size;

  const NabzLogo({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/nabz_logo.jpg',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.favorite_rounded,
          color: primary,
          size: size * 0.45,
        );
      },
    );
  }
}
