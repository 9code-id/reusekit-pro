import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaInvestmentAnalysisView extends StatefulWidget {
  const RmaInvestmentAnalysisView({super.key});

  @override
  State<RmaInvestmentAnalysisView> createState() => _RmaInvestmentAnalysisViewState();
}

class _RmaInvestmentAnalysisViewState extends State<RmaInvestmentAnalysisView> {
  String selectedProperty = "all";
  String selectedTimeframe = "12_months";
  String selectedAnalysisType = "comprehensive";
  bool loading = false;

  List<Map<String, dynamic>> properties = [
    {"value": "all", "label": "All Properties"},
    {"value": "1", "label": "Sunset Apartments"},
    {"value": "2", "label": "Downtown Office Complex"},
    {"value": "3", "label": "Riverside Condos"},
    {"value": "4", "label": "Metro Plaza"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"value": "6_months", "label": "6 Months"},
    {"value": "12_months", "label": "12 Months"},
    {"value": "24_months", "label": "24 Months"},
    {"value": "60_months", "label": "5 Years"},
  ];

  List<Map<String, dynamic>> analysisTypes = [
    {"value": "comprehensive", "label": "Comprehensive Analysis"},
    {"value": "cash_flow", "label": "Cash Flow Analysis"},
    {"value": "market_value", "label": "Market Value Analysis"},
    {"value": "risk_assessment", "label": "Risk Assessment"},
  ];

  List<Map<String, dynamic>> analysisData = [
    {
      "id": "1",
      "property": "Sunset Apartments",
      "analysisType": "Comprehensive Analysis",
      "dateCreated": "2024-06-15",
      "totalInvestment": 850000.0,
      "currentValue": 920000.0,
      "totalReturn": 15.2,
      "annualReturn": 12.8,
      "cashFlow": 4500.0,
      "occupancyRate": 95.0,
      "capRate": 6.8,
      "status": "completed",
      "riskLevel": "medium",
    },
    {
      "id": "2", 
      "property": "Downtown Office Complex",
      "analysisType": "Cash Flow Analysis",
      "dateCreated": "2024-06-10",
      "totalInvestment": 1200000.0,
      "currentValue": 1350000.0,
      "totalReturn": 18.7,
      "annualReturn": 14.2,
      "cashFlow": 8200.0,
      "occupancyRate": 88.0,
      "capRate": 7.2,
      "status": "completed",
      "riskLevel": "low",
    },
    {
      "id": "3",
      "property": "Riverside Condos",
      "analysisType": "Market Value Analysis", 
      "dateCreated": "2024-06-05",
      "totalInvestment": 650000.0,
      "currentValue": 695000.0,
      "totalReturn": 8.9,
      "annualReturn": 7.1,
      "cashFlow": 2800.0,
      "occupancyRate": 92.0,
      "capRate": 5.4,
      "status": "in_progress",
      "riskLevel": "high",
    },
  ];

  List<Map<String, dynamic>> get filteredAnalysis {
    return analysisData.where((analysis) {
      if (selectedProperty != "all" && analysis["id"] != selectedProperty) return false;
      return true;
    }).toList();
  }

  double get totalInvestment {
    return filteredAnalysis.fold(0.0, (sum, analysis) => sum + (analysis["totalInvestment"] as double));
  }

  double get totalCurrentValue {
    return filteredAnalysis.fold(0.0, (sum, analysis) => sum + (analysis["currentValue"] as double));
  }

  double get averageReturn {
    if (filteredAnalysis.isEmpty) return 0.0;
    return filteredAnalysis.fold(0.0, (sum, analysis) => sum + (analysis["totalReturn"] as double)) / filteredAnalysis.length;
  }

  double get totalCashFlow {
    return filteredAnalysis.fold(0.0, (sum, analysis) => sum + (analysis["cashFlow"] as double));
  }

