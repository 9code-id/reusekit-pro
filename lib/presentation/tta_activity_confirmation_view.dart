import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaActivityConfirmationView extends StatefulWidget {
  const TtaActivityConfirmationView({super.key});

  @override
  State<TtaActivityConfirmationView> createState() => _TtaActivityConfirmationViewState();
}

class _TtaActivityConfirmationViewState extends State<TtaActivityConfirmationView> {
  Map<String, dynamic> bookingData = {
    "bookingId": "ACT-2024-001247",
    "status": "Confirmed",
    "activity": {
      "name": "Snorkeling Adventure at Coral Bay",
      "location": "Coral Bay Marine Reserve",
      "image": "https://picsum.photos/400/200?random=801",
      "provider": "Ocean Adventures Co.",
      "rating": 4.8,
      "reviews": 342
    },
    "booking": {
      "date": "2024-01-15",
      "time": "09:00 AM",
      "duration": "3 hours",
      "package": "Premium Package",
      "adults": 2,
      "children": 1,
      "isPrivate": false,
      "totalAmount": 157.50
    },
    "contact": {
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 (555) 123-4567"
    },
    "meetingPoint": {
      "name": "Coral Bay Visitor Center",
      "address": "123 Marine Drive, Coral Bay",
      "coordinates": "34.0522° N, 118.2437° W",
      "instructions": "Meet at the main entrance 15 minutes before departure time. Look for staff wearing blue Ocean Adventures uniforms."
    },
    "cancellation": {
      "policy": "Free cancellation up to 24 hours before activity",
      "deadline": "2024-01-14 09:00 AM"
    },
    "payment": {
      "method": "Credit Card",
      "last4": "4567",
      "amount": 157.50,
      "transactionId": "TXN-98765432"
    }
  };

  List<Map<String, dynamic>> includedItems = [
    {
      "title": "Snorkeling Equipment",
      "description": "Mask, snorkel, fins, and wetsuit",
      "icon": Icons.scuba_diving
    },
    {
      "title": "Safety Gear",
      "description": "Life jacket and safety whistle",
      "icon": Icons.security
    },
    {
      "title": "Professional Guide",
      "description": "Certified marine biology guide",
      "icon": Icons.person
    },
    {
      "title": "Premium Refreshments",
      "description": "Beverages and snacks included",
      "icon": Icons.local_cafe
    },
    {
      "title": "Professional Photos",
      "description": "Underwater photos of your experience",
      "icon": Icons.camera_alt
    },
    {
      "title": "Lunch",
      "description": "Fresh seafood lunch at beachside restaurant",
      "icon": Icons.restaurant
    }
  ];

  List<Map<String, dynamic>> importantNotes = [
    {
      "title": "What to Bring",
      "items": ["Swimwear", "Towel", "Sunscreen", "Water bottle", "Valid ID"]
    },
    {
      "title": "Physical Requirements",
      "items": ["Basic swimming ability required", "Minimum age: 8 years", "Maximum weight: 120kg"]
    },
    {
      "title": "Weather Policy",
      "items": ["Activity may be cancelled due to weather", "Full refund for weather cancellations", "Alternative dates will be offered"]
    }
  ];

  void _addToCalendar() {
    ss("Event added to calendar successfully!");
  }

  void _shareBooking() {
    ss("Booking details shared successfully!");
  }

  void _downloadVoucher() {
    ss("Voucher downloaded successfully!");
  }

  void _getDirections() {
    ss("Opening map directions...");
  }

  void _contactProvider() {
    ss("Calling activity provider...");
  }

  void _cancelBooking() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this booking? This action cannot be undone.");
    if (isConfirmed) {
      ss("Booking cancellation initiated. You will receive a confirmation email shortly.");
    }
  }

  void _modifyBooking() {
    si("Redirecting to booking modification...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmation"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _shareBooking,
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadVoucher,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 40,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Booking Confirmed!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Your activity has been successfully booked",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Booking ID: ${bookingData["bookingId"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Activity Details
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Activity Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${bookingData["activity"]["image"]}",
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${bookingData["activity"]["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${bookingData["activity"]["location"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.business, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${bookingData["activity"]["provider"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.star, size: 16, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${bookingData["activity"]["rating"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Booking Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Booking Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: [
                      _buildInfoRow("Date", "${bookingData["booking"]["date"]}", Icons.calendar_today),
                      _buildInfoRow("Time", "${bookingData["booking"]["time"]}", Icons.access_time),
                      _buildInfoRow("Duration", "${bookingData["booking"]["duration"]}", Icons.timer),
                      _buildInfoRow("Package", "${bookingData["booking"]["package"]}", Icons.card_giftcard),
                      _buildInfoRow("Guests", "${bookingData["booking"]["adults"]} Adults" + 
                                   (bookingData["booking"]["children"] > 0 ? ", ${bookingData["booking"]["children"]} Children" : ""), 
                                   Icons.people),
                      _buildInfoRow("Total Amount", "\$${((bookingData["booking"]["totalAmount"] as double)).currency}", Icons.payment),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Meeting Point
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Meeting Point",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Get Directions",
                        size: bs.sm,
                        onPressed: _getDirections,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${bookingData["meetingPoint"]["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${bookingData["meetingPoint"]["address"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${bookingData["meetingPoint"]["instructions"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // What's Included
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's Included",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: List.generate(includedItems.length, (index) {
                      final item = includedItems[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(30)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                item["icon"],
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${item["description"]}",
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
                      );
                    }),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Important Notes
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Important Notes",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: List.generate(importantNotes.length, (index) {
                      final note = importantNotes[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${note["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Column(
                              children: (note["items"] as List).map((item) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        margin: EdgeInsets.only(top: 6, right: spSm),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "$item",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Contact Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: [
                      _buildInfoRow("Name", "${bookingData["contact"]["name"]}", Icons.person),
                      _buildInfoRow("Email", "${bookingData["contact"]["email"]}", Icons.email),
                      _buildInfoRow("Phone", "${bookingData["contact"]["phone"]}", Icons.phone),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Cancellation Policy
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Cancellation Policy",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${bookingData["cancellation"]["policy"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Cancellation deadline: ${bookingData["cancellation"]["deadline"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Add to Calendar",
                    size: bs.sm,
                    onPressed: _addToCalendar,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Contact Provider",
                    size: bs.sm,
                    onPressed: _contactProvider,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Modify Booking",
                      size: bs.sm,
                      color: infoColor,
                      onPressed: _modifyBooking,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Cancel Booking",
                      size: bs.sm,
                      color: dangerColor,
                      onPressed: _cancelBooking,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spXl),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: disabledBoldColor),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
