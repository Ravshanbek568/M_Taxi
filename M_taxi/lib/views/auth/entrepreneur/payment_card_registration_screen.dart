import 'package:flutter/material.dart';
import 'package:m_taksi/core/theme/colors.dart';

class PaymentCardRegistrationScreen extends StatefulWidget {
  const PaymentCardRegistrationScreen({super.key});

  @override
  State<PaymentCardRegistrationScreen> createState() => _PaymentCardRegistrationScreenState();
}

class _PaymentCardRegistrationScreenState extends State<PaymentCardRegistrationScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryMonthController = TextEditingController();
  final TextEditingController _expiryYearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  String _selectedCardType = '';
  bool _isCvvVisible = false;
  bool _isExpiryValid = true;
  // _showEmptyFieldsDialog o'zgaruvchisini olib tashladik

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_formatCardNumber);
    _expiryMonthController.addListener(_checkExpiry);
    _expiryYearController.addListener(_checkExpiry);
    _cvvController.addListener(_handleCvvVisibility);
  }

  @override
  void dispose() {
    _cardNumberController.removeListener(_formatCardNumber);
    _expiryMonthController.removeListener(_checkExpiry);
    _expiryYearController.removeListener(_checkExpiry);
    _cvvController.removeListener(_handleCvvVisibility);
    
    _cardNumberController.dispose();
    _expiryMonthController.dispose();
    _expiryYearController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _formatCardNumber() {
    final text = _cardNumberController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final newText = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) newText.write(' ');
      newText.write(text[i]);
    }

    if (_cardNumberController.text != newText.toString()) {
      _cardNumberController.value = TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    _determineCardType(text);
  }

  void _determineCardType(String cardNumber) {
    if (cardNumber.startsWith('9860')) {
      setState(() => _selectedCardType = 'humo');
    } else if (cardNumber.startsWith('5614') || cardNumber.startsWith('8600')) {
      setState(() => _selectedCardType = 'uzcard');
    } else if (cardNumber.startsWith('4400')) {
      setState(() => _selectedCardType = 'visa');
    } else if (cardNumber.startsWith('5500')) {
      setState(() => _selectedCardType = 'mastercard');
    } else {
      setState(() => _selectedCardType = '');
    }
  }

  void _checkExpiry() {
    if (_expiryMonthController.text.length == 2 && _expiryYearController.text.length == 4) {
      final now = DateTime.now();
      final month = int.tryParse(_expiryMonthController.text) ?? 0;
      final year = int.tryParse(_expiryYearController.text) ?? 0;
      
      final isExpired = year < now.year || (year == now.year && month < now.month);
      setState(() => _isExpiryValid = !isExpired);
    }
  }

  void _handleCvvVisibility() {
    if (_cvvController.text.isNotEmpty) {
      setState(() => _isCvvVisible = true);
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isCvvVisible = false);
        }
      });
    }
  }

  // Funksiyani qayta nomladik va faqat bir marta e'lon qildik
  void _showEmptyFieldsDialogFunction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: SizedBox(
            width: 280,
            height: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Ma'lumotlarni keyinroq kiritmoqchimisiz?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        minimumSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/app_terms');
                      },
                      child: const Text(
                        "Ha",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        minimumSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Yo'q",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onConfirmPressed() {
    if (_cardNumberController.text.isEmpty &&
        _expiryMonthController.text.isEmpty &&
        _expiryYearController.text.isEmpty &&
        _cvvController.text.isEmpty) {
      _showEmptyFieldsDialogFunction(); // Yangi nom bilan chaqiramiz
      return;
    }

    if (_cardNumberController.text.isNotEmpty && 
        _cardNumberController.text.replaceAll(' ', '').length != 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Karta raqami noto\'g\'ri kiritilgan')),
      );
      return;
    }

    if ((_expiryMonthController.text.isNotEmpty || _expiryYearController.text.isNotEmpty) &&
        (_expiryMonthController.text.isEmpty || _expiryYearController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Karta amal qilish muddati kiritilmagan')),
      );
      return;
    }

    if (!_isExpiryValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Karta muddati o\'tib ketgan')),
      );
      return;
    }

    if (_cvvController.text.isNotEmpty && _cvvController.text.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CVV kodi noto\'g\'ri kiritilgan')),
      );
      return;
    }

    if (_cardNumberController.text.isNotEmpty &&
        _expiryMonthController.text.isNotEmpty &&
        _expiryYearController.text.isNotEmpty &&
        _cvvController.text.isNotEmpty) {
      Navigator.pushNamed(context, '/app_terms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF92CAFE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            const Text(
              'Sizga to\'lov qilishlari uchun',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Karta ma\'lumotlarini kiriting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/rasm6.png',
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Karta raqami',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _cardNumberController,
                            keyboardType: TextInputType.number,
                            maxLength: 19,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                              hintText: '0000 0000 0000 0000',
                              contentPadding: const EdgeInsets.only(
                                left: 115,
                                right: 15,
                                top: 15,
                                bottom: 12,
                              ),
                              counterText: '',
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 85,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 176, 218, 178),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        if (_selectedCardType.isNotEmpty)
                          Positioned(
                            left: 12,
                            top: -5,
                            child: Image.asset(
                              'assets/images/${_selectedCardType}_logo.png',
                              width: 60,
                              height: 60,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Amal qilish muddati',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                      controller: _expiryMonthController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      decoration: _buildExpiryDecoration('MM', isMonth: true),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                      controller: _expiryYearController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      decoration: _buildExpiryDecoration('YYYY'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CVV',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextField(
                                    controller: _cvvController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                    obscureText: !_isCvvVisible,
                                    decoration: _buildExpiryDecoration('***'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 20,
                                      icon: Icon(
                                        _isCvvVisible 
                                          ? Icons.visibility_off 
                                          : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() => _isCvvVisible = !_isCvvVisible);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!_isExpiryValid)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Muddati o\'tib ketgan',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: _onConfirmPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.txtColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Tasdiqlash',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildExpiryDecoration(String hint, {bool isMonth = false}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      hintText: hint,
      contentPadding: isMonth 
          ? const EdgeInsets.symmetric(horizontal: 15, vertical: 16)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      counterText: '',
      hintStyle: TextStyle(
        fontSize: isMonth ? 14 : null,
      ),
    );
  }
}