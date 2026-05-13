import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaHarvestPlanningView extends StatefulWidget {
  const AmaHarvestPlanningView({super.key});

  @override
  State<AmaHarvestPlanningView> createState() => _AmaHarvestPlanningViewState();
}

class _AmaHarvestPlanningViewState extends State<AmaHarvestPlanningView> {
  String selectedSeason = "2024 Fall";
  String selectedCrop = "All Crops";
  String viewMode = "Calendar";
  String newCropName = "";
  String newCropVariety = "";
  String newPlantingDate = "";
  String newHarvestDate = "";
  String newArea = "";
  
  List<String> seasons = ["2024 Fall", "2024 Winter", "2025 Spring", "2025 Summer"];
  List<String> cropTypes = ["All Crops", "Vegetables", "Fruits", "Grains", "Herbs"];
  List<String> viewModes = ["Calendar", "Timeline", "List"];
  
  List<Map<String, dynamic>> harvestPlan = [
    {
      "crop_name": "Organic Tomatoes",
      "variety": "Heirloom",
      "planting_date": "2024-03-15",
      "harvest_date": "2024-08-15",
      "area": "45 acres",
      "expected_yield": "120 tons",
      "market_price": 3.50,
      "projected_revenue": 420000.0,
      "status": "harvesting",
      "weather_risk": "low",
      "crop_type": "Vegetables",
      "growth_days": 153,
      "notes": "Premium variety for organic markets",
    },
    {
      "crop_name": "Sweet Corn",
      "variety": "Golden Bantam",
      "planting_date": "2024-04-01",
      "harvest_date": "2024-09-01",
      "area": "60 acres",
      "expected_yield": "180 tons",
      "market_price": 2.80,
      "projected_revenue": 504000.0,
      "status": "mature",
      "weather_risk": "medium",
      "crop_type": "Vegetables",
      "growth_days": 153,
      "notes": "High demand from local processors",
    },
    {
      "crop_name": "Bell Peppers",
      "variety": "California Wonder",
      "planting_date": "2024-02-28",
      "harvest_date": "2024-07-28",
      "area": "30 acres",
      "expected_yield": "90 tons",
      "market_price": 4.20,
      "projected_revenue": 378000.0,
      "status": "completed",
      "weather_risk": "low",
      "crop_type": "Vegetables",
      "growth_days": 150,
      "notes": "Excellent quality this season",
    },
    {
      "crop_name": "Winter Wheat",
      "variety": "Hard Red",
      "planting_date": "2024-10-15",
      "harvest_date": "2025-06-15",
      "area": "100 acres",
      "expected_yield": "350 tons",
      "market_price": 1.80,
      "projected_revenue": 630000.0,
      "status": "planned",
      "weather_risk": "medium",
      "crop_type": "Grains",
      "growth_days": 243,
      "notes": "Contract with local mill secured",
    },
    {
      "crop_name": "Strawberries",
      "variety": "Albion",
      "planting_date": "2024-09-01",
      "harvest_date": "2025-05-01",
      "area": "15 acres",
      "expected_yield": "45 tons",
      "market_price": 8.50,
      "projected_revenue": 382500.0,
      "status": "growing",
      "weather_risk": "high",
      "crop_type": "Fruits",
      "growth_days": 242,
      "notes": "Premium variety for direct sales",
    },
    {
      "crop_name": "Basil",
      "variety": "Genovese",
      "planting_date": "2024-05-15",
      "harvest_date": "2024-09-15",
      "area": "5 acres",
      "expected_yield": "8 tons",
      "market_price": 12.00,
      "projected_revenue": 96000.0,
      "status": "harvesting",
      "weather_risk": "low",
      "crop_type": "Herbs",
      "growth_days": 123,
      "notes": "Restaurant supply contract",
    },
  ];

