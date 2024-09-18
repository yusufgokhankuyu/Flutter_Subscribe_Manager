import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:subscribe_manager/Constants/constants.dart';
import 'package:subscribe_manager/Models/subscription.dart';
import 'package:subscribe_manager/Pages/PaymentPlanofPlatform.dart';
import 'package:subscribe_manager/utils/database_helper_subscription.dart';

class PaymentPlanPage extends StatefulWidget {
  var platformName;
  var imageUrl;
  var startDate;
  var endDate;
  var isMonthlySelected;
  PaymentPlanPage(
      {super.key,
      required this.platformName,
      required this.imageUrl,
      required this.startDate,
      required this.endDate,
      required this.isMonthlySelected});

  @override
  State<PaymentPlanPage> createState() => _PaymentPlanPageState();
}

class _PaymentPlanPageState extends State<PaymentPlanPage> {
  List<Subscription>? allSubscription;
  late DatabaseHelperSubscription databaseHelperSubscription;

  List<String> installmentDates = [];

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
        title: Text("Payment Plan", style: Constants.googleFontsStyle),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                infoDialog(widget.platformName);
              },
              child: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: allSubscription!.length,
        itemBuilder: (context, index) {
          String startDateString = allSubscription![index].start_Date;
          String finishDateString = allSubscription![index].finish_Date;
          String startDateStringFormatted =
              "${startDateString.split("/")[2]}-${startDateString.split("/")[1]}-${startDateString.split("/")[0]}";
          String finishDateStringFormatted =
              "${finishDateString.split("/")[2]}-${finishDateString.split("/")[1]}-${finishDateString.split("/")[0]}";

          DateTime startDate = DateTime.parse(startDateStringFormatted);
          DateTime finishDate = DateTime.parse(finishDateStringFormatted);
          Duration difference = finishDate.difference(startDate);
          int days = difference.inDays;
          int months = difference.inDays ~/ 30;
          int years = difference.inDays ~/ 365;
          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width / 2.3,
                child: Image.asset(widget.imageUrl),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Constants.appBarColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Start Date :",
                        style: GoogleFonts.quicksand(
                            fontSize: 24, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          // _openDatePickerStart(context);
                        },
                        child: Container(
                          child: Text(
                            allSubscription![index].start_Date,
                            style: GoogleFonts.quicksand(
                                fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // _openDatePickerStart(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Constants.appBarColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "End Date :",
                        style: GoogleFonts.quicksand(
                            fontSize: 24, color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          // _openDatePickerEnd(context);
                        },
                        child: Container(
                          child: Text(
                            allSubscription![index].finish_Date,
                            style: GoogleFonts.quicksand(
                                fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // _openDatePickerEnd(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Text('Start Date: ${DateFormat('dd/MM/yyyy').format(startDate)}'),
              // Text('End Date: ${DateFormat('dd/MM/yyyy').format(endDate)}'),
              SizedBox(height: 20),
              // Text('Difference:'),
              Container(
                color: Constants.appBarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Total Days: $days',
                          style: GoogleFonts.quicksand(
                              fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          'Total Months: $months',
                          style: GoogleFonts.quicksand(
                              fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          'Total Years: $years',
                          style: GoogleFonts.quicksand(
                              fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Frequency :",
                    style: GoogleFonts.quicksand(
                        color: Colors.black, fontSize: 24),
                  ),
                  Text(
                    allSubscription![index].frequency,
                    style: GoogleFonts.quicksand(
                        color: Colors.black, fontSize: 24),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentPlanofPlatform(
                                imagePath: widget.imageUrl,
                                platformName:
                                    allSubscription![index].platform_Name,
                                startDate: allSubscription![index].start_Date,
                                endDate: allSubscription![index].finish_Date,
                                isMonthlySelected:
                                    allSubscription![index].frequency)));
                  },
                  child: Text(
                    "Review Installment Plan",
                    style: GoogleFonts.quicksand(
                        color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }

  void updateSubscriptionList() {
    DatabaseHelperSubscription()
        .getSubscriptionListByPlatform(widget.platformName)
        .then((subscriptionList) {
      setState(() {
        allSubscription = subscriptionList;
      });
    });
  }

  void infoDialog(String platformName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AlertDialog oluştur
        return CupertinoAlertDialog(
          title: Text(
            "How can I manage '$platformName' subscription?",
            style: GoogleFonts.quicksand(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Text(
              "This page provides information about the platform you have previously subscribed to. You can view the start, end and frequency information of the subscription.\n\n You can view your payment plan between the start and end dates by clicking the 'Reiview Installment Plan' button.",
              style: GoogleFonts.quicksand(
                color: Colors.black,
              )),
          actions: [
            // İptal butonu
            TextButton(
              onPressed: () {
                // AlertDialog'ı kapat
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.quicksand(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ), // Silme butonu
          ],
        );
      },
    );
  }
}
