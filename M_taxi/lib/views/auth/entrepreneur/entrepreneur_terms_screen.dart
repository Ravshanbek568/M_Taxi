import 'package:flutter/material.dart';
import 'package:m_taksi/core/theme/colors.dart';
import 'package:m_taksi/views/auth/entrepreneur/entrepreneur_home_scren.dart'; // To'g'ri import yo'li

class EntrepreneurTermsScreen extends StatefulWidget {
  const EntrepreneurTermsScreen({super.key}); // Super parametri bilan qisqartirildi

  @override
  State<EntrepreneurTermsScreen> createState() => _EntrepreneurTermsScreenState();
}

class _EntrepreneurTermsScreenState extends State<EntrepreneurTermsScreen> {
  bool _termsAccepted = false;
  bool _privacyAccepted = false;
  bool _gpsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView( // Qo'shimcha scroll qo'shildi
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rasm
              Image.asset(
                'assets/images/terms_illustration.png',
                width: 390,
                height: 234,
              ),
              
              // Sarlavha
              const SizedBox(height: 25),
              const Text(
                "Ilova shartlarini qabul qilasizmi?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              // Shartlar ro'yxati
              const SizedBox(height: 25),
              _buildTermItem(
                "Xizmat ko'rsatish qoidalarini tasdiqlash",
                _termsAccepted,
                (value) => setState(() => _termsAccepted = value),
              ),
              const SizedBox(height: 15),
              _buildTermItem(
                "Maxfiylik siyosatini qabul qilish",
                _privacyAccepted,
                (value) => setState(() => _privacyAccepted = value),
              ),
              const SizedBox(height: 15),
              _buildTermItem(
                "GPS va bildirishnomalarni yoqish",
                _gpsEnabled,
                (value) => setState(() => _gpsEnabled = value),
              ),
              
              // Tasdiqlash tugmasi
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: (_termsAccepted && _privacyAccepted && _gpsEnabled)
                      ? () {
                          // GPS yoqish logikasi
                          // Asosiy menyuga o'tish
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EntrepreneurHomeScreen(), 
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor, // primary -> backgroundColor
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Tasdiqlash",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermItem(String text, bool value, Function(bool) onChanged) {
    return SizedBox( // Container o'rniga SizedBox ishlatildi
      width: 217,
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () => onChanged(!value),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: value
                  ? Icon(Icons.check, color: AppColors.primaryColor)
                  : null,
            ),
          ),
          
          // Matn
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}