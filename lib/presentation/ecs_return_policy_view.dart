import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsReturnPolicyView extends StatefulWidget {
  const EcsReturnPolicyView({super.key});

  @override
  State<EcsReturnPolicyView> createState() => _EcsReturnPolicyViewState();
}

class _EcsReturnPolicyViewState extends State<EcsReturnPolicyView> {
  List<Map<String, dynamic>> returnPolicySections = [
    {
      "title": "Return Time Limits",
      "icon": Icons.schedule,
      "color": primaryColor,
      "items": [
        "Most items: 30 days from delivery",
        "Electronics: 15 days from delivery",
        "Clothing & accessories: 45 days from delivery",
        "Seasonal items: 14 days from delivery",
        "Custom/personalized items: Not returnable",
      ],
    },
    {
      "title": "Return Conditions",
      "icon": Icons.checklist,
      "color": successColor,
      "items": [
        "Items must be in original condition",
        "Original packaging required",
        "All tags and labels must be attached",
        "Include all accessories and manuals",
        "No signs of wear or damage",
      ],
    },
    {
      "title": "Return Process",
      "icon": Icons.autorenew,
      "color": infoColor,
      "items": [
        "1. Request return through app or website",
        "2. Print prepaid return label",
        "3. Package item securely",
        "4. Drop off at designated location",
        "5. Track return shipment",
      ],
    },
    {
      "title": "Refund Timeline",
      "icon": Icons.payments,
      "color": warningColor,
      "items": [
        "Processing: 2-3 business days after receipt",
        "Credit card: 5-7 business days",
        "Debit card: 3-5 business days",
        "PayPal: 1-2 business days",
        "Store credit: Immediate",
      ],
    },
  ];

  List<Map<String, dynamic>> nonReturnableItems = [
    {
      "category": "Personal Care",
      "items": ["Cosmetics", "Personal hygiene products", "Opened beauty items"],
      "icon": Icons.face,
    },
    {
      "category": "Perishables",
      "items": ["Food items", "Plants", "Flowers", "Fresh products"],
      "icon": Icons.local_grocery_store,
    },
    {
      "category": "Digital Products",
      "items": ["Downloaded software", "Digital gift cards", "E-books"],
      "icon": Icons.cloud_download,
    },
    {
      "category": "Custom Items",
      "items": ["Personalized products", "Made-to-order items", "Engraved products"],
      "icon": Icons.design_services,
    },
  ];

  List<Map<String, dynamic>> returnReasons = [
    {
      "reason": "Defective/Damaged",
      "description": "Item arrived damaged or not working properly",
      "processing": "Free return shipping + full refund",
      "color": dangerColor,
    },
    {
      "reason": "Wrong Item",
      "description": "Received incorrect item or size/color",
      "processing": "Free return shipping + exchange/refund",
      "color": warningColor,
    },
    {
      "reason": "Not as Described",
      "description": "Item doesn't match product description",
      "processing": "Free return shipping + full refund",
      "color": infoColor,
    },
    {
      "reason": "Changed Mind",
      "description": "No longer want the item",
      "processing": "Customer pays return shipping",
      "color": disabledBoldColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Return Policy"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: GestureDetector(
              onTap: () {
                _showReturnCalculator();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calculate,
                    size: 20,
                    color: primaryColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Return Calculator",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.assignment_return,
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
                              "Hassle-Free Returns",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Easy returns with free shipping on eligible items",
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
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      _buildFeatureBadge("30-Day Returns", Icons.schedule),
                      SizedBox(width: spSm),
                      _buildFeatureBadge("Free Return Shipping*", Icons.local_shipping),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Start Return",
                    size: bs.sm,
                    onPressed: () {
                      _startReturn();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Track Return",
                    size: bs.sm,
                    onPressed: () {
                      _trackReturn();
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Return Policy Sections
            ...returnPolicySections.map((section) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
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
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (section["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            section["icon"] as IconData,
                            color: section["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${section["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...(section["items"] as List<String>).map((item) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: section["color"] as Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }).toList(),

            // Return Reasons
            Text(
              "Return Reasons & Processing",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...returnReasons.map((reason) {
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
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: reason["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${reason["reason"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${reason["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (reason["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${reason["processing"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: reason["color"] as Color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Non-Returnable Items
            Text(
              "Non-Returnable Items",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: nonReturnableItems.map((category) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: dangerColor.withAlpha(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            category["icon"] as IconData,
                            color: dangerColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      ...(category["items"] as List<String>).map((item) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Icon(
                                Icons.close,
                                size: 12,
                                color: dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Contact Support
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Need Help with Returns?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Our customer service team is here to help with your return questions and requests.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      QButton(
                        label: "Live Chat",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to live chat
                        },
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Call Support",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to call support
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Footer
            Center(
              child: Column(
                children: [
                  Text(
                    "Return Policy Last Updated",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "December 13, 2024",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureBadge(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spSm,
        vertical: spXs,
      ),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: successColor,
          ),
          SizedBox(width: spXs),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _startReturn() {
    showDialog(
      context: context,
      builder: (context) {
        String orderNumber = "";
        
        return AlertDialog(
          title: Text("Start Return"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter your order number to start the return process:",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Order Number",
                value: orderNumber,
                onChanged: (value) => orderNumber = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Continue",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Return process started for order $orderNumber");
              },
            ),
          ],
        );
      },
    );
  }

  void _trackReturn() {
    showDialog(
      context: context,
      builder: (context) {
        String trackingNumber = "";
        
        return AlertDialog(
          title: Text("Track Return"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter your return tracking number:",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Tracking Number",
                value: trackingNumber,
                onChanged: (value) => trackingNumber = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Track",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Tracking return $trackingNumber");
              },
            ),
          ],
        );
      },
    );
  }

  void _showReturnCalculator() {
    showDialog(
      context: context,
      builder: (context) {
        String itemPrice = "";
        String itemCategory = "Electronics";
        int daysFromDelivery = 0;
        
        return AlertDialog(
          title: Text("Return Calculator"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QNumberField(
                label: "Item Price (\$)",
                value: itemPrice,
                onChanged: (value) => itemPrice = value,
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Item Category",
                items: [
                  {"label": "Electronics", "value": "Electronics"},
                  {"label": "Clothing", "value": "Clothing"},
                  {"label": "Home & Garden", "value": "Home & Garden"},
                  {"label": "Books", "value": "Books"},
                ],
                value: itemCategory,
                onChanged: (value, label) => itemCategory = value,
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Days from Delivery",
                value: daysFromDelivery.toString(),
                onChanged: (value) => daysFromDelivery = int.tryParse(value) ?? 0,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
            QButton(
              label: "Calculate",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                _showCalculationResult(itemCategory, daysFromDelivery);
              },
            ),
          ],
        );
      },
    );
  }

  void _showCalculationResult(String category, int days) {
    String result;
    if (category == "Electronics" && days <= 15) {
      result = "✅ Eligible for return with full refund";
    } else if (category == "Clothing" && days <= 45) {
      result = "✅ Eligible for return with full refund";
    } else if (days <= 30) {
      result = "✅ Eligible for return with full refund";
    } else {
      result = "❌ Return window has expired";
    }
    
    ss(result);
  }
}
