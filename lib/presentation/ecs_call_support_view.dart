import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsCallSupportView extends StatefulWidget {
  const EcsCallSupportView({super.key});

  @override
  State<EcsCallSupportView> createState() => _EcsCallSupportViewState();
}

class _EcsCallSupportViewState extends State<EcsCallSupportView> {
  List<Map<String, dynamic>> supportNumbers = [
    {
      "title": "Customer Service",
      "number": "+1 (800) 123-4567",
      "description": "General inquiries, order status, returns & exchanges",
      "hours": "Mon-Fri: 9AM-8PM, Sat-Sun: 10AM-6PM",
      "waitTime": "2-3 minutes",
      "icon": Icons.headset_mic,
      "color": primaryColor,
    },
    {
      "title": "Technical Support",
      "number": "+1 (800) 123-4568",
      "description": "App issues, website problems, account access",
      "hours": "24/7 Available",
      "waitTime": "1-2 minutes",
      "icon": Icons.build,
      "color": infoColor,
    },
    {
      "title": "Order & Shipping",
      "number": "+1 (800) 123-4569",
      "description": "Delivery issues, tracking, shipping questions",
      "hours": "Mon-Fri: 8AM-10PM, Weekends: 9AM-7PM",
      "waitTime": "3-5 minutes",
      "icon": Icons.local_shipping,
      "color": warningColor,
    },
    {
      "title": "Returns & Refunds",
      "number": "+1 (800) 123-4570",
      "description": "Product returns, refund status, exchange requests",
      "hours": "Mon-Fri: 9AM-6PM",
      "waitTime": "5-7 minutes",
      "icon": Icons.assignment_return,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> recentCalls = [
    {
      "type": "Customer Service",
      "number": "+1 (800) 123-4567",
      "date": "Dec 10, 2024",
      "time": "2:30 PM",
      "duration": "8 min 45 sec",
      "status": "Completed",
    },
    {
      "type": "Technical Support",
      "number": "+1 (800) 123-4568",
      "date": "Dec 8, 2024",
      "time": "11:15 AM",
      "duration": "5 min 20 sec",
      "status": "Completed",
    },
    {
      "type": "Order & Shipping",
      "number": "+1 (800) 123-4569",
      "date": "Dec 5, 2024",
      "time": "4:45 PM",
      "duration": "3 min 15 sec",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Support"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: GestureDetector(
              onTap: () {
                // Show callback request
                _showCallbackRequest();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.phone_callback,
                    size: 20,
                    color: primaryColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Request Callback",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Need Immediate Help?",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Call our support team directly for fast assistance with your orders and account.",
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
            ),

            SizedBox(height: spMd),

            // Support Numbers
            Text(
              "Support Numbers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...supportNumbers.map((support) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (support["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            support["icon"] as IconData,
                            color: support["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${support["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${support["number"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: support["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            _makeCall(support["number"] as String);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${support["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${support["hours"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w500,
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 12,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Wait: ${support["waitTime"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
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
              );
            }).toList(),

            SizedBox(height: spMd),

            // Emergency Contact
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: dangerColor.withAlpha(30),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emergency,
                    color: dangerColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emergency Support",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "For urgent issues only: +1 (800) 911-HELP",
                          style: TextStyle(
                            fontSize: 14,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.phone,
                    size: bs.sm,
                    onPressed: () {
                      _makeCall("+1 (800) 911-HELP");
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Recent Calls
            Text(
              "Recent Calls",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...recentCalls.map((call) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.phone,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${call["type"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${call["number"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${call["date"]} • ${call["time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${call["duration"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                        _makeCall(call["number"] as String);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _makeCall(String phoneNumber) {
    // Simulate making a call
    ss("Calling $phoneNumber...");
  }

  void _showCallbackRequest() {
    showDialog(
      context: context,
      builder: (context) {
        String phoneNumber = "";
        String preferredTime = "";
        String issue = "";

        return AlertDialog(
          title: Text("Request Callback"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Your Phone Number",
                value: phoneNumber,
                onChanged: (value) => phoneNumber = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Preferred Time",
                value: preferredTime,
                onChanged: (value) => preferredTime = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Brief Description of Issue",
                value: issue,
                onChanged: (value) => issue = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Request Callback",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Callback request submitted successfully!");
              },
            ),
          ],
        );
      },
    );
  }
}
