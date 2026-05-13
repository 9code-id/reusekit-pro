import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaLaundryServiceView extends StatefulWidget {
  const HhaLaundryServiceView({super.key});

  @override
  State<HhaLaundryServiceView> createState() => _HhaLaundryServiceViewState();
}

class _HhaLaundryServiceViewState extends State<HhaLaundryServiceView> {
  int selectedTab = 0;
  String selectedStatus = "All";
  String selectedService = "All";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Ready", "value": "Ready"},
    {"label": "Delivered", "value": "Delivered"},
  ];

  List<Map<String, dynamic>> serviceOptions = [
    {"label": "All", "value": "All"},
    {"label": "Wash & Fold", "value": "Wash & Fold"},
    {"label": "Dry Cleaning", "value": "Dry Cleaning"},
    {"label": "Press Only", "value": "Press Only"},
    {"label": "Express Service", "value": "Express Service"},
  ];

  List<Map<String, dynamic>> laundryStats = [
    {
      "title": "Today's Orders",
      "value": 45,
      "icon": Icons.local_laundry_service,
      "color": primaryColor,
    },
    {
      "title": "In Progress",
      "value": 18,
      "icon": Icons.hourglass_empty,
      "color": warningColor,
    },
    {
      "title": "Ready",
      "value": 12,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Revenue",
      "value": 1250,
      "icon": Icons.attach_money,
      "color": infoColor,
      "currency": true,
    },
  ];

  List<Map<String, dynamic>> laundryOrders = [
    {
      "id": "L001",
      "roomNumber": "301",
      "guestName": "John Smith",
      "service": "Wash & Fold",
      "items": 8,
      "status": "Pending",
      "requestedAt": "09:30 AM",
      "estimatedReady": "2:00 PM",
      "price": 24.0,
      "priority": "Normal",
      "specialInstructions": "Gentle cycle for delicates",
    },
    {
      "id": "L002",
      "roomNumber": "205",
      "guestName": "Sarah Johnson",
      "service": "Dry Cleaning",
      "items": 3,
      "status": "In Progress",
      "requestedAt": "08:15 AM",
      "estimatedReady": "6:00 PM",
      "price": 45.0,
      "priority": "Express",
      "specialInstructions": "Handle with care - silk material",
    },
    {
      "id": "L003",
      "roomNumber": "102",
      "guestName": "Mike Davis",
      "service": "Press Only",
      "items": 5,
      "status": "Ready",
      "requestedAt": "07:45 AM",
      "estimatedReady": "11:00 AM",
      "price": 15.0,
      "priority": "Normal",
      "specialInstructions": null,
    },
    {
      "id": "L004",
      "roomNumber": "408",
      "guestName": "Emma Wilson",
      "service": "Express Service",
      "items": 12,
      "status": "Delivered",
      "requestedAt": "06:30 AM",
      "estimatedReady": "10:00 AM",
      "price": 60.0,
      "priority": "Express",
      "specialInstructions": "Same day delivery requested",
    },
    {
      "id": "L005",
      "roomNumber": "156",
      "guestName": "Robert Brown",
      "service": "Wash & Fold",
      "items": 15,
      "status": "In Progress",
      "requestedAt": "10:00 AM",
      "estimatedReady": "4:00 PM",
      "price": 36.0,
      "priority": "Normal",
      "specialInstructions": "Separate whites and colors",
    },
  ];

  List<Map<String, dynamic>> servicePackages = [
    {
      "name": "Standard Wash",
      "description": "Regular washing and folding service",
      "price": 3.0,
      "duration": "4-6 hours",
      "icon": Icons.local_laundry_service,
    },
    {
      "name": "Dry Cleaning",
      "description": "Professional dry cleaning for delicate items",
      "price": 15.0,
      "duration": "24-48 hours",
      "icon": Icons.dry_cleaning,
    },
    {
      "name": "Express Service",
      "description": "Same day service with premium care",
      "price": 5.0,
      "duration": "2-4 hours",
      "icon": Icons.flash_on,
    },
    {
      "name": "Press Only",
      "description": "Professional pressing and steaming",
      "price": 2.5,
      "duration": "2-3 hours",
      "icon": Icons.iron,
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return laundryOrders.where((order) {
      bool statusMatch = selectedStatus == "All" || order["status"] == selectedStatus;
      bool serviceMatch = selectedService == "All" || order["service"] == selectedService;
      return statusMatch && serviceMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Laundry Service",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.list)),
        Tab(text: "Services", icon: Icon(Icons.local_laundry_service)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOrdersTab(),
        _buildServicesTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: laundryStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      stat["icon"] as IconData,
                      color: stat["color"] as Color,
                      size: 28,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      stat["currency"] == true 
                          ? "\$${((stat["value"] as num).toDouble()).currency}"
                          : "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Service Type",
                  items: serviceOptions,
                  value: selectedService,
                  onChanged: (value, label) {
                    selectedService = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Orders List
          Row(
            children: [
              Text(
                "Laundry Orders",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredOrders.length} orders",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          Column(
            spacing: spSm,
            children: filteredOrders.map((order) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(order["status"] as String),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${order["id"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Room ${order["roomNumber"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${order["guestName"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if (order["priority"] == "Express")
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "EXPRESS",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                "${order["service"]} • ${order["items"]} items",
                                style: TextStyle(
                                  fontSize: 14,
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
                            color: _getStatusColor(order["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${order["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(order["status"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Requested: ${order["requestedAt"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Ready by: ${order["estimatedReady"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${((order["price"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    if (order["specialInstructions"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${order["specialInstructions"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        if (order["status"] == "Pending")
                          Expanded(
                            child: QButton(
                              label: "Start Processing",
                              size: bs.sm,
                              onPressed: () {
                                ss("Order ${order["id"]} processing started");
                              },
                            ),
                          ),
                        if (order["status"] == "In Progress")
                          Expanded(
                            child: QButton(
                              label: "Mark Ready",
                              size: bs.sm,
                              onPressed: () {
                                ss("Order ${order["id"]} marked as ready");
                              },
                            ),
                          ),
                        if (order["status"] == "Ready")
                          Expanded(
                            child: QButton(
                              label: "Deliver",
                              size: bs.sm,
                              onPressed: () {
                                ss("Order ${order["id"]} delivered");
                              },
                            ),
                          ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            ss("More options for order ${order["id"]}");
                          },
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
    );
  }

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Service Packages",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: servicePackages.map((service) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            service["icon"] as IconData,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${service["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${((service["price"] as double).toDouble()).currency}/item",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "${service["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${service["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Create Order",
                        size: bs.sm,
                        onPressed: () {
                          ss("Creating order for ${service["name"]}");
                        },
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
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Laundry Reports",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Performance Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildMetricCard("Average Processing Time", "3.2 hours", Icons.timer, successColor),
                    _buildMetricCard("Customer Satisfaction", "94%", Icons.star, warningColor),
                    _buildMetricCard("Daily Revenue", "\$1,250", Icons.attach_money, infoColor),
                    _buildMetricCard("Orders Completed", "156", Icons.check_circle, primaryColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Progress":
        return infoColor;
      case "Ready":
        return successColor;
      case "Delivered":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
