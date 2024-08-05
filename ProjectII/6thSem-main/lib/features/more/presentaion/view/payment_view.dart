import 'package:flutter/material.dart';
import 'package:foodrush/config/constants/theme_constant.dart';
import 'package:foodrush/features/home/presentation/view/home_view.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String referenceId = "";
  bool cashOnDeliverySelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ThemeConstant.darkPrimaryColor,
        title: const Text(
          "Payment Method",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Add with Khalti",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                payWithKhaltiInApp();
              },
              child: const Text("Pay with Khalti"),
            ),
            CheckboxListTile(
              title: const Text('Cash on Delivery'),
              value: cashOnDeliverySelected,
              onChanged: (value) {
                setState(() {
                  cashOnDeliverySelected = value ?? false;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (cashOnDeliverySelected) {
                  // Implement Cash on Delivery logic here
                  payWithCashOnDelivery();
                } else {
                  // Implement Khalti payment logic here
                  payWithKhaltiInApp();
                }
              },
              child: const Text("Proceed"),
            ),
            Text(referenceId),
          ],
        ),
      ),
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, // in paisa
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  payWithCashOnDelivery() {
    // Implement Cash on Delivery logic here
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cash on Delivery'),
          content: const Text('You will pay with Cash on Delivery.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to HomeView
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const HomeView(), // Replace HomeView with the actual name of your HomeView class
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  referenceId = success.idx;
                });

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
}
