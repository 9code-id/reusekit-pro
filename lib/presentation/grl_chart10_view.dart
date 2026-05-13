import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChart10View extends StatefulWidget {
  @override
  State<GrlChart10View> createState() => _GrlChart10ViewState();
}

class _GrlChart10ViewState extends State<GrlChart10View> {
  String selectedVisualization = "Heat Map";
  int selectedDataset = 0;
  bool showInteractive = true;
  bool enableExport = false;
  
  List<String> datasets = ["User Behavior", "Sales Performance", "Market Analysis", "Customer Journey"];
  
  List<Map<String, dynamic>> visualizationTypes = [
    {"label": "Heat Map", "value": "heat_map"},
    {"label": "Scatter Plot", "value": "scatter_plot"},
    {"label": "Bubble Chart", "value": "bubble_chart"},
    {"label": "Treemap", "value": "treemap"},
  ];

  List<Map<String, dynamic>> heatmapData = [
    {"hour": "00", "mon": 23, "tue": 18, "wed": 12, "thu": 28, "fri": 15, "sat": 45, "sun": 38},
    {"hour": "03", "mon": 15, "tue": 12, "wed": 8, "thu": 19, "fri": 11, "sat": 32, "sun": 25},
    {"hour": "06", "mon": 45, "tue": 38, "wed": 32, "thu": 52, "fri": 41, "sat": 68, "sun": 59},
    {"hour": "09", "mon": 78, "tue": 82, "wed": 75, "thu": 89, "fri": 85, "sat": 92, "sun": 71},
    {"hour": "12", "mon": 95, "tue": 89, "wed": 92, "thu": 98, "fri": 94, "sat": 100, "sun": 87},
    {"hour": "15", "mon": 85, "tue": 91, "wed": 88, "thu": 93, "fri": 90, "sat": 95, "sun": 82},
    {"hour": "18", "mon": 72, "tue": 68, "wed": 75, "thu": 79, "fri": 81, "sat": 88, "sun": 76},
    {"hour": "21", "mon": 52, "tue": 45, "wed": 48, "thu": 59, "fri": 62, "sat": 78, "sun": 65},
  ];

  List<Map<String, dynamic>> scatterData = [
    {"spend": 1200, "revenue": 4800, "roi": 4.0, "size": 45, "category": "Email"},
    {"spend": 2500, "revenue": 8500, "roi": 3.4, "size": 78, "category": "Google Ads"},
    {"spend": 1800, "revenue": 6200, "roi": 3.44, "size": 65, "category": "Facebook"},
    {"spend": 800, "revenue": 5100, "roi": 6.4, "size": 32, "category": "Content"},
    {"spend": 1500, "revenue": 4200, "roi": 2.8, "size": 58, "category": "Display"},
    {"spend": 900, "revenue": 3800, "roi": 4.2, "size": 28, "category": "Referral"},
    {"spend": 2200, "revenue": 7200, "roi": 3.3, "size": 89, "category": "Social"},
    {"spend": 1100, "revenue": 3900, "roi": 3.5, "size": 42, "category": "Influencer"},
  ];

