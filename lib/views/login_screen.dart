import 'package:academic/controllers/authentication_controller.dart';
import 'package:academic/controllers/theme_controller.dart';
import 'package:academic/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:academic/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final ThemeController _themeController = Get.find<ThemeController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool obscureText = true.obs;
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  void togglePassword() {
    obscureText.value = !obscureText.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Image.asset(
                  'assets/images/science.gif',
                  width: 200,
                ),
              ),
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
                          const SizedBox(
                            height: 1,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(26, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: lightBlueColor,
                              ),
                            ),
                            child: TextFormField(
                                controller: emailController,
                                cursorColor: lightBlueColor,
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  focusColor: Colors.white,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Email Address',
                                  prefixIcon: Icon(Icons.email_outlined),
                                  border: InputBorder.none,
                                ),
                                validator: (val) => val!.isEmpty
                                    ? 'Email tidak boleh kosong.'
                                    : null),
                          ),
                          const SizedBox(
                            height: 15, //<-- SEE HERE
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(26, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: lightBlueColor,
                              ),
                            ),
                            child: Obx(
                              () => TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                controller: passwordController,
                                cursorColor: lightBlueColor,
                                obscureText: obscureText.value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.key),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  suffixIcon: InkWell(
                                    onTap: togglePassword,
                                    child: Icon(
                                      obscureText.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: blueColor,
                                    ),
                                  ),
                                ),
                                validator: (val) => val!.isEmpty
                                    ? 'Password tidak boleh kosong.'
                                    : null,
                                // onSaved: (val) => _password = val!,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15, //<-- SEE HERE
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                AuthController.instance.login(
                                  emailController.text.trim(),
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
                                  'Login',
                                  style: GoogleFonts.sora(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: whiteColor),
                                ),
                              ),
                            ),
                          ),

                          Row(children: [
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 15.0),
                                  child: const Divider(
                                    color: Colors.black,
                                    height: 50,
                                  )),
                            ),
                            Text(
                              'OR',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: blackColor),
                            ),
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 15.0, right: 10.0),
                                  child: const Divider(
                                    color: Colors.black,
                                    height: 50,
                                  )),
                            ),
                          ]),
                          // SizedBox(
                          //   height: 18,
                          // ),
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
                          const SizedBox(
                            height: 18,
                          ),
                          GestureDetector(
                            onTap: () {
                              AuthController.instance.loginAnonymous();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Masuk Sebagai Tamu',
                                  style: GoogleFonts.sora(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: whiteColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Belum punya akun? ',
                                style: GoogleFonts.sora(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: blackColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const RegisterScreen());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: brownColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    'Daftar sekarang',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
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
            ],
          )),
    );
  }
}
