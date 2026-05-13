import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaOrderTrackingView extends StatefulWidget {
  const SpaOrderTrackingView({super.key});

  @override
  State<SpaOrderTrackingView> createState() => _SpaOrderTrackingViewState();
}

class _SpaOrderTrackingViewState extends State<SpaOrderTrackingView> {
  String orderId = "SPA-001234";
  int currentStepIndex = 2;
  
  Map<String, dynamic> orderDetails = {
    "orderNumber": "SPA-001234",
    "orderDate": "2024-03-20",
    "status": "In Progress",
    "totalAmount": 300.00,
    "estimatedCompletion": "2024-03-25 16:30",
    "customer": {
      "name": "Emma Wilson",
      "email": "emma.wilson@email.com",
      "phone": "+1 234 567 8900",
    },
  };

  List<Map<String, dynamic>> trackingSteps = [
    {
      "title": "Booking Confirmed",
      "description": "Your spa appointment has been confirmed",
      "time": "2024-03-20 10:30",
      "status": "completed",
      "icon": Icons.check_circle,
    },
    {
      "title": "Payment Processed",
      "description": "Payment of \$300.00 has been successfully processed",
      "time": "2024-03-20 10:31",
      "status": "completed",
      "icon": Icons.payment,
    },
    {
      "title": "Preparing Your Experience",
      "description": "Our team is preparing for your spa services",
      "time": "2024-03-25 13:00",
      "status": "in_progress",
      "icon": Icons.spa,
    },
    {
      "title": "Ready for Service",
      "description": "Please arrive 15 minutes early for check-in",
      "time": "2024-03-25 13:45",
      "status": "upcoming",
      "icon": Icons.schedule,
    },
    {
      "title": "Service Complete",
      "description": "Enjoy your relaxing spa experience",
      "time": "2024-03-25 16:30",
      "status": "upcoming",
      "icon": Icons.star,
    },
  ];

  List<Map<String, dynamic>> services = [
    {
      "id": 1,
      "name": "Luxury Facial Treatment",
      "category": "Facial",
      "price": 120.0,
      "duration": "90 min",
      "scheduledDate": "2024-03-25",
      "scheduledTime": "14:00",
      "endTime": "15:30",
      "package": "Premium Package",
      "therapist": {
        "name": "Sarah Johnson",
        "image": "https://picsum.photos/80/80?random=10&keyword=therapist",
        "specialization": "Anti-aging & Skincare",
        "phone": "+1 234 567 8901",
      },
      "room": "Room 101",
      "status": "Scheduled",
    },
    {
      "id": 2,
      "name": "Hot Stone Massage",
      "category": "Massage",
      "price": 180.0,
      "duration": "75 min",
      "scheduledDate": "2024-03-25",
      "scheduledTime": "16:00",
      "endTime": "17:15",
      "package": "Standard Package",
      "therapist": {
        "name": "Michael Chen",
        "image": "https://picsum.photos/80/80?random=11&keyword=therapist",
        "specialization": "Deep Tissue & Relaxation",
        "phone": "+1 234 567 8902",
      },
      "room": "Room 205",
      "status": "Scheduled",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Your Booking"),
        actions: [
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: () {
              _contactSupport();
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareTracking();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Header
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order ${orderDetails["orderNumber"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: infoColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${orderDetails["status"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
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
                        "Booked on ${orderDetails["orderDate"]}",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Est. completion: ${orderDetails["estimatedCompletion"]}",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Tracking Timeline
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
                    "Booking Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Column(
                    children: trackingSteps.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> step = entry.value;
                      String status = step["status"];
                      bool isLast = index == trackingSteps.length - 1;
                      
                      Color stepColor;
                      switch (status) {
                        case "completed":
                          stepColor = successColor;
                          break;
                        case "in_progress":
                          stepColor = warningColor;
                          break;
                        case "upcoming":
                          stepColor = disabledColor;
                          break;
                        default:
                          stepColor = disabledColor;
                      }
                      
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Timeline Indicator
                          Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: stepColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  step["icon"] as IconData,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  width: 2,
                                  height: 50,
                                  color: status == "completed" ? successColor : disabledColor,
                                ),
                            ],
                          ),
                          
                          SizedBox(width: spSm),
                          
                          // Step Content
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: isLast ? 0 : spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step["title"],
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    step["description"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      height: 1.4,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    step["time"],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Service Details
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
                    "Your Services",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    children: services.map((service) {
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
                                    service["name"],
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    service["status"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                  "${service["scheduledTime"]} - ${service["endTime"]}",
                                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
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
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${service["room"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    QButton(
                                      label: "Contact Therapist",
                                      size: bs.sm,
                                      onPressed: () {
                                        _contactTherapist(service["therapist"]);
                                      },
                                    ),
                                    SizedBox(width: spSm),
                                    GestureDetector(
                                      onTap: () {
                                        _rescheduleService(service);
                                      },
                                      child: Text(
                                        "Reschedule",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
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
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Location & Directions
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
                    "Location & Directions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Luxury Spa & Wellness Center",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "123 Wellness Boulevard, Spa District, New York, NY 10001",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
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
                      Expanded(
                        child: QButton(
                          label: "Get Directions",
                          size: bs.sm,
                          onPressed: () {
                            _getDirections();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Call Spa",
                          size: bs.sm,
                          onPressed: () {
                            _callSpa();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Important Notes
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: warningColor),
                      SizedBox(width: spSm),
                      Text(
                        "Important Reminders",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• Arrive 15 minutes early for check-in and consultation",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Please bring a valid ID and your confirmation email",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Avoid heavy meals 2 hours before your massage",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "• Inform your therapist of any allergies or medical conditions",
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
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Modify Booking",
                size: bs.md,
                onPressed: () {
                  _modifyBooking();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Cancel Booking",
                size: bs.md,
                onPressed: () {
                  _cancelBooking();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _contactSupport() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusXl),
              topRight: Radius.circular(radiusXl),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Text(
                  "Contact Support",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Call Support",
                        size: bs.md,
                        onPressed: () {
                          back();
                          ss("Calling support...");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Live Chat",
                        size: bs.md,
                        onPressed: () {
                          back();
                          ss("Starting live chat...");
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Send Email",
                    size: bs.md,
                    onPressed: () {
                      back();
                      ss("Opening email...");
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _shareTracking() {
    ss("Sharing tracking information...");
  }

  void _contactTherapist(Map<String, dynamic> therapist) {
    ss("Contacting ${therapist["name"]}...");
  }

  void _rescheduleService(Map<String, dynamic> service) {
    ss("Rescheduling ${service["name"]}...");
  }

  void _getDirections() {
    ss("Opening directions...");
  }

  void _callSpa() {
    ss("Calling spa...");
  }

  void _modifyBooking() {
    ss("Modifying booking...");
  }

  void _cancelBooking() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel this booking?");
    if (isConfirmed) {
      ss("Booking cancelled successfully");
    }
  }
}