  void _generateAnalysis() {
    loading = true;
    setState(() {});

    // Simulate analysis generation
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Investment analysis generated successfully");
    });
  }

  void _exportAnalysis() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Export Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Export as PDF",
              size: bs.md,
              onPressed: () {
                back();
                ss("Analysis exported as PDF");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Export as Excel",
              size: bs.md,
              onPressed: () {
                back();
                ss("Analysis exported as Excel");
              },
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Share Report",
              size: bs.md,
              onPressed: () {
                back();
                ss("Analysis report shared");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewAnalysisDetail(Map<String, dynamic> analysis) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${analysis["property"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: analysis["status"] == "completed" ? successColor : warningColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${analysis["status"] == "completed" ? "Completed" : "In Progress"}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSection("Investment Overview", [
                      _buildDetailItem("Total Investment", "\$${((analysis["totalInvestment"] as double)).currency}"),
                      _buildDetailItem("Current Value", "\$${((analysis["currentValue"] as double)).currency}"),
                      _buildDetailItem("Total Return", "${(analysis["totalReturn"] as double).toStringAsFixed(1)}%"),
                      _buildDetailItem("Annual Return", "${(analysis["annualReturn"] as double).toStringAsFixed(1)}%"),
                    ]),
                    SizedBox(height: spMd),
                    _buildDetailSection("Cash Flow Analysis", [
                      _buildDetailItem("Monthly Cash Flow", "\$${((analysis["cashFlow"] as double)).currency}"),
                      _buildDetailItem("Occupancy Rate", "${(analysis["occupancyRate"] as double).toStringAsFixed(1)}%"),
                      _buildDetailItem("Cap Rate", "${(analysis["capRate"] as double).toStringAsFixed(1)}%"),
                      _buildDetailItem("Risk Level", "${analysis["riskLevel"]}".toUpperCase()),
                    ]),
                    SizedBox(height: spMd),
                    _buildDetailSection("Market Performance", [
                      _buildDetailItem("Market Appreciation", "8.5%"),
                      _buildDetailItem("Rental Growth Rate", "4.2%"),
                      _buildDetailItem("Market Cap Rate", "6.1%"),
                      _buildDetailItem("Comparable Properties", "15 units"),
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Close",
              size: bs.md,
              onPressed: () => back(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...children,
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String subtitle, Color color, IconData icon) {
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
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

  Widget _buildAnalysisItem(Map<String, dynamic> analysis) {
    Color statusColor = analysis["status"] == "completed" ? successColor : warningColor;
    Color riskColor = analysis["riskLevel"] == "low" ? successColor : 
                     analysis["riskLevel"] == "medium" ? warningColor : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${analysis["property"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${analysis["analysisType"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${analysis["status"] == "completed" ? "Completed" : "In Progress"}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
                      "Total Return",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${(analysis["totalReturn"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 18,
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
                      "Cash Flow",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "\$${((analysis["cashFlow"] as double)).currency}",
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
                      "Risk Level",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: riskColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${analysis["riskLevel"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
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
              Text(
                "Created: ${DateTime.parse(analysis["dateCreated"]).dMMMy}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () => _viewAnalysisDetail(analysis),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Investment Analysis"),
        actions: [
          QButton(
            icon: Icons.file_download,
            size: bs.sm,
            onPressed: _exportAnalysis,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Cards
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildSummaryCard(
                        "Total Investment",
                        "\$${(totalInvestment).currency}",
                        "Across all properties",
                        primaryColor,
                        Icons.account_balance_wallet,
                      ),
                      _buildSummaryCard(
                        "Current Value", 
                        "\$${(totalCurrentValue).currency}",
                        "Market valuation",
                        successColor,
                        Icons.trending_up,
                      ),
                      _buildSummaryCard(
                        "Average Return",
                        "${averageReturn.toStringAsFixed(1)}%",
                        "Annualized return",
                        infoColor,
                        Icons.analytics,
                      ),
                      _buildSummaryCard(
                        "Total Cash Flow",
                        "\$${(totalCashFlow).currency}",
                        "Monthly income",
                        warningColor,
                        Icons.monetization_on,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  // Filters
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Analysis Filters",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        QDropdownField(
                          label: "Property",
                          items: properties,
                          value: selectedProperty,
                          onChanged: (value, label) {
                            selectedProperty = value;
                            setState(() {});
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Timeframe",
                                items: timeframeOptions,
                                value: selectedTimeframe,
                                onChanged: (value, label) {
                                  selectedTimeframe = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QDropdownField(
                                label: "Analysis Type",
                                items: analysisTypes,
                                value: selectedAnalysisType,
                                onChanged: (value, label) {
                                  selectedAnalysisType = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        QButton(
                          label: "Generate New Analysis",
                          size: bs.md,
                          onPressed: _generateAnalysis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Analysis List
                  Text(
                    "Recent Analysis Reports",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...filteredAnalysis.map((analysis) => _buildAnalysisItem(analysis)),
                  
                  if (filteredAnalysis.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.analytics_outlined,  
                            size: 64,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No Analysis Reports",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Generate your first investment analysis report to get started",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
