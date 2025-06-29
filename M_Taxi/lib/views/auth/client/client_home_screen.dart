// lib/views/home/entrepreneur_home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // SVG rasmlar uchun kutubxona

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _selectedIndex = 0; // Pastki menyuda tanlangan indeks
  final Color _selectedColor = Colors.blue; // Tanlangan icon rangi
  final Color _unselectedColor = Colors.grey[700]!; // Tanlanmagan icon rangi
  int? _selectedServiceIndex; // Tanlangan xizmat indeksi

  // Xizmatlar ro'yxati (nomi va ikonkasi)
  final List<Map<String, String>> services = [
    {'title': 'Maxalliy taksi', 'icon': 'assets/icons/icon2.svg'},
    {'title': 'Yuk tashish hizmati', 'icon': 'assets/icons/icon3.svg'},
    {'title': 'Shaxarlar aro taksi', 'icon': 'assets/icons/icon4.svg'},
    {'title': 'Kafe & restoranlar', 'icon': 'assets/icons/icon5.svg'},
    {'title': 'Xo\'jalik va qurilish molari', 'icon': 'assets/icons/icon6.svg'},
    {'title': 'Do\'konlar savdo uylari', 'icon': 'assets/icons/icon7.svg'},
    {'title': 'Sartaroshxona go\'zalik salo\'nlar', 'icon': 'assets/icons/icon8.svg'},
    {'title': 'Sartaroshxona go\'zalik salo\'nlar', 'icon': 'assets/icons/icon9.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Asosiy sahifa fon rangi (och kulrang #F8F9F9)
      backgroundColor: const Color(0xFFF8F9F9),
      
      // Yuqori navigatsiya paneli (AppBar)
      appBar: PreferredSize(
        // AppBar balandligini belgilash (80 piksel)
        preferredSize: const Size.fromHeight(80),
        child: Container(
          // AppBar chetlaridan bo'shliq (2 piksel)
          margin: const EdgeInsets.symmetric(horizontal: 2),
          // AppBar dizayni
          decoration: BoxDecoration(
            color: Colors.white, // AppBar fon rangi (oq)
            borderRadius: const BorderRadius.only(
              // Faqat pastki ikki burchakni yumaloqlash (24 radius)
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05), // Soyaning rangi (5% shaffof)
                spreadRadius: 1, // Soyaning tarqalish radiusi
                blurRadius: 6, // Soyaning xiralashish darajasi
                offset: const Offset(0, 2), // Soyaning yo'nalishi (pastga)
              ),
            ],
          ),
          // AppBar ichidagi content uchun padding
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Gorizontal padding 20px
            child: AppBar(
              backgroundColor: Colors.transparent, // Shaffof fon
              elevation: 0, // Soyasiz
              leading: IconButton( // Chap tomondagi menyu tugmasi
                icon: const Icon(Icons.menu, color: Colors.black, size: 32),
                onPressed: () {}, // Sozlamalar sahifasiga o'tish funksiyasi
              ),
              title: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, // Kengligi 80%
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Manzil ko'rsatuvchi qator
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
                              overflow: TextOverflow.ellipsis, // Uzun matnda "..."
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
                      overflow: TextOverflow.ellipsis, // Uzun matnda "..."
                    ),
                  ],
                ),
              ),
              actions: [
                // Foydalanuvchi rasmi (o'ng tomonda)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CircleAvatar(
                    radius: 30, // Avatar radiusi (30px)
                    backgroundImage: NetworkImage('https://example.com/user-profile.jpg'),
                    backgroundColor: Colors.grey[300], // Rasm yo'q bo'lganda fon
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // Asosiy kontent (Xizmatlar toifalari)
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 2), // AppBar pastidan 2px
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "Xizmat toifalari" sarlavhasi
              const Padding(
                padding: EdgeInsets.only(top: 2, bottom: 4), // Sarlavha pastidan 4px
                child: Text(
                  'Xizmat toifalari',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              
              // Xizmatlar gridi (2 qator, har birida 4ta)
              GridView.builder(
                shrinkWrap: true, // GridView o'lchamini contentga moslashtirish
                physics: const NeverScrollableScrollPhysics(), // Scrollni o'chirish
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Har bir qatorda 4 ta element
                  mainAxisSpacing: 50, // Vertikal oraliq 50px
                  crossAxisSpacing: 18, // Gorizontal oraliq 18px
                  childAspectRatio: 0.9, // Eni va bo'yi nisbati
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedServiceIndex = index; // Tanlangan xizmat indeksi
                      });
                    },
                    child: Column(
                      children: [
                        // Xizmat ikonkasi konteyneri (54x50px)
                        Container(
                          width: 54,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _selectedServiceIndex == index 
                                ? Colors.cyan[100] // Tanlangan rang
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10), // Burchaklari 10px yumaloq
                            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05), // Soyaning rangi va shaffofligi
                spreadRadius: 1, // Soyaning tarqalish radiusi
                blurRadius: 6, // Soyaning xiralashish darajasi
                offset: const Offset(0, 2), // Soyaning yo'nalishi
              ),
            ],
                          ),
                          child: Center(
                            // SVG formatdagi ikonka
                            child: SvgPicture.asset(
                              services[index]['icon']!,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4), // Icon va matn orasidagi 4px bo'shliq
                        // Xizmat nomi
                        Text(
                          services[index]['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                          maxLines: 2, // Maksimal 2 qator
                          overflow: TextOverflow.ellipsis, // Ortiqcha matnni "..." qilish
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      
      // Pastki navigatsiya paneli
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1), // Soyaning rangi (10% shaffof)
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -5), // Soyaning yo'nalishi (yuqoriga)
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Iconlarni teng taqsimlash
            currentIndex: _selectedIndex,
            selectedItemColor: _selectedColor,
            unselectedItemColor: _unselectedColor,
            showSelectedLabels: false, // Tanlangan labelni ko'rsatmaslik
            showUnselectedLabels: false, // Tanlanmagan labelni ko'rsatmaslik
            elevation: 10, // Soyaning balandligi
            iconSize: 28, // Icon o'lchami
            onTap: (index) {
              setState(() {
                _selectedIndex = index; // Tanlangan indeksni yangilash
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Uy'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Qidiruv'),
              BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Xabarlar'),
              BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Bildirishnomalar'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Tanlanganlar'),
            ],
          ),
        ),
      ),
    );
  }
}