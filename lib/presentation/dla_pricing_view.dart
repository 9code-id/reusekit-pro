import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaPricingView extends StatefulWidget {
  const DlaPricingView({super.key});

  @override
  State<DlaPricingView> createState() => _DlaPricingViewState();
}

class _DlaPricingViewState extends State<DlaPricingView> {
  String selectedCategory = "delivery";
  String selectedPricingModel = "distance_based";
  
  final List<Map<String, dynamic>> categoryOptions = [
    {"label": "Delivery Services", "value": "delivery"},
    {"label": "Storage Services", "value": "storage"},
    {"label": "Packaging Services", "value": "packaging"},
    {"label": "Special Services", "value": "special"},
    {"label": "Insurance & Add-ons", "value": "insurance"},
  ];

  final List<Map<String, dynamic>> pricingModels = [
    {"label": "Distance-Based Pricing", "value": "distance_based"},
    {"label": "Weight-Based Pricing", "value": "weight_based"},
    {"label": "Time-Based Pricing", "value": "time_based"},
    {"label": "Zone-Based Pricing", "value": "zone_based"},
    {"label": "Flat Rate Pricing", "value": "flat_rate"},
  ];

  final Map<String, List<Map<String, dynamic>>> pricingData = {
    "delivery": [
      {
        "name": "Standard Delivery",
        "description": "Regular delivery within 3-5 business days",
        "base_price": 5.00,
        "per_km": 0.50,
        "min_charge": 3.00,
        "max_weight": 25.0,
        "zones": ["zone_1", "zone_2", "zone_3"],
        "active": true,
      },
      {
        "name": "Express Delivery", 
        "description": "Fast delivery within 1-2 business days",
        "base_price": 8.50,
        "per_km": 0.75,
        "min_charge": 5.00,
        "max_weight": 20.0,
        "zones": ["zone_1", "zone_2"],
        "active": true,
      },
      {
        "name": "Same Day Delivery",
        "description": "Delivery within the same day",
        "base_price": 15.00,
        "per_km": 1.25,
        "min_charge": 10.00,
        "max_weight": 15.0,
        "zones": ["zone_1"],
        "active": true,
      },
      {
        "name": "Next Day Delivery",
        "description": "Guaranteed next business day delivery",
        "base_price": 10.00,
        "per_km": 0.85,
        "min_charge": 7.50,
        "max_weight": 30.0,
        "zones": ["zone_1", "zone_2", "zone_3", "zone_4"],
        "active": false,
      },
    ],
    "storage": [
      {
        "name": "Basic Storage",
        "description": "Standard warehouse storage",
        "base_price": 2.50,
        "per_day": 0.25,
        "per_cbm": 5.00,
        "min_charge": 10.00,
        "security_level": "Standard",
        "active": true,
      },
      {
        "name": "Climate Controlled",
        "description": "Temperature and humidity controlled storage",
        "base_price": 4.00,
        "per_day": 0.50,
        "per_cbm": 8.00,
        "min_charge": 20.00,
        "security_level": "High",
        "active": true,
      },
      {
        "name": "High Security Storage",
        "description": "Maximum security storage facility",
        "base_price": 6.00,
        "per_day": 0.75,
        "per_cbm": 12.00,
        "min_charge": 30.00,
        "security_level": "Maximum",
        "active": true,
      },
    ],
    "packaging": [
      {
        "name": "Standard Packaging",
        "description": "Basic protective packaging",
        "base_price": 2.00,
        "per_item": 1.50,
        "materials": ["Cardboard", "Bubble Wrap"],
        "fragile_support": false,
        "active": true,
      },
      {
        "name": "Fragile Packaging",
        "description": "Special packaging for fragile items",
        "base_price": 5.00,
        "per_item": 3.00,
        "materials": ["Foam", "Bubble Wrap", "Cardboard"],
        "fragile_support": true,
        "active": true,
      },
      {
        "name": "Custom Packaging",
        "description": "Tailored packaging solutions",
        "base_price": 10.00,
        "per_item": 5.00,
        "materials": ["Custom", "Foam", "Cardboard"],
        "fragile_support": true,
        "active": false,
      },
    ],
    "special": [
      {
        "name": "White Glove Service",
        "description": "Premium handling and setup service",
        "base_price": 25.00,
        "hourly_rate": 35.00,
        "min_hours": 2,
        "includes": ["Assembly", "Installation", "Cleanup"],
        "active": true,
      },
      {
        "name": "Scheduled Delivery",
        "description": "Delivery at specific time slots",
        "base_price": 7.50,
        "time_slot_fee": 5.00,
        "weekend_surcharge": 10.00,
        "includes": ["Time Coordination", "SMS Updates"],
        "active": true,
      },
    ],
    "insurance": [
      {
        "name": "Basic Coverage",
        "description": "Standard liability coverage",
        "percentage": 1.0,
        "min_fee": 2.00,
        "max_fee": 25.00,
        "coverage_limit": 1000.00,
        "active": true,
      },
      {
        "name": "Premium Coverage",
        "description": "Enhanced protection coverage",
        "percentage": 1.5,
        "min_fee": 5.00,
        "max_fee": 100.00,
        "coverage_limit": 10000.00,
        "active": true,
      },
    ],
  };

