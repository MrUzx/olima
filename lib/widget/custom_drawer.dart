import 'package:document_sent/constants.dart';
import 'package:document_sent/responsive.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer uchun sarlavha
          const DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Foydalanuvchi nomi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Menyu elementlari
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Bosh sahifa'),
            onTap: () {
              Navigator.pop(context); // Drawer yopiladi
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Sozlamalar'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Haqida'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          // Pastki chiqish tugmasi
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Chiqish'),
            onTap: () {
              Navigator.pop(context);
              // Logout funksiyasini qo'shish mumkin
            },
          ),
        ],
      ),
    );
  }
}


class AnimateDrawer extends StatelessWidget {
  var isMenuVisible;
  AnimateDrawer({super.key, required this.isMenuVisible});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width:  isMenuVisible ? Responsive.isDesktop(context) ? 325 : 225 : 0, // Ochilib-yopilish kengligi
      color: primaryColor,
      child: isMenuVisible
          ? const Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Menyu",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

        ],
      )
          : const SizedBox.shrink(),
    );
  }
}
