
import 'package:flutter/material.dart';
import 'package:nabzai/pages/authenticationPage.dart';

// ============================================================
// NABZ AI WELCOME SCREEN
// Responsive, non-scrollable layout.
// Keeps NabzLogo public for splash_screen.dart.
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
              Color(0xFF0D7D70),
              Color(0xFF0A635A),
              Color(0xFF063F3A),
            ],
            stops: [0.0, 0.52, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double screenHeight = constraints.maxHeight;
              final double screenWidth = constraints.maxWidth;

              final double sidePadding =
              screenWidth < 360 ? 18 : 24;

              final double availableWidth =
                  screenWidth - (sidePadding * 2);

              // Keep some space above and below the content.
              final double verticalPadding =
              screenHeight < 670 ? 6 : 14;

              final double availableHeight =
              (screenHeight - verticalPadding * 2)
                  .clamp(0.0, double.infinity)
                  .toDouble();

              // Center the design on tall screens.
              // Scale it down automatically when the screen
              // is too short. No scrolling is used.
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sidePadding,
                  vertical: verticalPadding,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: availableHeight,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: availableWidth,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 1. LOGO
                            Container(
                              width: 106,
                              height: 106,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: surface,
                                borderRadius:
                                BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF001F1C)
                                        .withValues(alpha: 0.32),
                                    blurRadius: 28,
                                    spreadRadius: 3,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const NabzLogo(size: 86),
                            ),

                            const SizedBox(height: 20),

                            // 2. MAIN DARI TITLE
                            const Text(
                              'نبض هوشمند',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: dariFont,
                                fontSize: 30,
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

                            const SizedBox(height: 22),

                            // 4. INTRODUCTION
                            const Text(
                              'خدمات صحی، نزدیک‌تر به شما.',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: dariFont,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: primaryTint,
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // 5. DESCRIPTION
                            const Text(
                              'داکتران، کلینیک‌ها و شفاخانه‌های تأییدشده را پیدا کنید و آنلاین نوبت بگیرید.',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: dariFont,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: primarySoft,
                                height: 1.65,
                              ),
                            ),

                            const SizedBox(height: 22),

                            // 6. FEATURE CARDS
                            const _WelcomeFeatureCard(
                              icon: Icons.search_rounded,
                              title: 'جستجوی داکتر تأییدشده',
                              subtitle: '۱۹ داکتر در ۶ ولایت',
                            ),

                            const SizedBox(height: 9),

                            const _WelcomeFeatureCard(
                              icon: Icons.calendar_today_outlined,
                              title: 'نوبت‌گیری آنلاین',
                              subtitle:
                              'بدون تماس تلفونی، بدون نوبت دوباره',
                            ),

                            const SizedBox(height: 9),

                            const _WelcomeFeatureCard(
                              icon: Icons.auto_awesome_rounded,
                              title: 'دستیار هوشمند نبض',
                              subtitle: 'علایم خود را مرتب کنید',
                            ),

                            const SizedBox(height: 22),

                            // 7. PRIMARY BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add registration navigation here.
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignInScreen(),
                                      ),
                                    );

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: surface,
                                  foregroundColor: primaryDeep,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'شروع کنید',
                                  style: TextStyle(
                                    fontFamily: dariFont,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // 8. SIGN-IN BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: OutlinedButton(
                                onPressed: () {
                                  // Add sign-in navigation here.
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: surface,
                                  side: BorderSide(
                                    color: primarySoft.withValues(
                                      alpha: 0.40,
                                    ),
                                    width: 1.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text(
                                  'قبلاً حساب دارم',
                                  style: TextStyle(
                                    fontFamily: dariFont,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // 9. PRIVACY NOTE
                            const Text(
                              'با ادامه، شما شرایط استفاده و سیاست حفظ حریم خصوصی نبض هوشمند را می‌پذیرید.',
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: dariFont,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w400,
                                color: primarySoft,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
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
          // Icon on the right.
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
              size: 18,
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
// Keep this public class for splash_screen.dart.
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
