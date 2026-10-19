import 'package:flutter/material.dart';
import 'package:nabzai/utilitise/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  static const Color _background = Color(0xFFF5FAF9);
  static const Color _ink = Color(0xFF172D30);
  static const Color _muted = Color(0xFF849493);
  static const Color _border = Color(0xFFDCE9E6);
  static const Color _mint = Color(0xFFF0FAF8);
  static const Color _mintBorder = Color(0xFFB9E4DC);

  static const String _dariFont = 'Vazirmatn';
  static const String _englishFont = 'Inter';

  @override
  void dispose() {
    _phoneController.dispose();
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.right,
          style: const TextStyle(fontFamily: _dariFont, fontSize: 13),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  TextStyle _dari({
    double size = 13,
    Color color = _ink,
    FontWeight weight = FontWeight.w400,
    double height = 1.6,
  }) {
    return TextStyle(
      fontFamily: _dariFont,
      fontSize: size,
      color: color,
      fontWeight: weight,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _background,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontal = constraints.maxWidth < 360 ? 16.0 : 22.0;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(horizontal, 8, horizontal, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _topBar(),
                    const SizedBox(height: 17),
                    _heading(),
                    const SizedBox(height: 27),
                    _phoneCard(),
                    const SizedBox(height: 20),
                    _divider(),
                    const SizedBox(height: 18),
                    _socialButton(
                      label: 'ادامه با Google',
                      icon: Icons.language_rounded,
                      onPressed: () =>
                          _showMessage('ورود با Google هنوز فعال نشده است.'),
                    ),
                    const SizedBox(height: 10),
                    _socialButton(
                      label: 'ادامه با Apple',
                      icon: Icons.phone_outlined,
                      onPressed: () =>
                          _showMessage('ورود با Apple هنوز فعال نشده است.'),
                    ),
                    const SizedBox(height: 24),
                    _privacyCard(),
                    const SizedBox(height: 22),
                    _otpCard(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    // LTR here deliberately keeps Dari on the left and Back on the right.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: 52,
        child: Row(
          children: [
            OutlinedButton(
              onPressed: () =>
                  _showMessage('تغییر زبان در آینده اضافه می‌شود.'),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: deepTeal,
                side: const BorderSide(color: _border),
                minimumSize: const Size(0, 42),
                padding: const EdgeInsets.symmetric(horizontal: 17),
                shape: const StadiumBorder(),
              ),
              child: Text(
                'دری',
                style: _dari(size: 12, weight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.maybePop(context),
              tooltip: 'بازگشت',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 38, minHeight: 42),
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 32,
                color: _ink,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ورود به حساب',
          textAlign: TextAlign.right,
          style: _dari(size: 25, weight: FontWeight.w700, height: 1.5),
        ),
        const SizedBox(height: 7),
        Text(
          'شماره تلفون خود را وارد کنید. یک کد تأییدی برای شما ارسال می‌شود.',
          textAlign: TextAlign.right,
          style: _dari(size: 13, color: const Color(0xFF7C9292), height: 1.9),
        ),
      ],
    );
  }

  Widget _phoneCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 17, 17, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: deepTeal.withOpacity(0.045),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4, bottom: 10),
            child: Text(
              'شماره تلفون',
              textAlign: TextAlign.right,
              style: _dari(size: 12, color: _muted, weight: FontWeight.w500),
            ),
          ),
          Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: emerald, width: 1.3),
              boxShadow: [
                BoxShadow(color: emerald.withOpacity(0.10), spreadRadius: 2),
              ],
            ),
            // LTR ensures check LEFT, number CENTER, +93 RIGHT.
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  const Icon(Icons.check_rounded, size: 22, color: _muted),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: _dari(size: 14, weight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: '۷۹۰ ۱۲۳ ۴۵۶',
                        hintStyle: _dari(size: 14, color: _ink),
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 27,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: _border,
                  ),
                  const Text(
                    '+93',
                    style: TextStyle(
                      fontFamily: _englishFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 64,
            child: ElevatedButton(
              onPressed: () {
                if (_phoneController.text.trim().isEmpty) {
                  _showMessage('لطفاً شماره تلفون خود را وارد کنید.');
                } else {
                  _showMessage('ارسال کد تأییدی هنوز فعال نشده است.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: emerald,
                foregroundColor: Colors.white,
                elevation: 3,
                shadowColor: emerald.withOpacity(0.18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: Text(
                'ارسال کد تأیید',
                style: _dari(
                  size: 16,
                  color: Colors.white,
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: _border, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('یا ادامه با', style: _dari(size: 12, color: _muted)),
        ),
        const Expanded(child: Divider(color: _border, thickness: 1)),
      ],
    );
  }

  Widget _socialButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 68,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: _ink,
          side: const BorderSide(color: _border, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        // RTL + icon first puts the icon to the RIGHT of the text.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 21, color: _ink),
            const SizedBox(width: 10),
            Text(label, style: _dari(size: 14, weight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _privacyCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: _mint,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _mintBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: deepTeal.withOpacity(0.035),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_user_outlined, size: 19, color: _ink),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              'حساب شما رایگان است. مریضان می‌توانند اعضای خانواده خود را به همین حساب اضافه کنند — بدون ایجاد حساب جداگانه.',
              textAlign: TextAlign.right,
              style: _dari(
                size: 13,
                color: const Color(0xFF416C68),
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _otpCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 18, 17, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: deepTeal.withOpacity(0.025),
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'کود چهار رقمی',
            textAlign: TextAlign.right,
            style: _dari(size: 12, color: _muted, weight: FontWeight.w500),
          ),
          const SizedBox(height: 14),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: List.generate(4, (index) {
                final digit = index == 2
                    ? '۷'
                    : index == 3
                    ? '۴'
                    : '—';

                return Expanded(
                  child: Container(
                    height: 62,
                    margin: EdgeInsets.only(
                      left: index == 0 ? 0 : 5,
                      right: index == 3 ? 0 : 5,
                    ),
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _otpFocusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      maxLength: 1,
                      style: _dari(
                        size: 21,
                        color: deepTeal,
                        weight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: digit,
                        hintStyle: _dari(
                          size: index >= 2 ? 19 : 23,
                          color: index >= 2 ? deepTeal : _muted,
                        ),
                        filled: true,
                        fillColor: index >= 2 ? _mint : _background,
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: index >= 2 ? _mintBorder : _border,
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: emerald, width: 1.4),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _otpFocusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _otpFocusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '۰۱:۲۴',
                style: _dari(
                  size: 11,
                  color: deepTeal,
                  weight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () =>
                    _showMessage('ارسال دوباره کود هنوز فعال نشده است.'),
                style: TextButton.styleFrom(
                  foregroundColor: _muted,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'ارسال دوباره کود',
                  style: _dari(size: 12, color: _muted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
