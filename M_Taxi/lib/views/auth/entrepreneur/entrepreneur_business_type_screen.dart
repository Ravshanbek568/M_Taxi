import 'package:flutter/material.dart';
import 'package:m_taksi/core/theme/colors.dart';
import 'package:m_taksi/views/auth/entrepreneur/entrepreneur_phone_screen.dart';

class EntrepreneurBusinessTypeScreen extends StatelessWidget {
  // Biznes turlari ro'yxati (const qiymat sifatida)
  static const List<String> businessTypes = [
    "Mahaliy taksi ",
    "Do'kondor",
    "Yuk tashuvchi Taksi",
    "Sartarosh",
    "Shaharlararo taksi",
    "Hunarmand usta",
    "Kafe yoki restoran sohibi",
    "Xo'jalik molari",
  ];

  const EntrepreneurBusinessTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Pastki qismdagi rasm (55% balandlikda)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: Image.asset(
                'assets/images/rasm8.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          
          // Yuqori qismdagi tanlov paneli
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.56,
              child: Center(
                child: Container(
                  width: 350, // Konteyner enini kengaytirdik (oldingi 316)
                  height: 350,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withAlpha(51), // ~20% shaffoflik
                    borderRadius: BorderRadius.circular(44),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Sarlavha matni
                      const Text(
                        "Tadbirkorligingiz yo'nalishini ko'rsating",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      
                      // Biznes turi tugmalari
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2, // 2 ustun
                          childAspectRatio: 160/50, // Eni 170px, bo'yi 50px
                          mainAxisSpacing: 12, // Vertikal oraliq
                          crossAxisSpacing: 12, // Gorizontal oraliq
                          padding: EdgeInsets.zero, // Qo'shimcha padding olib tashlandi
                          children: businessTypes.map((type) => 
                            BusinessTypeButton(
                              title: type,
                              onPressed: () {
                                if (type == "Mahaliy taksi") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EntrepreneurPhoneScreen(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessTypeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const BusinessTypeButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170, // Aniq eni 170px
      height: 50,  // Aniq bo'yi 50px
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4), // Matn sig'ishi uchun padding
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12, // Matn o'lchami kichraytirildi
            color: AppColors.txtColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 1, // Faqat 1 qator
          overflow: TextOverflow.ellipsis, // Sig'masa "..." ko'rinishida
        ),
      ),
    );
  }
}