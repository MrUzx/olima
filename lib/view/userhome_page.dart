import 'dart:convert';

import 'package:document_sent/constants.dart';
import 'package:document_sent/model/categoriya.dart';
import 'package:document_sent/responsive.dart';
import 'package:document_sent/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  bool isMenuVisible = false; // Menyu ko'rinishini boshqarish
  List<Category> categories = []; // Kategoriyalarni saqlash uchun ro'yxat
  bool isLoading = true; // Yuklanish holatini boshqarish

  @override
  void initState() {
    super.initState();
    fetchCategories(); // Ma'lumotlarni yuklashni boshlash
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('https://uzxteam.uz/olima/kategoriya.php'));

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(json.decode(response.body));
        setState(() {
          categories = apiResponse.data;
          isLoading = false; // Yuklanish tugadi
        });
      } else {
        throw Exception('Ma\'lumotlarni olishda xatolik yuz berdi.');
      }
    } catch (error) {
      setState(() {
        isLoading = false; // Xatolikda ham yuklanish holatini to'xtatish
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Xatolik: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 3;

    return Scaffold(
      drawer: !Responsive.isDesktop(context) ? CustomDrawer() : null,
      // Mobilda Drawer
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        leading: !Responsive.isMobile(context)
            ? IconButton(
                icon: Icon(
                  isMenuVisible ? Icons.close : Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isMenuVisible = !isMenuVisible;
                  });
                },
              )
            : null,
        title: const Text(
          'User Home Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Row(
        children: [
          if (!Responsive.isMobile(context))
            AnimateDrawer(isMenuVisible: isMenuVisible), // Desktopda yon menyu
          // GridView
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: !Responsive.isMobile(context) ? 3 : 2,
                childAspectRatio: !Responsive.isMobile(context)
                    ? itemWidth / itemHeight
                    : itemWidth / itemHeight * 2,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildItem(categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildItem(Category category) {
  //   return GestureDetector(
  //     onTap: (){
  //       print(category.nomi);
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.all(defaultPadding),
  //       decoration: BoxDecoration(
  //         color: primaryColor,
  //         borderRadius: BorderRadius.circular(15),
  //         boxShadow: [
  //           const BoxShadow(
  //             color: Colors.black26,
  //             blurRadius: 6,
  //             offset: Offset(4, 4),
  //           ),
  //         ],
  //       ),
  //       child: Center(
  //         child: Text(
  //           category.nomi,
  //           style: !Responsive.isMobile(context)
  //               ? Theme.of(context).textTheme.titleMedium?.copyWith(
  //                     color: Colors.white,
  //                   )
  //               : Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                     color: Colors.white,
  //                   ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildItem(Category category) {
    return GestureDetector(
      onTap: () {
        if (category.status == 1) {
          print('Selected: ${category.nomi}');
        } else {
          Get.snackbar('Kategoriya ochilmagan', '${category.nomi} ochilmagan');
        }
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                category.nomi,
                style: !Responsive.isMobile(context)
                    ? Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        )
                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (category.status == 0)
            //xira qilish va qulflash uchun
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                // Xira fon uchun qora rang
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
