
// -------------------- SIGN-IN PAGE --------------------

import 'package:flutter/material.dart';
import 'package:nabzai/utilitise/constants.dart';

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

