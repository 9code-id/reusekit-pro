import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBookingCancelView extends StatefulWidget {
  const BrsBookingCancelView({super.key});

  @override
  State<BrsBookingCancelView> createState() => _BrsBookingCancelViewState();
}

class _BrsBookingCancelViewState extends State<BrsBookingCancelView> {
  String selectedReason = "";
  String customReason = "";
  bool isRefundRequested = false;
  
  List<Map<String, dynamic>> cancellationReasons = [
    {
      "title": "Change of Plans",
      "description": "I no longer need this service",
      "value": "change_of_plans",
    },
    {
      "title": "Schedule Conflict",
      "description": "I have a conflicting appointment",
      "value": "schedule_conflict",
    },
    {
      "title": "Personal Emergency",
      "description": "An emergency has come up",
      "value": "personal_emergency",
    },
    {
      "title": "Found Another Barber",
      "description": "I decided to go somewhere else",
      "value": "found_another_barber",
    },
    {
      "title": "Price Concerns",
      "description": "The service is too expensive",
      "value": "price_concerns",
    },
    {
      "title": "Health Reasons",
      "description": "Health issues prevent me from attending",
      "value": "health_reasons",
    },
    {
      "title": "Other",
      "description": "I'll specify my reason",
      "value": "other",
    },
  ];

  // Sample booking data
  Map<String, dynamic> bookingDetails = {
    "id": "BK001",
    "barberName": "Marco Rodriguez",
    "barberImage": "https://picsum.photos/60/60?random=1&keyword=barber",
    "serviceName": "Classic Haircut + Beard Trim",
    "date": "2024-06-18",
    "time": "2:30 PM",
    "price": 35.0,
    "shopName": "Marco's Barbershop",
    "address": "123 Main Street, Downtown",
    "duration": 45,
    "paymentMethod": "Credit Card",
    "bookingDate": "2024-06-12",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Booking"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Booking Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${bookingDetails["barberImage"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${bookingDetails["barberName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${bookingDetails["serviceName"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${bookingDetails["shopName"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: primaryColor, size: 16),
                            SizedBox(width: spSm),
                            Text(
                              "${bookingDetails["date"]} at ${bookingDetails["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${bookingDetails["duration"]} min",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(Icons.payment, color: primaryColor, size: 16),
                            SizedBox(width: spSm),
                            Text(
                              "Total: \$${(bookingDetails["price"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${bookingDetails["paymentMethod"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Cancellation Policy Warning
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(77)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cancellation Policy",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Free cancellation up to 24 hours before appointment. Cancellations within 24 hours may incur a 25% fee.",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Cancellation Reasons
            Text(
              "Reason for Cancellation",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Please select why you're cancelling this booking",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),

            SizedBox(height: spSm),

            // Reason Selection
            Column(
              children: List.generate(cancellationReasons.length, (index) {
                final reason = cancellationReasons[index];
                bool isSelected = selectedReason == reason["value"];
                
                return GestureDetector(
                  onTap: () {
                    selectedReason = reason["value"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(26) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledBoldColor,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${reason["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${reason["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            // Custom Reason Input
            if (selectedReason == "other") ...[
              SizedBox(height: spSm),
              Text(
                "Please specify your reason",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Type your reason here...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(spSm),
                  ),
                  onChanged: (value) {
                    customReason = value;
                    setState(() {});
                  },
                ),
              ),
            ],

            SizedBox(height: spMd),

            // Refund Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Refund Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 16),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Based on our cancellation policy, you are eligible for a full refund.",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.monetization_on, color: successColor, size: 16),
                        SizedBox(width: spSm),
                        Text(
                          "Refund Amount: \$${(bookingDetails["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Refunds are processed within 3-5 business days to your original payment method.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Request Refund Checkbox
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    isRefundRequested = !isRefundRequested;
                    setState(() {});
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isRefundRequested ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: isRefundRequested ? primaryColor : disabledBoldColor,
                        width: 2,
                      ),
                    ),
                    child: isRefundRequested
                        ? Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "I would like to request a refund for this cancellation",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Keep Booking",
                    size: bs.md,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: TextButton(
                      onPressed: selectedReason.isEmpty ? null : () async {
                        bool isConfirmed = await confirm(
                          "Are you sure you want to cancel this booking? This action cannot be undone."
                        );
                        
                        if (isConfirmed) {
                          showLoading();
                          await Future.delayed(Duration(seconds: 2));
                          hideLoading();
                          
                          ss("Booking cancelled successfully");
                          back();
                        }
                      },
                      child: Text(
                        "Cancel Booking",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Help Text
            Container(
              padding: EdgeInsets.all(spSm),
              child: Column(
                children: [
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  GestureDetector(
                    onTap: () {
                      ss("Opening support chat");
                    },
                    child: Text(
                      "Contact our support team if you have questions about cancelling your booking",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
