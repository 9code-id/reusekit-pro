import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaOrderConfirmationView extends StatefulWidget {
  const SpaOrderConfirmationView({super.key});

  @override
  State<SpaOrderConfirmationView> createState() => _SpaOrderConfirmationViewState();
}

class _SpaOrderConfirmationViewState extends State<SpaOrderConfirmationView> {
  String orderNumber = "SPA-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
  String orderDate = DateTime.now().toString().split(' ')[0];
  String estimatedTime = "2-3 hours";
  
  Map<String, dynamic> orderDetails = {
    "orderNumber": "",
    "orderDate": "",
    "status": "Confirmed",
    "paymentMethod": "Credit Card •••• 4242",
    "totalAmount": 300.00,
    "customer": {
      "name": "Emma Wilson",
      "email": "emma.wilson@email.com",
      "phone": "+1 234 567 8900",
    },
  };

  List<Map<String, dynamic>> bookedServices = [
    {
      "id": 1,
      "name": "Luxury Facial Treatment",
      "category": "Facial",
      "price": 120.0,
      "duration": "90 min",
      "scheduledDate": "2024-03-25",
      "scheduledTime": "14:00",
      "package": "Premium Package",
      "therapist": {
        "name": "Sarah Johnson",
        "image": "https://picsum.photos/80/80?random=10&keyword=therapist",
        "specialization": "Anti-aging & Skincare",
      },
      "room": "Room 101",
    },
    {
      "id": 2,
      "name": "Hot Stone Massage",
      "category": "Massage",
      "price": 180.0,
      "duration": "75 min",
      "scheduledDate": "2024-03-26",
      "scheduledTime": "16:00",
      "package": "Standard Package",
      "therapist": {
        "name": "Michael Chen",
        "image": "https://picsum.photos/80/80?random=11&keyword=therapist",
        "specialization": "Deep Tissue & Relaxation",
      },
      "room": "Room 205",
    },
  ];

  List<Map<String, dynamic>> nextSteps = [
    {
      "title": "Confirmation Email Sent",
      "description": "Check your email for booking details",
      "icon": Icons.email,
      "completed": true,
    },
    {
      "title": "Prepare for Your Visit",
      "description": "Arrive 15 minutes early for check-in",
      "icon": Icons.schedule,
      "completed": false,
    },
    {
      "title": "Enjoy Your Services",
      "description": "Relax and enjoy your spa experience",
      "icon": Icons.spa,
      "completed": false,
    },
    {
      "title": "Rate Your Experience",
      "description": "Share your feedback after your visit",
      "icon": Icons.star_rate,
      "completed": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    orderDetails["orderNumber"] = orderNumber;
    orderDetails["orderDate"] = orderDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Confirmed"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Navigate to home
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Message
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Booking Confirmed!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Your spa appointment has been successfully booked. We've sent a confirmation email with all the details.",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Text(
                      "Order #$orderNumber",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Booking Details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
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
                  
                  Column(
                    children: bookedServices.map((service) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${service["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${(service["price"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${service["scheduledDate"]}",
                                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${service["scheduledTime"]} (${service["duration"]})",
                                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage("${service["therapist"]["image"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${service["therapist"]["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${service["therapist"]["specialization"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${service["room"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Payment Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Method", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
                      Text("${orderDetails["paymentMethod"]}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order Date", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
                      Text("$orderDate", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status", style: TextStyle(fontSize: 14, color: disabledBoldColor)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${orderDetails["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Paid",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${(orderDetails["totalAmount"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Next Steps
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's Next?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    children: nextSteps.map((step) {
                      final isCompleted = step["completed"] as bool;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCompleted 
                              ? successColor.withAlpha(20) 
                              : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isCompleted ? successColor : disabledColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isCompleted ? Icons.check : step["icon"] as IconData,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step["title"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    step["description"],
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
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Important Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor),
                      SizedBox(width: spSm),
                      Text(
                        "Important Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• Please arrive 15 minutes early for check-in",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Bring a valid ID and your confirmation email",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Cancellations must be made 24 hours in advance",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Contact us if you need to reschedule: (555) 123-4567",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowLg],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Booking",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to booking details
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Book More",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to service list
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _shareBooking();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.share, size: 20, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _downloadReceipt();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download, size: 20, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Download",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _addToCalendar();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today, size: 20, color: primaryColor),
                      SizedBox(width: spXs),
                      Text(
                        "Add to Calendar",
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
          ],
        ),
      ),
    );
  }

  void _shareBooking() {
    ss("Sharing booking details...");
    // Implement share functionality
  }

  void _downloadReceipt() {
    ss("Downloading receipt...");
    // Implement download functionality
  }

  void _addToCalendar() {
    ss("Adding to calendar...");
    // Implement calendar functionality
  }
}
