import 'package:flutter/material.dart';
import 'package:m_taksi/core/theme/colors.dart';

// To'lov kartasini ro'yxatdan o'tkazish ekrani
class PaymentCardRegistrationScreen extends StatefulWidget {
  const PaymentCardRegistrationScreen({super.key});

  @override
  State<PaymentCardRegistrationScreen> createState() => _PaymentCardRegistrationScreenState();
}

class _PaymentCardRegistrationScreenState extends State<PaymentCardRegistrationScreen> {
  // TextField controllerlari
  final TextEditingController _cardNumberController = TextEditingController(); // Karta raqami uchun
  final TextEditingController _expiryMonthController = TextEditingController(); // Oy uchun (MM)
  final TextEditingController _expiryYearController = TextEditingController(); // Yil uchun (YYYY)
  final TextEditingController _cvvController = TextEditingController(); // CVV kodi uchun

  // UI holatlari
  String _selectedCardType = ''; // Tanlangan karta turi (humo, uzcard, visa)
  bool _isCvvVisible = false; // CVV ko'rinadimi yoki yo'q
  bool _isExpiryValid = true; // Karta muddati amal qiladimi

  @override
  void initState() {
    super.initState();
    // Controllerlarga listenerlar qo'shamiz
    _cardNumberController.addListener(_formatCardNumber); // Karta raqamini formatlash
    _expiryMonthController.addListener(_checkExpiry); // Muddatni tekshirish
    _expiryYearController.addListener(_checkExpiry); // Muddatni tekshirish
    _cvvController.addListener(_handleCvvVisibility); // CVV ko'rinishini boshqarish
  }

  @override
  void dispose() {
    // Listenerlarni olib tashlash
    _cardNumberController.removeListener(_formatCardNumber);
    _expiryMonthController.removeListener(_checkExpiry);
    _expiryYearController.removeListener(_checkExpiry);
    _cvvController.removeListener(_handleCvvVisibility);
    
    // Controllerlarni tozalash
    _cardNumberController.dispose();
    _expiryMonthController.dispose();
    _expiryYearController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // Karta raqamini 4-4-4-4 formatiga keltiradi
  void _formatCardNumber() {
    // Faqat raqamlarni qoldiradi
    final text = _cardNumberController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final newText = StringBuffer();

    // Har 4 ta raqamdan keyin probel qo'yamiz
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) newText.write(' ');
      newText.write(text[i]);
    }

    // Agar o'zgarish bo'lsa, yangi qiymatni o'rnatamiz
    if (_cardNumberController.text != newText.toString()) {
      _cardNumberController.value = TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    _determineCardType(text); // Karta turini aniqlash
  }

  // Karta raqamiga qarab turini aniqlaymiz
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

  // Karta muddatini tekshiramiz
  void _checkExpiry() {
    if (_expiryMonthController.text.length == 2 && _expiryYearController.text.length == 4) {
      final now = DateTime.now(); // Joriy sana
      final month = int.tryParse(_expiryMonthController.text) ?? 0; // Oy
      final year = int.tryParse(_expiryYearController.text) ?? 0; // Yil
      
      // Muddat o'tganligini tekshiramiz
      final isExpired = year < now.year || (year == now.year && month < now.month);
      
      setState(() => _isExpiryValid = !isExpired); // Holatni yangilaymiz
    }
  }

