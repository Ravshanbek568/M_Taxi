import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _selectedIndex = 0;
  final Color _selectedColor = Colors.blue;
  final Color _unselectedColor = Colors.grey[700]!;

  // Tavsiya qilingan haydovchilar ro'yxati
  final List<Map<String, dynamic>> _recommendations = [
    {
      'avatar': 'assets/images/driver1.jpg',
      'name': 'Aliyev Sardor',
      'service': 'Haydovchi',
      'days': 'Dushanbadan - Jumagacha',
      'hours': '08:00 - 20:00',
      'rating': 4.8,
    },
    {
      'avatar': 'assets/images/driver2.jpg',
      'name': 'Xasanov Jasur',
      'service': 'Yuk tashish',
      'days': 'Dushanbadan - Shanbagacha',
      'hours': '09:00 - 18:00',
      'rating': 4.9,
    },
    {
      'avatar': 'assets/images/driver3.jpg',
      'name': 'Karimov Shoxrux',
      'service': 'Shaxarlararo taksi',
      'days': 'Dushanbadan - Yakshanbagacha',
      'hours': '07:00 - 22:00',
      'rating': 4.7,
    },
    {
      'avatar': 'assets/images/driver4.jpg',
      'name': 'Omonova Dilfuza',
      'service': 'Yetkazib berish',
      'days': 'Dushanbadan - Shanbagacha',
      'hours': '10:00 - 19:00',
      'rating': 4.9,
    },
    {
      'avatar': 'assets/images/driver5.jpg',
      'name': 'Toshmatov Bahodir',
      'service': 'Maxsus transport',
      'days': 'Dushanbadan - Jumagacha',
      'hours': '08:00 - 18:00',
      'rating': 4.6,
    },
  ];

  // Mashhur haydovchilar ro'yxati
  final List<Map<String, dynamic>> _popularDrivers = [
    {
      'avatar': 'assets/images/driver6.jpg',
      'name': 'Rahimov Shoxrux',
      'service': 'Ekspress yetkazib berish',
      'days': 'Dushanbadan - Yakshanbagacha',
      'hours': '08:00 - 22:00',
      'rating': 4.9,
    },
    {
      'avatar': 'assets/images/driver7.jpg',
      'name': 'Usmonova Dilbar',
      'service': 'Shaxsiy haydovchi',
      'days': 'Dushanbadan - Jumagacha',
      'hours': '07:00 - 19:00',
      'rating': 4.8,
    },
    {
      'avatar': 'assets/images/driver8.jpg',
      'name': 'Qodirov Aziz',
      'service': 'Yuk tashish xizmati',
      'days': 'Dushanbadan - Shanbagacha',
      'hours': '09:00 - 20:00',
      'rating': 4.7,
    },
    {
      'avatar': 'assets/images/driver9.jpg',
      'name': 'Nazarova Malika',
      'service': 'Shaxarlararo taksi',
      'days': 'Dushanbadan - Yakshanbagacha',
      'hours': '06:00 - 23:00',
      'rating': 4.9,
    },
    {
      'avatar': 'assets/images/driver10.jpg',
      'name': 'Turgunov Jamshid',
      'service': 'Maxsus transport',
      'days': 'Dushanbadan - Jumagacha',
      'hours': '08:00 - 18:00',
      'rating': 4.8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F9),
      
      // AppBar - endi rangi o'zgarmaydi
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black, size: 32),
          onPressed: () {},
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'Toshkent shahri',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
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
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://example.com/user-profile.jpg'),
              backgroundColor: Colors.grey[300],
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Xizmat toifalari bo'limi
            _buildServiceCategories(),
            
            // Tavsiya qilingan haydovchilar bo'limi
            _buildRecommendationsSection(),
            
            // Mashhur haydovchilar bo'limi
            _buildPopularDriversSection(),
          ],
        ),
      ),
      
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildServiceCategories() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Xizmat toifalari',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildServiceItem(imagePath: 'assets/images/rasm9.png', label: 'Maxalliy taksi'),
              _buildServiceItem(imagePath: 'assets/images/rasm10.png', label: 'Yuk tashish hizmati'),
              _buildServiceItem(imagePath: 'assets/images/rasm11.png', label: 'Shaxarlar aro taksi'),
              _buildServiceItem(imagePath: 'assets/images/rasm12.png', label: 'Kafe & restoranlar'),
            ],
          ),
          
          const SizedBox(height: 30),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildServiceItem(imagePath: 'assets/images/rasm13.png', label: 'Xo\'jalik va qurilish molari'),
              _buildServiceItem(imagePath: 'assets/images/rasm14.png', label: 'Do\'konlar savdo uylari'),
              _buildServiceItem(imagePath: 'assets/images/rasm15.png', label: 'Sartaroshxona go\'zalik salo\'nlar'),
              _buildServiceItem(imagePath: 'assets/images/rasm16.png', label: 'Yetkazib berish'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({required String imagePath, required String label}) {
    bool isPressed = false;
    
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTapDown: (_) => setState(() => isPressed = true),
          onTapUp: (_) => setState(() => isPressed = false),
          onTapCancel: () => setState(() => isPressed = false),
          onTap: () {
            if (kDebugMode) debugPrint('$label tanlandi');
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            transform: Matrix4.identity()..scale(isPressed ? 0.95 : 1.0),
            child: Column(
              children: [
                Container(
                  width: 68,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 25).withAlpha(25),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      width: 75,
                      height: 75,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 64,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecommendationsSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Siz uchun tavsiyalar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 195,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recommendations.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 300,
                  margin: EdgeInsets.only(
                    right: index == _recommendations.length - 1 ? 0 : 16,
                  ),
                  child: _buildBusinessCard(_recommendations[index], index, isRecommendation: true),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularDriversSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Hozir mashhurlar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 195,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _popularDrivers.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 300,
                  margin: EdgeInsets.only(
                    right: index == _popularDrivers.length - 1 ? 0 : 16,
                  ),
                  child: _buildBusinessCard(_popularDrivers[index], index, isRecommendation: false),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCard(Map<String, dynamic> recommendation, int index, {bool isRecommendation = true}) {
    // Ranglar ro'yxati
    final colors = isRecommendation 
      ? [
          const Color(0xFF0062FF), // ko'k
          const Color(0xFF6CADFF), // zangori
          const Color(0xFF0062FF), // ko'k
          const Color(0xFFFFE500), // sariq
          const Color(0xFF0062FF), // ko'k
        ]
      : [
          const Color(0xFFFB1313), // qizil
          const Color(0xFF6CADFF), // zangori
          const Color(0xFFC37272), // pushti
          const Color(0xFF6CADFF), // zangori
          const Color(0xFF549554), // yashil
        ];

    // Gradientlar ro'yxati
    final gradientColors = isRecommendation
      ? [
          [const Color(0xFF10F1FF), const Color(0xFF0139FE)], // ko'k gradient
          [const Color(0xFFA0D1FF), const Color(0xFF6CADFF)], // zangori gradient
          [const Color(0xFF10F1FF), const Color(0xFF0139FE)], // ko'k gradient
          [const Color(0xFFFFF3B8), const Color(0xFFFFE500)], // sariq gradient
          [const Color(0xFF10F1FF), const Color(0xFF0139FE)], // ko'k gradient
        ]
      : [
          [const Color(0xFFFFA1A1), const Color(0xFFFB1313)], // qizil gradient
          [const Color(0xFFA0D1FF), const Color(0xFF6CADFF)], // zangori gradient
          [const Color(0xFFE8B5B5), const Color(0xFFC37272)], // pushti gradient
          [const Color(0xFFA0D1FF), const Color(0xFF6CADFF)], // zangori gradient
          [const Color(0xFFA0D1A0), const Color(0xFF549554)], // yashil gradient
        ];

    return Container(
      width: 300,
      height: 190,
      decoration: BoxDecoration(
        color: colors[index % colors.length],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 25).withAlpha(25),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Diagonal gradient fon
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: gradientColors[index % gradientColors.length],
              ),
            ),
          ),

          // Geometrik shakllar
          Positioned(
            left: -30,
            top: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: gradientColors[index % gradientColors.length][0].withAlpha(128),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          Positioned(
            right: -20,
            bottom: -20,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: gradientColors[index % gradientColors.length][0].withAlpha(77),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          
          // Asosiy kontent
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar va reyting
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: AssetImage(recommendation['avatar']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          recommendation['rating'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(width: 20),
                
                // Ma'lumotlar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recommendation['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                      const SizedBox(height: 5),
                      
                      Text(
                        recommendation['service'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        recommendation['days'],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      
                      Text(
                        recommendation['hours'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Murojat qilish tugmasi
          Positioned(
            bottom: 15,
            right: 15,
            child: GestureDetector(
              onTap: () => debugPrint('Xabar yuborish: ${recommendation['name']}'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.message, size: 14, color: colors[index % colors.length]),
                    const SizedBox(width: 5),
                    Text(
                      "Murojat qilish",
                      style: TextStyle(
                        color: colors[index % colors.length],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 25).withAlpha(25),
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
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: _selectedColor,
          unselectedItemColor: _unselectedColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 10,
          iconSize: 28,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Uy'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Qidiruv'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Xabarlar'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Bildirishnomalar'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Tanlanganlar'),
          ],
        ),
      ),
    );
  }
}