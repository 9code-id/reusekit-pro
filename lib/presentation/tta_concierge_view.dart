import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaConciergeView extends StatefulWidget {
  const TtaConciergeView({super.key});

  @override
  State<TtaConciergeView> createState() => _TtaConciergeViewState();
}

class _TtaConciergeViewState extends State<TtaConciergeView> {
  String selectedCategory = "All";
  String requestMessage = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Transportation", "value": "Transportation"},
    {"label": "Dining", "value": "Dining"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Shopping", "value": "Shopping"},
    {"label": "General", "value": "General"},
  ];

  List<Map<String, dynamic>> services = [
    {
      "title": "Restaurant Reservations",
      "description": "Book tables at the finest restaurants in the city",
      "category": "Dining",
      "icon": Icons.restaurant,
      "color": primaryColor,
      "price": "Free",
      "duration": "Immediate",
    },
    {
      "title": "Airport Transfer",
      "description": "Luxury car service to and from the airport",
      "category": "Transportation",
      "icon": Icons.airport_shuttle,
      "color": infoColor,
      "price": "\$75",
      "duration": "45-60 min",
    },
    {
      "title": "Theater Tickets",
      "description": "Premium seats for shows, concerts and events",
      "category": "Entertainment",
      "icon": Icons.theater_comedy,
      "color": warningColor,
      "price": "Varies",
      "duration": "Same day",
    },
    {
      "title": "Shopping Assistant",
      "description": "Personal shopping guide for luxury boutiques",
      "category": "Shopping",
      "icon": Icons.shopping_bag,
      "color": successColor,
      "price": "\$50/hour",
      "duration": "2-4 hours",
    },
    {
      "title": "City Tours",
      "description": "Guided tours of famous landmarks and attractions",
      "category": "Entertainment",
      "icon": Icons.tour,
      "color": secondaryColor,
      "price": "\$120",
      "duration": "4-6 hours",
    },
    {
      "title": "Car Rental",
      "description": "Luxury and standard vehicle rentals",
      "category": "Transportation",
      "icon": Icons.directions_car,
      "color": dangerColor,
      "price": "\$80/day",
      "duration": "Pick-up ready",
    },
    {
      "title": "Event Planning",
      "description": "Special occasion and business event coordination",
      "category": "General",
      "icon": Icons.event,
      "color": primaryColor,
      "price": "Quote",
      "duration": "1-7 days",
    },
    {
      "title": "Spa Appointments",
      "description": "Book treatments at premium spa facilities",
      "category": "General",
      "icon": Icons.spa,
      "color": successColor,
      "price": "\$150-300",
      "duration": "1-3 hours",
    },
  ];

  List<Map<String, dynamic>> recentRequests = [
    {
      "id": "REQ001",
      "service": "Restaurant Reservation",
      "details": "Table for 4 at Le Bernardin, 8 PM tonight",
      "status": "Confirmed",
      "statusColor": successColor,
      "timestamp": "2 hours ago",
      "concierge": "Sarah Johnson",
    },
    {
      "id": "REQ002",
      "service": "Theater Tickets",
      "details": "2 tickets for Hamilton - Saturday show",
      "status": "In Progress",
      "statusColor": warningColor,
      "timestamp": "1 day ago",
      "concierge": "Michael Chen",
    },
    {
      "id": "REQ003",
      "service": "Airport Transfer",
      "details": "Pickup at 6 AM tomorrow to JFK Airport",
      "status": "Scheduled",
      "statusColor": infoColor,
      "timestamp": "2 days ago",
      "concierge": "Emma Wilson",
    },
  ];

  List<Map<String, dynamic>> get filteredServices {
    if (selectedCategory == "All") {
      return services;
    }
    return services.where((service) => 
        service["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Concierge Services"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showRequestHistory();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "24/7 Concierge Service",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Your personal assistant for exceptional experiences",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Available",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              Text(
                                "24/7",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Response Time",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              Text(
                                "< 15 min",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Request
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Request",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QMemoField(
                    label: "How can we assist you today?",
                    value: requestMessage,
                    hint: "Describe your request in detail...",
                    onChanged: (value) {
                      requestMessage = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Send Request",
                          size: bs.sm,
                          onPressed: () {
                            if (requestMessage.isNotEmpty) {
                              ss("Request sent successfully!");
                              requestMessage = "";
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.call,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category Filter
            Text(
              "Popular Services",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Services Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: filteredServices.map((service) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledOutlineBorderColor),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (service["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          service["icon"] as IconData,
                          color: service["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${service["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${service["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${service["price"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: service["color"] as Color,
                                  ),
                                ),
                                Text(
                                  "${service["duration"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ss("${service["title"]} request started");
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (service["color"] as Color).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: service["color"] as Color,
                                size: 16,
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

            // Recent Requests
            if (recentRequests.isNotEmpty) ...[
              Text(
                "Recent Requests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              ...recentRequests.map((request) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledOutlineBorderColor),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${request["service"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                              color: (request["statusColor"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${request["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: request["statusColor"] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${request["details"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: disabledBoldColor,
                            size: 14,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${request["concierge"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${request["timestamp"]}",
                            style: TextStyle(
                              fontSize: 11,
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
          ],
        ),
      ),
    );
  }

  void _showRequestHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Request History",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Expanded(
                child: ListView.builder(
                  itemCount: recentRequests.length + 5, // Adding some dummy history
                  itemBuilder: (context, index) {
                    if (index < recentRequests.length) {
                      final request = recentRequests[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${request["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (request["statusColor"] as Color).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${request["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: request["statusColor"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${request["service"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${request["details"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Dummy historical data
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "REQ00${index + 1}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "Completed",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Historical Request ${index + 1}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Previous service request - completed successfully",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
