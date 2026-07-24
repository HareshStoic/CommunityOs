import 'package:flutter/material.dart';
import 'package:communityos/widgets/qr_scanner_page.dart';

class MyAccessCard extends StatelessWidget {
  const MyAccessCard({super.key});

  static const Color primaryPurple = Color(0xFF6C5DD3);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF7B6EF6), Color(0xFF6C5DD3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child:Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Access",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Show QR to Enter",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 16),

                // Arrow button — navigates to scanner
                Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const QrScannerPage()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: primaryPurple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // QR code display box — separate widget, no tap logic
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: const Icon(Icons.qr_code_2, size: 64, color: Colors.black87),
          // ),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const QrScannerPage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.qr_code_2,
                  size: 64,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}