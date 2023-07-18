import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soar_mobile/resources/color_manager.dart';
import 'package:soar_mobile/resources/components/custom_button.dart';
import 'package:soar_mobile/resources/controller.dart';
import 'package:soar_mobile/resources/styles_manager.dart';
import 'package:soar_mobile/screens/home.dart';
import 'package:lottie/lottie.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> with TickerProviderStateMixin {
  bool isValidNumber = false;
  bool isCodeSent = false;
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _animationController;

  String? errorText;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      final isLoggedIn = await Controller.login(
          _emailController.text, _passwordController.text);
      if (isLoggedIn) {
        isCodeSent = true;
        _animationController.forward();
        isLoading = false;
        setState(() {});
      } else {
        setState(() {
          errorText = 'Wrong email or password';
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            )).then((value) {
          _animationController.reset();
          setState(() {
            isCodeSent = false;
            isLoading = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            children: [
              // const CustomBackButton(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/illustrations/logo.png',
                      height: 170,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login',
                      style: getBoldStyle(fontSize: 21.5),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 7.0,
                            spreadRadius: 4.5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Error';
                                }
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              errorText: errorText,
                              hintStyle: getRegularStyle(fontSize: 13.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: (isCodeSent)
                                      ? ColorManager.green
                                      : Colors.black54,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Error';
                                }
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText: errorText,
                              hintText: 'Password',
                              hintStyle: getRegularStyle(fontSize: 13.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: (isCodeSent)
                                      ? ColorManager.green
                                      : Colors.black54,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Builder(builder: (context) {
                            if (isLoading) {
                              return const SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (isCodeSent) {
                              return SizedBox(
                                height: 50,
                                width: 50,
                                child: LottieBuilder.asset(
                                  'assets/animations/checked1.json',
                                  controller: _animationController,
                                ),
                              );
                            }
                            return CustomButton(
                              onPressed: () {
                                login();
                              },
                              label: 'Login',
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;
  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      } else {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: newValue.text.substring(0, newValue.text.length - 1),
            selection: TextSelection.collapsed(
              offset: newValue.selection.end - 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
