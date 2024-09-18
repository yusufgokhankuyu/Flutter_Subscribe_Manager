import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:subscribe_manager/Constants/constants.dart';

class PaymentPlanofPlatform extends StatefulWidget {
  var imagePath;
  var platformName;
  var startDate;
  var endDate;
  var isMonthlySelected;
  PaymentPlanofPlatform({
    super.key,
    required this.imagePath,
    required this.platformName,
    required this.startDate,
    required this.endDate,
    required this.isMonthlySelected,
  });

  @override
  State<PaymentPlanofPlatform> createState() => _PaymentPlanofPlatformState();
}

class _PaymentPlanofPlatformState extends State<PaymentPlanofPlatform> {
  // String platformName = "widget.;
  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now();
  // bool isMonthlySelected = false;

  List<String> installmentDates = [];
  @override
  void initState() {
    super.initState();
    calculateInstallmentDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title: Text(
          widget.platformName + " Installment Dates",
          style: GoogleFonts.quicksand(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            width: MediaQuery.sizeOf(context).width / 2.3,
            child: Image.asset(widget.imagePath),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Installment Dates',
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: installmentDates.length,
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 0 ? Colors.black : Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${index + 1}. Installment Date:",
                          style: GoogleFonts.quicksand(
                              fontSize: 22, color: Colors.white),
                        ),
                        Container(
                          child: Text(
                            installmentDates[index],
                            style: GoogleFonts.quicksand(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void calculateInstallmentDates() {
    installmentDates.clear();

    DateTime currentStartDate =
        DateFormat('dd/MM/yyyy').parse(widget.startDate);
    DateTime endTime = DateFormat('dd/MM/yyyy').parse(widget.endDate);

    while (currentStartDate.isBefore(endTime) ||
        currentStartDate.isAtSameMomentAs(endTime)) {
      installmentDates.add(DateFormat('dd/MM/yyyy').format(currentStartDate));
      if (widget.isMonthlySelected.toString().toLowerCase() == "monthly") {
        currentStartDate = DateTime(currentStartDate.year,
            currentStartDate.month + 1, currentStartDate.day);
      } else {
        currentStartDate = DateTime(currentStartDate.year + 1,
            currentStartDate.month, currentStartDate.day);
      }
    }

    setState(() {
      installmentDates = installmentDates;
    });
  }
}


            // Container(
            //   color: Constants.appBarColor,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           "Start Date :",
            //           style: GoogleFonts.quicksand(
            //               fontSize: 24, color: Colors.white),
            //         ),
            //         Container(
            //           child: Text(
            //             widget.startDate,
            //             style: GoogleFonts.quicksand(
            //                 fontSize: 24, color: Colors.white),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Container(
            //   color: Constants.appBarColor,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           "End Date :",
            //           style: GoogleFonts.quicksand(
            //               fontSize: 24, color: Colors.white),
            //         ),
            //         Container(
            //           child: Text(
            //             widget.endDate,
            //             style: GoogleFonts.quicksand(
            //                 fontSize: 24, color: Colors.white),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // // Text('Start Date: ${DateFormat('dd/MM/yyyy').format(startDate)}'),
            // // Text('End Date: ${DateFormat('dd/MM/yyyy').format(endDate)}'),
            // SizedBox(height: 20),
            // Container(
            //   color: Constants.appBarColor,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           "Subscription Type :",
            //           style: GoogleFonts.quicksand(
            //               fontSize: 24, color: Colors.white),
            //         ),
            //         Container(
            //           child: Text(
            //             widget.isMonthlySelected,
            //             style: GoogleFonts.quicksand(
            //                 fontSize: 24, color: Colors.white),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            // if (installmentDates.isNotEmpty)
