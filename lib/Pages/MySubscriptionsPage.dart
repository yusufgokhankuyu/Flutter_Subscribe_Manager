import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subscribe_manager/Components/MyBottomNavigationBar.dart';
import 'package:subscribe_manager/Models/subscription.dart';
import 'package:subscribe_manager/Pages/PaymentPlanPage.dart';
import 'package:subscribe_manager/utils/database_helper_subscription.dart';

class MySubscriptionsPage extends StatefulWidget {
  const MySubscriptionsPage({super.key});

  @override
  State<MySubscriptionsPage> createState() => _MySubscriptionsPageState();
}

class _MySubscriptionsPageState extends State<MySubscriptionsPage> {
  List<Subscription>? allSubscription;
  late DatabaseHelperSubscription databaseHelperSubscription;

  Map<String, String> platformImages = <String, String>{
    "Netflix": "assets/images/netflix.png",
    "Spotify": "assets/images/spotify.png",
    "Youtube Premium": "assets/images/youtube_premium.png",
    "Youtube Music": "assets/images/youtube_music.png",
    "Amazon Prime": "assets/images/amazon_prime.png",
    "Disney Plus": "assets/images/disney_plus.png",
    "LinkedIn": "assets/images/linkedin.png",
    "Phone": "assets/images/phone.png",
    "Internet": "assets/images/internet.png",
    "Electric": "assets/images/electric.png",
    "Water": "assets/images/water.png"
  };
  @override
  void initState() {
    super.initState();
    databaseHelperSubscription = DatabaseHelperSubscription();
    updateSubscriptionList();
  }

  @override
  Widget build(BuildContext context) {
    if (allSubscription == null) {
      allSubscription = <Subscription>[];
      updateSubscriptionList();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title: Text(
          "My Subscriptions",
          style: GoogleFonts.quicksand(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: allSubscription!.length,
          itemBuilder: (context, index) {
            String platformName = allSubscription![index].platform_Name;

            String? imagePath = platformImages[platformName];

            Widget platformImage = Image.asset(
              imagePath ?? "assets/images/default_image.png",
              width: 100,
              height: 100,
            );
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          platformImage,
                          Column(
                            children: [
                              Text(
                                "Start Date: " +
                                    allSubscription![index].start_Date,
                                style: GoogleFonts.quicksand(fontSize: 20),
                              ),
                              Text(
                                "End Date: " +
                                    allSubscription![index].finish_Date,
                                style: GoogleFonts.quicksand(fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentPlanPage(
                                          platformName: allSubscription![index]
                                              .platform_Name,
                                          imageUrl: imagePath,
                                          startDate: allSubscription![index]
                                              .start_Date,
                                          endDate: allSubscription![index]
                                              .finish_Date,
                                          isMonthlySelected:
                                              allSubscription![index]
                                                  .frequency),
                                    ));
                              },
                              child: Text(
                                "Update",
                                style: GoogleFonts.quicksand(
                                    fontSize: 18, color: Colors.white),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                deleteDialog(
                                    allSubscription![index].platform_Name);

                                // DatabaseHelperSubscription().deleteSubscription(
                                //     );
                              },
                              child: Text(
                                "Delete",
                                style: GoogleFonts.quicksand(
                                    fontSize: 18, color: Colors.white),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );

            // Text(
            //     "${allSubscription![index].frequency} ${allSubscription![index].ID} ${allSubscription![index].platform_Name}, start date: ${allSubscription![index].start_Date}, finish: ${allSubscription![index].finish_Date}");
          }),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  void updateSubscriptionList() {
    DatabaseHelperSubscription().getSubscriptionList().then((subscriptionList) {
      setState(() {
        allSubscription = subscriptionList;
      });
    });
  }

  void deleteDialog(String plarformName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AlertDialog oluştur
        return CupertinoAlertDialog(
          title: Text(
            "Are you sure to delete?",
            style: GoogleFonts.quicksand(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Text("You want to delete '$plarformName' subscription?"),
          actions: [
            // İptal butonu
            TextButton(
              onPressed: () {
                // AlertDialog'ı kapat
                Navigator.of(context).pop();
              },
              child: Text(
                "İptal",
                style: GoogleFonts.quicksand(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            // Silme butonu
            TextButton(
              onPressed: () {
                DatabaseHelperSubscription().deleteSubscription(plarformName);

                updateSubscriptionList();
                Navigator.of(context).pop();
              },
              child: Text(
                "Sil",
                style: TextStyle(
                    color: Colors
                        .red), // Silme işaretli bir buton için kırmızı renk kullanabilirsiniz
              ),
            ),
          ],
        );
      },
    );
  }
}
