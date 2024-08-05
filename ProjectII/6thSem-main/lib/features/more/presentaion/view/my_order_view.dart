import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/theme_constant.dart';
import 'package:foodrush/config/router/app_route.dart';
import 'package:foodrush/core/common/snackbar/my_snackbar.dart';
import 'package:foodrush/features/more/presentaion/view_model/order_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrderView extends ConsumerStatefulWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyOrderViewState();
}

List<String> addtocart = [];

class _MyOrderViewState extends ConsumerState<MyOrderView> {
  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      addtocart = prefs.getStringList('storedData') ?? [];
    });
  }

  List itemArr = [
    {"name": "Beef Burger", "qty": "1", "price": 16.0},
    {"name": "Classic Burger", "qty": "1", "price": 14.0},
    {"name": "Cheese Chicken Burger", "qty": "1", "price": 17.0},
    {"name": "Chicken Legs Basket", "qty": "1", "price": 15.0},
    {"name": "French Fries Large", "qty": "1", "price": 6.0}
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.watch(orderViewModelProvider).showMessage) {
        showSnackBar(message: 'Order Successfully', context: context);
        ref.read(orderViewModelProvider.notifier).resetMessage(false);
      }
    });
    return Scaffold(
      backgroundColor: ThemeConstant.white,
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: addtocart.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = jsonDecode(addtocart[index]);
                num totalPrice =
                    num.parse(item['FoodQTY']) * (item['foodPrice'] ?? 0.0);

                return ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              item['foodImageUrl']!,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 16.0), // Add some space between image and text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['foodName'] ?? ''),
                            const SizedBox(height: 8.0),
                            Text(item['foodDescription'] ?? ''),
                            const SizedBox(height: 8.0),
                            Text('Quantity: ${item['FoodQTY'] ?? ''}'),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text('\$${item['foodPrice']} each'),
                                const SizedBox(width: 10),
                                Text(
                                    'Total: \$${totalPrice.toStringAsFixed(2)}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                print('Items in the cart:');
                for (String itemString in addtocart) {
                  Map<String, dynamic> item = jsonDecode(itemString);
                  print(
                      '${item['foodName']} - Quantity: ${item['FoodQTY']} - Price: \$${item['foodPrice']} each');
                }
                ref.read(orderViewModelProvider);
                Navigator.pushNamed(context, AppRoute.paymentRoute);
              },
              child: const Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}
