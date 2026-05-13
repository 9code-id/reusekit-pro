import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDistancePricingView extends StatefulWidget {
  const LtaDistancePricingView({super.key});

  @override
  State<LtaDistancePricingView> createState() => _LtaDistancePricingViewState();
}

class _LtaDistancePricingViewState extends State<LtaDistancePricingView> {
  bool loading = true;
  String selectedServiceType = "All Services";
  String selectedZone = "All Zones";
  String searchQuery = "";

  List<Map<String, dynamic>> serviceTypeOptions = [
    {"label": "All Services", "value": "All Services"},
    {"label": "Standard Delivery", "value": "standard"},
    {"label": "Express Delivery", "value": "express"},
    {"label": "Same Day", "value": "same_day"},
    {"label": "Overnight", "value": "overnight"},
    {"label": "Long Distance", "value": "long_distance"},
  ];

  List<Map<String, dynamic>> zoneOptions = [
    {"label": "All Zones", "value": "All Zones"},
    {"label": "Local (0-25 miles)", "value": "local"},
    {"label": "Regional (26-100 miles)", "value": "regional"},
    {"label": "Interstate (101-500 miles)", "value": "interstate"},
    {"label": "Cross Country (500+ miles)", "value": "cross_country"},
  ];

  List<Map<String, dynamic>> distanceBrackets = [
    {
      "id": "dist_001",
      "service_type": "Standard Delivery",
      "zone": "Local",
      "min_distance": 0,
      "max_distance": 25,
      "base_rate": 12.50,
      "per_mile_rate": 1.25,
      "minimum_charge": 15.00,
      "fuel_adjustment": 0.15,
      "status": "Active",
      "effective_date": "2024-01-01"
    },
    {
      "id": "dist_002",
      "service_type": "Standard Delivery",
      "zone": "Regional",
      "min_distance": 26,
      "max_distance": 100,
      "base_rate": 25.00,
      "per_mile_rate": 2.50,
      "minimum_charge": 40.00,
      "fuel_adjustment": 0.20,
      "status": "Active",
      "effective_date": "2024-01-01"
    },
    {
      "id": "dist_003",
      "service_type": "Express Delivery",
      "zone": "Local",
      "min_distance": 0,
      "max_distance": 25,
      "base_rate": 20.00,
      "per_mile_rate": 2.00,
      "minimum_charge": 25.00,
      "fuel_adjustment": 0.20,
      "status": "Active",
      "effective_date": "2024-01-01"
    },
    {
      "id": "dist_004",
      "service_type": "Same Day",
      "zone": "Local",
      "min_distance": 0,
      "max_distance": 15,
      "base_rate": 35.00,
      "per_mile_rate": 3.50,
      "minimum_charge": 45.00,
      "fuel_adjustment": 0.25,
      "status": "Active",
      "effective_date": "2024-01-01"
    },
    {
      "id": "dist_005",
      "service_type": "Long Distance",
      "zone": "Interstate",
      "min_distance": 101,
      "max_distance": 500,
      "base_rate": 150.00,
      "per_mile_rate": 3.25,
      "minimum_charge": 200.00,
      "fuel_adjustment": 0.30,
      "status": "Active",
      "effective_date": "2024-01-01"
    },
    {
      "id": "dist_006",
      "service_type": "Long Distance",
      "zone": "Cross Country",
      "min_distance": 501,
      "max_distance": 3000,
      "base_rate": 300.00,
      "per_mile_rate": 2.75,
      "minimum_charge": 500.00,
      "fuel_adjustment": 0.35,
      "status": "Active",
      "effective_date": "2024-01-01"
    }
  ];

  Map<String, dynamic> pricingAnalytics = {
    "total_routes": 156,
    "active_brackets": 12,
    "avg_per_mile_rate": 2.45,
    "highest_rate": 3.50,
    "lowest_rate": 1.25,
    "revenue_impact": 45780.25,
    "cost_efficiency": 87.5
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    setState(() {});
  }

