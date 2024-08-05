import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/router/app_route.dart';
import 'package:foodrush/core/common/snackbar/my_snackbar.dart';
import 'package:foodrush/features/auth/presentation/view/helpers/biometic_helper.dart';
import 'package:foodrush/features/auth/presentation/view_model/auth_viewmodel.dart';
import 'package:foodrush/features/forgetpassword/presentation/view/sendemail_screen_view.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool showBiometric = false;
  bool isAuthenticated = false;

  @override
  void initState() {
    isBiometricsAvailable();
    super.initState();
  }

  isBiometricsAvailable() async {
    showBiometric = await BiometricHelper().hasEnrolledBiometrics();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authState.showMessage! && authState.error != null) {
        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
        ref.read(authViewModelProvider.notifier).resetMessage(false);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/login.png',
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      color: Colors.black,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(authViewModelProvider.notifier)
                            .loginuser(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xFF5B8F37)),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  if (showBiometric)
                    ElevatedButton(
                      onPressed: () async {
                        isAuthenticated =
                            await BiometricHelper().authenticate();
                        if (isAuthenticated) {
                          // If authentication is successful, navigate to the Dashboard.
                          Navigator.of(context).pushReplacementNamed(
                              '/home'); // Use the appropriate route name for your dashboard screen.
                        }
                        setState(
                            () {}); // This will refresh the UI based on the authentication result.
                      },
                      child: const Text('Login with Biometrics'),
                    ),
                  if (isAuthenticated)
                    const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text(
                        'Well done!, Authenticated',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.registerRoute);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SendEmailScreenView(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
