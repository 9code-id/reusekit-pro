import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCarbonFootprintView extends StatefulWidget {
  const CmaCarbonFootprintView({super.key});

  @override
  State<CmaCarbonFootprintView> createState() => _CmaCarbonFootprintViewState();
}

class _CmaCarbonFootprintViewState extends State<CmaCarbonFootprintView> {
  int currentTab = 0;
  String selectedPeriod = "This Month";
  String selectedScope = "All Scopes";
  
  List<Map<String, dynamic>> carbonData = [
    {
      "category": "Vehicle Operations",
      "scope": "Scope 1",
      "currentPeriod": 1245.8,
      "previousPeriod": 1456.3,
      "change": -14.5,
      "unit": "tCO2e",
      "breakdown": {
        "Gasoline Vehicles": 856.4,
        "Diesel Vehicles": 389.4
      },
      "icon": Icons.local_shipping,
      "color": "danger"
    },
    {
      "category": "Electricity Usage",
      "scope": "Scope 2",
      "currentPeriod": 567.2,
      "previousPeriod": 623.8,
      "change": -9.1,
      "unit": "tCO2e",
      "breakdown": {
        "Charging Stations": 234.5,
        "Facilities": 189.7,
        "Manufacturing": 143.0
      },
      "icon": Icons.electrical_services,
      "color": "warning"
    },
    {
      "category": "Supply Chain",
      "scope": "Scope 3",
      "currentPeriod": 2134.6,
      "previousPeriod": 2234.1,
      "change": -4.5,
      "unit": "tCO2e",
      "breakdown": {
        "Materials": 845.2,
        "Transportation": 567.8,
        "Manufacturing": 456.3,
        "Waste": 265.3
      },
      "icon": Icons.factory,
      "color": "info"
    },
    {
      "category": "Business Travel",
      "scope": "Scope 3",
      "currentPeriod": 89.4,
      "previousPeriod": 156.7,
      "change": -42.9,
      "unit": "tCO2e",
      "breakdown": {
        "Air Travel": 67.8,
        "Ground Transport": 21.6
      },
      "icon": Icons.flight,
      "color": "primary"
    }
  ];

  List<Map<String, dynamic>> offsetProjects = [
    {
      "id": 1,
      "name": "Renewable Energy Initiative",
      "type": "Solar Farm Development",
      "location": "Nevada, USA",
      "carbonOffset": 1250.0,
      "cost": 18750.0,
      "duration": "10 years",
      "certification": "Gold Standard",
      "status": "Active",
      "progress": 65.0,
      "description": "Large-scale solar farm providing clean energy to the grid",
      "image": "https://picsum.photos/300/200?random=1&keyword=solar-farm"
    },
    {
      "id": 2,
      "name": "Forest Conservation Project",
      "type": "Reforestation",
      "location": "Amazon, Brazil",
      "carbonOffset": 890.0,
      "cost": 12350.0,
      "duration": "25 years",
      "certification": "VCS",
      "status": "Active",
      "progress": 45.0,
      "description": "Protecting and restoring native forest ecosystems",
      "image": "https://picsum.photos/300/200?random=2&keyword=forest"
    },
    {
      "id": 3,
      "name": "Wind Energy Project",
      "type": "Wind Farm",
      "location": "Texas, USA",
      "carbonOffset": 2150.0,
      "cost": 32250.0,
      "duration": "15 years",
      "certification": "CDM",
      "status": "Planned",
      "progress": 15.0,
      "description": "Offshore wind farm generating clean electricity",
      "image": "https://picsum.photos/300/200?random=3&keyword=wind-turbine"
    },
    {
      "id": 4,
      "name": "Methane Capture Initiative",
      "type": "Waste Management",
      "location": "California, USA",
      "carbonOffset": 567.0,
      "cost": 8505.0,
      "duration": "8 years",
      "certification": "ACR",
      "status": "Active",
      "progress": 80.0,
      "description": "Capturing and utilizing methane from landfills",
      "image": "https://picsum.photos/300/200?random=4&keyword=methane-capture"
    }
  ];

