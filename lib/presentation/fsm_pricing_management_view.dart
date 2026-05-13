import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmPricingManagementView extends StatefulWidget {
  const FsmPricingManagementView({super.key});

  @override
  State<FsmPricingManagementView> createState() => _FsmPricingManagementViewState();
}

class _FsmPricingManagementViewState extends State<FsmPricingManagementView> {
  List<Map<String, dynamic>> servicePricing = [
    {
      "id": "SP001",
      "category": "Preventive Maintenance",
      "serviceName": "Generator Oil Change & Filter Replacement",
      "description": "Quarterly oil change with filter replacement and system inspection",
      "basePrice": 285.0,
      "laborHours": 2.5,
      "laborRate": 125.0,
      "materialCost": 87.50,
      "markup": 15.0,
      "finalPrice": 327.75,
      "isActive": true,
      "lastUpdated": "2024-06-15",
      "usageCount": 45
    },
    {
      "id": "SP002",
      "category": "Emergency Repair",
      "serviceName": "HVAC Compressor Replacement",
      "description": "Emergency compressor unit replacement with system rebalancing",
      "basePrice": 3800.0,
      "laborHours": 6.0,
      "laborRate": 150.0,
      "materialCost": 2900.0,
      "markup": 25.0,
      "finalPrice": 4750.0,
      "isActive": true,
      "lastUpdated": "2024-06-12",
      "usageCount": 8
    },
    {
      "id": "SP003",
      "category": "Inspection",
      "serviceName": "Fire Safety System Inspection",
      "description": "Monthly safety system inspection with sensor calibration and testing",
      "basePrice": 425.0,
      "laborHours": 2.0,
      "laborRate": 125.0,
      "materialCost": 175.0,
      "markup": 10.0,
      "finalPrice": 467.50,
      "isActive": true,
      "lastUpdated": "2024-06-10",
      "usageCount": 28
    },
    {
      "id": "SP004",
      "category": "Installation",
      "serviceName": "Conveyor Belt System Installation",
      "description": "Complete conveyor belt system installation with testing and commissioning",
      "basePrice": 8500.0,
      "laborHours": 16.0,
      "laborRate": 135.0,
      "materialCost": 6340.0,
      "markup": 20.0,
      "finalPrice": 10200.0,
      "isActive": false,
      "lastUpdated": "2024-05-20",
      "usageCount": 3
    },
    {
      "id": "SP005",
      "category": "Software Update",
      "serviceName": "Security Camera Firmware Update",
      "description": "Firmware update with analytics configuration for camera networks",
      "basePrice": 185.0,
      "laborHours": 1.5,
      "laborRate": 125.0,
      "materialCost": 0.0,
      "markup": 5.0,
      "finalPrice": 194.25,
      "isActive": true,
      "lastUpdated": "2024-06-05",
      "usageCount": 22
    }
  ];

  List<Map<String, dynamic>> laborRates = [
    {
      "id": "LR001",
      "skillLevel": "Apprentice",
      "baseRate": 85.0,
      "overtimeRate": 127.50,
      "emergencyRate": 170.0,
      "description": "Entry-level technicians with basic training",
      "isActive": true
    },
    {
      "id": "LR002", 
      "skillLevel": "Intermediate",
      "baseRate": 125.0,
      "overtimeRate": 187.50,
      "emergencyRate": 250.0,
      "description": "Experienced technicians with specialized skills",
      "isActive": true
    },
    {
      "id": "LR003",
      "skillLevel": "Advanced",
      "baseRate": 165.0,
      "overtimeRate": 247.50,
      "emergencyRate": 330.0,
      "description": "Senior technicians with advanced certifications",
      "isActive": true
    },
    {
      "id": "LR004",
      "skillLevel": "Expert",
      "baseRate": 195.0,
      "overtimeRate": 292.50,
      "emergencyRate": 390.0,
      "description": "Master technicians and specialists",
      "isActive": true
    }
  ];

  List<Map<String, dynamic>> markupRules = [
    {
      "id": "MR001",
      "ruleName": "Standard Materials",
      "category": "Materials",
      "minAmount": 0.0,
      "maxAmount": 1000.0,
      "markupPercentage": 15.0,
      "description": "Standard markup for common materials and parts",
      "isActive": true
    },
    {
      "id": "MR002",
      "ruleName": "High-Value Parts",
      "category": "Materials",
      "minAmount": 1000.0,
      "maxAmount": 10000.0,
      "markupPercentage": 25.0,
      "description": "Higher markup for expensive or specialized parts",
      "isActive": true
    },
    {
      "id": "MR003",
      "ruleName": "Emergency Service",
      "category": "Service",
      "minAmount": 0.0,
      "maxAmount": 999999.0,
      "markupPercentage": 50.0,
      "description": "Emergency service premium for urgent repairs",
      "isActive": true
    },
    {
      "id": "MR004",
      "ruleName": "After Hours",
      "category": "Service",
      "minAmount": 0.0,
      "maxAmount": 999999.0,
      "markupPercentage": 30.0,
      "description": "After-hours service premium",
      "isActive": true
    }
  ];

