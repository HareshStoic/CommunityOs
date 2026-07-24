import 'package:flutter/material.dart';
import 'package:communityos/pages/home_page.dart';
import 'package:communityos/animation/ripple_route.dart';

// import 'package:communityos/apiService/api_service.dart';

class OtpverificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpverificationPage({
    super.key,
    // required this.onThemeChanged,

    required this.phoneNumber,
  });

  @override
  State<OtpverificationPage> createState() => _OtpverificationPageState();
}

class _OtpverificationPageState extends State<OtpverificationPage> {
  final List<TextEditingController> otpControllers = List.generate(
    5,
        (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 55,
      height: 60,
      child: TextField(
        controller: otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          color: Colors.deepPurple,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 4) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// Background — same gradient as SignInPage
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

          /// Floating Card
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
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
                              Icons.lock_outline_rounded,
                              color: Colors.deepPurple,
                              size: 32,
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            "Verify Your Number",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            "We've sent a 5-digit verification code to your mobile number.\nEnter the code below to continue.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(5, (index) => otpBox(index)),
                          ),

                          const SizedBox(height: 8),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Resend OTP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
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
                                Navigator.pushReplacement(
                                  context,
                                  RippleRoute(
                                      page: const HomePage()
                                    // builder: (context) => HomePage(),
                                      // phoneNumber: _phoneController.text.trim(),
                                  ),
                                );
                              },

                              // onPressed: () async {
//                         //   String enteredOtp = otpControllers
//                         //       .map((e) => e.text)
//                         //       .join();
//                         //
//                         //   if (enteredOtp.length != 5) {
//                         //     ScaffoldMessenger.of(context).showSnackBar(
//                         //       const SnackBar(
//                         //         content: Text("Enter 5 digit OTP"),
//                         //       ),
//                         //     );
//                         //     return;
//                         //   }
//                         //
//                         //   // ✅ Save these BEFORE the await
//                         //   final navigator = Navigator.of(context);
//                         //   final messenger = ScaffoldMessenger.of(context);
//                         //
//                         //   bool success = await ApiService.verifyOtp(
//                         //     widget.phoneNumber,
//                         //     enteredOtp,
//                         //   );
//                         //
//                         //   if (!mounted) return;
//                         //
//                         //   if (success) {
//                         //     navigator.pushAndRemoveUntil(
//                         //       MaterialPageRoute(
//                         //         builder: (_) => HomePage(
//                         //           onThemeChanged: widget.onThemeChanged,
//                         //         ),
//                         //       ),
//                         //           (route) => false,
//                         //     );
//                         //   } else {
//                         //     messenger.showSnackBar(
//                         //       const SnackBar(content: Text("Invalid OTP")),
//                         //     );
//                         //   }
//                         // },

                              child: const Text(
                                "VERIFY OTP",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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