  List<Map<String, dynamic>> reductionStrategies = [
    {
      "strategy": "Electric Vehicle Transition",
      "description": "Replace 80% of fleet with electric vehicles by 2025",
      "potentialReduction": 980.5,
      "cost": 2500000.0,
      "timeframe": "24 months",
      "roi": 18.5,
      "implementation": 35.0,
      "priority": "High",
      "category": "Fleet"
    },
    {
      "strategy": "Renewable Energy Adoption",
      "description": "Switch to 100% renewable electricity for all facilities",
      "potentialReduction": 567.2,
      "cost": 450000.0,
      "timeframe": "12 months",
      "roi": 22.3,
      "implementation": 60.0,
      "priority": "High",
      "category": "Energy"
    },
    {
      "strategy": "Supply Chain Optimization",
      "description": "Optimize logistics and select low-carbon suppliers",
      "potentialReduction": 425.8,
      "cost": 180000.0,
      "timeframe": "18 months",
      "roi": 15.2,
      "implementation": 20.0,
      "priority": "Medium",
      "category": "Supply Chain"
    },
    {
      "strategy": "Smart Building Systems",
      "description": "Implement IoT-based energy management systems",
      "potentialReduction": 234.6,
      "cost": 320000.0,
      "timeframe": "8 months",
      "roi": 12.8,
      "implementation": 75.0,
      "priority": "Medium",
      "category": "Facilities"
    }
  ];

  List<Map<String, dynamic>> benchmarkData = [
    {
      "company": "Your Company",
      "industry": "Automotive",
      "totalEmissions": 3947.0,
      "emissionsPerRevenue": 2.45,
      "reductionTarget": 50.0,
      "netZeroYear": 2035,
      "ranking": 1,
      "isCurrentCompany": true
    },
    {
      "company": "Industry Average",
      "industry": "Automotive",
      "totalEmissions": 5234.0,
      "emissionsPerRevenue": 3.2,
      "reductionTarget": 30.0,
      "netZeroYear": 2040,
      "ranking": 2,
      "isCurrentCompany": false
    },
    {
      "company": "Best in Class",
      "industry": "Automotive",
      "totalEmissions": 2156.0,
      "emissionsPerRevenue": 1.35,
      "reductionTarget": 65.0,
      "netZeroYear": 2030,
      "ranking": 3,
      "isCurrentCompany": false
    }
  ];

  double get totalCurrentEmissions {
    return carbonData.fold(0.0, (sum, item) => sum + (item["currentPeriod"] as double));
  }

  double get totalPreviousEmissions {
    return carbonData.fold(0.0, (sum, item) => sum + (item["previousPeriod"] as double));
  }

  double get totalChange {
    return totalPreviousEmissions > 0 ? 
        ((totalCurrentEmissions - totalPreviousEmissions) / totalPreviousEmissions) * 100 : 0.0;
  }

  double get totalOffsets {
    return offsetProjects.fold(0.0, (sum, project) => 
        sum + ((project["carbonOffset"] as double) * (project["progress"] as double) / 100));
  }

  Color _getCategoryColor(String colorName) {
    switch (colorName) {
      case "danger": return dangerColor;
      case "warning": return warningColor;
      case "info": return infoColor;
      case "primary": return primaryColor;
      default: return primaryColor;
    }
  }

