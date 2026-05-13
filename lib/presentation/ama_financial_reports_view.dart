import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaFinancialReportsView extends StatefulWidget {
  const AmaFinancialReportsView({super.key});

  @override
  State<AmaFinancialReportsView> createState() => _AmaFinancialReportsViewState();
}

class _AmaFinancialReportsViewState extends State<AmaFinancialReportsView> {
  String selectedPeriod = "This Year";
  String selectedReportType = "Profit & Loss";
  String selectedCrop = "All Crops";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Year", "value": "Last Year"},
    {"label": "Custom Period", "value": "Custom Period"},
  ];

  List<Map<String, dynamic>> reportTypeOptions = [
    {"label": "Profit & Loss", "value": "Profit & Loss"},
    {"label": "Cash Flow", "value": "Cash Flow"},
    {"label": "Cost Analysis", "value": "Cost Analysis"},
    {"label": "Revenue Analysis", "value": "Revenue Analysis"},
    {"label": "Balance Sheet", "value": "Balance Sheet"},
    {"label": "Tax Summary", "value": "Tax Summary"},
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "All Crops"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Soybeans", "value": "Soybeans"},
  ];

  List<Map<String, dynamic>> profitLossData = [
    {
      "category": "Revenue",
      "items": [
        {"name": "Crop Sales", "amount": 185000.0, "percentage": 92.5},
        {"name": "Livestock Sales", "amount": 12000.0, "percentage": 6.0},
        {"name": "Equipment Rental", "amount": 3000.0, "percentage": 1.5},
      ],
      "total": 200000.0,
      "type": "income",
    },
    {
      "category": "Direct Costs",
      "items": [
        {"name": "Seeds", "amount": 15000.0, "percentage": 12.5},
        {"name": "Fertilizer", "amount": 21200.0, "percentage": 17.7},
        {"name": "Pesticides", "amount": 9800.0, "percentage": 8.2},
        {"name": "Fuel", "amount": 5200.0, "percentage": 4.3},
      ],
      "total": 51200.0,
      "type": "expense",
    },
    {
      "category": "Operating Expenses",
      "items": [
        {"name": "Labor", "amount": 16500.0, "percentage": 20.3},
        {"name": "Equipment Maintenance", "amount": 8900.0, "percentage": 11.0},
        {"name": "Insurance", "amount": 7000.0, "percentage": 8.6},
        {"name": "Utilities", "amount": 3200.0, "percentage": 3.9},
        {"name": "Professional Services", "amount": 2400.0, "percentage": 3.0},
      ],
      "total": 38000.0,
      "type": "expense",
    },
  ];

  List<Map<String, dynamic>> cashFlowData = [
    {"month": "Jan", "inflow": 12500.0, "outflow": 8200.0, "net": 4300.0},
    {"month": "Feb", "inflow": 8500.0, "outflow": 7800.0, "net": 700.0},
    {"month": "Mar", "inflow": 15000.0, "outflow": 12500.0, "net": 2500.0},
    {"month": "Apr", "inflow": 22000.0, "outflow": 15800.0, "net": 6200.0},
    {"month": "May", "inflow": 28500.0, "outflow": 11200.0, "net": 17300.0},
    {"month": "Jun", "inflow": 35000.0, "outflow": 9800.0, "net": 25200.0},
    {"month": "Jul", "inflow": 42000.0, "outflow": 13500.0, "net": 28500.0},
    {"month": "Aug", "inflow": 38000.0, "outflow": 12800.0, "net": 25200.0},
    {"month": "Sep", "inflow": 32000.0, "outflow": 14200.0, "net": 17800.0},
    {"month": "Oct", "inflow": 25000.0, "outflow": 16500.0, "net": 8500.0},
    {"month": "Nov", "inflow": 18000.0, "outflow": 11200.0, "net": 6800.0},
    {"month": "Dec", "inflow": 15000.0, "outflow": 9800.0, "net": 5200.0},
  ];

  List<Map<String, dynamic>> keyMetrics = [
    {
      "name": "Total Revenue",
      "value": 200000.0,
      "change": 12.5,
      "trend": "up",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "name": "Total Expenses",
      "value": 89200.0,
      "change": 8.3,
      "trend": "up",
      "icon": Icons.trending_up,
      "color": dangerColor,
    },
    {
      "name": "Net Profit",
      "value": 110800.0,
      "change": 18.2,
      "trend": "up",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "name": "Profit Margin",
      "value": 55.4,
      "change": 4.8,
      "trend": "up",
      "icon": Icons.trending_up,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> topExpenses = [
    {"category": "Fertilizer", "amount": 21200.0, "percentage": 23.8},
    {"category": "Labor", "amount": 16500.0, "percentage": 18.5},
    {"category": "Seeds", "amount": 15000.0, "percentage": 16.8},
    {"category": "Pesticides", "amount": 9800.0, "percentage": 11.0},
    {"category": "Equipment Maintenance", "amount": 8900.0, "percentage": 10.0},
  ];

  List<Map<String, dynamic>> recentReports = [
    {
      "name": "Q2 2024 Profit & Loss",
      "type": "Profit & Loss",
      "date": "2024-06-30",
      "status": "Generated",
      "size": "2.4 MB",
    },
    {
      "name": "May 2024 Cash Flow",
      "type": "Cash Flow",
      "date": "2024-05-31",
      "status": "Generated",
      "size": "1.8 MB",
    },
    {
      "name": "Annual Tax Summary 2023",
      "type": "Tax Summary",
      "date": "2024-04-15",
      "status": "Filed",
      "size": "3.2 MB",
    },
    {
      "name": "Corn Cost Analysis",
      "type": "Cost Analysis",
      "date": "2024-04-10",
      "status": "Generated",
      "size": "1.5 MB",
    },
  ];

  double get totalRevenue => profitLossData.firstWhere((item) => item["category"] == "Revenue")["total"] as double;
  double get totalExpenses => profitLossData.where((item) => item["type"] == "expense").fold(0.0, (sum, item) => sum + (item["total"] as double));
  double get netProfit => totalRevenue - totalExpenses;
  double get profitMargin => totalRevenue > 0 ? (netProfit / totalRevenue) * 100 : 0;

  void _generateReport() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Report generated successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("All reports exported");
            },
          ),
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              //navigateTo('AmaScheduledReportsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Financial Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(128)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Financial Overview",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.assessment,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Comprehensive financial reporting for your farm",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(204),
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
                              "Net Profit",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${netProfit.currency}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                              "Profit Margin",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "${profitMargin.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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

            // Report Generation
            Text(
              "Generate Report",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                          label: "Report Type",
                          items: reportTypeOptions,
                          value: selectedReportType,
                          onChanged: (value, label) {
                            selectedReportType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periodOptions,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Crop Filter",
                    items: cropOptions,
                    value: selectedCrop,
                    onChanged: (value, label) {
                      selectedCrop = value;
                      setState(() {});
                    },
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Generate Report",
                      icon: Icons.description,
                      size: bs.md,
                      onPressed: _generateReport,
                    ),
                  ),
                ],
              ),
            ),

            // Key Financial Metrics
            Text(
              "Key Financial Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.all(spSm),
              minItemWidth: 200,
              children: keyMetrics.map((metric) {
                bool isPercentage = metric["name"] == "Profit Margin";
                
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
                          Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${metric["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        isPercentage 
                            ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                            : "\$${((metric["value"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: metric["color"] as Color,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            metric["trend"] == "up" ? Icons.trending_up : Icons.trending_down,
                            color: metric["trend"] == "up" ? successColor : dangerColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}% vs last period",
                            style: TextStyle(
                              fontSize: 12,
                              color: metric["trend"] == "up" ? successColor : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Profit & Loss Summary
            Text(
              "Profit & Loss Summary",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: profitLossData.map((section) {
                  bool isRevenue = section["type"] == "income";
                  Color sectionColor = isRevenue ? successColor : dangerColor;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${section["category"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: sectionColor,
                              ),
                            ),
                            Text(
                              "${isRevenue ? '+' : '-'}\$${((section["total"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: sectionColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        ...(section["items"] as List<Map<String, dynamic>>).map((item) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: spXs),
                            child: Row(
                              children: [
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${item["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${((item["amount"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  width: 50,
                                  child: Text(
                                    "${(item["percentage"] as double).toStringAsFixed(1)}%",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Cash Flow Overview
            Text(
              "Monthly Cash Flow",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                      Container(
                        width: 50,
                        child: Text(
                          "Month",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Cash Flow",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        child: Text(
                          "Net Flow",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  ...cashFlowData.map((flow) {
                    double inflow = flow["inflow"] as double;
                    double outflow = flow["outflow"] as double;
                    double net = flow["net"] as double;
                    bool isPositive = net > 0;
                    
                    return Row(
                      children: [
                        Container(
                          width: 50,
                          child: Text(
                            "${flow["month"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        // Inflow Bar
                                        Container(
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(51),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: (inflow / 50000).clamp(0.0, 1.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: successColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        // Outflow Bar
                                        Container(
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(51),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: (outflow / 50000).clamp(0.0, 1.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: dangerColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "+\$${(inflow / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "-\$${(outflow / 1000).toStringAsFixed(1)}K",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          width: 80,
                          child: Text(
                            "${isPositive ? '+' : ''}\$${(net / 1000).toStringAsFixed(1)}K",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isPositive ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

            // Top Expenses
            Text(
              "Top Expense Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: topExpenses.map((expense) {
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.category,
                          color: primaryColor,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${expense["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: ((expense["percentage"] as double) / 100).clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${((expense["amount"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${(expense["percentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Recent Reports
            Text(
              "Recent Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: recentReports.map((report) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.description,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${report["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${report["type"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${report["date"]} • ${report["size"]}",
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${report["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () {
                            ss("Report downloaded");
                          },
                          child: Icon(
                            Icons.download,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
