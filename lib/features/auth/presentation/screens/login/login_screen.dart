import 'package:flutter_pat_application/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_pat_application/features/auth/data/models/reqlogin.dart';
import 'package:flutter_pat_application/features/auth/providers/login_controller.dart';
import 'package:flutter_pat_application/features/shared/providers/state/login_state.dart';
import 'package:flutter_pat_application/shared/widgets/custom_text_default.dart';
import 'package:flutter_pat_application/shared/widgets/textFrom/custom_text_form_field.dart';
import 'package:flutter_pat_application/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/widgets/logo/logo_create_pin.dart';
// สำหรับ kIsWeb และ defaultTargetPlatform

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isIconTrue = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      ref
          .read(loginControllerProvider.notifier)
          .login(Reqlogin(username: username, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    ref.listen<LoginState>(loginControllerProvider, (previous, next) {
      if (next.resLoginModel?.isSuccess == true) {
        context.goNamed(AppRouter.mainPageScreen);
      } else if (next.isError) {
        context.goNamed(AppRouter.mainPageScreen);

        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.resLoginModel?.message ?? "Login failed")));
      }
    });

    // ref.listen(loginControllerProvider, (previous, next) {

    //   next.whenOrNull(
    //     data: (res) {
    //       if (res?.isSuccess ?? false) {
    //         Navigator.pushNamed(context, AppRouter.navigationBar);
    //       } else {
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res?.message ?? "Login failed")));
    //       }
    //     },
    //     error: (err, _) {
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $err')));
    //     },
    //   );
    // });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE6EFF5), // Light blue background
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Color(0xFF009ADB)),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 40.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LogoCreatePinWidget(),
                        // Image.asset(
                        //   "lib/assets/images/pat_logo_image.png",
                        //   width: 150,
                        //   height: 150,
                        //   fit: BoxFit.contain,
                        //   errorBuilder: (context, error, stackTrace) =>
                        //       const Icon(Icons.image_not_supported, size: 100),
                        // ),
                        const SizedBox(height: 20),
                        const CustomTextDefault(
                          text: "เข้าสู่ระบบ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF009ADB),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextFormField(
                          controller: _usernameController,
                          hintText: 'Enter your Email',
                          obscureText: false,
                          inputDecoration: inputDecoration(
                            nameImage: "lib/assets/icons/ic_login_email.svg",
                            context,
                            hintText: "อีเมล",
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _passwordController,
                          obscureText: isIconTrue,
                          inputDecoration: inputDecoration(
                            nameImage: "lib/assets/icons/ic_login_password.svg",
                            context,
                            hintText: "รหัสผ่าน",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() => isIconTrue = !isIconTrue);
                              },
                              icon: Icon(
                                isIconTrue
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Forgot password navigation
                            },
                            child: const Text(
                              'ลืมรหัสผ่าน ?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF009ADB).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            gradient: loginState.isLoading
                                ? null
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFF009ADB),
                                      Color(0xFF00B4FF),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                            color: loginState.isLoading ? Colors.grey : null,
                          ),
                          child: ElevatedButton(
                            onPressed: loginState.isLoading ? null : _onLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: loginState.isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : const CustomTextDefault(
                                    text: 'เข้าสู่ระบบ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
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
      ),
    );
  }
}

//   void loadLogin() async {
//     setState(() {
//       _isSubmit = false;
//       _isLogin = false; // Set loading state to true
//     });

//     try {
//       final response = await repository.getLoginUser(
//         Reqlogin(username: _usernameController.text, password: _passwordController.text),
//       );

//       setState(() {
//         _isLogin = false; // Stop loading
//       });

//       if (response.isSuccess) {
//         if (mounted) {
//           print("Login Success");
//           Navigator.pushNamed(context, AppRouter.navigationBar);
//         }
//         return;
//       }

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message)));
//       }
//     } catch (e) {
//       setState(() {
//         _isLogin = false; // Stop loading in case of an error
//       });

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//       }
//     }
//   }
// }