  // CVV kodini 3 soniyagina ko'rsatamiz
  void _handleCvvVisibility() {
    if (_cvvController.text.isNotEmpty) {
      setState(() => _isCvvVisible = true); // Ko'rsatamiz
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isCvvVisible = false); // Yashiramiz
        }
      });
    }
  }

  // Tasdiqlash tugmasi bosilganda
  void _onConfirmPressed() {
    // Karta raqami validatsiyasi
    if (_cardNumberController.text.replaceAll(' ', '').length != 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Karta raqami noto\'g\'ri kiritilgan')),
      );
      return;
    }

    // Muddat kiritilganligini tekshiramiz
    if (_expiryMonthController.text.isEmpty || _expiryYearController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Karta amal qilish muddati kiritilmagan')),
      );
      return;
    }

    // Muddat amal qilishini tekshiramiz
    if (!_isExpiryValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Karta muddati o\'tib ketgan')),
      );
      return;
    }

    // CVV kodini tekshiramiz
    if (_cvvController.text.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CVV kodi noto\'g\'ri kiritilgan')),
      );
      return;
    }

    Navigator.pop(context); // Sahifani yopamiz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF92CAFE), // Moviy fon rangi
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Shaffof appbar
        elevation: 0, // Soyasiz
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Orqaga tugmasi
          onPressed: () => Navigator.pop(context), // Orqaga qaytish
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20), // Yuqori padding
        child: Column(
          children: [
            // Sarlavha matni
            const Text(
              'Sizga to\'lov qilishlari uchun',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // Qo'shimcha yo'riqnoma
            const Text(
              'Karta ma\'lumotlarini kiriting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            
            // Karta rasmi
            Image.asset(
              'assets/images/rasm6.png',
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            
            // Karta raqami maydoni
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40), // Yon tomonlardan joy
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Chapga tekislash
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
                    child: Stack( // Stack widgeti (children bilan ishlatiladi)
                      children: [
                        // Karta raqami input maydoni
                        TextField(
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number, // Raqamli klaviatura
                          maxLength: 19, // 16 raqam + 3 probel
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white, // Oq fon
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20), // Yumaloq burchaklar
                              borderSide: BorderSide.none, // Chegara yo'q
                            ),
                            hintText: '0000 0000 0000 0000', // Namuna matn
                            contentPadding: const EdgeInsets.only(
                              left: 110, // Karta logosi uchun joy
                              right: 20,
                              top: 15,
                              bottom: 15,
                            ),
                            counterText: '', // Hisoblagichni olib tashlash
                          ),
                        ),
                        
                        // Karta logosi (agar tanlangan bo'lsa)
                        if (_selectedCardType.isNotEmpty)
                          Positioned(
                            left: 30,
                            top: 3,
                            child: Image.asset(
                              'assets/images/${_selectedCardType}_logo.png',
                              width: 45,
                              height: 45,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Muddat va CVV maydonlari
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Amal qilish muddati maydoni
                      Expanded(
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
                                // Oy maydoni (MM)
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    controller: _expiryMonthController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 2, // 2 ta belgi
                                    decoration: _buildExpiryDecoration('MM'), // Hint
                                  ),
                                ),
                                const SizedBox(width: 10),
                                
                                // Yil maydoni (YYYY)
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    controller: _expiryYearController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4, // 4 ta belgi
                                    decoration: _buildExpiryDecoration('YYYY'), // Hint
                                  ),
                                ),
                              ],
                            ),
                            // Xabar (agar muddat o'tib ketgan bo'lsa)
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
                      
                      const SizedBox(width: 20),
                      
                      // CVV maydoni
                      Expanded(
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
                            Stack( // Stack widgeti (children bilan ishlatiladi)
                              alignment: Alignment.centerRight, // Tugmani o'ngga joylash
                              children: [
                                // CVV input maydoni
                                TextField(
                                  controller: _cvvController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3, // 3 ta belgi
                                  obscureText: !_isCvvVisible, // Yashirish holati
                                  decoration: _buildExpiryDecoration('***'), // Hint
                                ),
                                // Ko'z tugmasi
                                IconButton(
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),
            
            // Tasdiqlash tugmasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: _onConfirmPressed, // Bosilganda funktsiya
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Oq rang
                  foregroundColor: AppColors.txtColor, // Matn rangi 
                  minimumSize: const Size(double.infinity, 50), // Kenglik
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Yumaloq burchaklar
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

  // Input maydonlari uchun umumiy bezak
  InputDecoration _buildExpiryDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white, // Oq fon
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), // Yumaloq burchaklar
        borderSide: BorderSide.none, // Chegara yo'q
      ),
      hintText: hint, // Ko'rsatkich matni
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      counterText: '', // Hisoblagichni olib tashlash
    );
  }
}