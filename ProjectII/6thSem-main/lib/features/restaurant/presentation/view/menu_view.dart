import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/theme_constant.dart';
import 'package:foodrush/features/restaurant/presentation/view_model/restaurant_view_model.dart';

class RestaurantView extends ConsumerStatefulWidget {
  const RestaurantView({Key? key}) : super(key: key);

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends ConsumerState<RestaurantView> {
  final ScrollController _scrollController = ScrollController();
  final gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    final restaurantState = ref.watch(restaurantViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0 &&
              !restaurantState.isLoading &&
              !restaurantState.hasReachedMax) {
            ref.read(restaurantViewModelProvider.notifier).getAllRestaurant();
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: ThemeConstant.darkPrimaryColor,
          title: const Text(
            "Restaurants",
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(restaurantViewModelProvider.notifier)
                        .resetState();
                    EasyLoading.showSuccess(
                        "Refreshed Successfully".toUpperCase());
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: restaurantState.hasReachedMax
                        ? restaurantState.restaurants.length
                        : restaurantState.restaurants.length + 1,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < restaurantState.restaurants.length) {
                        List<Color> cardColors = [
                          const Color.fromARGB(255, 236, 184, 184),
                          const Color.fromARGB(255, 208, 153, 153),
                        ];
                        return Card(
                          color: cardColors[index % 2],
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15),
                            leading: restaurantState.restaurants[index]
                                        .restaurantImageUrl !=
                                    null
                                ? Container(
                                    width: 150,
                                    height: 350,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          restaurantState.restaurants[index]
                                              .restaurantImageUrl!,
                                        ),
                                      ),
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.white,
                                  ),
                            title: Text(
                              restaurantState.restaurants[index].restaurantName,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gap,
                                Text(
                                  restaurantState
                                      .restaurants[index].restaurantLocation,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Contact: ${restaurantState.restaurants[index].restaurantContact}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                )
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
            Text(
              "Good morning!",
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
          "Deeya Dangol",
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
          "Deeya Dangol",
          style: TextStyle(
              fontSize: 15,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
