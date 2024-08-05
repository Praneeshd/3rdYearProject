import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/common/snackbar/my_snackbar.dart';
import 'package:foodrush/features/forgetpassword/presentation/view_model/code_viewmodel.dart';

class CodeEntryScreenView extends ConsumerStatefulWidget {
  const CodeEntryScreenView({Key? key}) : super(key: key);

  @override
  _CodeEntryScreenViewState createState() => _CodeEntryScreenViewState();
}
/*// Inside the build method or elsewhere in the destination route
final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

// Access the 'email' parameter
final String email = args?['email'] ?? '';
*/
class _CodeEntryScreenViewState extends ConsumerState<CodeEntryScreenView> {
  TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final codeState = ref.watch(resetCodeViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (codeState.showMessage != null && codeState.error != null) {
        showSnackBar(message: 'Invalid code', context: context);
        ref.read(resetCodeViewModelProvider.notifier).resetMessage(false);
      }
    }
    );
    final String email = args?['email'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the 4-digit code that has been sent to you:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: codeController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: 'Code',
                  hintText: 'Enter 4-digit code',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Open Sans',
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value == null || value.length != 4) {
                    return 'Please enter a valid 4-digit code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref
                        .read(resetCodeViewModelProvider.notifier)
                        .sendresetCode(context, codeController.hashCode,email);
                  }
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
