import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDriverDetailView extends StatefulWidget {
  const DlaDriverDetailView({super.key});

  @override
  State<DlaDriverDetailView> createState() => _DlaDriverDetailViewState();
}

class _DlaDriverDetailViewState extends State<DlaDriverDetailView> {
  int currentTab = 0;
  bool loading = false;

  Map<String, dynamic> driverData = {
    "id": "DRV001",
    "name": "Mike Johnson",
    "photo": "https://picsum.photos/150/150?random=1&keyword=person",
    "rating": 4.9,
    "total_deliveries": 1250,
    "status": "online",
    "vehicle": {
      "type": "motorcycle",
      "brand": "Honda",
      "model": "CBR 150R",
      "year": 2022,
      "license_plate": "ABC 1234",
      "color": "Red"
    },
    "contact": {
      "phone": "+1 234 567 8890",
      "email": "mike.johnson@delivery.com",
      "emergency_contact": "+1 234 567 8891"
    },
    "address": {
      "street": "123 Main Street",
      "city": "Downtown",
      "state": "CA",
      "zip": "90210"
    },
    "documents": {
      "license": "valid",
      "insurance": "valid",
      "vehicle_registration": "valid",
      "background_check": "cleared"
    },
    "join_date": "2023-01-15",
    "last_active": "2024-01-15 16:45",
    "current_location": "Downtown Area",
    "completion_rate": 98.5,
    "average_delivery_time": 25,
    "total_earnings": 12450.75,
    "earnings_this_month": 2345.50,
    "earnings_today": 145.50,
    "deliveries_today": 12,
    "deliveries_this_week": 67,
    "deliveries_this_month": 289
  };

  List<Map<String, dynamic>> performanceMetrics = [
    {"label": "On-Time Delivery", "value": 97.8, "unit": "%", "icon": Icons.schedule, "color": "success"},
    {"label": "Customer Rating", "value": 4.9, "unit": "/5", "icon": Icons.star, "color": "warning"},
    {"label": "Response Time", "value": 3.2, "unit": "min", "icon": Icons.speed, "color": "info"},
    {"label": "Cancellation Rate", "value": 1.5, "unit": "%", "icon": Icons.cancel, "color": "danger"},
  ];

  List<Map<String, dynamic>> recentDeliveries = [
    {
      "id": "DL098",
      "customer": "Emma Davis",
      "address": "789 Pine Street",
      "completed_at": "2024-01-15 16:30",
      "payment": 22.0,
      "rating": 5.0,
      "feedback": "Excellent service! Very professional and fast.",
      "delivery_time": 18
    },
    {
      "id": "DL097",
      "customer": "Robert Brown",
      "address": "321 Elm Road",
      "completed_at": "2024-01-15 15:45",
      "payment": 35.0,
      "rating": 4.5,
      "feedback": "Good delivery, package was in perfect condition.",
      "delivery_time": 22
    },
    {
      "id": "DL096",
      "customer": "Lisa Wilson",
      "address": "456 Oak Avenue",
      "completed_at": "2024-01-15 14:20",
      "payment": 18.0,
      "rating": 5.0,
      "feedback": "Very polite and punctual driver.",
      "delivery_time": 15
    },
  ];

  List<Map<String, dynamic>> earnings = [
    {"date": "2024-01-15", "deliveries": 12, "amount": 145.50, "tips": 25.00},
    {"date": "2024-01-14", "deliveries": 15, "amount": 178.25, "tips": 32.50},
    {"date": "2024-01-13", "deliveries": 10, "amount": 125.75, "tips": 18.00},
    {"date": "2024-01-12", "deliveries": 14, "amount": 167.00, "tips": 28.75},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "online":
        return successColor;
      case "busy":
        return warningColor;
      case "offline":
        return disabledColor;
      case "break":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getMetricColor(String colorType) {
    switch (colorType) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "danger":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getMetricColor(metric["color"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  metric["icon"],
                  color: _getMetricColor(metric["color"]),
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                "${(metric["value"] as double).toStringAsFixed(1)}${metric["unit"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: _getMetricColor(metric["color"]),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${metric["label"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage("${driverData["photo"]}"),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _getStatusColor(driverData["status"]),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${driverData["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Driver ID: ${driverData["id"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < (driverData["rating"] as double) ? Icons.star : Icons.star_border,
                                    color: index < (driverData["rating"] as double) ? warningColor : disabledColor,
                                    size: 16,
                                  );
                                }),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(driverData["rating"] as double).toStringAsFixed(1)} • ${driverData["total_deliveries"]} deliveries",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(driverData["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${driverData["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor(driverData["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Since ${driverData["join_date"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.motorcycle,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${driverData["vehicle"]["brand"]} ${driverData["vehicle"]["model"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Plate: ${driverData["vehicle"]["license_plate"]} • ${driverData["vehicle"]["year"]}",
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
              ],
            ),
          ),
          
          SizedBox(height: spLg),
          
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            minItemWidth: 150,
            children: performanceMetrics.map((metric) => _buildMetricCard(metric)).toList(),
          ),
          
          SizedBox(height: spLg),
          
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Earnings",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(driverData["earnings_today"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${driverData["deliveries_today"]} deliveries",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
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
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This Month",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(driverData["earnings_this_month"] as double).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${driverData["deliveries_this_month"]} deliveries",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spLg),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Send Message",
              onPressed: () {},
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call Driver",
                  color: successColor,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Location",
                  color: infoColor,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Deliveries",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          ...recentDeliveries.map((delivery) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order #${delivery["id"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${delivery["customer"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (delivery["rating"] as double) ? Icons.star : Icons.star_border,
                                color: index < (delivery["rating"] as double) ? warningColor : disabledColor,
                                size: 14,
                              );
                            }),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${(delivery["payment"] as double).toStringAsFixed(2)}",
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
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${delivery["address"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Completed in ${delivery["delivery_time"]} minutes",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${delivery["completed_at"]}".split(" ")[1],
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if (delivery["feedback"] != null && delivery["feedback"].toString().isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Customer Feedback:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${delivery["feedback"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEarningsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  "Earnings Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Earnings",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(driverData["total_earnings"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                            "This Month",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(driverData["earnings_this_month"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
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
          
          SizedBox(height: spLg),
          
          Text(
            "Daily Earnings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spSm),
          
          ...earnings.map((earning) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${earning["date"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${earning["deliveries"]} deliveries",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${(earning["amount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      if ((earning["tips"] as double) > 0) ...[
                        SizedBox(height: spXs),
                        Text(
                          "Tips: \$${(earning["tips"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Driver Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.person)),
        Tab(text: "Deliveries", icon: Icon(Icons.local_shipping)),
        Tab(text: "Earnings", icon: Icon(Icons.attach_money)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDeliveriesTab(),
        _buildEarningsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
