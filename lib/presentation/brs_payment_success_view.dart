import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPaymentSuccessView extends StatefulWidget {
  const BrsPaymentSuccessView({super.key});

  @override
  State<BrsPaymentSuccessView> createState() => _BrsPaymentSuccessViewState();
}

class _BrsPaymentSuccessViewState extends State<BrsPaymentSuccessView> {
  Map<String, dynamic> bookingDetails = {
    "id": "BRS-001234",
    "transactionId": "TXN-789012345",
    "amount": 50.0,
    "paymentMethod": "Credit Card (**** 4532)",
    "date": DateTime.now().add(Duration(days: 2)),
    "time": "10:00",
    "barber": {
      "name": "John Smith",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=barber"
    },
    "services": [
      {
        "name": "Classic Haircut",
        "price": 25.0
      },
      {
        "name": "Beard Trim",
        "price": 15.0
      },
      {
        "name": "Hair Wash",
        "price": 10.0
      }
    ],
    "location": {
      "name": "Prime Cuts Barbershop",
      "address": "123 Main Street, Downtown",
      "phone": "+1 234 567 8901"
    }
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> services = (bookingDetails["services"] as List).cast<Map<String, dynamic>>();
    double totalAmount = bookingDetails["amount"] as double;
    Map<String, dynamic> barber = bookingDetails["barber"] as Map<String, dynamic>;
    Map<String, dynamic> location = bookingDetails["location"] as Map<String, dynamic>;
    DateTime bookingDate = bookingDetails["date"] as DateTime;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: spMd,
          children: [
            SizedBox(height: spXl),
            
            // Success Animation/Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                shape: BoxShape.circle,
                border: Border.all(color: successColor, width: 3),
              ),
              child: Icon(
                Icons.check_circle,
                size: 80,
                color: successColor,
              ),
            ),

            // Success Message
            Column(
              spacing: spSm,
              children: [
                Text(
                  "Payment Successful!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Your booking has been confirmed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Text(
                    "Booking ID: ${bookingDetails["id"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            // Transaction Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Transaction Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Transaction ID",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${bookingDetails["transactionId"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Amount Paid",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${totalAmount.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Payment Method",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${bookingDetails["paymentMethod"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Payment Date",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${DateTime.now().dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Appointment Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Appointment Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${barber["avatar"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${barber["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${bookingDate.dMMMy} at ${bookingDetails["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  ...services.map((service) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(service["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

            // Location Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Location",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${location["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${location["address"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${location["phone"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Next Steps
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "What's Next?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• You'll receive a confirmation email shortly\n• SMS reminder will be sent 1 hour before\n• Please arrive 5 minutes early\n• Bring a valid ID for verification",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Booking Details",
                    size: bs.md,
                    onPressed: () {
                      ss("Viewing booking details");
                    },
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Download Receipt",
                        size: bs.md,
                        onPressed: () {
                          ss("Downloading receipt");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Share",
                        size: bs.md,
                        onPressed: () {
                          ss("Sharing booking details");
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Back to Home",
                    size: bs.md,
                    onPressed: () {
                      ss("Returning to home");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
