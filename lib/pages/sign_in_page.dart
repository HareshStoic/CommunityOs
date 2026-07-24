import 'package:communityos/pages/sign_up_page.dart';
// import 'package:communityos/apiService/api_service.dart';
// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:communityos/animation/ripple_route.dart';
import 'package:communityos/pages/otp_verification_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});


  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{
    // with SingleTickerProviderStateMixin {
  // late AnimationController controller;
  final TextEditingController _phoneController = TextEditingController();
  bool rememberMe = false;

  // @override
  // void initState() {
  //   super.initState();
  //
  //   controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 6),
  //   )..repeat();
  // }

  @override
  void dispose() {
    // controller.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Widget ripple(double size, double delay) {
  //   return AnimatedBuilder(
  //     animation: controller,
  //     builder: (context, child) {
  //       double value = (controller.value + delay) % 1;
  //
  //       return Container(
  //         width: size * value,
  //         height: size * value,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           border: Border.all(
  //             color: Colors.white.withValues(alpha: 1 - value),
  //             width: 2,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget buildTextField() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "Phone Number",
        prefixIcon: const Icon(Icons.phone),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff5B4DFF),
                  Color(0xff8A55FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// Ripples
          // Center(
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       ripple(700, 0.0),
          //       ripple(700, 0.25),
          //       ripple(700, 0.5),
          //       ripple(700, 0.75),
          //     ],
          //   ),
          // ),

          /// Floating Card
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  splashColor: Colors.white24,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white30,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.apartment,
                              color: Colors.deepPurple,
                              size: 32,
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            "CommunityOS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            "Welcome Back",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 30),

                          buildTextField(),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  RippleRoute(page: OtpverificationPage(
                                    phoneNumber: _phoneController.text.trim(),
                                  ),
                                  ),
                                );
                              },
                              child: const Text(
                                "SIGN IN",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // REMEMBER ME
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                                activeColor: const Color(0xFFff4d6d),
                              ),
                              const Expanded(
                                child: Text(
                                  "Remember my login for faster sign-in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          const FacebookGoogleLogin(),

                          const SizedBox(height: 22),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: TextStyle(color: Colors.white70),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    RippleRoute(
                                      page: SignUpPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign up?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
class FacebookGoogleLogin extends StatelessWidget {
  const FacebookGoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.white30)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Or", style: TextStyle(color: Colors.white70)),
            ),
            Expanded(child: Divider(color: Colors.white30)),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              child: FaIcon(
                FontAwesomeIcons.facebookF,
                color: Colors.deepPurple,
                size: 24,
              ),
            ),
            const SizedBox(width: 30),
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              child: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.deepPurple,
                size: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}