  void _showAddBracketDialog() {
    String serviceType = "Standard Delivery";
    String zone = "Local";
    double minDistance = 0;
    double maxDistance = 0;
    double baseRate = 0;
    double perMileRate = 0;
    double minimumCharge = 0;
    double fuelAdjustment = 0;
    String effectiveDate = DateTime.now().toString().split(' ')[0];
    String status = "Active";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Distance Pricing Bracket"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDropdownField(
                label: "Service Type",
                items: serviceTypeOptions.where((item) => item["value"] != "All Services").toList(),
                value: serviceType,
                onChanged: (value, label) => serviceType = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Zone",
                value: zone,
                onChanged: (value) => zone = value,
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Min Distance (miles)",
                      value: minDistance.toString(),
                      onChanged: (value) => minDistance = double.tryParse(value) ?? 0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Max Distance (miles)",
                      value: maxDistance.toString(),
                      onChanged: (value) => maxDistance = double.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Base Rate (\$)",
                      value: baseRate.toString(),
                      onChanged: (value) => baseRate = double.tryParse(value) ?? 0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Per Mile Rate (\$)",
                      value: perMileRate.toString(),
                      onChanged: (value) => perMileRate = double.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Minimum Charge (\$)",
                      value: minimumCharge.toString(),
                      onChanged: (value) => minimumCharge = double.tryParse(value) ?? 0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Fuel Adjustment (\$)",
                      value: fuelAdjustment.toString(),
                      onChanged: (value) => fuelAdjustment = double.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Effective Date",
                value: DateTime.parse(effectiveDate),
                onChanged: (value) => effectiveDate = value.toString().split(' ')[0],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Status",
                items: [
                  {"label": "Active", "value": "Active"},
                  {"label": "Inactive", "value": "Inactive"},
                ],
                value: status,
                onChanged: (value, label) => status = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Bracket",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Distance pricing bracket added successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showEditBracketDialog(Map<String, dynamic> bracket) {
    String serviceType = "${bracket["service_type"]}";
    String zone = "${bracket["zone"]}";
    double minDistance = (bracket["min_distance"] as num).toDouble();
    double maxDistance = (bracket["max_distance"] as num).toDouble();
    double baseRate = (bracket["base_rate"] as num).toDouble();
    double perMileRate = (bracket["per_mile_rate"] as num).toDouble();
    double minimumCharge = (bracket["minimum_charge"] as num).toDouble();
    double fuelAdjustment = (bracket["fuel_adjustment"] as num).toDouble();
    String effectiveDate = "${bracket["effective_date"]}";
    String status = "${bracket["status"]}";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Distance Pricing Bracket"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDropdownField(
                label: "Service Type",
                items: serviceTypeOptions.where((item) => item["value"] != "All Services").toList(),
                value: serviceType,
                onChanged: (value, label) => serviceType = value,
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Zone",
                value: zone,
                onChanged: (value) => zone = value,
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Min Distance (miles)",
                      value: minDistance.toString(),
                      onChanged: (value) => minDistance = double.tryParse(value) ?? 0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Max Distance (miles)",
                      value: maxDistance.toString(),
                      onChanged: (value) => maxDistance = double.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Base Rate (\$)",
                      value: baseRate.toString(),
                      onChanged: (value) => baseRate = double.tryParse(value) ?? 0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Per Mile Rate (\$)",
                      value: perMileRate.toString(),
                      onChanged: (value) => perMileRate = double.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Minimum Charge (\$)",
                      value: minimumCharge.toString(),
                      onChanged: (value) => minimumCharge = double.tryParse(value) ?? 0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Fuel Adjustment (\$)",
                      value: fuelAdjustment.toString(),
                      onChanged: (value) => fuelAdjustment = double.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Effective Date",
                value: DateTime.parse(effectiveDate),
                onChanged: (value) => effectiveDate = value.toString().split(' ')[0],
              ),
              SizedBox(height: spSm),
              QDropdownField(
                label: "Status",
                items: [
                  {"label": "Active", "value": "Active"},
                  {"label": "Inactive", "value": "Inactive"},
                ],
                value: status,
                onChanged: (value, label) => status = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save Changes",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Distance pricing bracket updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showPriceCalculator() {
    double distance = 0;
    String selectedService = "Standard Delivery";
    double calculatedPrice = 0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Distance Price Calculator"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QDropdownField(
                label: "Service Type",
                items: serviceTypeOptions.where((item) => item["value"] != "All Services").toList(),
                value: selectedService,
                onChanged: (value, label) {
                  selectedService = value;
                  setDialogState(() {});
                },
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Distance (miles)",
                value: distance.toString(),
                onChanged: (value) {
                  distance = double.tryParse(value) ?? 0;
                  
                  // Find matching bracket and calculate price
                  var matchingBracket = distanceBrackets.firstWhere(
                    (bracket) => 
                      bracket["service_type"] == selectedService &&
                      distance >= (bracket["min_distance"] as num) &&
                      distance <= (bracket["max_distance"] as num),
                    orElse: () => {},
                  );
                  
                  if (matchingBracket.isNotEmpty) {
                    double baseRate = (matchingBracket["base_rate"] as num).toDouble();
                    double perMileRate = (matchingBracket["per_mile_rate"] as num).toDouble();
                    double minimumCharge = (matchingBracket["minimum_charge"] as num).toDouble();
                    double fuelAdjustment = (matchingBracket["fuel_adjustment"] as num).toDouble();
                    
                    calculatedPrice = (baseRate + (distance * perMileRate) + fuelAdjustment);
                    if (calculatedPrice < minimumCharge) {
                      calculatedPrice = minimumCharge;
                    }
                  }
                  
                  setDialogState(() {});
                },
              ),
              SizedBox(height: spMd),
              if (calculatedPrice > 0) ...[
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Calculated Price",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${calculatedPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String subtitle, IconData icon, Color color) {
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
                padding: EdgeInsets.all(spXs),
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
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceBracketCard(Map<String, dynamic> bracket) {
    bool isActive = bracket["status"] == "Active";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isActive ? primaryColor : disabledColor,
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
                      "${bracket["service_type"]} - ${bracket["zone"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${(bracket["min_distance"] as num).toInt()}-${(bracket["max_distance"] as num).toInt()} miles",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${bracket["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isActive ? successColor : disabledColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _showEditBracketDialog(bracket),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Base Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(bracket["base_rate"] as num).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Per Mile",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(bracket["per_mile_rate"] as num).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimum",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(bracket["minimum_charge"] as num).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fuel Adjustment",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(bracket["fuel_adjustment"] as num).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Effective Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${bracket["effective_date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Calculate",
                size: bs.sm,
                onPressed: _showPriceCalculator,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> filteredBrackets = distanceBrackets.where((bracket) {
      bool matchesService = selectedServiceType == "All Services" || 
                           bracket["service_type"] == selectedServiceType;
      bool matchesZone = selectedZone == "All Zones" || 
                        bracket["zone"].toString().toLowerCase().contains(selectedZone.toLowerCase());
      bool matchesSearch = searchQuery.isEmpty ||
                          bracket["service_type"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          bracket["zone"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesService && matchesZone && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Distance Pricing Management"),
        actions: [
          QButton(
            icon: Icons.calculate,
            size: bs.sm,
            onPressed: _showPriceCalculator,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _showAddBracketDialog,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Analytics Overview
            Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildAnalyticsCard(
                        "Total Routes",
                        "${pricingAnalytics["total_routes"]}",
                        "Active pricing routes",
                        Icons.route,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildAnalyticsCard(
                        "Avg Rate/Mile",
                        "\$${(pricingAnalytics["avg_per_mile_rate"] as num).toStringAsFixed(2)}",
                        "Average pricing",
                        Icons.attach_money,
                        successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildAnalyticsCard(
                        "Revenue Impact",
                        "\$${((pricingAnalytics["revenue_impact"] as num)).currency}",
                        "Monthly revenue",
                        Icons.trending_up,
                        infoColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildAnalyticsCard(
                        "Efficiency",
                        "${(pricingAnalytics["cost_efficiency"] as num).toStringAsFixed(1)}%",
                        "Cost efficiency",
                        Icons.speed,
                        warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filters
            QTextField(
              label: "Search brackets...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Service Type",
                    items: serviceTypeOptions,
                    value: selectedServiceType,
                    onChanged: (value, label) {
                      selectedServiceType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Zone",
                    items: zoneOptions,
                    value: selectedZone,
                    onChanged: (value, label) {
                      selectedZone = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Distance Pricing Brackets
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Distance Pricing Brackets (${filteredBrackets.length})",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Add Bracket",
                  size: bs.sm,
                  onPressed: _showAddBracketDialog,
                ),
              ],
            ),
            SizedBox(height: spSm),
            if (filteredBrackets.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.route_outlined,
                        size: 48,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No distance pricing brackets found",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledColor,
                        ),
                      ),
                      Text(
                        "Try adjusting your filters",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Column(
                children: filteredBrackets.map((bracket) {
                  return _buildDistanceBracketCard(bracket);
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
