import 'package:flutter/material.dart';
import 'package:m_taxi/models/user_model.dart'; // Loyiha nomiga moslab o'zgartiring

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserModel _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
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

  Future<void> _saveProfile() async {
    if (!mounted) return;
    if (_formKey.currentState!.validate()) {
      try {
        await _user.saveToPrefs();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil yangilandi!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Xatolik yuz berdi!')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sozlamalar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildAvatarSection(),
              _buildTextField('Ism', _user.firstName ?? '', (value) => _user.firstName = value),
              _buildTextField('Familiya', _user.lastName ?? '', (value) => _user.lastName = value),
              _buildTextField('Telefon', _user.phone ?? '', (value) => _user.phone = value),
              _buildTextField('Manzil', _user.address ?? '', (value) => _user.address = value),
              _buildTextField('Email', _user.email ?? '', (value) => _user.email = value),
              _buildPasswordField(),
              _buildCardInfoSection(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Saqlash'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _user.avatarUrl != null 
                ? NetworkImage(_user.avatarUrl!) 
                : const AssetImage('assets/default_avatar.png') as ImageProvider,
          ),
          TextButton(
            onPressed: () {}, // Rasmni o'zgartirish funksiyasi
            child: const Text('Rasmni o\'zgartirish'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        initialValue: value,
        validator: (value) => value!.isEmpty ? 'Maydon to\'ldirilishi shart' : null,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Yangi parol',
          border: OutlineInputBorder(),
        ),
        obscureText: true,
        onChanged: (value) => _user.password = value,
      ),
    );
  }

  Widget _buildCardInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Karta ma\'lumotlari',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        _buildTextField('Karta raqami', _user.cardNumber ?? '', (v) => _user.cardNumber = v),
        _buildTextField('Amal qilish muddati', _user.cardExpiry ?? '', (v) => _user.cardExpiry = v),
      ],
    );
  }
}