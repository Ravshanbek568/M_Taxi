import 'package:flutter/material.dart';
import 'package:m_taksi/models/user_model.dart';
import 'package:m_taksi/core/theme/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // final _formKey = GlobalKey<FormState>();
  late UserModel _user;
  bool _isLoading = true;
  bool _enablePasswordChange = false;
  bool _enableCardChange = false;
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _showCvv = false;
  
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryMonthController = TextEditingController();
  final TextEditingController _expiryYearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  
  String _selectedCardType = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _cardNumberController.addListener(_formatCardNumber);
    _expiryMonthController.addListener(_validateCardExpiry);
    _expiryYearController.addListener(_validateCardExpiry);
  }

  @override
  void dispose() {
    _cardNumberController.removeListener(_formatCardNumber);
    _expiryMonthController.removeListener(_validateCardExpiry);
    _expiryYearController.removeListener(_validateCardExpiry);
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _cardNumberController.dispose();
    _expiryMonthController.dispose();
    _expiryYearController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await UserModel.loadFromPrefs();
      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _user = UserModel();
          _isLoading = false;
        });
      }
    }
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

  void _validateCardExpiry() {
    if (_expiryMonthController.text.length == 2 && _expiryYearController.text.length == 4) {
      final now = DateTime.now();
      final month = int.tryParse(_expiryMonthController.text) ?? 0;
      final year = int.tryParse(_expiryYearController.text) ?? 0;
      
      if (month < 1 || month > 12) {
        _showSnackBar('Noto\'g\'ri oy');
        return;
      }
      
      if (year < now.year || (year == now.year && month < now.month)) {
        // Karta muddati o'tganligi haqida xabar ekranda qoladi
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

 // Remove the unused formKey
// final _formKey = GlobalKey<FormState>(); // This line should be removed

// In the _saveProfile method, update the null checks:
Future<void> _saveProfile() async {
    if (!mounted) return;
    
    // Profil maydonlarini tekshirish
    if ((_user.firstName ?? '').isEmpty ||
        (_user.lastName ?? '').isEmpty ||
        (_user.phone ?? '').isEmpty ||
        (_user.address ?? '').isEmpty ||
        (_user.email ?? '').isEmpty) {
      _showSnackBar('Maydonlarni to\'liq to\'ldirishingiz shart');
      return;
    }

    // Parol o'zgartirish bo'limini tekshirish
    if (_enablePasswordChange) {
      if (_currentPasswordController.text.isEmpty ||
          _newPasswordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        _showSnackBar('Maydonlarni to\'liq to\'ldirishingiz shart');
        return;
      }

      if (_newPasswordController.text.length < 4) {
        _showSnackBar('Parol kamida 4 ta belgidan iborat bo\'lishi kerak');
        return;
      }

      if (_newPasswordController.text != _confirmPasswordController.text) {
        _showSnackBar('Parollar mos kelmadi');
        return;
      }
    }

    // Rest of the method remains the same...
}

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Rasm tanlang"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Galereyadan rasm tanlash
              },
              child: const Text("Galereya"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Kamera orqali rasm olish
              },
              child: const Text("Kamera"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.txtColor1),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Sozlamalar',
          style: TextStyle(color: AppColors.txtColor1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildAvatarSection(),
            const SizedBox(height: 30),
            _buildProfileForm(),
            const SizedBox(height: 30),
            _buildCardChangeSection(),
            const SizedBox(height: 30),
            _buildSaveButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 145,
                height: 145,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: _user.avatarUrl != null
                      ? DecorationImage(
                          image: NetworkImage(_user.avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _user.avatarUrl == null
                    ? const Icon(Icons.person, size: 60, color: Colors.white)
                    : null,
              ),
              GestureDetector(
                onTap: _showImagePickerDialog,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                  child: const Icon(Icons.camera_alt),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Rasmni o\'zgartirish',
              style: TextStyle(color: AppColors.txtColor1, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.txtColor1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildInputField("Ism", _user.firstName ?? '', (value) => _user.firstName = value),
          _buildInputField("Familiya", _user.lastName ?? '', (value) => _user.lastName = value),
          _buildInputField("Telefon", _user.phone ?? '', (value) => _user.phone = value),
          _buildInputField("Manzil", _user.address ?? '', (value) => _user.address = value),
          _buildInputField("Email", _user.email ?? '', (value) => _user.email = value),
          const SizedBox(height: 10),
          
          Row(
            children: [
              Checkbox(
                value: _enablePasswordChange,
                onChanged: (value) {
                  setState(() {
                    _enablePasswordChange = value!;
                    if (!_enablePasswordChange) {
                      _currentPasswordController.clear();
                      _newPasswordController.clear();
                      _confirmPasswordController.clear();
                    }
                  });
                },
              ),
              const Text(
                "Parolni o'zgartirishni xohlaysizmi?",
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
          
          if (_enablePasswordChange) ...[
            const SizedBox(height: 15),
            _buildPasswordField(
              "Joriy parol", 
              _currentPasswordController,
              _showCurrentPassword,
              () => setState(() => _showCurrentPassword = !_showCurrentPassword),
            ),
            const SizedBox(height: 15),
            _buildPasswordField(
              "Yangi parol", 
              _newPasswordController,
              _showNewPassword,
              () => setState(() => _showNewPassword = !_showNewPassword),
            ),
            const SizedBox(height: 15),
            _buildPasswordField(
              "Yangi parolni takrorlang", 
              _confirmPasswordController,
              _showConfirmPassword,
              () => setState(() => _showConfirmPassword = !_showConfirmPassword),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    bool showPassword,
    VoidCallback onToggleVisibility,
  ) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      child: TextField(
        controller: controller,
        obscureText: !showPassword,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Color.fromARGB(179, 32, 32, 32)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: onToggleVisibility,
          ),
        ),
      ),
    );
  }

  Widget _buildCardChangeSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.txtColor1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: _enableCardChange,
                onChanged: (value) {
                  setState(() {
                    _enableCardChange = value!;
                    if (!_enableCardChange) {
                      _cardNumberController.clear();
                      _expiryMonthController.clear();
                      _expiryYearController.clear();
                      _cvvController.clear();
                    }
                  });
                },
              ),
              Text(
                _user.cardNumber == null 
                  ? "Ilovaga kartani bog'laysizmi?"
                  : "Karta ma'lumotlarini o'zgartirasizmi?",
                style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
          
          if (_enableCardChange) ...[
            const SizedBox(height: 20),
            _buildCardNumberField(),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildExpiryField("Oy (MM)", _expiryMonthController, 2),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildExpiryField("Yil (YYYY)", _expiryYearController, 4),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildCvvField(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.txtColor,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text(
          'Saqlash',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String value, Function(String) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      child: TextField(
        controller: TextEditingController(text: value),
        style: const TextStyle(color: Color.fromARGB(255, 10, 10, 10)),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Color.fromARGB(179, 32, 32, 32)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCardNumberField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      child: Stack(
        children: [
          TextField(
            controller: _cardNumberController,
            keyboardType: TextInputType.number,
            maxLength: 19, // 16 raqam + 3 probel
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            decoration: InputDecoration(
              hintText: 'Kartangiz raqami kirgazing',
              hintStyle: const TextStyle(color: Color.fromARGB(179, 32, 32, 32)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: _selectedCardType.isNotEmpty ? 90 : 90,
                right: 15,
                top: 15,
                bottom: 12,
              ),
              counterText: '',
            ),
          ),
          if (_selectedCardType.isNotEmpty)
            Positioned(
              left: 18,
              top: 0,
              child: Image.asset(
                'assets/images/${_selectedCardType}_logo.png',
                width: 50,
                height: 50,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExpiryField(String hint, TextEditingController controller, int maxLength) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color.fromARGB(179, 32, 32, 32)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          counterText: '',
        ),
      ),
    );
  }

  Widget _buildCvvField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      child: TextField(
        controller: _cvvController,
        keyboardType: TextInputType.number,
        obscureText: !_showCvv,
        maxLength: 3,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          hintText: 'CVV',
          hintStyle: const TextStyle(color: Color.fromARGB(179, 32, 32, 32)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          counterText: '',
          suffixIcon: IconButton(
            icon: Icon(
              _showCvv ? Icons.visibility : Icons.visibility_off,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {
              setState(() => _showCvv = !_showCvv);
              if (_showCvv) {
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) {
                    setState(() => _showCvv = false);
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }
}