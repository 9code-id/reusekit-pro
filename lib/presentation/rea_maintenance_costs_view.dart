import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaMaintenanceCostsView extends StatefulWidget {
  const ReaMaintenanceCostsView({super.key});

  @override
  State<ReaMaintenanceCostsView> createState() => _ReaMaintenanceCostsViewState();
}

class _ReaMaintenanceCostsViewState extends State<ReaMaintenanceCostsView> {
  String selectedPropertyType = "Single Family Home";
  String selectedTimeframe = "Annual";
  double propertyValue = 500000;
  double sqft = 2500;
  int propertyAge = 15;
  bool hasPool = false;
  bool hasGarden = true;
  bool hasGarage = true;
  
  final List<String> propertyTypes = [
    "Single Family Home", "Condo", "Townhouse", "Multi-Family", "Commercial"
  ];
  
  final List<String> timeframes = [
    "Monthly", "Annual", "10 Years", "20 Years"
  ];

  final List<Map<String, dynamic>> maintenanceCategories = [
    {
      "category": "HVAC System",
      "icon": Icons.ac_unit,
      "color": primaryColor,
      "monthlyMin": 100,
      "monthlyMax": 300,
      "annualMin": 1200,
      "annualMax": 3600,
      "description": "Heating, ventilation, and air conditioning",
      "frequency": "Monthly inspections, annual servicing",
      "urgency": "high",
    },
    {
      "category": "Plumbing",
      "icon": Icons.plumbing,
      "color": infoColor,
      "monthlyMin": 50,
      "monthlyMax": 150,
      "annualMin": 600,
      "annualMax": 1800,
      "description": "Pipes, fixtures, water heater maintenance",
      "frequency": "Quarterly inspections",
      "urgency": "medium",
    },
    {
      "category": "Electrical",
      "icon": Icons.electrical_services,
      "color": warningColor,
      "monthlyMin": 40,
      "monthlyMax": 120,
      "annualMin": 480,
      "annualMax": 1440,
      "description": "Wiring, outlets, electrical panel maintenance",
      "frequency": "Annual inspections",
      "urgency": "high",
    },
    {
      "category": "Roofing",
      "icon": Icons.roofing,
      "color": dangerColor,
      "monthlyMin": 80,
      "monthlyMax": 200,
      "annualMin": 960,
      "annualMax": 2400,
      "description": "Roof repairs, gutter cleaning, insulation",
      "frequency": "Bi-annual inspections",
      "urgency": "medium",
    },
    {
      "category": "Exterior",
      "icon": Icons.home,
      "color": successColor,
      "monthlyMin": 60,
      "monthlyMax": 180,
      "annualMin": 720,
      "annualMax": 2160,
      "description": "Siding, windows, doors, painting",
      "frequency": "Annual maintenance",
      "urgency": "low",
    },
    {
      "category": "Flooring",
      "icon": Icons.layers,
      "color": primaryColor,
      "monthlyMin": 30,
      "monthlyMax": 100,
      "annualMin": 360,
      "annualMax": 1200,
      "description": "Carpet, hardwood, tile maintenance",
      "frequency": "As needed",
      "urgency": "low",
    },
    {
      "category": "Landscaping",
      "icon": Icons.grass,
      "color": successColor,
      "monthlyMin": 100,
      "monthlyMax": 300,
      "annualMin": 1200,
      "annualMax": 3600,
      "description": "Lawn care, tree maintenance, irrigation",
      "frequency": "Monthly",
      "urgency": "low",
    },
    {
      "category": "Appliances",
      "icon": Icons.kitchen,
      "color": infoColor,
      "monthlyMin": 50,
      "monthlyMax": 150,
      "annualMin": 600,
      "annualMax": 1800,
      "description": "Kitchen and laundry appliance maintenance",
      "frequency": "Quarterly",
      "urgency": "medium",
    },
  ];

