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

  static const Color _background = Color(0xFFF3F9F8);
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
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: _dariFont)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  TextStyle _dari({
    double size = 14,
    Color color = _ink,
    FontWeight weight = FontWeight.w500,
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
              final double horizontalPadding = constraints.maxWidth < 360
                  ? 16
                  : 22;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  8,
                  horizontalPadding,
                  28,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 36,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _topBar(),
                      const SizedBox(height: 22),
                      _heading(),
                      const SizedBox(height: 25),
                      _phoneCard(),
                      const SizedBox(height: 24),
                      _divider(),
                      const SizedBox(height: 18),
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
                      const SizedBox(height: 24),
                      _privacyCard(),
                      const SizedBox(height: 24),
                      _otpCard(),
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

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () => _showMessage('تغییر زبان در آینده اضافه می‌شود.'),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: deepTeal,
            side: const BorderSide(color: _border),
            minimumSize: const Size(0, 43),
            padding: const EdgeInsets.symmetric(horizontal: 17),
            shape: const StadiumBorder(),
          ),
          child: Text('دری', style: _dari(size: 13, weight: FontWeight.w600)),
        ),
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          tooltip: 'بازگشت',
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 23,
            color: _ink,
          ),
        ),
      ],
    );
  }

  Widget _heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ورود به حساب',
          style: _dari(size: 27, weight: FontWeight.w800, height: 1.5),
        ),
        const SizedBox(height: 8),
        Text(
          'شماره تلفون خود را وارد کنید. یک کد تأییدی برای شما ارسال می‌شود.',
          style: _dari(size: 14, color: const Color(0xFF7C9292), height: 1.9),
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
            color: deepTeal.withOpacity(0.055),
            blurRadius: 14,
            offset: const Offset(0, 5),
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
              style: _dari(size: 12, color: _muted, weight: FontWeight.w600),
            ),
          ),
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: emerald, width: 1.4),
              boxShadow: [
                BoxShadow(
                  color: emerald.withOpacity(0.12),
                  spreadRadius: 2,
                  blurRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.phone_rounded, size: 21, color: _muted),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: _dari(size: 14),
                    decoration: InputDecoration(
                      hintText: '۷۹۰ ۱۲۳ ۴۵۶',
                      hintStyle: _dari(size: 14, color: _muted),
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
                Container(
                  height: 28,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  color: _border,
                ),
                const Text(
                  '+93',
                  textDirection: TextDirection.ltr,
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
          const SizedBox(height: 18),
          SizedBox(
            height: 58,
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
                shadowColor: emerald.withOpacity(0.20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                'ارسال کد تأیید',
                style: _dari(
                  size: 16,
                  color: Colors.white,
                  weight: FontWeight.w800,
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
      height: 56,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: _englishFont,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
            const SizedBox(width: 12),
            Icon(icon, size: 21, color: _ink),
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
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: _mintBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: deepTeal.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_user_outlined, size: 20, color: _ink),
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
            color: deepTeal.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'کود چهار رقمی',
            style: _dari(size: 12, color: _muted, weight: FontWeight.w600),
          ),
          const SizedBox(height: 14),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    height: 62,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: TextField(
                      controller: _otpControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: _dari(
                        size: 22,
                        color: deepTeal,
                        weight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '—',
                        hintStyle: _dari(size: 24, color: _muted),
                        filled: true,
                        fillColor: index >= 2 ? _mint : _background,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: index >= 2 ? _mintBorder : _border,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: index >= 2 ? _mintBorder : _border,
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: emerald, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '۰۱:۲۴',
                style: _dari(
                  size: 11,
                  color: deepTeal,
                  weight: FontWeight.w800,
                ),
              ),
              TextButton(
                onPressed: () =>
                    _showMessage('ارسال دوباره کد هنوز فعال نشده است.'),
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
