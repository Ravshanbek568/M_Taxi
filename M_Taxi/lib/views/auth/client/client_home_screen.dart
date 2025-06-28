// lib/views/home/entrepreneur_home_screen.dart
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F9), // Scaffold orqa fon rangi
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255), // AppBar container fon rangi
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                // withOpacity o'rniga Color.fromRGBO yoki Color.fromARGB dan foydalaning
                color: Color.fromRGBO(0, 0, 0, 0.05), // RGB + Opacity
                // yoki: color: Color.fromARGB(13, 0, 0, 0), // Alpha = 13 (255 ning ~5%)
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),//ikkala yondagi tugmalar appp bardagi chetdan o'lchami
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black, size: 32),
                onPressed: () {
                  // Sozlamalarga o'tish
                },
              ),
              title: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
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
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://example.com/user-profile.jpg'),
                    backgroundColor: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFF8F9F9), // Body orqa fon rangi
        child: const Center(
          child: Text(
            'Xush kelibsiz!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}