  Widget _buildPricingHeader() {
    return Container(
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
              Icon(Icons.price_check, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Pricing Management",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  si("Add new pricing tier");
                },
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Service Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Pricing Model",
                  items: pricingModels,
                  value: selectedPricingModel,
                  onChanged: (value, label) {
                    selectedPricingModel = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCards() {
    List<Map<String, dynamic>> currentPricing = pricingData[selectedCategory] ?? [];
    
    return Column(
      spacing: spMd,
      children: currentPricing.map((pricing) => _buildPricingCard(pricing)).toList(),
    );
  }

  Widget _buildPricingCard(Map<String, dynamic> pricing) {
    bool isActive = pricing["active"] ?? false;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isActive ? successColor : disabledBoldColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${pricing["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${pricing["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (isActive ? successColor : disabledBoldColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  isActive ? "ACTIVE" : "INACTIVE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isActive ? successColor : disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          _buildPricingDetails(pricing),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Pricing",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    si("Edit pricing for ${pricing["name"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: isActive ? "Deactivate" : "Activate",
                color: isActive ? dangerColor : successColor,
                size: bs.sm,
                onPressed: () {
                  if (isActive) {
                    sw("${pricing["name"]} deactivated");
                  } else {
                    ss("${pricing["name"]} activated");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingDetails(Map<String, dynamic> pricing) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          if (pricing.containsKey("base_price"))
            Row(
              children: [
                Icon(Icons.attach_money, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Base Price:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(pricing["base_price"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          if (pricing.containsKey("per_km"))
            Row(
              children: [
                Icon(Icons.route, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Per Kilometer:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(pricing["per_km"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          if (pricing.containsKey("per_day"))
            Row(
              children: [
                Icon(Icons.calendar_today, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Per Day:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(pricing["per_day"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          if (pricing.containsKey("per_item"))
            Row(
              children: [
                Icon(Icons.inventory, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Per Item:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(pricing["per_item"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          if (pricing.containsKey("hourly_rate"))
            Row(
              children: [
                Icon(Icons.schedule, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Hourly Rate:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(pricing["hourly_rate"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          if (pricing.containsKey("percentage"))
            Row(
              children: [
                Icon(Icons.percent, color: primaryColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Percentage:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${(pricing["percentage"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          if (pricing.containsKey("min_charge"))
            Row(
              children: [
                Icon(Icons.low_priority, color: disabledBoldColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Minimum Charge:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${(pricing["min_charge"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          if (pricing.containsKey("max_weight"))
            Row(
              children: [
                Icon(Icons.fitness_center, color: disabledBoldColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Max Weight:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${(pricing["max_weight"] as double).toStringAsFixed(0)}kg",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          if (pricing.containsKey("zones"))
            Row(
              children: [
                Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Available Zones:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${(pricing["zones"] as List).length} zones",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPricingAnalytics() {
    return Container(
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
            "Pricing Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              _buildAnalyticsCard("Average Price", "\$12.50", primaryColor, Icons.trending_up),
              _buildAnalyticsCard("Most Popular", "Standard", successColor, Icons.star),
              _buildAnalyticsCard("Price Range", "\$3-\$50", infoColor, Icons.compare_arrows),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Market Comparison",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "vs. Competitors:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "15% COMPETITIVE",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(icon, color: color, size: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pricing Management"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              si("Pricing settings");
            },
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              si("Export pricing data");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPricingHeader(),
            _buildPricingAnalytics(),
            _buildPricingCards(),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Bulk Price Update",
                color: warningColor,
                size: bs.md,
                onPressed: () {
                  si("Bulk price update wizard");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
