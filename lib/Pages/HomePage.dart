import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subscribe_manager/Components/MyBottomNavigationBar.dart';
import 'package:subscribe_manager/Constants/constants.dart';
import 'package:subscribe_manager/Pages/MySubscriptionsPage.dart';
import 'package:subscribe_manager/Pages/PlatformDetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.appBarColor,
        title: Text("Subscriber Manager", style: Constants.googleFontsStyle),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: Constants.appBarColor,
              ),
              padding: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Select platform and choose start and end date of your subsbcription",
                      style: GoogleFonts.quicksand(
                          fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Social Media Platforms",
                  style: GoogleFonts.quicksand(fontSize: 24),
                ),
                Icon(Icons.arrow_right_alt_rounded)
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/netflix.png",
                                  platfromName: "Netflix")));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Image.asset("assets/images/netflix.png"),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/spotify.png",
                                  platfromName: "Spotify")));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Image.asset("assets/images/spotify.png"),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/youtube_premium.png",
                                  platfromName: "Youtube Premium")));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Image.asset("assets/images/youtube_premium.png"),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/youtube_music.png",
                                  platfromName: "Youtube Music")));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Image.asset("assets/images/youtube_music.png"),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/amazon_prime.png",
                                  platfromName: "Amazon Prime")));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Image.asset("assets/images/amazon_prime.png"),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/disney_plus.png",
                                  platfromName: "Disney Plus")));
                    },
                    child: Container(
                      color: Colors.blue,
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Image.asset("assets/images/disney_plus.png"),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/linkedin.png",
                                  platfromName: "LinkedIn")));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.5,
                      child: Image.asset("assets/images/linkedin.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Other Subscriptions",
                  style: GoogleFonts.quicksand(fontSize: 24),
                ),
                Icon(Icons.arrow_right_alt_rounded)
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/phone.png",
                                  platfromName: "Phone")));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width / 2.5,
                          child: Image.asset("assets/images/phone.png"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Phone",
                          style: GoogleFonts.quicksand(
                              fontSize: 24, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/internet.png",
                                  platfromName: "Internet")));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width / 2.5,
                          child: Image.asset("assets/images/internet.png"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Internet",
                          style: GoogleFonts.quicksand(
                              fontSize: 24, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/electric.png",
                                  platfromName: "Electric")));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width / 2.5,
                          child: Image.asset("assets/images/electric.png"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Electric",
                          style: GoogleFonts.quicksand(
                              fontSize: 24, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlatformDetailPage(
                                  imageUrl: "assets/images/water.png",
                                  platfromName: "Water")));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width / 2.5,
                          child: Image.asset("assets/images/water.png"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Water",
                          style: GoogleFonts.quicksand(
                              fontSize: 24, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => PlatformDetailPage(
                  //                 imageUrl: "assets/images/amazon_prime.png",
                  //                 platfromName: "Amazon Prime")));
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     width: MediaQuery.sizeOf(context).width / 2.5,
                  //     child: Image.asset("assets/images/amazon_prime.png"),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => PlatformDetailPage(
                  //                 imageUrl: "assets/images/disney_plus.png",
                  //                 platfromName: "Disney Plus")));
                  //   },
                  //   child: Container(
                  //     color: Colors.blue,
                  //     height: 50,
                  //     width: MediaQuery.sizeOf(context).width / 2.5,
                  //     child: Image.asset("assets/images/disney_plus.png"),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => PlatformDetailPage(
                  //                 imageUrl: "assets/images/linkedin.png",
                  //                 platfromName: "LinkedIn")));
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     width: MediaQuery.sizeOf(context).width / 2.5,
                  //     child: Image.asset("assets/images/linkedin.png"),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
