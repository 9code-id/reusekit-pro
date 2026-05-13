import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaOrderView extends StatefulWidget {
  const DlaOrderView({super.key});

  @override
  State<DlaOrderView> createState() => _DlaOrderViewState();
}

class _DlaOrderViewState extends State<DlaOrderView> {
  String currentStep = "pickup"; // pickup, in_transit, delivered
  
  Map<String, dynamic> orderData = {
    "id": "DL001",
    "restaurant": "Pizza Palace",
    "restaurantPhone": "+1 (555) 123-4567",
    "customer": "John Smith",
    "customerPhone": "+1 (555) 987-6543",
    "pickupAddress": "123 Main Street, Downtown",
    "deliveryAddress": "456 Oak Avenue, Apartment 2B",
    "distance": "3.2 km",
    "estimatedTime": "25 min",
    "payment": 12.50,
    "tip": 3.00,
    "orderTotal": 15.50,
    "specialInstructions": "Please ring the doorbell twice and leave at the door.",
    "items": [
      {"name": "Large Pepperoni Pizza", "quantity": 1, "price": 14.99},
      {"name": "Garlic Bread", "quantity": 1, "price": 4.99},
      {"name": "Coca Cola 2L", "quantity": 1, "price": 2.99},
    ],
  };
  
  Map<String, dynamic> stepData = {
    "pickup": {
      "title": "Pickup Order",
      "subtitle": "Collect the order from restaurant",
      "icon": Icons.store,
      "completed": false,
    },
    "in_transit": {
      "title": "In Transit",
      "subtitle": "Delivering to customer",
      "icon": Icons.local_shipping,
      "completed": false,
    },
    "delivered": {
      "title": "Delivered",
      "subtitle": "Order completed successfully",
      "icon": Icons.check_circle,
      "completed": false,
    },
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order #${orderData["id"]}"),
        actions: [
          IconButton(
            onPressed: () {
              // Call restaurant
              _showCallOptions();
            },
            icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {
              // Order options
              _showOrderOptions();
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Stepper
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Delivery Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildStepIndicator(),
                ],
              ),
            ),
            
            // Order Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "\$${((orderData["payment"] as double) + (orderData["tip"] as double)).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(),
                  
                  ...(orderData["items"] as List).map((item) => _buildOrderItem(item)),
                  
                  Divider(),
                  
                  _buildSummaryRow("Subtotal", "\$${(orderData["orderTotal"] as double).toStringAsFixed(2)}"),
                  _buildSummaryRow("Delivery Fee", "\$${(orderData["payment"] as double).toStringAsFixed(2)}"),
                  _buildSummaryRow("Tip", "\$${(orderData["tip"] as double).toStringAsFixed(2)}", color: successColor),
                ],
              ),
            ),
            
            // Restaurant Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Restaurant",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderData["restaurant"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${orderData["pickupAddress"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          // Call restaurant
                          ss("Calling ${orderData["restaurant"]}...");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Customer Information
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderData["customer"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${orderData["deliveryAddress"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          // Call customer
                          ss("Calling ${orderData["customer"]}...");
                        },
                      ),
                    ],
                  ),
                  
                  if (orderData["specialInstructions"].toString().isNotEmpty) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${orderData["specialInstructions"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Navigation Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Navigation",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Navigate to restaurant
                          },
                          icon: Icon(Icons.navigation, size: 16),
                          label: Text("To Restaurant"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryColor,
                            side: BorderSide(color: primaryColor),
                            padding: EdgeInsets.symmetric(vertical: spSm),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Navigate to customer
                          },
                          icon: Icon(Icons.location_on, size: 16),
                          label: Text("To Customer"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryColor,
                            side: BorderSide(color: primaryColor),
                            padding: EdgeInsets.symmetric(vertical: spSm),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Action Button
            Container(
              width: double.infinity,
              child: _buildActionButton(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStepIndicator() {
    List<String> steps = ["pickup", "in_transit", "delivered"];
    int currentStepIndex = steps.indexOf(currentStep);
    
    return Row(
      children: steps.asMap().entries.map((entry) {
        int index = entry.key;
        String step = entry.value;
        bool isActive = index <= currentStepIndex;
        bool isCurrent = index == currentStepIndex;
        
        return Expanded(
          child: Row(
            children: [
              if (index > 0) Expanded(child: Container(height: 2, color: isActive ? primaryColor : disabledColor)),
              
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isActive ? primaryColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusXl),
                ),
                child: Icon(
                  stepData[step]["icon"],
                  color: Colors.white,
                  size: 20,
                ),
              ),
              
              if (index < steps.length - 1) Expanded(child: Container(height: 2, color: index < currentStepIndex ? primaryColor : disabledColor)),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Center(
                  child: Text(
                    "${item["quantity"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          "\$${(item["price"] as double).toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSummaryRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color ?? primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButton() {
    switch (currentStep) {
      case "pickup":
        return QButton(
          label: "Picked Up - Start Delivery",
          size: bs.md,
          onPressed: () {
            currentStep = "in_transit";
            setState(() {});
            ss("Order picked up! Starting delivery...");
          },
        );
      case "in_transit":
        return QButton(
          label: "Mark as Delivered",
          size: bs.md,
          onPressed: () {
            currentStep = "delivered";
            setState(() {});
            ss("Order delivered successfully!");
          },
        );
      case "delivered":
        return OutlinedButton(
          onPressed: () {
            back();
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: spMd),
            side: BorderSide(color: primaryColor),
          ),
          child: Text(
            "Return to Home",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      default:
        return Container();
    }
  }
  
  void _showCallOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.restaurant),
              title: Text("Call Restaurant"),
              subtitle: Text("${orderData["restaurantPhone"]}"),
              onTap: () {
                Navigator.pop(context);
                ss("Calling restaurant...");
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Call Customer"),
              subtitle: Text("${orderData["customerPhone"]}"),
              onTap: () {
                Navigator.pop(context);
                ss("Calling customer...");
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _showOrderOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.report_problem),
              title: Text("Report Issue"),
              onTap: () {
                Navigator.pop(context);
                // Handle issue reporting
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Get Help"),
              onTap: () {
                Navigator.pop(context);
                // Open help
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text("Cancel Order"),
              onTap: () {
                Navigator.pop(context);
                // Handle order cancellation
              },
            ),
          ],
        ),
      ),
    );
  }
}
