import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTracking6View extends StatefulWidget {
  @override
  State<GrlTracking6View> createState() => _GrlTracking6ViewState();
}

class _GrlTracking6ViewState extends State<GrlTracking6View> {
  String selectedFilter = 'all';
  
  List<Map<String, dynamic>> shipments = [
    {
      "id": "SHP001",
      "trackingNumber": "1Z999AA1234567890",
      "sender": "TechStore Inc.",
      "recipient": "Sarah Williams",
      "origin": "New York, NY",
      "destination": "Los Angeles, CA",
      "status": "in_transit",
      "currentLocation": "Chicago, IL",
      "estimatedDelivery": "2024-01-25",
      "shipmentType": "Express",
      "weight": "2.5 lbs",
      "dimensions": "12x8x4 inches",
      "value": 299.99,
      "lastUpdate": "2024-01-23 14:30",
      "milestones": [
        {
          "status": "picked_up",
          "location": "New York, NY",
          "timestamp": "2024-01-22 10:00",
          "description": "Package picked up from sender"
        },
        {
          "status": "in_transit",
          "location": "Chicago, IL",
          "timestamp": "2024-01-23 14:30",
          "description": "Package arrived at sorting facility"
        },
      ],
    },
    {
      "id": "SHP002",
      "trackingNumber": "1Z999AA9876543210",
      "sender": "Fashion Boutique",
      "recipient": "Michael Johnson",
      "origin": "Miami, FL",
      "destination": "Seattle, WA",
      "status": "delivered",
      "currentLocation": "Seattle, WA",
      "estimatedDelivery": "2024-01-22",
      "shipmentType": "Standard",
      "weight": "1.8 lbs",
      "dimensions": "10x6x3 inches",
      "value": 89.99,
      "lastUpdate": "2024-01-22 16:45",
      "milestones": [
        {
          "status": "picked_up",
          "location": "Miami, FL",
          "timestamp": "2024-01-20 09:15",
          "description": "Package picked up from sender"
        },
        {
          "status": "in_transit",
          "location": "Atlanta, GA",
          "timestamp": "2024-01-21 11:20",
          "description": "Package in transit"
        },
        {
          "status": "delivered",
          "location": "Seattle, WA",
          "timestamp": "2024-01-22 16:45",
          "description": "Package delivered to recipient"
        },
      ],
    },
    {
      "id": "SHP003",
      "trackingNumber": "1Z999AA5678901234",
      "sender": "Electronics World",
      "recipient": "Emma Davis",
      "origin": "Austin, TX",
      "destination": "Boston, MA",
      "status": "processing",
      "currentLocation": "Austin, TX",
      "estimatedDelivery": "2024-01-28",
      "shipmentType": "Overnight",
      "weight": "5.2 lbs",
      "dimensions": "15x10x8 inches",
      "value": 899.99,
      "lastUpdate": "2024-01-23 08:00",
      "milestones": [
        {
          "status": "processing",
          "location": "Austin, TX",
          "timestamp": "2024-01-23 08:00",
          "description": "Package received and processing"
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipment Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // navigateTo(QRScannerView());
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Track Section
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Track",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Enter tracking number...",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.qr_code,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Status Filter
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: [
                'all', 'processing', 'in_transit', 'delivered', 'exception'
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
                    filter.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: selectedFilter == filter ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Shipments List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Statistics Row
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
                                "${shipments.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Shipments",
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
                                "${shipments.where((s) => s["status"] == "in_transit").length}",
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
                    "Recent Shipments",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Shipment Cards
                  ...shipments.map((shipment) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        // Shipment Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: _getStatusColor(shipment["status"]).withAlpha(20),
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
                                  color: _getStatusColor(shipment["status"]),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  _getStatusIcon(shipment["status"]),
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
                                      "${shipment["trackingNumber"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${shipment["recipient"]}",
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
                                      color: _getStatusColor(shipment["status"]),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${shipment["status"]}".replaceAll('_', ' ').toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${shipment["shipmentType"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Shipment Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Route Information
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "From",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${shipment["origin"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "To",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${shipment["destination"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Current Location
                              if (shipment["currentLocation"] != null) ...[
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "Current Location: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                      Text(
                                        "${shipment["currentLocation"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spMd),
                              ],
                              
                              // Shipment Info
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.scale,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${shipment["weight"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.inventory,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${shipment["dimensions"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
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
                                        "Value",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(shipment["value"] as double).currency}",
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
                              
                              SizedBox(height: spMd),
                              
                              // Estimated Delivery
                              if (shipment["estimatedDelivery"] != null) ...[
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Estimated Delivery: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${shipment["estimatedDelivery"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spMd),
                              ],
                              
                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Track Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        // navigateTo(ShipmentDetailsView());
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.share,
                                    size: bs.sm,
                                    onPressed: () {},
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(CreateShipmentView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'processing':
        return infoColor;
      case 'in_transit':
        return warningColor;
      case 'delivered':
        return successColor;
      case 'exception':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'processing':
        return Icons.refresh;
      case 'in_transit':
        return Icons.local_shipping;
      case 'delivered':
        return Icons.check_circle;
      case 'exception':
        return Icons.error;
      default:
        return Icons.info;
    }
  }
}
