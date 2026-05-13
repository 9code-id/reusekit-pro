import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyReportsView extends StatefulWidget {
  const ReaPropertyReportsView({super.key});

  @override
  State<ReaPropertyReportsView> createState() => _ReaPropertyReportsViewState();
}

class _ReaPropertyReportsViewState extends State<ReaPropertyReportsView> {
  String selectedReportType = "Market Analysis";
  String selectedTimeframe = "Last 6 Months";
  String selectedPropertyType = "All Types";
  bool isGenerating = false;
  
  List<Map<String, dynamic>> reportTypes = [
    {
      "label": "Market Analysis",
      "value": "Market Analysis",
    },
    {
      "label": "Price Trends",
      "value": "Price Trends",
    },
    {
      "label": "Investment Report",
      "value": "Investment Report",
    },
    {
      "label": "Comparative Market Analysis",
      "value": "Comparative Market Analysis",
    },
    {
      "label": "Rental Yield Report",
      "value": "Rental Yield Report",
    },
  ];

  List<Map<String, dynamic>> timeframes = [
    {
      "label": "Last 3 Months",
      "value": "Last 3 Months",
    },
    {
      "label": "Last 6 Months",
      "value": "Last 6 Months",
    },
    {
      "label": "Last Year",
      "value": "Last Year",
    },
    {
      "label": "Last 2 Years",
      "value": "Last 2 Years",
    },
    {
      "label": "Custom Range",
      "value": "Custom Range",
    },
  ];

  List<Map<String, dynamic>> propertyTypes = [
    {
      "label": "All Types",
      "value": "All Types",
    },
    {
      "label": "Residential",
      "value": "Residential",
    },
    {
      "label": "Commercial",
      "value": "Commercial",
    },
    {
      "label": "Apartments",
      "value": "Apartments",
    },
    {
      "label": "Houses",
      "value": "Houses",
    },
  ];

  List<Map<String, dynamic>> generatedReports = [
    {
      "id": 1,
      "title": "Q4 2024 Market Analysis",
      "type": "Market Analysis",
      "location": "Downtown District",
      "date": DateTime.now().subtract(Duration(days: 7)),
      "status": "Completed",
      "size": "2.4 MB",
      "pages": 15,
      "insights": 8,
      "cover": "https://picsum.photos/400/300?random=1&keyword=chart"
    },
    {
      "id": 2,
      "title": "Investment Opportunities Report",
      "type": "Investment Report",
      "location": "Suburban Areas",
      "date": DateTime.now().subtract(Duration(days: 14)),
      "status": "Completed",
      "size": "3.1 MB",
      "pages": 22,
      "insights": 12,
      "cover": "https://picsum.photos/400/300?random=2&keyword=building"
    },
    {
      "id": 3,
      "title": "Price Trends Analysis",
      "type": "Price Trends",
      "location": "City Center",
      "date": DateTime.now().subtract(Duration(days: 21)),
      "status": "Completed",
      "size": "1.8 MB",
      "pages": 18,
      "insights": 10,
      "cover": "https://picsum.photos/400/300?random=3&keyword=graph"
    },
    {
      "id": 4,
      "title": "Rental Yield Assessment",
      "type": "Rental Yield Report",
      "location": "Business District",
      "date": DateTime.now().subtract(Duration(days: 35)),
      "status": "Processing",
      "size": "-",
      "pages": 0,
      "insights": 0,
      "cover": "https://picsum.photos/400/300?random=4&keyword=office"
    },
  ];

