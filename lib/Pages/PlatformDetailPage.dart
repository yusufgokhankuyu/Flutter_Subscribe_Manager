import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:subscribe_manager/Constants/constants.dart';
import 'package:subscribe_manager/Models/PaymentCalculator.dart';
import 'package:subscribe_manager/Models/subscription.dart';
import 'package:subscribe_manager/Pages/PaymentPlanPage.dart';
import 'package:subscribe_manager/utils/database_helper_subscription.dart';

class PlatformDetailPage extends StatefulWidget {
  var imageUrl;
  var platfromName;
  PlatformDetailPage(
      {super.key, required this.imageUrl, required this.platfromName});

  @override
  State<PlatformDetailPage> createState() => PlatformDetailPageState();
}

class PlatformDetailPageState extends State<PlatformDetailPage> {
  List<Subscription>? allSubscription;
  late DatabaseHelperSubscription databaseHelperSubscription;
  List<bool> isSelected = [false, false];
  bool isMonthlySelected = false;
  bool isYearlySelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    databaseHelperSubscription = DatabaseHelperSubscription();
    updateSubscriptionList();
  }

  var startDate = DateTime.now();
  var endDate = DateTime.now();
  void _openDatePickerStart(BuildContext context) {
    BottomPicker.date(
      title: "Select a date",
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: GoogleFonts.quicksand(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      titleStyle: GoogleFonts.quicksand(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      onSubmit: (index) {
        setState(() {
          // var formatter = DateFormat('dd/MM/yyyy');
          // var formattedDate = formatter.format(index);
          startDate = index;
          print(index);
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  void _openDatePickerEnd(BuildContext context) {
    BottomPicker.date(
      title: "Select a date",
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: GoogleFonts.quicksand(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      titleStyle: GoogleFonts.quicksand(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      onSubmit: (index) {
        setState(() {
          // var formatter = DateFormat('dd/MM/yyyy');
          // var formattedDate = formatter.format(index);
          endDate = index;
          print(index);
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    if (allSubscription == null) {
      allSubscription = <Subscription>[];
      updateSubscriptionList();
    }
    // var formatter = DateFormat('dd/MM/yyyy');
    // var formattedDate = formatter.format(now);
    Duration difference = endDate.difference(startDate);
    int days = difference.inDays;
    int months = difference.inDays ~/ 30;
    int years = difference.inDays ~/ 365;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Constants.appBarColor,
        title: Text(
          widget.platfromName,
          style: Constants.googleFontsStyle,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                infoDialog(widget.platfromName);
              },
              child: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
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
                      _openDatePickerStart(context);
                    },
                    child: Container(
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(startDate),
                        style: GoogleFonts.quicksand(
                            fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openDatePickerStart(context);
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
                      _openDatePickerEnd(context);
                    },
                    child: Container(
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(endDate),
                        style: GoogleFonts.quicksand(
                            fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _openDatePickerEnd(context);
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
                style: GoogleFonts.quicksand(fontSize: 24, color: Colors.black),
              ),
              ToggleButtons(
                borderWidth: 1,
                borderRadius: BorderRadius.circular(50),
                selectedColor: Colors.grey.shade200,
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    if (index == 0) {
                      isYearlySelected = false;
                      isMonthlySelected = true;
                    } else {
                      isYearlySelected = true;
                      isMonthlySelected = false;
                    }
                  });
                },
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Monthly',
                      style: GoogleFonts.quicksand(
                          color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Yearly',
                      style: GoogleFonts.quicksand(
                          color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          FutureBuilder(
            future: DatabaseHelperSubscription()
                .checkSubscriptionExists(widget.platfromName),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.black,
                );
              } else {
                if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  final subscriptionExists = snapshot.data!;
                  return subscriptionExists
                      ? Column(
                          children: [
                            Text(
                              // Netflix subscription
                              " You already have a " +
                                  "'" +
                                  widget.platfromName +
                                  "'" +
                                  " subscription",
                              style: TextStyle(color: Colors.black),
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
                                              builder: (context) =>
                                                  PaymentPlanPage(
                                                    platformName:
                                                        widget.platfromName,
                                                    imageUrl: widget.imageUrl,
                                                    startDate:
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(startDate)
                                                            .toString(),
                                                    endDate:
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(endDate)
                                                            .toString(),
                                                    isMonthlySelected:
                                                        isMonthlySelected,
                                                  )));
                                    },
                                    child: Text(
                                      "Details",
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () {
                                      deleteDialog(widget.platfromName);
                                    },
                                    child: Text(
                                      "Delete Subscription",
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white),
                                    ))
                              ],
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                onPressed: () {
                                  if (isMonthlySelected) {
                                    print("monthly");
                                  } else if (isYearlySelected) {
                                    print("yearly");
                                  }
                                  DatabaseHelperSubscription().addSubscription(
                                      Subscription(
                                          widget.platfromName,
                                          DateFormat('dd/MM/yyyy')
                                              .format(startDate)
                                              .toString(),
                                          DateFormat('dd/MM/yyyy')
                                              .format(endDate)
                                              .toString(),
                                          isMonthlySelected
                                              ? "Monthly"
                                              : "Yearly"));
                                },
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white),
                                )),
                          ],
                        );
                }
              }
            },
          )
        ],
      ),
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
                "Cancel",
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
                "Delete",
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

  void infoDialog(String plarformName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AlertDialog oluştur
        return CupertinoAlertDialog(
          title: Text(
            "How can I manage '$plarformName' subscription?",
            style: GoogleFonts.quicksand(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Text(
              "First, select the start date and end date of your subscription. Then choose whether your subscription is yearly or monthly.\n\n If you have already saved your subscription, you can go to the detail page by clicking the 'Details' button. You can click the 'Delete Subscription' button to delete your subscription.",
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
