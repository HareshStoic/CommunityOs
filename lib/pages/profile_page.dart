import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:communityos/animation/ripple_route.dart';
import 'package:communityos/pages/sign_in_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color primaryPurple = Color(0xFF6C5DD3);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
  TextEditingController(text: "Harsh Singh");
  final TextEditingController _phoneController =
  TextEditingController(text: "+91 62024 47610");
  final TextEditingController _emailController =
  TextEditingController(text: "harsh.singh@example.com");
  final TextEditingController _dobController =
  TextEditingController(text: "15 Aug 2007");
  final TextEditingController _addressController =
  TextEditingController(text: "B-204, Green Valley Apartments, Bengaluru");
  final TextEditingController _emergencyContactController =
  TextEditingController(text: "+91 98765 43210");

  DateTime? _selectedDob;

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not pick image: $e")),
      );
    }
  }

  Future<void> _pickDob() async {
    if (!_isEditing) return;

    final initialDate = _selectedDob ?? DateTime(1998, 8, 15);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme(
              brightness: isDark ? Brightness.dark : Brightness.light,
              primary: primaryPurple,
              onPrimary: Colors.white,
              secondary: primaryPurple,
              onSecondary: Colors.white,
              surface: Theme.of(context).cardColor,
              onSurface: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
              error: Colors.red,
              onError: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDob = pickedDate;
        _dobController.text =
        "${pickedDate.day.toString().padLeft(2, '0')} "
            "${_monthName(pickedDate.month)} ${pickedDate.year}";
      });
    }
  }

  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    return months[month - 1];
  }

  void _showImageSourceSheet() {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined, color: primaryPurple),
                  title: Text("Take a Photo", style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined, color: primaryPurple),
                  title: Text("Choose from Gallery", style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                if (_profileImage != null)
                  ListTile(
                    leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    title: const Text("Remove Photo", style: TextStyle(color: Colors.redAccent)),
                    onTap: () {
                      setState(() => _profileImage = null);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isEditing = false);
      FocusScope.of(context).unfocus();

      // TODO: send updated name/phone/email/dob/address/emergencyContact/profileImage to your backend here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: theme.textTheme.bodyLarge?.color),
        actions: [
          TextButton(
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                setState(() => _isEditing = true);
              }
            },
            child: Text(
              _isEditing ? "Save" : "Edit",
              style: const TextStyle(
                color: primaryPurple,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: primaryPurple.withValues(alpha: 0.12),
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const NetworkImage("https://i.pravatar.cc/150?img=12")
                    as ImageProvider,
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _showImageSourceSheet,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryPurple,
                            shape: BoxShape.circle,
                            border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildLabel(theme, "Full Name"),
            _buildTextField(
              theme: theme,
              controller: _nameController,
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Name cannot be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 18),

            _buildLabel(theme, "Date of Birth"),
            GestureDetector(
              onTap: _pickDob,
              child: AbsorbPointer(
                child: _buildTextField(
                  theme: theme,
                  controller: _dobController,
                  icon: Icons.cake_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Date of birth cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 18),

            _buildLabel(theme, "Mobile Number"),
            _buildTextField(
              theme: theme,
              controller: _phoneController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Phone number cannot be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 18),

            _buildLabel(theme, "Email Address"),
            _buildTextField(
              theme: theme,
              controller: _emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Email cannot be empty";
                }
                if (!value.contains("@") || !value.contains(".")) {
                  return "Enter a valid email address";
                }
                return null;
              },
            ),
            const SizedBox(height: 18),

            _buildLabel(theme, "Address"),
            _buildTextField(
              theme: theme,
              controller: _addressController,
              icon: Icons.home_outlined,
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Address cannot be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 18),

            _buildLabel(theme, "Emergency Contact Number"),
            _buildTextField(
              theme: theme,
              controller: _emergencyContactController,
              icon: Icons.contact_phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Emergency contact cannot be empty";
                }
                return null;
              },
            ),

            if (_isEditing) ...[
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _saveProfile,
                  child: const Text("Save Changes", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],

            const SizedBox(height: 24),

            Material(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    RippleRoute(page: const SignInPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.logout, color: Colors.redAccent, size: 22),
                      SizedBox(width: 14),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required ThemeData theme,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: _isEditing,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge?.color),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: primaryPurple, size: 20),
        filled: true,
        fillColor: _isEditing
            ? theme.cardColor
            : (theme.brightness == Brightness.dark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.shade100),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
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
          borderSide: const BorderSide(color: primaryPurple, width: 1.5),
        ),
      ),
    );
  }
}