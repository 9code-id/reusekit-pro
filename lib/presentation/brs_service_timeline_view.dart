import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsServiceTimelineView extends StatefulWidget {
  const BrsServiceTimelineView({super.key});

  @override
  State<BrsServiceTimelineView> createState() => _BrsServiceTimelineViewState();
}

class _BrsServiceTimelineViewState extends State<BrsServiceTimelineView> {
  String selectedBookingId = "BK2024001";
  
  List<Map<String, dynamic>> bookings = [
    {
      "id": "BK2024001",
      "service": "Premium Haircut + Beard Trim",
      "barber": "Mike Johnson",
      "barbershop": "Elite Cuts",
      "date": "2024-06-15",
      "time": "2:30 PM",
      "status": "In Progress"
    },
    {
      "id": "BK2024002",
      "service": "Signature Haircut",
      "barber": "David Chen",
      "barbershop": "Classic Barber Co.",
      "date": "2024-06-10",
      "time": "11:00 AM",
      "status": "Completed"
    },
    {
      "id": "BK2024003",
      "service": "Traditional Shave",
      "barber": "Tom Brown",
      "barbershop": "Vintage Barber",
      "date": "2024-06-20",
      "time": "10:30 AM",
      "status": "Upcoming"
    },
  ];

  List<Map<String, dynamic>> timelineSteps = [
    {
      "title": "Booking Confirmed",
      "description": "Your appointment has been successfully booked",
      "time": "2024-06-14 09:15 AM",
      "status": "completed",
      "icon": Icons.check_circle,
      "details": "Booking ID: BK2024001\nPayment: \$45.00 confirmed"
    },
    {
      "title": "Reminder Sent",
      "description": "24-hour reminder notification sent",
      "time": "2024-06-14 02:30 PM",
      "status": "completed",
      "icon": Icons.notifications,
      "details": "SMS and email reminder sent\nCheck-in available from 2:00 PM"
    },
    {
      "title": "Check-in Available",
      "description": "You can now check in for your appointment",
      "time": "2024-06-15 02:00 PM",
      "status": "completed",
      "icon": Icons.login,
      "details": "Online check-in completed\nEstimated wait time: 5 minutes"
    },
    {
      "title": "Service Started",
      "description": "Barber has started your service",
      "time": "2024-06-15 02:35 PM",
      "status": "current",
      "icon": Icons.content_cut,
      "details": "Consultation completed\nHaircut in progress"
    },
    {
      "title": "Service Completion",
      "description": "Service will be marked as completed",
      "time": "Expected: 2024-06-15 03:20 PM",
      "status": "pending",
      "icon": Icons.done_all,
      "details": "Final styling and finishing touches\nQuality check"
    },
    {
      "title": "Payment & Review",
      "description": "Complete payment and leave a review",
      "time": "Expected: 2024-06-15 03:25 PM",
      "status": "pending",
      "icon": Icons.payment,
      "details": "Service payment\nRate your experience"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedBooking = bookings.firstWhere((booking) => booking["id"] == selectedBookingId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Service Timeline"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Booking Selection
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Booking",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Booking",
                          items: bookings.map((booking) => {
                            "label": "${booking["id"]} - ${booking["service"]}",
                            "value": "${booking["id"]}"
                          }).toList(),
                          value: selectedBookingId,
                          onChanged: (value, label) {
                            selectedBookingId = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Current Booking Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${selectedBooking["service"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Barber",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${selectedBooking["barber"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${selectedBooking["barbershop"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date & Time",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${DateTime.parse(selectedBooking["date"]).dMMMy} at ${selectedBooking["time"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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
                          color: _getStatusColor(selectedBooking["status"]),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${selectedBooking["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Timeline
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Service Timeline",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  // Timeline Steps
                  ...timelineSteps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    final isLast = index == timelineSteps.length - 1;
                    
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline Icon and Line
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getStepColor(step["status"]),
                                shape: BoxShape.circle,
                                boxShadow: [shadowSm],
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
                                height: 60,
                                color: step["status"] == "completed" || step["status"] == "current"
                                    ? primaryColor
                                    : disabledColor,
                              ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        
                        // Step Content
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: isLast ? 0 : spMd),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${step["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${step["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${step["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: step["status"] == "current" 
                                        ? primaryColor
                                        : disabledBoldColor,
                                    fontWeight: step["status"] == "current" 
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (step["details"] != null) ...[
                                  SizedBox(height: spSm),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: _getStepColor(step["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(
                                        color: _getStepColor(step["status"]).withAlpha(100),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      "${step["details"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Action Buttons (for current step)
            if (selectedBooking["status"] == "In Progress")
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            label: "View Live Progress",
                            size: bs.sm,
                            onPressed: () {
                              ss("Opening live progress view");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Contact Barber",
                            size: bs.sm,
                            onPressed: () {
                              ss("Connecting to barber");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Progress Insights
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Timeline Info",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Track your service progress in real-time\n• Get notified at each milestone\n• Estimated completion time may vary\n• Contact support if you notice any delays",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      height: 1.4,
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return successColor;
      case "in progress":
        return warningColor;
      case "upcoming":
        return infoColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStepColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "current":
        return primaryColor;
      case "pending":
        return disabledColor;
      default:
        return disabledBoldColor;
    }
  }
}
