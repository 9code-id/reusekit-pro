import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaDeliveryScheduleView extends StatefulWidget {
  const FmaDeliveryScheduleView({super.key});

  @override
  State<FmaDeliveryScheduleView> createState() => _FmaDeliveryScheduleViewState();
}

class _FmaDeliveryScheduleViewState extends State<FmaDeliveryScheduleView> {
  int currentTab = 0;
  DateTime selectedDate = DateTime.now();
  String selectedStatus = "All";
  String selectedDriver = "All";
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Delayed", "value": "Delayed"},
    {"label": "Failed", "value": "Failed"},
  ];
  
  List<Map<String, dynamic>> driverItems = [
    {"label": "All", "value": "All"},
    {"label": "Mike Johnson", "value": "driver1"},
    {"label": "Sarah Wilson", "value": "driver2"},
    {"label": "Tom Brown", "value": "driver3"},
    {"label": "Lisa Davis", "value": "driver4"},
  ];

  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL-001",
      "customerName": "Pizza Palace",
      "address": "123 Main St, Downtown",
      "phone": "+1 234 567 8901",
      "items": 5,
      "total": 245.50,
      "scheduledTime": "11:30 AM",
      "estimatedTime": "11:45 AM",
      "driver": "Mike Johnson",
      "status": "In Transit",
      "priority": "High",
      "distance": "2.5 km",
    },
    {
      "id": "DEL-002",
      "customerName": "Burger House",
      "address": "456 Oak Ave, Midtown",
      "phone": "+1 234 567 8902",
      "items": 3,
      "total": 89.25,
      "scheduledTime": "12:00 PM",
      "estimatedTime": "12:15 PM",
      "driver": "Sarah Wilson",
      "status": "Scheduled",
      "priority": "Medium",
      "distance": "1.8 km",
    },
    {
      "id": "DEL-003",
      "customerName": "Cafe Central",
      "address": "789 Pine St, Uptown",
      "phone": "+1 234 567 8903",
      "items": 8,
      "total": 156.75,
      "scheduledTime": "12:30 PM",
      "estimatedTime": "12:30 PM",
      "driver": "Tom Brown",
      "status": "Delivered",
      "priority": "Low",
      "distance": "3.2 km",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return infoColor;
      case "In Transit":
        return warningColor;
      case "Delivered":
        return successColor;
      case "Delayed":
        return dangerColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Delivery Schedule",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Today", icon: Icon(Icons.today)),
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Drivers", icon: Icon(Icons.local_shipping)),
        Tab(text: "Routes", icon: Icon(Icons.map)),
      ],
      tabChildren: [
        _buildTodayTab(),
        _buildScheduleTab(),
        _buildDriversTab(),
        _buildRoutesTab(),
      ],
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Date and Filter Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Select Date",
                        value: selectedDate,
                        onChanged: (value) {
                          selectedDate = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusItems,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Driver",
                        items: driverItems,
                        value: selectedDriver,
                        onChanged: (value, label) {
                          selectedDriver = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(width: 4, color: primaryColor),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Deliveries",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "18",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(width: 4, color: successColor),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Deliveries List
          ...deliveries.map((delivery) => Container(
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${delivery["id"]} - ${delivery["customerName"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: disabledBoldColor),
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
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${delivery["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${delivery["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor("${delivery["status"]}"),
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${delivery["priority"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${delivery["priority"]}",
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor("${delivery["priority"]}"),
                            ),
                          ),
                        ),
                      ],
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
                            "Driver: ${delivery["driver"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Distance: ${delivery["distance"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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
                            "Scheduled: ${delivery["scheduledTime"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Total: \$${((delivery["total"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 12,
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
                    Expanded(
                      child: QButton(
                        label: "Track",
                        icon: Icons.my_location,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
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
                        "Schedule New Delivery",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Add",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                QTextField(
                  label: "Customer Name",
                  value: "",
                  onChanged: (value) {},
                ),
                QTextField(
                  label: "Delivery Address",
                  value: "",
                  onChanged: (value) {},
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Delivery Date",
                        value: DateTime.now(),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Time",
                        value: TimeOfDay.now(),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Assign Driver",
                  items: driverItems.where((item) => item["value"] != "All").toList(),
                  value: "",
                  onChanged: (value, label) {},
                ),
              ],
            ),
          ),

          // Weekly Schedule Overview
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Weekly Schedule Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"].map((day) => 
                  Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: disabledOutlineBorderColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          child: Text(
                            day,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  day == "Monday" ? "15 deliveries" :
                                  day == "Tuesday" ? "12 deliveries" :
                                  day == "Wednesday" ? "18 deliveries" :
                                  day == "Thursday" ? "14 deliveries" :
                                  day == "Friday" ? "20 deliveries" :
                                  day == "Saturday" ? "22 deliveries" : "8 deliveries",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                day == "Saturday" || day == "Sunday" ? "Peak hours: 6-9 PM" : "Peak hours: 11 AM-2 PM",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriversTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Driver Performance
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Driver Performance Today",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...["Mike Johnson", "Sarah Wilson", "Tom Brown", "Lisa Davis"].map((driver) => 
                  Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  driver.split(' ').map((n) => n[0]).join(''),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driver,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    driver == "Mike Johnson" ? "Currently delivering" :
                                    driver == "Sarah Wilson" ? "Available" :
                                    driver == "Tom Brown" ? "On break" : "Offline",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: driver == "Mike Johnson" ? warningColor :
                                             driver == "Sarah Wilson" ? successColor :
                                             driver == "Tom Brown" ? infoColor : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  driver == "Mike Johnson" ? "8/10" :
                                  driver == "Sarah Wilson" ? "6/8" :
                                  driver == "Tom Brown" ? "5/7" : "0/6",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "deliveries",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
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
                                    "Rating",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ...List.generate(5, (index) => Icon(
                                        Icons.star,
                                        size: 12,
                                        color: index < 4 ? warningColor : disabledColor,
                                      )),
                                      SizedBox(width: spXs),
                                      Text(
                                        "4.8",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "On-time Rate",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    driver == "Mike Johnson" ? "95%" :
                                    driver == "Sarah Wilson" ? "98%" :
                                    driver == "Tom Brown" ? "92%" : "96%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
                ).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Route Optimization
          Container(
            padding: EdgeInsets.all(spSm),
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
                        "Route Optimization",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    QButton(
                      label: "Optimize",
                      icon: Icons.route,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Distance",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "45.8 km",
                                  style: TextStyle(
                                    fontSize: 16,
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
                                  "Est. Time",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "3h 25m",
                                  style: TextStyle(
                                    fontSize: 16,
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
                                  "Fuel Cost",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "\$12.50",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
              ],
            ),
          ),

          // Active Routes
          Container(
            padding: EdgeInsets.all(spSm),
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
                  "Active Routes",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...["Route A - Downtown", "Route B - Midtown", "Route C - Uptown"].map((route) => 
                  Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: route.contains("A") ? successColor :
                                       route.contains("B") ? warningColor : infoColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                route,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              route.contains("A") ? "6 stops" :
                              route.contains("B") ? "4 stops" : "8 stops",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Driver: ${route.contains("A") ? "Mike Johnson" : route.contains("B") ? "Sarah Wilson" : "Tom Brown"}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: route.contains("A") ? successColor.withAlpha(20) :
                                       route.contains("B") ? warningColor.withAlpha(20) : infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                route.contains("A") ? "In Progress" :
                                route.contains("B") ? "Starting" : "Completed",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: route.contains("A") ? successColor :
                                         route.contains("B") ? warningColor : infoColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
