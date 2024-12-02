import 'dart:convert';
import 'package:document_sent/constants.dart';
import 'package:document_sent/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:document_sent/widget/custom_elevatedButton.dart';
import 'package:document_sent/widget/textfield_widget.dart';
import 'package:get/get.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // TextEditingController'larni tashqarida e'lon qilamiz
  TextEditingController passport_number = TextEditingController();
  TextEditingController passport_pin = TextEditingController();

  // Loading holatini saqlash uchun o'zgaruvchi
  bool isLoading = false;

  // POST so'rovini yuboradigan funksiya
  Future<void> signIn() async {
    if (passport_pin.text.isEmpty || passport_number.text.isEmpty) {
      Get.snackbar('Xatolik', 'Iltimos, barcha maydonlarni to\'ldiring');
      return;
    }

    final url = Uri.parse('https://uzxteam.uz/olima/login.php');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'passport_pin': passport_pin.text,
      'passport_number': passport_number.text,
    });

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('Status kod: ${response.statusCode}');
      print('Javob: ${response.body}'); // Serverdan qaytgan ma'lumotni ko'rsatish

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['data']['items'].isNotEmpty) {
          Get.snackbar('Hush kelibsiz', 'Foydalanuvchi Topildi');
        } else {
          Get.snackbar('Muvaffaqiyatsiz', 'Foydalanuvchi Topilmadi');
        }
      } else {
        Get.snackbar('Xatolik', 'Serverdan noto‘g‘ri javob: ${response.statusCode}');
      }
    } catch (e) {
      print('Xato yuz berdi: $e');
      Get.snackbar('Xatolik', 'Baza bilan muammo yuzaga keldi');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:  !Responsive.isMobile(context)? defaultPadding*3 : defaultPadding*2),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'SIGN IN',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: primaryColor,
                      fontWeight: FontWeight.w600
                        ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'passport pin',
                    controller: passport_pin,
                    isNumeric: true,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'passport number',
                    isPassword: true,
                    controller: passport_number,
                    isNumeric: false,
                  ),
                  SizedBox(height: 20),
                  CustomElevatedbutton(
                    color: primaryColor,
                    width: double.infinity,
                    height: 50.0,
                    onPressed: () {
                      isLoading ? null : signIn();
                    },
                    title: isLoading
                        ? "loading..."
                        : "sign in", // Loading holatiga qarab matnni o'zgartirish
                  ),
                ],
              ),
            ),
          ),
          if (!Responsive.isMobile(context))
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: defaultPadding*4),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding*5),
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.21),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.52),
                        ),
                        borderRadius: BorderRadius.circular(
                            25), // Responsiv borderRadius
                      ),
                    ),
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.fill,
                      height: 300,
                      width: 300,
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