  final List<Map<String, dynamic>> upcomingMaintenance = [
    {
      "task": "HVAC Filter Replacement",
      "dueDate": "Next Week",
      "cost": 45,
      "urgency": "high",
      "category": "HVAC System",
    },
    {
      "task": "Gutter Cleaning",
      "dueDate": "This Month",
      "cost": 200,
      "urgency": "medium",
      "category": "Roofing",
    },
    {
      "task": "Lawn Fertilization",
      "dueDate": "2 Weeks",
      "cost": 80,
      "urgency": "low",
      "category": "Landscaping",
    },
    {
      "task": "Water Heater Inspection",
      "dueDate": "Next Month",
      "cost": 150,
      "urgency": "medium",
      "category": "Plumbing",
    },
  ];

  final List<Map<String, dynamic>> maintenanceHistory = [
    {
      "task": "Roof Repair",
      "date": "2 months ago",
      "cost": 1200,
      "category": "Roofing",
      "contractor": "ABC Roofing",
    },
    {
      "task": "HVAC Servicing",
      "date": "3 months ago",
      "cost": 300,
      "category": "HVAC System",
      "contractor": "Cool Air Services",
    },
    {
      "task": "Exterior Painting",
      "date": "6 months ago",
      "cost": 2500,
      "category": "Exterior",
      "contractor": "Pro Painters",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maintenance Costs"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              _showMaintenanceSchedule();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              _showCostAnalytics();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cost Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Estimated ${selectedTimeframe} Maintenance Cost",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(217),
                    ),
                  ),
                  
                  Text(
                    "\$${_calculateTotalCost().toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildCostSummary("Per Sq Ft", "\$${(_calculateTotalCost() / sqft).toStringAsFixed(1)}"),
                      ),
                      
                      Expanded(
                        child: _buildCostSummary("% of Property Value", "${(_calculateTotalCost() / propertyValue * 100).toStringAsFixed(1)}%"),
                      ),
                      
