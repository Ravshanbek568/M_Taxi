import 'package:flutter/material.dart';
import 'package:m_taksi/core/theme/colors.dart'; // Loyiha ranglari uchun

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  // Form controllerlari
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Parolni ko'rish uchun holatlar
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  
  // Parol qo'yishni tanlash uchun checkbox
  bool _enablePassword = false;

  @override
  void dispose() {
    // Controllerlarni tozalash
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Formni to'g'ri to'ldirilganligini tekshirish
  bool _isFormValid() {
    // Agar parol qo'yish tanlangan bo'lsa
    if (_enablePassword) {
      return _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          (_passwordController.text == _confirmPasswordController.text);
    }
    // Agar parol qo'yish tanlanmagan bo'lsa
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      // APP BAR - ORQAGA QAYTISH TUGMASI
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Shaffof fon
        elevation: 0, // Soyani olib tashlash
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Orqaga ikonkasi
          onPressed: () => Navigator.pop(context), // Oldingi ekranga qaytish
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profil rasmi va sarlavha
            Column(
              children: [
                // Profil rasmi
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 145,
                      height: 145,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey, // Rasm yo'qligida fon rangi
                      ),
                      child: const Icon(Icons.person, size: 60),
                    ),
                    // Rasm qo'shish tugmasi
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
                const SizedBox(height: 10),
                // "Profilingizni yarating" matni
                const Text(
                  "Profilingizni yarating",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Ma'lumotlar formasi
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildInputField("Foydalanuvchi ismi", controller: _firstNameController),
                  _buildInputField("Foydalanuvchi familiyasi", controller: _lastNameController),
                  _buildInputField("Telefon raqamingiz", controller: _phoneController),
                  _buildInputField("Email", controller: _emailController),
                  const SizedBox(height: 10),
                  // Parol qo'yishni tanlash checkboxi
                  Row(
                    children: [
                      Checkbox(
                        value: _enablePassword,
                        onChanged: (value) {
                          setState(() {
                            _enablePassword = value!;
                            if (!_enablePassword) {
                              // Agar parol qo'yish bekor qilinsa, parollarni tozalash
                              _passwordController.clear();
                              _confirmPasswordController.clear();
                            }
                          });
                        },
                      ),
                      const Text("Parol qo'yishni xoxlaysizmi?"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Faqat checkbox tanlangan bo'lsa parol maydonlarini ko'rsatish
                  if (_enablePassword) ...[
                    _buildPasswordField("Parolni kiriting", 
                      controller: _passwordController,
                      showPassword: _showPassword,
                      onToggleVisibility: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    _buildPasswordField("Parolni takrorlang", 
                      controller: _confirmPasswordController,
                      showPassword: _showConfirmPassword,
                      onToggleVisibility: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                    // Parollar mos kelmasa xabar
                    if (_passwordController.text.isNotEmpty && 
                        _confirmPasswordController.text.isNotEmpty &&
                        _passwordController.text != _confirmPasswordController.text)
                      const Text(
                        "Parollar mos kelmadi!",
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Tasdiqlash tugmasi
            SizedBox(
              width: 315,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: _isFormValid() ? () {
                  // Form to'g'ri to'ldirilgan bo'lsa
                  Navigator.pushReplacementNamed(context, '/home');
                } : null,
                child: const Text(
                  "Tasdiqlash",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Rasm tanlash dialogi
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Rasm tanlang"),
        actions: [
          TextButton(
            onPressed: () {
              // Galereyadan rasm tanlash
              Navigator.pop(ctx);
            },
            child: const Text("Galereya"),
          ),
          TextButton(
            onPressed: () {
              // Kamera orqali rasm olish
              Navigator.pop(ctx);
            },
            child: const Text("Kamera"),
          ),
        ],
      ),
    );
  }

  // Oddiy input maydoni uchun widget
  Widget _buildInputField(String hint, {required TextEditingController controller}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
        onChanged: (value) {
          setState(() {}); // Form holatini yangilash
        },
      ),
    );
  }

  // Parol input maydoni uchun widget
  Widget _buildPasswordField(
    String hint, {
    required TextEditingController controller,
    required bool showPassword,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        obscureText: !showPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: onToggleVisibility,
          ),
        ),
        onChanged: (value) {
          setState(() {}); // Form holatini yangilash
        },
      ),
    );
  }
}