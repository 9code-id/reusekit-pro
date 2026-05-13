import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport7View extends StatefulWidget {
  @override
  State<GrlReport7View> createState() => _GrlReport7ViewState();
}

class _GrlReport7ViewState extends State<GrlReport7View> {
  int currentTab = 0;
  String selectedPeriod = "monthly";
  String selectedCategory = "all";

  List<Map<String, dynamic>> operationalData = [
    {
      "id": 1,
      "metric": "Production Output",
      "value": 95.8,
      "unit": "%",
      "target": 98.0,
      "trend": "up",
      "change": 2.3,
      "color": successColor,
      "icon": Icons.precision_manufacturing,
    },
    {
      "id": 2,
      "metric": "Equipment Efficiency",
      "value": 87.5,
      "unit": "%",
      "target": 90.0,
      "trend": "down",
      "change": -1.2,
      "color": warningColor,
      "icon": Icons.settings,
    },
    {
      "id": 3,
      "metric": "Quality Rating",
      "value": 99.2,
      "unit": "%",
      "target": 99.0,
      "trend": "up",
      "change": 0.8,
      "color": successColor,
      "icon": Icons.verified,
    },
    {
      "id": 4,
      "metric": "Energy Consumption",
      "value": 78.4,
      "unit": "kWh",
      "target": 80.0,
      "trend": "down",
      "change": -2.1,
      "color": successColor,
      "icon": Icons.electric_bolt,
    },
  ];

  List<Map<String, dynamic>> processData = [
    {
      "id": 1,
      "process": "Manufacturing Line A",
      "efficiency": 92.5,
      "downtime": 2.3,
      "quality": 98.7,
      "throughput": 1250,
      "status": "optimal",
    },
    {
      "id": 2,
      "process": "Manufacturing Line B",
      "efficiency": 88.2,
      "downtime": 4.1,
      "quality": 97.9,
      "throughput": 1180,
      "status": "warning",
    },
    {
      "id": 3,
      "process": "Quality Control",
      "efficiency": 95.8,
      "downtime": 1.2,
      "quality": 99.5,
      "throughput": 2400,
      "status": "optimal",
    },
    {
      "id": 4,
      "process": "Packaging Line",
      "efficiency": 89.7,
      "downtime": 3.5,
      "quality": 98.2,
      "throughput": 2200,
      "status": "good",
    },
  ];

  List<Map<String, dynamic>> resourceData = [
    {
      "id": 1,
      "resource": "Raw Materials",
      "usage": 85.2,
      "cost": 125000,
      "efficiency": 92.1,
      "waste": 3.2,
      "status": "good",
    },
    {
      "id": 2,
      "resource": "Labor Hours",
      "usage": 78.9,
      "cost": 85000,
      "efficiency": 88.5,
      "waste": 5.1,
      "status": "warning",
    },
    {
      "id": 3,
      "resource": "Machine Time",
      "usage": 91.3,
      "cost": 45000,
      "efficiency": 94.2,
      "waste": 2.8,
      "status": "optimal",
    },
    {
      "id": 4,
      "resource": "Energy",
      "usage": 82.7,
      "cost": 18000,
      "efficiency": 89.8,
      "waste": 4.3,
      "status": "good",
    },
  ];

  List<Map<String, dynamic>> performanceData = [
    {
      "id": 1,
      "kpi": "Overall Equipment Effectiveness",
      "current": 89.5,
      "target": 92.0,
      "benchmark": 85.0,
      "trend": "up",
      "priority": "high",
    },
    {
      "id": 2,
      "kpi": "First Pass Yield",
      "current": 96.8,
      "target": 98.0,
      "benchmark": 94.0,
      "trend": "stable",
      "priority": "medium",
    },
    {
      "id": 3,
      "kpi": "Mean Time Between Failures",
      "current": 425.0,
      "target": 500.0,
      "benchmark": 380.0,
      "trend": "up",
      "priority": "high",
    },
    {
      "id": 4,
      "kpi": "Cost per Unit",
      "current": 12.45,
      "target": 11.80,
      "benchmark": 13.20,
      "trend": "down",
      "priority": "medium",
    },
  ];

  Widget _buildMetricCard(Map<String, dynamic> metric) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (metric["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  metric["icon"] as IconData,
                  color: metric["color"] as Color,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${metric["metric"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${(metric["value"] as num).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (metric["trend"] == "up" ? successColor : warningColor).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            metric["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                            size: 14,
                            color: metric["trend"] == "up" ? successColor : warningColor,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${(metric["change"] as num).abs().toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: metric["trend"] == "up" ? successColor : warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Target: ${(metric["target"] as num).toStringAsFixed(1)}${metric["unit"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (metric["value"] as num) / (metric["target"] as num),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(metric["color"] as Color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessCard(Map<String, dynamic> process) {
    Color statusColor = process["status"] == "optimal" 
        ? successColor 
        : process["status"] == "warning" 
            ? warningColor 
            : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${process["process"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${process["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
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
                      "Efficiency",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(process["efficiency"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                      "Downtime",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(process["downtime"] as num).toStringAsFixed(1)}h",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quality",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(process["quality"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Throughput",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(process["throughput"] as int)} units",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(Map<String, dynamic> resource) {
    Color statusColor = resource["status"] == "optimal" 
        ? successColor 
        : resource["status"] == "warning" 
            ? warningColor 
            : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${resource["resource"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${resource["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
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
                      "Usage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(resource["usage"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                      "Cost",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((resource["cost"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Efficiency",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(resource["efficiency"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Waste",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(resource["waste"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: (resource["usage"] as num) / 100,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(Map<String, dynamic> kpi) {
    Color priorityColor = kpi["priority"] == "high" 
        ? dangerColor 
        : kpi["priority"] == "medium" 
            ? warningColor 
            : successColor;

    double progress = (kpi["current"] as num) / (kpi["target"] as num);
    if (kpi["kpi"] == "Cost per Unit") {
      progress = (kpi["target"] as num) / (kpi["current"] as num);
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${kpi["kpi"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${kpi["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
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
                      "Current",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(kpi["current"] as num).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                      "Target",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(kpi["target"] as num).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                      "Benchmark",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(kpi["benchmark"] as num).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
              Text(
                "Progress to Target",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(progress * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: progress >= 1.0 ? successColor : warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1.0 ? successColor : warningColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Operational Overview",
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
            children: operationalData.map((metric) {
              return _buildMetricCard(metric);
            }).toList(),
          ),
          SizedBox(height: spLg),
          Text(
            "Process Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: processData.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              return _buildProcessCard(processData[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Resource Utilization",
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
            children: resourceData.map((resource) {
              return _buildResourceCard(resource);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Key Performance Indicators",
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
            children: performanceData.map((kpi) {
              return _buildPerformanceCard(kpi);
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Operations Report",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Resources", icon: Icon(Icons.inventory)),
        Tab(text: "Performance", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildResourcesTab(),
        _buildPerformanceTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