                      Expanded(
                        child: _buildCostSummary("Monthly Avg", "\$${(_calculateTotalCost() / 12).toStringAsFixed(0)}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Property Configuration
            Text(
              "Property Configuration",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Property Type",
                          items: propertyTypes.map((type) => {"label": type, "value": type}).toList(),
                          value: selectedPropertyType,
                          onChanged: (value, label) {
                            selectedPropertyType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframes.map((time) => {"label": time, "value": time}).toList(),
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Property Value (\$)",
                          value: propertyValue.toString(),
                          onChanged: (value) {
                            propertyValue = double.tryParse(value) ?? 0;
                            setState(() {});
                          },
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: QNumberField(
                          label: "Square Feet",
                          value: sqft.toString(),
                          onChanged: (value) {
                            sqft = double.tryParse(value) ?? 0;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  QNumberField(
                    label: "Property Age (Years)",
                    value: propertyAge.toString(),
                    onChanged: (value) {
                      propertyAge = int.tryParse(value) ?? 0;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Has Pool",
                              "value": true,
                              "checked": hasPool,
                            }
                          ],
                          value: [if (hasPool) {"label": "Has Pool", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            hasPool = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Has Garden",
                              "value": true,
                              "checked": hasGarden,
                            }
                          ],
                          value: [if (hasGarden) {"label": "Has Garden", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            hasGarden = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Maintenance Categories
            Text(
              "Maintenance Categories",
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
              children: maintenanceCategories.map((category) {
                if (!_shouldShowCategory(category["category"])) {
                  return SizedBox.shrink();
                }
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
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
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: category["color"].withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              category["icon"],
                              color: category["color"],
                              size: 20,
                            ),
                          ),
                          
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${category["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getUrgencyColor(category["urgency"]).withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${category["urgency"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getUrgencyColor(category["urgency"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Text(
                        "${category["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Icon(Icons.schedule, color: disabledBoldColor, size: 14),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${category["frequency"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
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
                                  "Cost Range",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                
                                Text(
                                  "\$${_getCategoryCostRange(category)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: category["color"],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          QButton(
                            label: "Schedule",
                            size: bs.sm,
                            onPressed: () {
                              _scheduleMaintenance(category);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Upcoming Maintenance
            Text(
              "Upcoming Maintenance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: upcomingMaintenance.map((task) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getUrgencyColor(task["urgency"]).withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getUrgencyColor(task["urgency"]),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.build,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${task["task"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              
                              Text(
                                "${task["category"]} • Due: ${task["dueDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(task["cost"] as int).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            GestureDetector(
                              onTap: () {
                                _markAsCompleted(task);
                              },
                              child: Text(
                                "Mark Done",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Maintenance History
            Text(
              "Recent Maintenance History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: maintenanceHistory.map((record) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${record["task"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              
                              Text(
                                "${record["contractor"]} • ${record["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Text(
                          "\$${(record["cost"] as int).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quick Actions
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildActionCard(
                  "Find Contractors",
                  "Get quotes from local pros",
                  Icons.handyman,
                  primaryColor,
                  () => _findContractors(),
                ),
                
                _buildActionCard(
                  "Set Reminders",
                  "Schedule maintenance alerts",
                  Icons.notification_add,
                  warningColor,
                  () => _setReminders(),
                ),
                
                _buildActionCard(
                  "Cost Tracking",
                  "Track maintenance expenses",
                  Icons.receipt_long,
                  infoColor,
                  () => _trackCosts(),
                ),
                
                _buildActionCard(
                  "Emergency Fund",
                  "Calculate emergency reserves",
                  Icons.savings,
                  successColor,
                  () => _calculateEmergencyFund(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostSummary(String title, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(217),
            ),
          ),
          
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            
            SizedBox(height: spSm),
            
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
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
      ),
    );
  }

  double _calculateTotalCost() {
    double total = 0;
    for (var category in maintenanceCategories) {
      if (_shouldShowCategory(category["category"])) {
        total += _getCategoryEstimate(category);
      }
    }
    return total;
  }

  double _getCategoryEstimate(Map<String, dynamic> category) {
    final multiplier = selectedTimeframe == "Monthly" ? 1 :
                     selectedTimeframe == "Annual" ? 12 :
                     selectedTimeframe == "10 Years" ? 120 : 240;
    
    final baseMin = category["monthlyMin"] as int;
    final baseMax = category["monthlyMax"] as int;
    final average = (baseMin + baseMax) / 2;
    
    // Adjust for property age
    final ageMultiplier = 1 + (propertyAge / 100);
    
    return average * multiplier * ageMultiplier;
  }

  String _getCategoryCostRange(Map<String, dynamic> category) {
    final multiplier = selectedTimeframe == "Monthly" ? 1 :
                     selectedTimeframe == "Annual" ? 12 :
                     selectedTimeframe == "10 Years" ? 120 : 240;
    
    final min = (category["monthlyMin"] as int) * multiplier;
    final max = (category["monthlyMax"] as int) * multiplier;
    
    return "${min.toStringAsFixed(0)} - ${max.toStringAsFixed(0)}";
  }

  bool _shouldShowCategory(String categoryName) {
    if (categoryName == "Landscaping" && !hasGarden) return false;
    // Add more conditions based on property features
    return true;
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _showMaintenanceSchedule() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Maintenance Schedule",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text("View your complete maintenance schedule and set up recurring reminders."),
            
            Spacer(),
            
            QButton(
              label: "Close",
              size: bs.md,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showCostAnalytics() {
    ss("Opening cost analytics dashboard...");
  }

  void _scheduleMaintenance(Map<String, dynamic> category) {
    ss("Scheduling maintenance for ${category["category"]}");
  }

  void _markAsCompleted(Map<String, dynamic> task) {
    ss("Marked ${task["task"]} as completed");
  }

  void _findContractors() {
    ss("Finding local contractors...");
  }

  void _setReminders() {
    ss("Setting up maintenance reminders...");
  }

  void _trackCosts() {
    ss("Opening cost tracking dashboard...");
  }

  void _calculateEmergencyFund() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Emergency Fund Calculator"),
        content: Text(
          "Based on your property value and annual maintenance costs, we recommend:\n\n"
          "• Emergency Fund: \$${(propertyValue * 0.02).toStringAsFixed(0)}\n"
          "• Annual Reserve: \$${_calculateTotalCost().toStringAsFixed(0)}\n"
          "• Total Recommended: \$${(propertyValue * 0.02 + _calculateTotalCost()).toStringAsFixed(0)}"
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
