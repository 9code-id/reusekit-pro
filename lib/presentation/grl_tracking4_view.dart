import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTracking4View extends StatefulWidget {
  @override
  State<GrlTracking4View> createState() => _GrlTracking4ViewState();
}

class _GrlTracking4ViewState extends State<GrlTracking4View> {
  String selectedFilter = 'all';
  String searchQuery = '';
  
  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD001",
      "customerName": "Sarah Johnson",
      "items": ["Wireless Headphones", "Phone Case"],
      "totalAmount": 159.99,
      "status": "delivered",
      "trackingNumber": "TRK123456789",
      "orderDate": "2024-01-15",
      "deliveryDate": "2024-01-18",
      "shippingAddress": "123 Main St, New York, NY 10001",
      "estimatedDelivery": "Jan 18, 2024",
      "carrier": "FedEx",
      "progress": 100,
    },
    {
      "id": "ORD002", 
      "customerName": "Mike Chen",
      "items": ["Gaming Mouse", "Keyboard", "Monitor"],
      "totalAmount": 459.97,
      "status": "in_transit",
      "trackingNumber": "TRK987654321",
      "orderDate": "2024-01-20",
      "deliveryDate": null,
      "shippingAddress": "456 Oak Ave, Los Angeles, CA 90210",
      "estimatedDelivery": "Jan 25, 2024",
      "carrier": "UPS",
      "progress": 65,
    },
    {
      "id": "ORD003",
      "customerName": "Emma Davis",
      "items": ["Laptop Stand", "USB Cable"],
      "totalAmount": 89.99,
      "status": "processing",
      "trackingNumber": "TRK456789123",
      "orderDate": "2024-01-22",
      "deliveryDate": null,
      "shippingAddress": "789 Pine St, Chicago, IL 60601",
      "estimatedDelivery": "Jan 27, 2024",
      "carrier": "DHL",
      "progress": 25,
    },
    {
      "id": "ORD004",
      "customerName": "James Wilson",
      "items": ["Smart Watch", "Charging Cable"],
      "totalAmount": 299.99,
      "status": "cancelled",
      "trackingNumber": "TRK789123456",
      "orderDate": "2024-01-19",
      "deliveryDate": null,
      "shippingAddress": "321 Elm St, Houston, TX 77001",
      "estimatedDelivery": null,
      "carrier": "FedEx",
      "progress": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search orders...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Filter Chips
                QHorizontalScroll(
                  children: [
                    'all', 'processing', 'in_transit', 'delivered', 'cancelled'
                  ].map((filter) => GestureDetector(
                    onTap: () {
                      selectedFilter = filter;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedFilter == filter ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedFilter == filter ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        filter.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedFilter == filter ? Colors.white : primaryColor,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Orders List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Overview
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${orders.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Orders",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${orders.where((o) => o["status"] == "in_transit").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "In Transit",
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
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Recent Orders",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Order Cards
                  ...orders.map((order) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        // Order Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order["status"]).withAlpha(20),
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
                                  color: _getStatusColor(order["status"]),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  _getStatusIcon(order["status"]),
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
                                      "${order["id"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${order["customerName"]}",
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
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(order["status"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${order["status"]}".replaceAll('_', ' ').toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Order Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Items
                              Text(
                                "Items: ${(order["items"] as List).join(", ")}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              
                              SizedBox(height: spSm),
                              
                              // Amount and Tracking
                              Row(
                                children: [
                                  Text(
                                    "\$${(order["totalAmount"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${order["trackingNumber"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Progress Bar
                              if (order["status"] != "cancelled") ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Progress",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${order["progress"]}%",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: _getStatusColor(order["status"]),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: (order["progress"] as int) / 100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(order["status"]),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spMd),
                              ],
                              
                              // Delivery Info
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_shipping,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${order["carrier"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  if (order["estimatedDelivery"] != null) ...[
                                    Icon(
                                      Icons.schedule,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${order["estimatedDelivery"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Track Order",
                                      size: bs.sm,
                                      onPressed: () {
                                        // navigateTo(TrackingDetailsView());
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.more_vert,
                                    size: bs.sm,
                                    onPressed: () {},
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
      case 'delivered':
        return successColor;
      case 'in_transit':
        return warningColor;
      case 'processing':
        return infoColor;
      case 'cancelled':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'delivered':
        return Icons.check_circle;
      case 'in_transit':
        return Icons.local_shipping;
      case 'processing':
        return Icons.refresh;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
}
