import 'package:academic/controllers/authentication_controller.dart';
import 'package:academic/controllers/theme_controller.dart';
import 'package:academic/theme.dart';
import 'package:academic/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterScreen> {
  final ThemeController _themeController = Get.find<ThemeController>();

  final _formKey = GlobalKey<FormState>();
  late String _password;
  late String _passwordConfirm;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  // Toggles the password show status
  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _togglePasswordConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();

  @override
  initState() {
    super.initState();
    _password = '';
    _passwordConfirm = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/logo.png'),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(26, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: lightBlueColor,
                              ),
                            ),
                            // Email or Phone Number
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                cursorColor: blueColor,
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email Address',
                                  hintStyle: GoogleFonts.sora(),
                                  prefixIcon: Icon(Icons.email_outlined),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Email atau nomor telepon tidak boleh kosong';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Name input
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(26, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: lightBlueColor,
                              ),
                            ),
                            // Email or Phone Number
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                cursorColor: Color.fromARGB(255, 0, 0, 0),
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusColor: Colors.white,
                                  labelStyle: GoogleFonts.sora(),
                                  hintText: 'Full Name',
                                  hintStyle: GoogleFonts.sora(),
                                  prefixIcon: Icon(Icons.person),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Nama tidak boleh kosong';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Password
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(26, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: lightBlueColor,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 2.0),
                              child: TextFormField(
                                cursorColor: Color.fromARGB(255, 0, 0, 0),
                                controller: passwordController,
                                obscureText: _obscureTextPassword,
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: InkWell(
                                    onTap: _togglePassword,
                                    child: Icon(
                                      _obscureTextPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: blueColor,
                                    ),
                                  ),
                                  labelStyle: GoogleFonts.sora(),
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.sora(),
                                  prefixIcon: Icon(Icons.key),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Kata sandi tidak boleh kosong';
                                  }
                                  if (val.length < 6) {
                                    return 'Kata sandi terlalu pendek.';
                                  }
                                  return null;
                                },
                                onChanged: (val) => _password = val,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Confirm Password
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(26, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: lightBlueColor,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 2.0),
                              child: TextFormField(
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                cursorColor: blueColor,
                                controller: passwordConfirmController,
                                obscureText: _obscureTextConfirmPassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  suffixIcon: InkWell(
                                    onTap: _togglePasswordConfirm,
                                    child: Icon(
                                      _obscureTextConfirmPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: blueColor,
                                    ),
                                  ),
                                  labelStyle: GoogleFonts.sora(),
                                  hintText: 'Confirmation Password',
                                  hintStyle: GoogleFonts.sora(),
                                  prefixIcon: Icon(Icons.key),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Konfirmasi kata sandi tidak boleh kosong';
                                  }
                                  if (val != _password) {
                                    return 'Konfirmasi kata sandi tidak sesuai';
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _passwordConfirm = val!;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Register Button
                          GestureDetector(
                            onTap: () {
                              // TODO: check if allowed to register
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                AuthController.instance.register(
                                  emailController.text.trim(),
                                  nameController.text.trimRight(),
                                  passwordController.text.trim(),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 54,
                              decoration: const BoxDecoration(
                                  color: blueColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: GoogleFonts.sora(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: whiteColor),
                                ),
                              ),
                            ),
                          ),
                          // Policy
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    color: blackColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'ATAU',
                                    style: GoogleFonts.sora(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              AuthController.instance.loginWithGoogle();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 44,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/google.png',
                                      width: 19),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Sign in with Google',
                                    style: GoogleFonts.sora(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: blackColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Redirect to login page
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Kamu sudah punya akun? ',
                                  style: GoogleFonts.sora(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => LoginScreen());
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.sora(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: blueColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
