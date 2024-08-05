import 'dart:async';
import 'dart:convert';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/theme_constant.dart';
import 'package:foodrush/config/router/app_route.dart';
import 'package:foodrush/core/common/provider/is_dark_theme.dart';
import 'package:foodrush/features/home/domain/entity/home_entity.dart';
import 'package:foodrush/features/home/presentation/view_model/home_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  String qty = '1';
  final gap = const SizedBox(height: 8);
  late StreamSubscription<AccelerometerEvent> _accelerationSubscription;
  List<String> addtocart = [];
  late bool isDark;

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      addtocart = prefs.getStringList('storedData') ?? [];
    });
  }

  Future<void> _addToCart(HomeEntity items, String qty) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    addtocart = prefs.getStringList('storedData') ?? [];
    Map<String, dynamic> itemsMap = {
      "foodId": items.foodId,
      "foodName": items.foodName,
      "foodPrice": items.foodPrice,
      "foodDescription": items.foodDescription,
      "foodCategory": items.foodCategory,
      "foodImageUrl": items.foodImageUrl,
      "foodLocation": items.foodLocation,
      "FoodQTY": qty
    };

    var itemsString = jsonEncode(itemsMap); // Encode Map to JSON
    addtocart.add(itemsString);
    prefs.setStringList('storedData', addtocart);
    _loadData();
  }

  @override
  void initState() {
    super.initState();
    isDark = ref.read(isDarkThemeProvider);
    super.initState();

    // Initialize the sensor listener
    _accelerationSubscription =
        accelerometerEvents!.listen((AccelerometerEvent event) {
      // You can adjust the sensitivity as needed
      if (event.x.abs() > 12.0 ||
          event.y.abs() > 12.0 ||
          event.z.abs() > 12.0) {
        _showLogoutConfirmationDialog();
      }
    });
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action here
                // For example, you can navigate to the login screen
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacementNamed(context, AppRoute.loginRoute);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _accelerationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0 &&
              !homeState.isLoading &&
              !homeState.hasReachedMax) {
            ref.read(homeViewModelProvider.notifier).getAllHome();
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.purple,
          actions: [
            Switch(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                  ref.read(isDarkThemeProvider.notifier).updateTheme(value);
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              greeting(),
              const SizedBox(height: 15),
              const Text(
                "Food",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 0),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(homeViewModelProvider.notifier).resetState();
                    EasyLoading.showSuccess(
                        "Refreshed Successfully".toUpperCase());
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: homeState.hasReachedMax
                        ? homeState.homes.length
                        : homeState.homes.length + 1,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < homeState.homes.length) {
                        List<Color> cardColors = [
                          const Color.fromARGB(255, 130, 239, 80),
                          const Color.fromARGB(255, 87, 233, 61),
                        ];

                        return Card(
                          color: cardColors[index % 2],
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: homeState.homes[index].foodImageUrl != null
                                ? Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          homeState.homes[index].foodImageUrl!,
                                        ),
                                      ),
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.white,
                                  ),
                            title: Text(
                              homeState.homes[index].foodName,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gap,
                                Text(
                                  homeState.homes[index].foodDescription,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Quantity Display
                                DropdownButton<String>(
                                  value: qty,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      qty = newValue!;
                                    });
                                    print(qty);
                                  },
                                  items: <String>['1', '2', '3', '4']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    _addToCart(homeState.homes[index], qty);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    elevation: 5,
                                    splashFactory: InkRipple.splashFactory,
                                    backgroundColor:
                                        ThemeConstant.darkPrimaryColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                // Adjust the spacing between buttons
                              ],
                            ),
                          ),
                        );
                      } else {
                        // Loading indicator for additional data
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget greeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 0 && hour < 12) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Good morning!",
              style: TextStyle(
                  color: ThemeConstant.darkPrimaryColor,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800),
            ),
            Image.asset(
              "assets/images/night.png",
              width: 30,
              height: 30,
            ),
          ],
        ),
        const Text(
          "User",
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Good Night!",
              style: TextStyle(
                  color: ThemeConstant.primaryText,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w800),
            ),
            Image.asset(
              "assets/images/night.png",
              width: 30,
              height: 30,
            ),
          ],
        ),
        const Text(
          "User",
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
