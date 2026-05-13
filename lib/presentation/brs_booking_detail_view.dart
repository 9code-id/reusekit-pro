import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBookingDetailView extends StatefulWidget {
  const BrsBookingDetailView({super.key});

  @override
  State<BrsBookingDetailView> createState() => _BrsBookingDetailViewState();
}

class _BrsBookingDetailViewState extends State<BrsBookingDetailView> {
  Map<String, dynamic> bookingDetail = {
    "id": "BRS-001234",
    "transactionId": "TXN-789012345",
    "date": DateTime.now().add(Duration(days: 2)),
    "time": "10:00",
    "status": "confirmed",
    "createdAt": DateTime.now().subtract(Duration(hours: 2)),
    "barber": {
      "name": "John Smith",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=barber",
      "speciality": "Classic Cuts & Styling",
      "rating": 4.8,
      "experience": "8 years",
      "phone": "+1 234 567 8902"
    },
    "customer": {
      "name": "Alex Johnson",
      "phone": "+1 234 567 8900",
      "email": "alex@email.com"
    },
    "services": [
      {
        "name": "Classic Haircut",
        "price": 25.0,
        "duration": 30,
        "description": "Professional haircut with styling"
      },
      {
        "name": "Beard Trim",
        "price": 15.0,
        "duration": 15,
        "description": "Precision beard trimming and shaping"
      },
      {
        "name": "Hair Wash",
        "price": 10.0,
        "duration": 10,
        "description": "Premium shampoo and conditioning"
      }
    ],
    "location": {
      "name": "Prime Cuts Barbershop",
      "address": "123 Main Street, Downtown",
      "city": "New York",
      "zipCode": "10001",
      "phone": "+1 234 567 8901",
      "coordinates": {
        "latitude": 40.7128,
        "longitude": -74.0060
      }
    },
    "payment": {
      "method": "Credit Card",
      "cardLast4": "4532",
      "amount": 50.0,
      "processingFee": 2.50,
      "totalAmount": 52.50,
      "status": "paid"
    },
    "specialRequests": "Please use organic products",
    "allergies": "None",
    "canCancel": true,
    "canReschedule": true,
    "reminderSent": false
  };

  Color getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "pending":
        return warningColor;
      case "cancelled":
        return dangerColor;
      case "completed":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "confirmed":
        return "Confirmed";
      case "pending":
        return "Pending";
      case "cancelled":
        return "Cancelled";
      case "completed":
        return "Completed";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> services = (bookingDetail["services"] as List).cast<Map<String, dynamic>>();
    Map<String, dynamic> barber = bookingDetail["barber"] as Map<String, dynamic>;
    Map<String, dynamic> customer = bookingDetail["customer"] as Map<String, dynamic>;
    Map<String, dynamic> location = bookingDetail["location"] as Map<String, dynamic>;
    Map<String, dynamic> payment = bookingDetail["payment"] as Map<String, dynamic>;
    DateTime bookingDate = bookingDetail["date"] as DateTime;
    DateTime createdAt = bookingDetail["createdAt"] as DateTime;
    String status = bookingDetail["status"] as String;

    int totalDuration = services.fold<int>(0, (sum, service) => sum + (service["duration"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Status Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: getStatusColor(status).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: getStatusColor(status)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: getStatusColor(status),
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              getStatusText(status),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: getStatusColor(status),
                              ),
                            ),
                            Text(
                              "Booking ID: ${bookingDetail["id"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (status == "confirmed")
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: infoColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Please arrive 5 minutes early for your appointment",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Appointment Info
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
                    "Appointment Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 20, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Date & Time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${bookingDate.dMMMy} at ${bookingDetail["time"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 20, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "$totalDuration minutes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 20, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Booked On",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${createdAt.dMMMy} at ${createdAt.dMMMykkmm.split(' ').last}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage("${barber["avatar"]}"),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${barber["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${barber["speciality"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, size: 16, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${barber["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${barber["experience"]} experience",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${barber["phone"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling ${barber["name"]}");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Services Details
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
                    "Services & Pricing",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...services.map((service) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${service["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${(service["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${service["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${service["duration"]} min",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
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
                  Row(
                    children: [
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
                      QButton(
                        icon: Icons.directions,
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening directions");
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 20, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
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
                              "${location["city"]}, ${location["zipCode"]}",
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
                    ],
                  ),
                ],
              ),
            ),

            // Customer Information
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
                    "Customer Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 20, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "${customer["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 20, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "${customer["phone"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, size: 20, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "${customer["email"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
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
                        "${bookingDetail["transactionId"]}",
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
                          "Payment Method",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${payment["method"]} (*${payment["cardLast4"]})",
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
                          "Services Total",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(payment["amount"] as double).currency}",
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
                          "Processing Fee",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(payment["processingFee"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(payment["totalAmount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Special Requests & Notes
            if ((bookingDetail["specialRequests"] as String).isNotEmpty || (bookingDetail["allergies"] as String) != "None")
              Container(
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
                        Icon(Icons.note, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    if ((bookingDetail["specialRequests"] as String).isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Special Requests:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${bookingDetail["specialRequests"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    if ((bookingDetail["allergies"] as String) != "None")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Allergies:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${bookingDetail["allergies"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

            // Action Buttons
            if (status == "confirmed")
              Column(
                spacing: spSm,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      if (bookingDetail["canReschedule"] as bool)
                        Expanded(
                          child: QButton(
                            label: "Reschedule",
                            size: bs.md,
                            onPressed: () {
                              ss("Rescheduling appointment");
                            },
                          ),
                        ),
                      if (bookingDetail["canCancel"] as bool)
                        Expanded(
                          child: QButton(
                            label: "Cancel Booking",
                            size: bs.md,
                            onPressed: () async {
                              bool isConfirmed = await confirm("Are you sure you want to cancel this booking?");
                              if (isConfirmed) {
                                ss("Booking cancelled");
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Download Receipt",
                      size: bs.md,
                      onPressed: () {
                        ss("Downloading receipt");
                      },
                    ),
                  ),
                ],
              )
            else
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Download Receipt",
                  size: bs.md,
                  onPressed: () {
                    ss("Downloading receipt");
                  },
                ),
              ),

            // Contact Support
            Container(
              width: double.infinity,
              child: QButton(
                label: "Contact Support",
                size: bs.md,
                onPressed: () {
                  ss("Contacting support");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
