import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPricingManagementView extends StatefulWidget {
  const LtaPricingManagementView({super.key});

  @override
  State<LtaPricingManagementView> createState() => _LtaPricingManagementViewState();
}

class _LtaPricingManagementViewState extends State<LtaPricingManagementView> {
  bool loading = true;
  String searchQuery = "";
  String selectedServiceType = "All Services";
  String selectedZone = "All Zones";

  List<Map<String, dynamic>> serviceTypeOptions = [
    {"label": "All Services", "value": "All Services"},
    {"label": "Standard Delivery", "value": "standard"},
    {"label": "Express Delivery", "value": "express"},
    {"label": "Same Day", "value": "same_day"},
    {"label": "Overnight", "value": "overnight"},
    {"label": "International", "value": "international"},
  ];

  List<Map<String, dynamic>> zoneOptions = [
    {"label": "All Zones", "value": "All Zones"},
    {"label": "Zone A (Urban)", "value": "zone_a"},
    {"label": "Zone B (Suburban)", "value": "zone_b"},
    {"label": "Zone C (Rural)", "value": "zone_c"},
    {"label": "Zone D (Remote)", "value": "zone_d"},
  ];

  List<Map<String, dynamic>> pricingRules = [
    {
      "id": "pr_001",
      "name": "Standard Urban Delivery",
      "serviceType": "standard",
      "serviceName": "Standard Delivery",
      "zone": "zone_a",
      "zoneName": "Zone A (Urban)",
      "baseRate": 5.99,
      "perKmRate": 0.50,
      "perKgRate": 1.25,
      "minimumCharge": 8.00,
      "maximumCharge": 50.00,
      "fuelSurcharge": 15.0,
      "active": true,
      "validFrom": "2024-03-01T00:00:00Z",
      "validTo": "2024-12-31T23:59:59Z",
      "description": "Standard delivery service for urban areas with 2-3 business days delivery",
      "lastUpdated": "2024-03-10T14:30:00Z",
      "updatedBy": "Admin",
    },
    {
      "id": "pr_002",
      "name": "Express Urban Delivery",
      "serviceType": "express",
      "serviceName": "Express Delivery",
      "zone": "zone_a",
      "zoneName": "Zone A (Urban)",
      "baseRate": 12.99,
      "perKmRate": 0.75,
      "perKgRate": 2.00,
      "minimumCharge": 15.00,
      "maximumCharge": 100.00,
      "fuelSurcharge": 15.0,
      "active": true,
      "validFrom": "2024-03-01T00:00:00Z",
      "validTo": "2024-12-31T23:59:59Z",
      "description": "Express delivery service for urban areas with next business day delivery",
      "lastUpdated": "2024-03-12T09:15:00Z",
      "updatedBy": "Manager",
    },
    {
      "id": "pr_003",
      "name": "Same Day Urban Premium",
      "serviceType": "same_day",
      "serviceName": "Same Day",
      "zone": "zone_a",
      "zoneName": "Zone A (Urban)",
      "baseRate": 25.99,
      "perKmRate": 1.50,
      "perKgRate": 3.50,
      "minimumCharge": 30.00,
      "maximumCharge": 200.00,
      "fuelSurcharge": 20.0,
      "active": true,
      "validFrom": "2024-03-01T00:00:00Z",
      "validTo": "2024-12-31T23:59:59Z",
      "description": "Same day delivery service for urban areas with 4-6 hours delivery window",
      "lastUpdated": "2024-03-08T16:45:00Z",
      "updatedBy": "Admin",
    },
    {
      "id": "pr_004",
      "name": "Standard Suburban Delivery",
      "serviceType": "standard",
      "serviceName": "Standard Delivery",
      "zone": "zone_b",
      "zoneName": "Zone B (Suburban)",
      "baseRate": 7.99,
      "perKmRate": 0.65,
      "perKgRate": 1.50,
      "minimumCharge": 10.00,
      "maximumCharge": 75.00,
      "fuelSurcharge": 18.0,
      "active": true,
      "validFrom": "2024-03-01T00:00:00Z",
      "validTo": "2024-12-31T23:59:59Z",
      "description": "Standard delivery service for suburban areas with 3-4 business days delivery",
      "lastUpdated": "2024-03-05T11:20:00Z",
      "updatedBy": "Manager",
    },
    {
      "id": "pr_005",
      "name": "Rural Express Delivery",
      "serviceType": "express",
      "serviceName": "Express Delivery",
      "zone": "zone_c",
      "zoneName": "Zone C (Rural)",
      "baseRate": 18.99,
      "perKmRate": 1.00,
      "perKgRate": 2.75,
      "minimumCharge": 25.00,
      "maximumCharge": 150.00,
      "fuelSurcharge": 25.0,
      "active": false,
      "validFrom": "2024-03-01T00:00:00Z",
      "validTo": "2024-12-31T23:59:59Z",
      "description": "Express delivery service for rural areas with 2-3 business days delivery",
      "lastUpdated": "2024-03-14T13:10:00Z",
      "updatedBy": "Admin",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadPricingData();
  }

  void _loadPricingData() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredPricingRules {
    return pricingRules.where((rule) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${rule["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${rule["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesServiceType = selectedServiceType == "All Services" || 
          rule["serviceType"] == selectedServiceType;
      
      bool matchesZone = selectedZone == "All Zones" || 
          rule["zone"] == selectedZone;
      
      return matchesSearch && matchesServiceType && matchesZone;
    }).toList();
  }

  void _editPricingRule(String ruleId) {
    // Find the rule to edit
    Map<String, dynamic> rule = pricingRules.firstWhere((r) => r["id"] == ruleId);
    
    showDialog(
      context: context,
      builder: (context) => _buildEditPricingDialog(rule),
    );
  }

  Widget _buildEditPricingDialog(Map<String, dynamic> rule) {
    String name = "${rule["name"]}";
    double baseRate = (rule["baseRate"] as num).toDouble();
    double perKmRate = (rule["perKmRate"] as num).toDouble();
    double perKgRate = (rule["perKgRate"] as num).toDouble();
    double minimumCharge = (rule["minimumCharge"] as num).toDouble();
    double maximumCharge = (rule["maximumCharge"] as num).toDouble();
    double fuelSurcharge = (rule["fuelSurcharge"] as num).toDouble();
    String description = "${rule["description"]}";
    bool active = rule["active"] as bool;

    return Dialog(
      child: Container(
        width: 500,
        padding: EdgeInsets.all(spMd),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Pricing Rule",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QTextField(
                label: "Rule Name",
                value: name,
                onChanged: (value) => name = value,
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Base Rate (\$)",
                      value: baseRate.toString(),
                      onChanged: (value) => baseRate = double.tryParse(value) ?? 0.0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Per KM Rate (\$)",
                      value: perKmRate.toString(),
                      onChanged: (value) => perKmRate = double.tryParse(value) ?? 0.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Per KG Rate (\$)",
                      value: perKgRate.toString(),
                      onChanged: (value) => perKgRate = double.tryParse(value) ?? 0.0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Fuel Surcharge (%)",
                      value: fuelSurcharge.toString(),
                      onChanged: (value) => fuelSurcharge = double.tryParse(value) ?? 0.0,
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
                      onChanged: (value) => minimumCharge = double.tryParse(value) ?? 0.0,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QNumberField(
                      label: "Maximum Charge (\$)",
                      value: maximumCharge.toString(),
                      onChanged: (value) => maximumCharge = double.tryParse(value) ?? 0.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Description",
                value: description,
                onChanged: (value) => description = value,
              ),
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Active",
                    "value": true,
                    "checked": active,
                  }
                ],
                value: active ? [{"label": "Active", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  active = values.isNotEmpty;
                },
              ),
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Save Changes",
                      size: bs.sm,
                      onPressed: () {
                        // Update the pricing rule
                        int index = pricingRules.indexWhere((r) => r["id"] == rule["id"]);
                        if (index != -1) {
                          pricingRules[index]["name"] = name;
                          pricingRules[index]["baseRate"] = baseRate;
                          pricingRules[index]["perKmRate"] = perKmRate;
                          pricingRules[index]["perKgRate"] = perKgRate;
                          pricingRules[index]["minimumCharge"] = minimumCharge;
                          pricingRules[index]["maximumCharge"] = maximumCharge;
                          pricingRules[index]["fuelSurcharge"] = fuelSurcharge;
                          pricingRules[index]["description"] = description;
                          pricingRules[index]["active"] = active;
                          pricingRules[index]["lastUpdated"] = DateTime.now().toIso8601String();
                          pricingRules[index]["updatedBy"] = "Current User";
                          setState(() {});
                          ss("Pricing rule updated successfully");
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deletePricingRule(String ruleId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this pricing rule?");
    if (isConfirmed) {
      pricingRules.removeWhere((r) => r["id"] == ruleId);
      setState(() {});
      ss("Pricing rule deleted successfully");
    }
  }

  Color _getServiceTypeColor(String serviceType) {
    switch (serviceType) {
      case "standard":
        return infoColor;
      case "express":
        return warningColor;
      case "same_day":
        return successColor;
      case "overnight":
        return primaryColor;
      case "international":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Pricing Management"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayRules = filteredPricingRules;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pricing Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new pricing rule
            },
          ),
          IconButton(
            icon: Icon(Icons.import_export),
            onPressed: () {
              // Import/Export pricing data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search pricing rules...",
              value: searchQuery,
              hint: "Search by name or description",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

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

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${pricingRules.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Rules",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
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
                      color: successColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${pricingRules.where((r) => r["active"] == true).length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active Rules",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
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
                      color: disabledBoldColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${pricingRules.where((r) => r["active"] == false).length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Inactive Rules",
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

            // Pricing Rules List
            if (displayRules.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No pricing rules found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or create a new pricing rule",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayRules.map((rule) {
                  bool isActive = rule["active"] as bool;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: isActive ? successColor : disabledBoldColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getServiceTypeColor("${rule["serviceType"]}").withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${rule["serviceName"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getServiceTypeColor("${rule["serviceType"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${rule["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive 
                                      ? successColor.withValues(alpha: 0.1)
                                      : disabledBoldColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  isActive ? "ACTIVE" : "INACTIVE",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isActive ? successColor : disabledBoldColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),

                          // Zone and Description
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${rule["zoneName"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${rule["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spSm),

                          // Pricing Details
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "\$${(rule["baseRate"] as num).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Base Rate",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "\$${(rule["perKmRate"] as num).toStringAsFixed(2)}/km",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Per KM",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "\$${(rule["perKgRate"] as num).toStringAsFixed(2)}/kg",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Text(
                                            "Per KG",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${(rule["fuelSurcharge"] as num).toStringAsFixed(1)}%",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: warningColor,
                                            ),
                                          ),
                                          Text(
                                            "Fuel",
                                            style: TextStyle(
                                              fontSize: 10,
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
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Min: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(rule["minimumCharge"] as num).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Max: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(rule["maximumCharge"] as num).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spSm),

                          // Footer
                          Row(
                            children: [
                              Text(
                                "Updated: ${DateTime.parse("${rule["lastUpdated"]}").day}/${DateTime.parse("${rule["lastUpdated"]}").month}/${DateTime.parse("${rule["lastUpdated"]}").year}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "by ${rule["updatedBy"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              QButton(
                                label: "Edit",
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () => _editPricingRule("${rule["id"]}"),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.delete,
                                size: bs.sm,
                                onPressed: () => _deletePricingRule("${rule["id"]}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
