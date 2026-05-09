import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ui_farm/resources/resources.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Assets.images.thankYou.image(),
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Assets.images.logoPng.image(width: 100),
                        const SizedBox(height: 32),
                        const TextField(
                          cursorColor: Colors.brown,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(),
                            hintText: "Email",
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          obscureText: true,
                          cursorColor: Colors.brown,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(),
                            border: const OutlineInputBorder(),
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                              child: const Icon(Icons.remove_red_eye),
                              onTap: () {},
                            ),
                          ),
                        ),
                        const SizedBox(height: 44),
                        ElevatedButton(
                          onPressed: () {
                            context.replaceRoute(const MainRoute());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundPrimary,
                            fixedSize: const Size(280, 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Đăng Nhập",
                            style: TextStyle(color: Colors.brown),
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            context.pushRoute(const RegisterRoute());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundPrimary,
                            fixedSize: const Size(280, 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Đăng Kí",
                            style: TextStyle(color: Colors.brown),
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: const Size(280, 32),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Assets.images.google.image(height: 14),
                              const Text(
                                "Đăng nhập bằng Google",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('🇻🇳 UI Farm Ho Chi Minh city 🇻🇳'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