  Widget _buildEmissionCard(Map<String, dynamic> data) {
    Color categoryColor = _getCategoryColor(data["color"]);
    double changeValue = data["change"] as double;
    bool isReduction = changeValue < 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: categoryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  data["icon"] as IconData,
                  color: categoryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data["category"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${data["scope"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isReduction ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isReduction ? Icons.trending_down : Icons.trending_up,
                      color: isReduction ? successColor : dangerColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${changeValue.abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        color: isReduction ? successColor : dangerColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
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
                      "${(data["currentPeriod"] as double).toStringAsFixed(1)} ${data["unit"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: categoryColor,
                      ),
                    ),
                    Text(
                      "Current Period",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(data["previousPeriod"] as double).toStringAsFixed(1)} ${data["unit"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Previous Period",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Breakdown:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          ...(data["breakdown"] as Map<String, dynamic>).entries.map((entry) => 
            Padding(
              padding: EdgeInsets.only(bottom: spXs),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: categoryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  Text(
                    "${(entry.value as double).toStringAsFixed(1)} ${data["unit"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildOffsetCard(Map<String, dynamic> project) {
    Color statusColor = project["status"] == "Active" ? successColor : 
                       project["status"] == "Planned" ? warningColor : infoColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  child: Image.network(
                    "${project["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${project["status"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${project["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${project["type"]} • ${project["location"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${project["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${(project["carbonOffset"] as double).toStringAsFixed(0)} tCO2e",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Carbon Offset",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${((project["cost"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${project["duration"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "Progress: ${(project["progress"] as double).toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (project["progress"] as double) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          _showProjectDetails(project);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        si("Sharing project details...");
                      },
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

  Widget _buildStrategyCard(Map<String, dynamic> strategy) {
    Color priorityColor = strategy["priority"] == "High" ? dangerColor :
                          strategy["priority"] == "Medium" ? warningColor : successColor;
    
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
              Expanded(
                child: Text(
                  "${strategy["strategy"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${strategy["priority"]} Priority",
                  style: TextStyle(
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${strategy["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 120,
            children: [
              _buildStrategyMetric("Reduction", "${(strategy["potentialReduction"] as double).toStringAsFixed(0)} tCO2e", successColor),
              _buildStrategyMetric("Investment", "\$${((strategy["cost"] as double).toDouble()).currency}", primaryColor),
              _buildStrategyMetric("Timeframe", "${strategy["timeframe"]}", infoColor),
              _buildStrategyMetric("ROI", "${(strategy["roi"] as double).toStringAsFixed(1)}%", warningColor),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "Implementation Progress: ${(strategy["implementation"] as double).toStringAsFixed(0)}%",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (strategy["implementation"] as double) / 100,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(priorityColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStrategyMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBenchmarkCard(Map<String, dynamic> benchmark) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: benchmark["isCurrentCompany"] ? primaryColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: benchmark["isCurrentCompany"] ? 
            Border.all(color: primaryColor.withAlpha(50)) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: benchmark["isCurrentCompany"] ? primaryColor : disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "${benchmark["ranking"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${benchmark["company"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${(benchmark["totalEmissions"] as double).toStringAsFixed(0)} tCO2e • ${(benchmark["emissionsPerRevenue"] as double).toStringAsFixed(2)} tCO2e/\$M",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "Target: ${(benchmark["reductionTarget"] as double).toStringAsFixed(0)}% by ${benchmark["netZeroYear"]}",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProjectDetails(Map<String, dynamic> project) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${project["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${project["type"]} • ${project["location"]}",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          "${project["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Project Details",
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
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow("Carbon Offset", "${(project["carbonOffset"] as double).toStringAsFixed(0)} tCO2e"),
                          _buildDetailRow("Total Cost", "\$${((project["cost"] as double).toDouble()).currency}"),
                          _buildDetailRow("Duration", "${project["duration"]}"),
                          _buildDetailRow("Certification", "${project["certification"]}"),
                          _buildDetailRow("Progress", "${(project["progress"] as double).toStringAsFixed(0)}%"),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${project["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Carbon Footprint",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.co2)),
        Tab(text: "Offsets", icon: Icon(Icons.forest)),
        Tab(text: "Strategies", icon: Icon(Icons.trending_down)),
        Tab(text: "Benchmarks", icon: Icon(Icons.leaderboard)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Period",
                      items: [
                        {"label": "This Month", "value": "This Month"},
                        {"label": "This Quarter", "value": "This Quarter"},
                        {"label": "This Year", "value": "This Year"},
                        {"label": "Last Year", "value": "Last Year"},
                      ],
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Scope",
                      items: [
                        {"label": "All Scopes", "value": "All Scopes"},
                        {"label": "Scope 1", "value": "Scope 1"},
                        {"label": "Scope 2", "value": "Scope 2"},
                        {"label": "Scope 3", "value": "Scope 3"},
                      ],
                      value: selectedScope,
                      onChanged: (value, label) {
                        selectedScope = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.co2, color: primaryColor),
                        SizedBox(width: spSm),
                        Text(
                          "Total Carbon Footprint",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${totalCurrentEmissions.toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "tCO2e Current",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${totalChange.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: totalChange < 0 ? successColor : dangerColor,
                                ),
                              ),
                              Text(
                                "Change",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${totalOffsets.toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "tCO2e Offset",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
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
              SizedBox(height: spMd),
              Text(
                "Emissions by Category",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...carbonData.map((data) => _buildEmissionCard(data)).toList(),
            ],
          ),
        ),
        
        // Offsets Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.forest, color: successColor, size: 48),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Carbon Offset Portfolio",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${totalOffsets.toStringAsFixed(1)} tCO2e offset achieved",
                            style: TextStyle(
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Net Impact: ${(totalOffsets - totalCurrentEmissions).toStringAsFixed(1)} tCO2e",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Active Offset Projects",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...offsetProjects.map((project) => _buildOffsetCard(project)).toList(),
            ],
          ),
        ),
        
        // Strategies Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Carbon Reduction Strategies",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...reductionStrategies.map((strategy) => _buildStrategyCard(strategy)).toList(),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add New Strategy",
                  icon: Icons.add,
                  onPressed: () {
                    si("Opening strategy creation form...");
                  },
                ),
              ),
            ],
          ),
        ),
        
        // Benchmarks Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Industry Benchmarks",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...benchmarkData.map((benchmark) => _buildBenchmarkCard(benchmark)).toList(),
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor),
                        SizedBox(width: spSm),
                        Text(
                          "Performance Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text("• You're performing 25% better than industry average"),
                    Text("• 45% reduction needed to match best in class"),
                    Text("• On track to meet 2035 net-zero commitment"),
                    Text("• Recommended: Accelerate EV transition plan"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
