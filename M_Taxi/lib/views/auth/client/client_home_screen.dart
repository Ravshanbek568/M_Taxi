// lib/views/home/entrepreneur_home_screen.dart
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  // Tanlangan menyu indeksini saqlash uchun o'zgaruvchi
  int _selectedIndex = 0;

  // Iconlarning tanlangan/tanlanmagan holatdagi ranglari
  final Color _selectedColor = Colors.blue;
  final Color _unselectedColor = Colors.grey[700]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Asosiy sahifa orqa fon rangi (och kulrang)
      backgroundColor: const Color(0xFFF8F9F9),
      
      // Yuqori navigatsiya paneli (AppBar)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // AppBar balandligi
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2), // Chet bo'shlig'i
          decoration: BoxDecoration(
            color: Colors.white, // AppBar fon rangi (oq)
            borderRadius: const BorderRadius.only(
              // Faqat YUQORI ikki burchakni yumaloqlash (talabga ko'ra o'zgartirildi)
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05), // Soyaning rangi va shaffofligi
                spreadRadius: 1, // Soyaning tarqalish radiusi
                blurRadius: 6, // Soyaning xiralashish darajasi
                offset: const Offset(0, 2), // Soyaning yo'nalishi
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Ichki padding
            child: AppBar(
              backgroundColor: Colors.transparent, // Shaffof fon
              elevation: 0, // Soyasiz
              leading: IconButton( // Chap tomondagi menyu tugmasi
                icon: const Icon(Icons.menu, color: Colors.black, size: 32),
                onPressed: () {
                  // Sozlamalar sahifasiga o'tish funksiyasi
                },
              ),
              title: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, // Sarlavhaning kengligi
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Manzil qatori
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Colors.grey),
                        const SizedBox(width: 4), // Icon va text orasidagi bo'shliq
                        Flexible(
                          child: Text(
                            'Toshkent shahri',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              overflow: TextOverflow.ellipsis, // Matn uzun bo'lsa "..." qo'yish
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2), // Ikki qator orasidagi bo'shliq
                    // Foydalanuvchi ismi
                    const Text(
                      'Alimov Abdulloh',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              actions: [
                // Foydalanuvchi rasmi (o'ng tomonda)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CircleAvatar(
                    radius: 30, // Avatar radiusi
                    backgroundImage: NetworkImage(
                        'https://example.com/user-profile.jpg'), // Rasm manbai
                    backgroundColor: Colors.grey[300], // Rasm yo'q bo'lganda fon rangi
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // Asosiy kontent
      body: Container(
        color: const Color(0xFFF8F9F9), // Kontent fon rangi
        child: const Center(
          child: Text(
            'Xush kelibsiz!', // Asosiy matn
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      
      // Pastki navigatsiya paneli (BottomNavigationBar)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            // Faqat yuqori ikki burchakni yumaloqlash
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
       boxShadow: [
  BoxShadow(
    color: Colors.black.withAlpha((0.1 * 255).toInt()),
    spreadRadius: 0,
    blurRadius: 10,
    offset: const Offset(0, -5),
  ),
],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Iconlarning joylashuvi
            currentIndex: _selectedIndex, // Joriy tanlangan indeks
            selectedItemColor: _selectedColor, // Tanlangan icon rangi
            unselectedItemColor: _unselectedColor, // Tanlanmagan icon rangi
            showSelectedLabels: false, // Tanlangan labelni ko'rsatmaslik
            showUnselectedLabels: false, // Tanlanmagan labelni ko'rsatmaslik
            elevation: 10, // Soyaning balandligi
            iconSize: 28,
            onTap: (index) {
              setState(() {
                _selectedIndex = index; // Tanlangan indeksni yangilash
              });
            },
            items: const [
              // 1. Uy iconi
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Uy',
              ),
              // 2. Qidiruv iconi
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Qidiruv',
              ),
              // 3. Xabarlar iconi
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Xabarlar',
              ),
              // 4. Bildirishnomalar iconi
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Bildirishnomalar',
              ),
              // 5. Tanlanganlar iconi
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Tanlanganlar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}