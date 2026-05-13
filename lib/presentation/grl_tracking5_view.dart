import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTracking5View extends StatefulWidget {
  @override
  State<GrlTracking5View> createState() => _GrlTracking5ViewState();
}

class _GrlTracking5ViewState extends State<GrlTracking5View> {
  String selectedTab = 'active';
  
  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL001",
      "customerName": "Alice Cooper",
      "customerPhone": "+1 (555) 123-4567",
      "pickupAddress": "789 Business Ave, NYC",
      "deliveryAddress": "456 Residential St, Brooklyn",
      "packageType": "Documents",
      "priority": "urgent",
      "status": "assigned",
      "estimatedTime": "30 min",
      "distance": "12.5 km",
      "paymentAmount": 25.50,
      "specialInstructions": "Ring doorbell twice",
      "assignedAt": "2024-01-22 14:30",
    },
    {
      "id": "DEL002",
      "customerName": "Robert Smith",
      "customerPhone": "+1 (555) 987-6543",
      "pickupAddress": "321 Mall Plaza, Queens",
      "deliveryAddress": "123 Oak Street, Manhattan",
      "packageType": "Electronics",
      "priority": "standard",
      "status": "in_progress",
      "estimatedTime": "45 min",
      "distance": "8.2 km",
      "paymentAmount": 18.75,
      "specialInstructions": "Leave at front desk",
      "assignedAt": "2024-01-22 13:15",
    },
    {
      "id": "DEL003",
      "customerName": "Maria Garcia",
      "customerPhone": "+1 (555) 456-7890",
      "pickupAddress": "654 Restaurant Row, Manhattan",
      "deliveryAddress": "987 Home Ave, Bronx",
      "packageType": "Food",
      "priority": "express",
      "status": "completed",
      "estimatedTime": "25 min",
      "distance": "15.3 km",
      "paymentAmount": 32.25,
      "specialInstructions": "Handle with care - fragile items",
      "assignedAt": "2024-01-22 12:00",
      "completedAt": "2024-01-22 12:28",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // navigateTo(DeliveryMapView());
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Driver Status Panel
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "John Delivery",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Driver ID: DR001",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Online",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
                        Text(
                          "Today's Earnings",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          "\$142.50",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${deliveries.where((d) => d["status"] == "completed").length}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${deliveries.where((d) => d["status"] == "in_progress").length}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "4.8★",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
          
          // Tab Navigation
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                'active', 'completed', 'all'
              ].map((tab) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedTab = tab;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      color: selectedTab == tab ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      tab.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: selectedTab == tab ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Deliveries List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  ...deliveries.where((delivery) {
                    if (selectedTab == 'all') return true;
                    if (selectedTab == 'active') return delivery["status"] != "completed";
                    if (selectedTab == 'completed') return delivery["status"] == "completed";
                    return true;
                  }).map((delivery) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        // Delivery Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: _getStatusColor(delivery["status"]).withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(delivery["status"]),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  _getStatusIcon(delivery["status"]),
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
                                      "${delivery["id"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${delivery["customerName"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(delivery["priority"]),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${delivery["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "\$${(delivery["paymentAmount"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Delivery Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Package Info
                              Row(
                                children: [
                                  Icon(
                                    Icons.inventory,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${delivery["packageType"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${delivery["estimatedTime"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Pickup Address
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pickup",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                        Text(
                                          "${delivery["pickupAddress"]}",
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
                              
                              // Connecting Line
                              Container(
                                margin: EdgeInsets.only(left: 8, top: spXs, bottom: spXs),
                                width: 2,
                                height: 20,
                                color: disabledColor,
                              ),
                              
                              // Delivery Address
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Delivery",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: dangerColor,
                                          ),
                                        ),
                                        Text(
                                          "${delivery["deliveryAddress"]}",
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
                              
                              SizedBox(height: spMd),
                              
                              // Special Instructions
                              if (delivery["specialInstructions"] != null) ...[
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${delivery["specialInstructions"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: warningColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spMd),
                              ],
                              
                              // Action Buttons
                              Row(
                                children: [
                                  QButton(
                                    icon: Icons.phone,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.navigation,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QButton(
                                      label: delivery["status"] == "assigned" 
                                          ? "Start Delivery" 
                                          : delivery["status"] == "in_progress"
                                              ? "Mark Complete"
                                              : "View Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        // Handle status change
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'assigned':
        return infoColor;
      case 'in_progress':
        return warningColor;
      case 'completed':
        return successColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'assigned':
        return Icons.assignment;
      case 'in_progress':
        return Icons.local_shipping;
      case 'completed':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'urgent':
        return dangerColor;
      case 'express':
        return warningColor;
      case 'standard':
        return primaryColor;
      default:
        return primaryColor;
    }
  }
}