  List<Map<String, dynamic>> bubbleData = [
    {"category": "Mobile Apps", "users": 12500, "revenue": 95000, "growth": 24.5, "color": Colors.blue},
    {"category": "Web Platform", "users": 8900, "revenue": 78000, "growth": 18.2, "color": Colors.green},
    {"category": "Desktop", "users": 4200, "revenue": 52000, "growth": -3.1, "color": Colors.orange},
    {"category": "Tablet", "users": 2800, "revenue": 32000, "growth": 12.8, "color": Colors.purple},
    {"category": "Smart TV", "users": 1500, "revenue": 18000, "growth": 45.2, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Visualizations"),
        actions: [
          Icon(Icons.fullscreen, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.settings, color: primaryColor),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVisualizationControls(),
            _buildVisualizationStats(),
            _buildMainVisualization(),
            _buildSecondaryCharts(),
            _buildDataInsights(),
            _buildExportActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualizationControls() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Visualization Controls",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Visualization Type",
                  items: visualizationTypes,
                  value: selectedVisualization,
                  onChanged: (value, label) {
                    selectedVisualization = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QCategoryPicker(
                  items: datasets.map((ds) => {"label": ds, "value": ds}).toList(),
                  value: datasets[selectedDataset],
                  onChanged: (index, label, value, item) {
                    selectedDataset = index;
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
                  items: [{
                    "label": "Interactive Mode",
                    "value": true,
                    "checked": showInteractive,
                  }],
                  value: showInteractive ? [{
                    "label": "Interactive Mode",
                    "value": true,
                    "checked": true
                  }] : [],
                  onChanged: (values, ids) {
                    showInteractive = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QSwitch(
                  items: [{
                    "label": "Enable Export",
                    "value": true,
                    "checked": enableExport,
                  }],
                  value: enableExport ? [{
                    "label": "Enable Export",
                    "value": true,
                    "checked": true
                  }] : [],
                  onChanged: (values, ids) {
                    enableExport = values.isNotEmpty;
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

  Widget _buildVisualizationStats() {
    List<Map<String, dynamic>> stats = [
      {"title": "Data Points", "value": "2.4K", "change": "+12.5%", "icon": Icons.scatter_plot, "positive": true},
      {"title": "Dimensions", "value": "24", "change": "+3", "icon": Icons.view_module, "positive": true},
      {"title": "Accuracy", "value": "94.2%", "change": "+1.8%", "icon": Icons.verified, "positive": true},
      {"title": "Processing Time", "value": "0.8s", "change": "-0.2s", "icon": Icons.speed, "positive": true},
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: stats.map((stat) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border(top: BorderSide(color: primaryColor.withAlpha(128), width: 3)),
            boxShadow: [shadowMd],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      stat["icon"],
                      size: 20,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: stat["positive"] ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${stat["change"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: stat["positive"] ? successColor : dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${stat["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${stat["value"]}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMainVisualization() {
    switch (selectedVisualization) {
      case "Heat Map":
        return _buildHeatMap();
      case "Scatter Plot":
        return _buildScatterPlot();
      case "Bubble Chart":
        return _buildBubbleChart();
      case "Treemap":
        return _buildTreemap();
      default:
        return _buildHeatMap();
    }
  }

  Widget _buildHeatMap() {
    List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    List<String> hours = heatmapData.map((data) => data["hour"] as String).toList();
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "User Activity Heat Map",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spXs,
            children: [
              // Header row
              Row(
                children: [
                  Container(width: 40, child: Text("")),
                  ...days.map((day) => Expanded(
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ],
              ),
              // Data rows
              ...heatmapData.map((hourData) {
                return Row(
                  children: [
                    Container(
                      width: 40,
                      child: Text(
                        "${hourData["hour"]}:00",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    ...days.map((day) {
                      final dayKey = day.toLowerCase().substring(0, 3);
                      final value = hourData[dayKey] as int;
                      final intensity = value / 100.0;
                      
                      return Expanded(
                        child: Container(
                          height: 30,
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha((intensity * 255).toInt()),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Center(
                            child: Text(
                              showInteractive ? "$value" : "",
                              style: TextStyle(
                                fontSize: 10,
                                color: intensity > 0.5 ? Colors.white : primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: spSm,
            children: [
              Text(
                "Low Activity",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Container(
                width: 100,
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withAlpha(51),
                      primaryColor.withAlpha(128),
                      primaryColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Text(
                "High Activity",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScatterPlot() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ROI vs Spend Analysis",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Size = Conversion Volume",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Container(
            height: 300,
            child: Stack(
              children: [
                // Grid lines
                ...List.generate(5, (i) => Positioned(
                  left: 0,
                  right: 0,
                  bottom: (i * 60).toDouble(),
                  child: Container(
                    height: 1,
                    color: Colors.grey.withAlpha(51),
                  ),
                )),
                ...List.generate(5, (i) => Positioned(
                  left: (i * 70).toDouble(),
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 1,
                    color: Colors.grey.withAlpha(51),
                  ),
                )),
                // Data points
                ...scatterData.map((data) {
                  final spend = data["spend"] as int;
                  final roi = data["roi"] as double;
                  final size = data["size"] as int;
                  final category = data["category"] as String;
                  
                  final x = (spend / 3000) * 280;
                  final y = 280 - ((roi / 7) * 280);
                  final dotSize = (size / 100) * 40 + 10;
                  
                  final color = _getCategoryColor(category);
                  
                  return Positioned(
                    left: x,
                    top: y,
                    child: GestureDetector(
                      onTap: showInteractive ? () {
                        // Show tooltip or details
                      } : null,
                      child: Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                          color: color.withAlpha(180),
                          shape: BoxShape.circle,
                          border: Border.all(color: color, width: 2),
                          boxShadow: [shadowSm],
                        ),
                        child: Center(
                          child: Text(
                            category.substring(0, 2),
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                // Axis labels
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Text(
                    "Marketing Spend (\$)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 0,
                  bottom: 0,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      "ROI (x)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spXs,
            children: scatterData.map((data) {
              final category = data["category"] as String;
              final color = _getCategoryColor(category);
              
              return Row(
                mainAxisSize: MainAxisSize.min,
                spacing: spXs,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBubbleChart() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Platform Performance Bubbles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
            child: Stack(
              children: bubbleData.asMap().entries.map((entry) {
                int index = entry.key;
                var data = entry.value;
                
                final users = data["users"] as int;
                final revenue = data["revenue"] as int;
                final growth = data["growth"] as double;
                final category = data["category"] as String;
                final color = data["color"] as Color;
                
                final bubbleSize = (users / 15000) * 120 + 40;
                final x = (index % 3) * 120 + 50.0;
                final y = (index ~/ 3) * 120 + 50.0;
                
                return Positioned(
                  left: x,
                  top: y,
                  child: Container(
                    width: bubbleSize,
                    height: bubbleSize,
                    decoration: BoxDecoration(
                      color: color.withAlpha(128),
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 3),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          category,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${(users / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: growth >= 0 ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${growth >= 0 ? '+' : ''}${growth.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreemap() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue Distribution Treemap",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 300,
            child: Column(
              spacing: spXs,
              children: [
                // First row - largest segments
                Expanded(
                  flex: 2,
                  child: Row(
                    spacing: spXs,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.withAlpha(128),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Mobile Apps",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$95K",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "38.5%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withAlpha(128),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Web Platform",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$78K",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "31.6%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Second row - smaller segments
                Expanded(
                  flex: 1,
                  child: Row(
                    spacing: spXs,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange.withAlpha(128),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: Colors.orange, width: 2),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Desktop",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$52K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.purple.withAlpha(128),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: Colors.purple, width: 2),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tablet",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$32K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withAlpha(128),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Smart TV",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$18K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryCharts() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Quality Score",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(51),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.94,
                        child: Container(
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "94%",
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
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Visualization Load Time",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "0.8s",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "Excellent performance",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataInsights() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [infoColor.withAlpha(25), infoColor.withAlpha(51)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border(left: BorderSide(color: infoColor, width: 4)),
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: infoColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Visualization Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          Text(
            "Heat map reveals peak user activity between 12-15 hours on weekends. Mobile apps dominate revenue with 38.5% share. Email marketing shows highest ROI at 6.4x return.",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportActions() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Export & Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              QButton(
                label: "Export PNG",
                icon: Icons.image,
                size: bs.sm,
                onPressed: enableExport ? () {} : null,
              ),
              QButton(
                label: "Export SVG",
                icon: Icons.merge_type,
                size: bs.sm,
                onPressed: enableExport ? () {} : null,
              ),
              QButton(
                label: "Export Data",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
              QButton(
                label: "Share View",
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Email": return Colors.green;
      case "Google Ads": return Colors.blue;
      case "Facebook": return Colors.indigo;
      case "Content": return Colors.orange;
      case "Display": return Colors.purple;
      case "Referral": return Colors.teal;
      case "Social": return Colors.pink;
      case "Influencer": return Colors.amber;
      default: return primaryColor;
    }
  }
}
