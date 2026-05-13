import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBookingConfirmationView extends StatefulWidget {
  const BrsBookingConfirmationView({super.key});

  @override
  State<BrsBookingConfirmationView> createState() => _BrsBookingConfirmationViewState();
}

class _BrsBookingConfirmationViewState extends State<BrsBookingConfirmationView> {
  final Map<String, dynamic> booking = {
    "bookingId": "BKG-2024-001",
    "date": "2024-06-20",
    "time": "2:30 PM",
    "barber": {
      "name": "Michael Rodriguez",
      "image": "https://picsum.photos/200/200?random=1&keyword=barber",
      "phone": "+1 (555) 123-4567",
      "specialty": "Classic Cuts & Beard Styling",
    },
    "services": [
      {
        "name": "Classic Haircut",
        "price": 35.0,
        "duration": 45,
      },
      {
        "name": "Beard Trim",
        "price": 20.0,
        "duration": 30,
      },
    ],
    "customer": {
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 (555) 987-6543",
    },
    "location": {
      "name": "Downtown Barbershop",
      "address": "123 Main Street, New York, NY 10001",
      "phone": "+1 (555) 234-5678",
    },
    "payment": {
      "method": "Credit Card",
      "amount": 55.0,
      "deposit": 11.0,
      "remaining": 44.0,
      "status": "confirmed",
    },
    "status": "confirmed",
    "createdAt": "2024-06-15 10:30 AM",
  };

  double get totalPrice {
    return booking["services"].fold(0.0, (sum, service) => sum + (service["price"] as double));
  }

  int get totalDuration {
    return booking["services"].fold(0, (sum, service) => sum + (service["duration"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmed"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              ss("Booking details shared!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Success Message
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 60,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Booking Confirmed!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Your appointment has been successfully booked",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: successColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Booking ID: ${booking["bookingId"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Appointment Details
            Container(
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
                    "Appointment Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: primaryColor,
                          size: 40,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${DateTime.parse(booking["date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${booking["time"]} ($totalDuration minutes)",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Barber Information
            Container(
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
                    "Your Barber",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spMd,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${booking["barber"]["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${booking["barber"]["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${booking["barber"]["specialty"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: disabledBoldColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${booking["barber"]["phone"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling ${booking["barber"]["name"]}...");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Services Booked
            Container(
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
                    "Services Booked",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...(booking["services"] as List).map((service) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${service["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${service["duration"]} minutes",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(service["price"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  Container(
                    height: 1,
                    color: disabledOutlineBorderColor,
                    margin: EdgeInsets.symmetric(vertical: spSm),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Payment Information
            Container(
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
                    "Payment Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${booking["payment"]["method"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deposit Paid",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                      Text(
                        "\$${(booking["payment"]["deposit"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remaining",
                        style: TextStyle(color: disabledBoldColor),
                      ),
                      Text(
                        "\$${(booking["payment"]["remaining"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Payment ${booking["payment"]["status"]}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Location Information
            Container(
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
                    "Location",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${booking["location"]["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${booking["location"]["address"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${booking["location"]["phone"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Get Directions",
                          icon: Icons.directions,
                          size: bs.sm,
                          onPressed: () {
                            si("Opening directions...");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Call Shop",
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            ss("Calling barbershop...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Modify Booking",
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            si("Opening modification options...");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Add to Calendar",
                          icon: Icons.calendar_today,
                          size: bs.sm,
                          onPressed: () {
                            ss("Added to calendar!");
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Send Reminder",
                          icon: Icons.notifications,
                          size: bs.sm,
                          onPressed: () {
                            ss("Reminder set successfully!");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Cancel Booking",
                          icon: Icons.cancel,
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Are you sure you want to cancel this booking?");
                            if (isConfirmed) {
                              sw("Booking cancellation initiated");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Important Notes
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Important Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Please arrive 10 minutes before your appointment time\n• Bring a valid ID and payment method\n• Cancellations must be made at least 24 hours in advance\n• A confirmation SMS will be sent 2 hours before your appointment",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Thank You Message
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Text(
                    "Thank You!",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "We look forward to serving you. If you have any questions, please don't hesitate to contact us.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Navigation Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "View All Bookings",
                    size: bs.md,
                    onPressed: () {
                      si("Opening booking history...");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Book Another",
                    size: bs.md,
                    onPressed: () {
                      si("Starting new booking...");
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
