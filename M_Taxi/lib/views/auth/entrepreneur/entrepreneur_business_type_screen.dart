import 'package:flutter/material.dart';
import 'package:m_taksi/core/theme/colors.dart';
import 'package:m_taksi/views/auth/entrepreneur/entrepreneur_phone_screen.dart';

class EntrepreneurBusinessTypeScreen extends StatelessWidget {
  // Make the list static const to fix const constructor issue
  static const List<String> businessTypes = [
    "Mahaliy taksi haydovchisi",
    "Do'kondor",
    "Yuk tashuvchi avto'mobil",
    "Sartarosh",
    "Shaharlararo taksi",
    "Hunarmand usta",
    "Kafe yoki restoran sohibi",
    "Xo'jalik molari",
  ];

  // Use super.key syntax
  const EntrepreneurBusinessTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Bottom image (50% height)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset(
                'assets/images/rasm7.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          
          // Top selection panel (50% height)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Container(
                  width: 316,
                  height: 379,
                  decoration: BoxDecoration(
                    // Replace deprecated withOpacity with withAlpha
                    color: AppColors.primaryColor.withAlpha(51), // ~20% opacity
                    borderRadius: BorderRadius.circular(44),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Title text
                      const Text(
                        "Tadbirkorligingiz yo'nalishini ko'rsating",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      
                      // Business type buttons
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: businessTypes.map((type) => 
                            BusinessTypeButton(
                              title: type,
                              onPressed: () {
                                if (type == "Mahaliy taksi haydovchisi") {
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

  // Use super.key syntax
  const BusinessTypeButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.primaryColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}