import 'package:crmo/data/models/register_request.dart';
import 'package:crmo/logic/blocs/auth/auth_bloc.dart';
import 'package:crmo/ui/screens/home_screen.dart';
import 'package:crmo/ui/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SignUpProScreen extends StatefulWidget {
  const SignUpProScreen({super.key});

  @override
  State<SignUpProScreen> createState() => _SignUpProScreenState();
}

class _SignUpProScreenState extends State<SignUpProScreen> {
  bool cheched = false;
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final phoneconfirmcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(RegisterEvent(
          request: RegisterRequest(
              name: namecontroller.text,
              phone: phonecontroller.text,
              password: passcontroller.text,
              password_confirmation: phoneconfirmcontroller.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          }
          if (state is AuthError) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(state.message),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/main_icon.png',
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            'WoorkRoom',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        height: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Sign up to WoorkRoom',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'name',
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: namecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Input your name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Opercoder',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'phone number',
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: phonecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Input your phone';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon:
                                      const Icon(CupertinoIcons.eye_slash),
                                  hintText: '1234567890',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'phone number vlaidate',
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: phoneconfirmcontroller,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      phonecontroller.text !=
                                          phoneconfirmcontroller.text) {
                                    return 'Input your phone correctly';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon:
                                      const Icon(CupertinoIcons.eye_slash),
                                  hintText: '1234567890',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Text(
                                'Password',
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: passcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Input your password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  suffixIcon:
                                      const Icon(CupertinoIcons.eye_slash),
                                  hintText: '********',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ZoomTapAnimation(
                                onTap: submit,
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sign In',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: ZoomTapAnimation(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const SignUpScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Don`t have an account?',
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