  List<Map<String, dynamic>> reportTemplates = [
    {
      "name": "Standard Market Report",
      "description": "Comprehensive market analysis with trends and forecasts",
      "icon": Icons.analytics,
      "color": primaryColor,
      "features": ["Price Trends", "Market Volume", "Forecasting", "Comparisons"]
    },
    {
      "name": "Investment Analysis",
      "description": "Detailed ROI analysis and investment recommendations",
      "icon": Icons.trending_up,
      "color": successColor,
      "features": ["ROI Calculation", "Risk Analysis", "Growth Potential", "Cash Flow"]
    },
    {
      "name": "Comparative Analysis",
      "description": "Side-by-side property and area comparisons",
      "icon": Icons.compare_arrows,
      "color": infoColor,
      "features": ["Property Comparison", "Area Analysis", "Value Assessment", "Benchmarking"]
    },
    {
      "name": "Custom Report",
      "description": "Build your own report with selected metrics",
      "icon": Icons.tune,
      "color": warningColor,
      "features": ["Custom Metrics", "Flexible Layout", "Personalized Insights", "Export Options"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Property Reports",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Generate detailed market analysis and insights",
                          style: TextStyle(
                            color: Colors.white.withAlpha(204),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.assessment,
                    size: 60,
                    color: Colors.white.withAlpha(128),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Report Generator Section
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
                  Text(
                    "Generate New Report",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Report Type
                  QDropdownField(
                    label: "Report Type",
                    items: reportTypes,
                    value: selectedReportType,
                    onChanged: (value, label) {
                      selectedReportType = value;
                      setState(() {});
                    },
                  ),

                  SizedBox(height: spMd),

                  // Timeframe and Property Type Row
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframes,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Property Type",
                          items: propertyTypes,
                          value: selectedPropertyType,
                          onChanged: (value, label) {
                            selectedPropertyType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Generate Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isGenerating ? "Generating..." : "Generate Report",
                      size: bs.md,
                      onPressed: isGenerating ? null : _generateReport,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Report Templates Section
            Text(
              "Report Templates",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: spMd,
                mainAxisSpacing: spMd,
              ),
              itemCount: reportTemplates.length,
              itemBuilder: (context, index) {
                final template = reportTemplates[index];
                return GestureDetector(
                  onTap: () => _selectTemplate(template),
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (template["color"] as Color).withAlpha(26),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(
                            template["icon"] as IconData,
                            color: template["color"] as Color,
                            size: 28,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${template["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${template["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (template["features"] as List).take(2).map<Widget>((feature) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: (template["color"] as Color).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "$feature",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: template["color"] as Color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: spLg),

            // Generated Reports Section
            Row(
              children: [
                Text(
                  "Generated Reports",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // View all reports
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: generatedReports.length,
              itemBuilder: (context, index) {
                final report = generatedReports[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${report["cover"]}",
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${report["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${report["type"]} • ${report["location"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: report["status"] == "Completed" 
                                        ? successColor.withAlpha(26)
                                        : warningColor.withAlpha(26),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${report["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: report["status"] == "Completed" 
                                          ? successColor
                                          : warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(report["date"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (report["status"] == "Completed") ...[
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => _viewReport(report),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.visibility,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            GestureDetector(
                              onTap: () => _downloadReport(report),
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.download,
                                  color: successColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        Container(
                          padding: EdgeInsets.all(spSm),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _generateReport() async {
    isGenerating = true;
    setState(() {});

    // Simulate report generation
    await Future.delayed(Duration(seconds: 3));

    isGenerating = false;
    setState(() {});

    ss("Report generation started! You'll be notified when it's ready.");
  }

  void _selectTemplate(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "${template["name"]}",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${template["description"]}"),
            SizedBox(height: spMd),
            Text(
              "Features:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...(template["features"] as List).map<Widget>((feature) {
              return Padding(
                padding: EdgeInsets.only(bottom: spXs),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text("$feature"),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Use Template",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Template selected! Configure your report parameters.");
            },
          ),
        ],
      ),
    );
  }

  void _viewReport(Map<String, dynamic> report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "${report["title"]}",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${report["cover"]}",
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: spMd),
            _buildReportDetail("Type", "${report["type"]}"),
            _buildReportDetail("Location", "${report["location"]}"),
            _buildReportDetail("Pages", "${report["pages"]}"),
            _buildReportDetail("Insights", "${report["insights"]}"),
            _buildReportDetail("Size", "${report["size"]}"),
            _buildReportDetail("Generated", "${(report["date"] as DateTime).dMMMy}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Open Report",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              // Navigate to report viewer
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 80,
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

  void _downloadReport(Map<String, dynamic> report) {
    ss("Downloading ${report["title"]}...");
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Report Help",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Available Report Types:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            _buildHelpItem("Market Analysis", "Comprehensive market overview and trends"),
            _buildHelpItem("Price Trends", "Historical and projected price movements"),
            _buildHelpItem("Investment Report", "ROI analysis and investment insights"),
            _buildHelpItem("CMA", "Comparative market analysis for properties"),
            _buildHelpItem("Rental Yield", "Rental income and yield calculations"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