  List<Map<String, dynamic>> filteredPricing = [];
  String searchQuery = "";
  String selectedCategory = "All";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Preventive Maintenance", "value": "Preventive Maintenance"},
    {"label": "Emergency Repair", "value": "Emergency Repair"},
    {"label": "Inspection", "value": "Inspection"},
    {"label": "Installation", "value": "Installation"},
    {"label": "Software Update", "value": "Software Update"},
  ];

  @override
  void initState() {
    super.initState();
    filteredPricing = servicePricing;
  }

  void _filterPricing() {
    filteredPricing = servicePricing.where((pricing) {
      bool matchesSearch = pricing["serviceName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          pricing["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || pricing["category"] == selectedCategory;
      bool matchesActive = !showActiveOnly || pricing["isActive"] == true;
      
      return matchesSearch && matchesCategory && matchesActive;
    }).toList();
    setState(() {});
  }

  Widget _buildServicePricingCard(Map<String, dynamic> pricing) {
    bool isActive = pricing["isActive"] as bool;
    double finalPrice = pricing["finalPrice"] as double;
    double basePrice = pricing["basePrice"] as double;
    double markup = pricing["markup"] as double;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isActive ? successColor : disabledColor,
          ),
        ),
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
                      "${pricing["serviceName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${pricing["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${finalPrice.currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isActive ? successColor : disabledColor).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      isActive ? "Active" : "Inactive",
                      style: TextStyle(
                        fontSize: 10,
                        color: isActive ? successColor : disabledColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${pricing["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildPriceRow("Base Price", basePrice),
                _buildPriceRow("Labor (${(pricing["laborHours"] as double).toStringAsFixed(1)}h × \$${(pricing["laborRate"] as double).currency})", (pricing["laborHours"] as double) * (pricing["laborRate"] as double)),
                _buildPriceRow("Materials", pricing["materialCost"] as double),
                Container(
                  height: 1,
                  color: successColor.withAlpha(50),
                  margin: EdgeInsets.symmetric(vertical: spXs),
                ),
                _buildPriceRow("Markup (${markup.toStringAsFixed(1)}%)", finalPrice - basePrice),
                Container(
                  height: 2,
                  color: successColor.withAlpha(100),
                  margin: EdgeInsets.symmetric(vertical: spXs),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Final Price:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "\$${finalPrice.currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem("Usage Count", "${pricing["usageCount"]}", Icons.analytics),
              ),
              Expanded(
                child: _buildInfoItem("Last Updated", "${pricing["lastUpdated"]}", Icons.update),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Pricing",
                  size: bs.sm,
                  onPressed: () {
                    // Edit pricing
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: isActive ? "Deactivate" : "Activate",
                  size: bs.sm,
                  onPressed: () {
                    pricing["isActive"] = !isActive;
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

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: successColor,
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLaborRatesSection() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Labor Rates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Add Rate",
                size: bs.sm,
                onPressed: () {
                  // Add new labor rate
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...laborRates.map((rate) {
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${rate["skillLevel"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(rate["baseRate"] as double).currency}/hr",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${rate["description"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Overtime: \$${(rate["overtimeRate"] as double).currency}/hr",
                          style: TextStyle(
                            fontSize: 10,
                            color: warningColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Emergency: \$${(rate["emergencyRate"] as double).currency}/hr",
                          style: TextStyle(
                            fontSize: 10,
                            color: dangerColor,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMarkupRulesSection() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Markup Rules",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Add Rule",
                size: bs.sm,
                onPressed: () {
                  // Add new markup rule
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...markupRules.map((rule) {
            bool isActive = rule["isActive"] as bool;
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (isActive ? warningColor : disabledColor).withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 3,
                    color: isActive ? warningColor : disabledColor,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${rule["ruleName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${(rule["markupPercentage"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${rule["description"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "${rule["category"]} • ",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "\$${(rule["minAmount"] as double).currency} - \$${(rule["maxAmount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        isActive ? "Active" : "Inactive",
                        style: TextStyle(
                          fontSize: 10,
                          color: isActive ? successColor : disabledColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    int totalServices = servicePricing.length;
    int activeServices = servicePricing.where((s) => s["isActive"] == true).length;
    double avgPrice = servicePricing.fold(0.0, (sum, s) => sum + (s["finalPrice"] as double)) / totalServices;
    int totalUsage = servicePricing.fold(0, (sum, s) => sum + (s["usageCount"] as int));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Total Services", "$totalServices", Icons.build, primaryColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Active", "$activeServices", Icons.check_circle, successColor),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: _buildStatCard("Avg Price", "\$${avgPrice.currency}", Icons.trending_up, infoColor),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: _buildStatCard("Total Usage", "$totalUsage", Icons.analytics, warningColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Pricing Management",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Service Pricing", icon: Icon(Icons.price_check)),
        Tab(text: "Labor Rates", icon: Icon(Icons.engineering)),
        Tab(text: "Markup Rules", icon: Icon(Icons.calculate)),
      ],
      tabChildren: [
        // Service Pricing Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatsCards(),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search Services",
                      value: searchQuery,
                      hint: "Search by service name or description...",
                      onChanged: (value) {
                        searchQuery = value;
                        _filterPricing();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categoryItems,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        _filterPricing();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Active Only",
                          "value": true,
                          "checked": showActiveOnly,
                        }
                      ],
                      value: [if (showActiveOnly) {"label": "Active Only", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        showActiveOnly = values.isNotEmpty;
                        _filterPricing();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Service Pricing (${filteredPricing.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QButton(
                    label: "Add Service",
                    size: bs.sm,
                    onPressed: () {
                      // Add new service pricing
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),
              ...filteredPricing.map((pricing) => _buildServicePricingCard(pricing)).toList(),
            ],
          ),
        ),
        // Labor Rates Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildLaborRatesSection(),
        ),
        // Markup Rules Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildMarkupRulesSection(),
        ),
      ],
    );
  }
}
