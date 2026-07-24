import 'package:communityos/pages/otp_verification_page.dart';
import 'package:communityos/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:communityos/animation/ripple_route.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  InputDecoration buildInput(String hint, {IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white60),
      prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.08),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight - 50),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
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
                                  "Create Your Account",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 30),

                                // NAME ROW
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _firstNameController,
                                        style: const TextStyle(color: Colors.white),
                                        decoration: buildInput("First Name"),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        controller: _lastNameController,
                                        style: const TextStyle(color: Colors.white),
                                        decoration: buildInput("Last Name"),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 15),

                                TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: buildInput("Email", icon: Icons.email_outlined),
                                ),

                                const SizedBox(height: 15),

                                TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: buildInput("Mobile Number", icon: Icons.phone),
                                ),

                                const SizedBox(height: 25),

                                SignUpButtonWidget(
                                  phoneController: _phoneController,
                                ),

                                const SizedBox(height: 20),

                                const FacebookGoogleLogin(),

                                const SizedBox(height: 22),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account? ",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          RippleRoute(
                                            page: const SignInPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Sign In",
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpButtonWidget extends StatelessWidget {
  final TextEditingController phoneController;

  const SignUpButtonWidget({
    super.key,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          final phone = phoneController.text.trim();

          if (phone.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please enter your mobile number")),
            );
            return;
          }

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OtpverificationPage(
                phoneNumber: phone,
              ),
            ),
                (route) => false,
          );
        },
        child: const Text(
          "SIGN UP",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
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