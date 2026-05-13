import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsShippingPolicyView extends StatefulWidget {
  const EcsShippingPolicyView({super.key});

  @override
  State<EcsShippingPolicyView> createState() => _EcsShippingPolicyViewState();
}

class _EcsShippingPolicyViewState extends State<EcsShippingPolicyView> {
  int selectedTab = 0;

  List<Map<String, dynamic>> shippingZones = [
    {
      "zone": "Standard Delivery",
      "areas": ["Within city limits", "Metro areas"],
      "timeframe": "3-5 business days",
      "cost": 5.99,
      "freeThreshold": 50.0,
      "description": "Standard delivery for most items within the city and metro areas."
    },
    {
      "zone": "Express Delivery",
      "areas": ["Urban areas", "Business districts"],
      "timeframe": "1-2 business days",
      "cost": 12.99,
      "freeThreshold": 100.0,
      "description": "Fast delivery for urgent orders in urban and business areas."
    },
    {
      "zone": "Next Day Delivery",
      "areas": ["Selected areas only"],
      "timeframe": "Next business day",
      "cost": 19.99,
      "freeThreshold": 150.0,
      "description": "Premium delivery service for same-day urgent needs."
    },
    {
      "zone": "Remote Areas",
      "areas": ["Rural areas", "Suburbs"],
      "timeframe": "5-10 business days",
      "cost": 8.99,
      "freeThreshold": 75.0,
      "description": "Extended delivery for remote and suburban locations."
    },
  ];

  List<Map<String, dynamic>> policies = [
    {
      "title": "Order Processing Time",
      "content": "Orders are processed within 1-2 business days. Orders placed after 2:00 PM on weekdays or during weekends will be processed the next business day."
    },
    {
      "title": "Shipping Methods",
      "content": "We offer multiple shipping options including standard, express, and next-day delivery. Shipping times may vary based on your location and product availability."
    },
    {
      "title": "Shipping Costs",
      "content": "Shipping costs are calculated based on the delivery zone, package weight, and selected shipping method. Free shipping is available on orders above certain thresholds."
    },
    {
      "title": "International Shipping",
      "content": "Currently, we only ship within the United States. International shipping options are being developed and will be available soon."
    },
    {
      "title": "Package Tracking",
      "content": "Once your order is shipped, you'll receive a tracking number via email. You can track your package status in real-time through our app."
    },
    {
      "title": "Delivery Instructions",
      "content": "You can provide special delivery instructions during checkout. Please ensure someone is available to receive the package during delivery hours."
    },
    {
      "title": "Failed Delivery",
      "content": "If delivery fails, we'll attempt redelivery the next business day. After 3 failed attempts, the package will be returned to our warehouse."
    },
    {
      "title": "Damaged or Lost Packages",
      "content": "We're responsible for packages until they're delivered. If your package arrives damaged or goes missing, contact our support team for a replacement or refund."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping Policy"),
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: [
                {"label": "Delivery Zones", "value": "zones"},
                {"label": "Policies", "value": "policies"},
              ],
              value: selectedTab == 0 ? "zones" : "policies",
              onChanged: (index, label, value, item) {
                selectedTab = index;
                setState(() {});
              },
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: selectedTab == 0 ? _buildDeliveryZones() : _buildPolicies(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryZones() {
    return Column(
      spacing: spSm,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                Icons.local_shipping,
                size: 48,
                color: primaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Delivery Zones & Rates",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Choose the best delivery option for your location",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Delivery Zones
        ...shippingZones.map((zone) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Zone Header
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getZoneColor("${zone["zone"]}").withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        _getZoneIcon("${zone["zone"]}"),
                        color: _getZoneColor("${zone["zone"]}"),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${zone["zone"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${zone["timeframe"]}",
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
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "\$${(zone["cost"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Description
                Text(
                  "${zone["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),

                SizedBox(height: spSm),

                // Coverage Areas
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Coverage Areas:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (zone["areas"] as List).map((area) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$area",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spSm),

                // Free Shipping Threshold
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: successColor.withAlpha(102),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_offer,
                        size: 18,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "FREE shipping on orders over \$${(zone["freeThreshold"] as double).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
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

        // Additional Info
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Important Notes",
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
                "• Delivery times exclude weekends and holidays\n"
                "• Additional charges may apply for oversized items\n"
                "• Weather conditions may affect delivery schedules\n"
                "• Signature required for orders above \$200",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPolicies() {
    return Column(
      spacing: spSm,
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                Icons.policy,
                size: 48,
                color: primaryColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Shipping Policies",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Learn about our shipping terms and conditions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Policy Items
        ...policies.map((policy) {
          return Container(
            padding: EdgeInsets.all(spMd),
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
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        _getPolicyIcon("${policy["title"]}"),
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${policy["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${policy["content"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          );
        }).toList(),

        // Contact Support
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: successColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Icon(
                Icons.support_agent,
                size: 32,
                color: successColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Need Help?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Contact our support team for shipping inquiries",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spSm),
              QButton(
                label: "Contact Support",
                icon: Icons.chat,
                size: bs.sm,
                onPressed: () {
                  //navigateTo("ContactSupportView")
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getZoneIcon(String zone) {
    switch (zone.toLowerCase()) {
      case 'standard delivery':
        return Icons.local_shipping;
      case 'express delivery':
        return Icons.speed;
      case 'next day delivery':
        return Icons.flash_on;
      case 'remote areas':
        return Icons.terrain;
      default:
        return Icons.local_shipping;
    }
  }

  Color _getZoneColor(String zone) {
    switch (zone.toLowerCase()) {
      case 'standard delivery':
        return primaryColor;
      case 'express delivery':
        return warningColor;
      case 'next day delivery':
        return dangerColor;
      case 'remote areas':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getPolicyIcon(String title) {
    if (title.contains("Processing")) return Icons.schedule;
    if (title.contains("Methods")) return Icons.local_shipping;
    if (title.contains("Costs")) return Icons.attach_money;
    if (title.contains("International")) return Icons.public;
    if (title.contains("Tracking")) return Icons.track_changes;
    if (title.contains("Instructions")) return Icons.description;
    if (title.contains("Failed")) return Icons.error;
    if (title.contains("Damaged")) return Icons.broken_image;
    return Icons.info;
  }
}