  List<Map<String, dynamic>> weatherAlerts = [
    {
      "alert_type": "Frost Warning",
      "severity": "high",
      "affected_crops": ["Strawberries", "Basil"],
      "date": "2024-11-25",
      "recommendation": "Cover crops or move to greenhouse",
      "probability": 85,
    },
    {
      "alert_type": "Heavy Rain",
      "severity": "medium",
      "affected_crops": ["Sweet Corn", "Winter Wheat"],
      "date": "2024-11-28",
      "recommendation": "Ensure proper drainage",
      "probability": 65,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter harvest plan based on selections
    List<Map<String, dynamic>> filteredPlans = harvestPlan.where((plan) {
      if (selectedCrop != "All Crops" && plan["crop_type"] != selectedCrop) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Harvest Planning"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddCropDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              si("Export harvest calendar");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Planning Overview Cards
            Row(
              children: [
                Expanded(
                  child: _buildOverviewCard(
                    "Total Crops",
                    "${harvestPlan.length}",
                    Icons.agriculture,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildOverviewCard(
                    "Total Area",
                    "${harvestPlan.fold<double>(0, (sum, plan) => sum + double.parse((plan["area"] as String).split(" ")[0])).toStringAsFixed(0)} acres",
                    Icons.landscape,
                    successColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: _buildOverviewCard(
                    "Active Harvests",
                    "${harvestPlan.where((plan) => plan["status"] == "harvesting" || plan["status"] == "mature").length}",
                    Icons.grass,
                    warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildOverviewCard(
                    "Revenue Proj.",
                    "\$${(harvestPlan.fold<double>(0, (sum, plan) => sum + (plan["projected_revenue"] as double)) / 1000).toStringAsFixed(0)}K",
                    Icons.attach_money,
                    infoColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Weather Alerts
            if (weatherAlerts.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning, color: warningColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Weather Alerts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${weatherAlerts.length}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...List.generate(weatherAlerts.length, (index) {
                      final alert = weatherAlerts[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: _getAlertSeverityColor(alert["severity"]).withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${alert["alert_type"]} - ${DateTime.parse(alert["date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: _getAlertSeverityColor(alert["severity"]),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${alert["probability"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _getAlertSeverityColor(alert["severity"]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Affected: ${(alert["affected_crops"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Action: ${alert["recommendation"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            
            if (weatherAlerts.isNotEmpty) SizedBox(height: spMd),
            
            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Season",
                    value: selectedSeason,
                    items: seasons.map((season) => {
                      "label": season,
                      "value": season,
                    }).toList(),
                    onChanged: (value, label) {
                      selectedSeason = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Crop Type",
                    value: selectedCrop,
                    items: cropTypes.map((type) => {
                      "label": type,
                      "value": type,
                    }).toList(),
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // View Mode Selector
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Harvest Schedule",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(viewModes.length, (index) {
                    final mode = viewModes[index];
                    final isSelected = viewMode == mode;
                    
                    return Container(
                      margin: EdgeInsets.only(left: spXs),
                      child: InkWell(
                        onTap: () {
                          viewMode = mode;
                          setState(() {});
                        },
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Text(
                            mode,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Harvest Plan List/Timeline
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(filteredPlans.length, (index) {
                    final plan = filteredPlans[index];
                    final plantingDate = DateTime.parse(plan["planting_date"]);
                    final harvestDate = DateTime.parse(plan["harvest_date"]);
                    final daysToHarvest = harvestDate.difference(DateTime.now()).inDays;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(plan["status"]).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: _getStatusColor(plan["status"]).withAlpha(30)),
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
                                      "${plan["crop_name"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${plan["variety"]} • ${plan["area"]}",
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
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(plan["status"]),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${plan["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getRiskColor(plan["weather_risk"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${plan["weather_risk"]} risk".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w500,
                                        color: _getRiskColor(plan["weather_risk"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Timeline
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Planted",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${plantingDate.dMMMy}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: disabledBoldColor, size: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      daysToHarvest > 0 ? "Days to Harvest" : "Harvest Date",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      daysToHarvest > 0 ? "$daysToHarvest days" : "${harvestDate.dMMMy}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: daysToHarvest <= 7 ? dangerColor : successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: disabledBoldColor, size: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Expected Yield",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${plan["expected_yield"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Financial Info
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Market Price",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(plan["market_price"] as double).toStringAsFixed(2)}/kg",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Growth Period",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${plan["growth_days"]} days",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Revenue Projection",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${((plan["projected_revenue"] as double) / 1000).toStringAsFixed(0)}K",
                                        style: TextStyle(
                                          fontSize: 14,
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
                          
                          if (plan["notes"] != null && (plan["notes"] as String).isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: spSm),
                                Text(
                                  "Notes: ${plan["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          
                          SizedBox(height: spSm),
                          
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Viewing details for ${plan["crop_name"]}");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Edit Plan",
                                  size: bs.sm,
                                  icon: Icons.edit,
                                  onPressed: () {
                                    si("Editing plan for ${plan["crop_name"]}");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'planned':
        return infoColor;
      case 'growing':
        return warningColor;
      case 'mature':
        return primaryColor;
      case 'harvesting':
        return successColor;
      case 'completed':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'low':
        return successColor;
      case 'medium':
        return warningColor;
      case 'high':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getAlertSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'low':
        return infoColor;
      case 'medium':
        return warningColor;
      case 'high':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _showAddCropDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Crop Plan"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Crop Name",
                value: newCropName,
                onChanged: (value) {
                  newCropName = value;
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Variety",
                value: newCropVariety,
                onChanged: (value) {
                  newCropVariety = value;
                },
              ),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Planting Date",
                value: newPlantingDate.isNotEmpty ? DateTime.parse(newPlantingDate) : DateTime.now(),
                onChanged: (value) {
                  newPlantingDate = value.toString();
                },
              ),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Expected Harvest Date",
                value: newHarvestDate.isNotEmpty ? DateTime.parse(newHarvestDate) : DateTime.now().add(Duration(days: 90)),
                onChanged: (value) {
                  newHarvestDate = value.toString();
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Area (acres)",
                value: newArea,
                onChanged: (value) {
                  newArea = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              back();
            },
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Crop",
            size: bs.sm,
            onPressed: () {
              if (newCropName.isNotEmpty && newArea.isNotEmpty) {
                ss("New crop plan added successfully");
                back();
                // Reset form
                newCropName = "";
                newCropVariety = "";
                newPlantingDate = "";
                newHarvestDate = "";
                newArea = "";
                setState(() {});
              } else {
                se("Please fill in all required fields");
              }
            },
          ),
        ],
      ),
    );
  }
}
