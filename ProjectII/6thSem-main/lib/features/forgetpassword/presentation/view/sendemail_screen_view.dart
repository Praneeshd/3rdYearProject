import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/common/snackbar/my_snackbar.dart';
import 'package:foodrush/features/forgetpassword/presentation/view_model/sendemail_viewmodel.dart';

class SendEmailScreenView extends ConsumerStatefulWidget {
  const SendEmailScreenView({Key? key}) : super(key: key);

  @override
  _SendEmailScreenViewState createState() => _SendEmailScreenViewState();
}

class _SendEmailScreenViewState extends ConsumerState<SendEmailScreenView> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailState = ref.watch(emailViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (emailState.showMessage! && emailState.error != null) {
        showSnackBar(message: 'Invalid email', context: context);
        ref.read(emailViewModelProvider.notifier).resetMessage(false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Email'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'An email will be sent with instructions to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(emailViewModelProvider.notifier)
                          .sendemailuser(context, emailController.text);
                    }
                  },
                  child: const Text('Send Email'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
