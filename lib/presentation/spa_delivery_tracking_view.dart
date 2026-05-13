import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaDeliveryTrackingView extends StatefulWidget {
  const SpaDeliveryTrackingView({super.key});

  @override
  State<SpaDeliveryTrackingView> createState() => _SpaDeliveryTrackingViewState();
}

class _SpaDeliveryTrackingViewState extends State<SpaDeliveryTrackingView> {
  String orderNumber = "SPA-ORD-2024-001";
  int currentStep = 2;
  bool isLoading = false;
  
  List<Map<String, dynamic>> trackingSteps = [
    {
      "title": "Order Confirmed",
      "description": "Your spa products order has been confirmed",
      "time": "Dec 15, 2024 at 2:30 PM",
      "icon": Icons.check_circle,
      "status": "completed"
    },
    {
      "title": "Processing",
      "description": "Products are being prepared for delivery",
      "time": "Dec 15, 2024 at 3:15 PM",
      "icon": Icons.inventory,
      "status": "completed"
    },
    {
      "title": "Out for Delivery",
      "description": "Your order is on the way to your spa location",
      "time": "Dec 16, 2024 at 9:00 AM",
      "icon": Icons.local_shipping,
      "status": "active"
    },
    {
      "title": "Delivered",
      "description": "Order will be delivered to your spa",
      "time": "Estimated: Dec 16, 2024 at 2:00 PM",
      "icon": Icons.home,
      "status": "pending"
    },
  ];
  
  Map<String, dynamic> deliveryInfo = {
    "driverName": "John Martinez",
    "driverPhone": "+1 (555) 123-4567",
    "vehicleNumber": "DELV-789",
    "estimatedArrival": "2:00 PM",
    "currentLocation": "Downtown District",
    "address": "123 Wellness Street, Spa District",
    "specialInstructions": "Call upon arrival, use spa service entrance"
  };
  
  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Premium Massage Oil Set",
      "quantity": 5,
      "price": 89.99,
      "image": "https://picsum.photos/80/80?random=101&keyword=oil"
    },
    {
      "name": "Organic Face Mask Collection",
      "quantity": 12,
      "price": 149.99,
      "image": "https://picsum.photos/80/80?random=102&keyword=mask"
    },
    {
      "name": "Aromatherapy Candle Set",
      "quantity": 8,
      "price": 79.99,
      "image": "https://picsum.photos/80/80?random=103&keyword=candle"
    },
    {
      "name": "Spa Towel Premium Pack",
      "quantity": 20,
      "price": 199.99,
      "image": "https://picsum.photos/80/80?random=104&keyword=towel"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Tracking"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _refreshTracking();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Order Header
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                Icons.local_shipping,
                                color: primaryColor,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order #$orderNumber",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Spa Supplies Delivery",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Expected: ${deliveryInfo["estimatedArrival"]}",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "IN TRANSIT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Tracking Steps
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tracking Progress",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        ...trackingSteps.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> step = entry.value;
                          return _buildTrackingStep(step, index, trackingSteps.length);
                        }).toList(),
                      ],
                    ),
                  ),

                  // Driver Info
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Text(
                          "Delivery Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusMd),
                              ),
                              child: Icon(
                                Icons.person,
                                color: successColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${deliveryInfo["driverName"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Delivery Driver • ${deliveryInfo["vehicleNumber"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Currently at: ${deliveryInfo["currentLocation"]}",
                                    style: TextStyle(
                                      color: infoColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.phone,
                              size: bs.sm,
                              color: successColor,
                              onPressed: () {
                                _callDriver();
                              },
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${deliveryInfo["address"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (deliveryInfo["specialInstructions"] != null)
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
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
                                    "${deliveryInfo["specialInstructions"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Order Items
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Order Items",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${orderItems.length} items",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        ...orderItems.map((item) => _buildOrderItem(item)).toList(),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: disabledOutlineBorderColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Total Amount:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${(orderItems.fold(0.0, (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)))).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact Support",
                          size: bs.md,
                          color: infoColor,
                          onPressed: () {
                            _contactSupport();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Track on Map",
                          size: bs.md,
                          onPressed: () {
                            _trackOnMap();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTrackingStep(Map<String, dynamic> step, int index, int totalSteps) {
    Color stepColor;
    bool isLast = index == totalSteps - 1;
    
    switch (step["status"]) {
      case "completed":
        stepColor = successColor;
        break;
      case "active":
        stepColor = primaryColor;
        break;
      default:
        stepColor = disabledColor;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: stepColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                step["icon"],
                color: Colors.white,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: stepColor.withAlpha(100),
                margin: EdgeInsets.symmetric(vertical: spXs),
              ),
          ],
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${step["title"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: stepColor,
                ),
              ),
              Text(
                "${step["description"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Text(
                "${step["time"]}",
                style: TextStyle(
                  color: stepColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!isLast) SizedBox(height: spMd),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Qty: ${item["quantity"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${((item["price"] as double) * (item["quantity"] as int)).toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  void _refreshTracking() async {
    isLoading = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    setState(() {});
    ss("Tracking information updated");
  }

  void _callDriver() {
    ss("Calling driver ${deliveryInfo["driverName"]}...");
  }

  void _contactSupport() {
    ss("Contacting delivery support...");
  }

  void _trackOnMap() {
    ss("Opening map tracking...");
  }
}
