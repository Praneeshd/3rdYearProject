import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/theme_constant.dart';
import 'package:foodrush/features/offer/presentation/view_model/offer_view_model.dart';

class OfferView extends ConsumerStatefulWidget {
  const OfferView({Key? key}) : super(key: key);

  @override
  _OfferViewState createState() => _OfferViewState();
}

class _OfferViewState extends ConsumerState<OfferView> {
  final ScrollController _scrollController = ScrollController();
  final gap = const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    final offerState = ref.watch(offerViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0 &&
              !offerState.isLoading &&
              !offerState.hasReachedMax) {
            ref.read(offerViewModelProvider.notifier).getAllOffer();
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
            "Offer Details",
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
                        .read(offerViewModelProvider.notifier)
                        .resetState();
                    EasyLoading.showSuccess(
                        "Refreshed Successfully".toUpperCase());
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: offerState.hasReachedMax
                        ? offerState.offers.length
                        : offerState.offers.length + 1,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < offerState.offers.length) {
                        List<Color> cardColors = [
                          const Color.fromARGB(255, 236, 184, 184),
                          const Color.fromARGB(255, 208, 153, 153),
                        ];
                        return Card(
                          color: cardColors[index % 2],
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading:
                                offerState.offers[index].foodImageUrl != null
                                    ? Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              offerState
                                                  .offers[index].foodImageUrl!,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const CircleAvatar(
                                        backgroundColor: Colors.white,
                                      ),
                            title: Text(
                              offerState.offers[index].foodName,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gap,
                                Text(
                                  offerState.offers[index].foodDescription,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // Handle the favorite action when the button is pressed
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: ThemeConstant.darkPrimaryColor,
                              ),
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
