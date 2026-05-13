import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaInvestmentAnalysisView extends StatefulWidget {
  const ReaInvestmentAnalysisView({super.key});

  @override
  State<ReaInvestmentAnalysisView> createState() => _ReaInvestmentAnalysisViewState();
}

class _ReaInvestmentAnalysisViewState extends State<ReaInvestmentAnalysisView> {
  String propertyType = "Apartment";
  String propertyValue = "500000";
  String downPayment = "100000";
  String loanAmount = "400000";
  String interestRate = "8.5";
  String loanTenure = "20";
  String monthlyRent = "25000";
  String expectedAppreciation = "8";
  String maintenanceCost = "5000";
  String propertyTax = "15000";
  int selectedTab = 0;

  List<Map<String, dynamic>> analysisResults = [
    {
      "metric": "Monthly Cash Flow",
      "value": 15000,
      "description": "Net rental income after expenses",
      "status": "positive",
      "icon": Icons.trending_up,
    },
    {
      "metric": "ROI",
      "value": 12.5,
      "description": "Return on investment percentage",
      "status": "good",
      "icon": Icons.percent,
    },
    {
      "metric": "Cap Rate",
      "value": 6.0,
      "description": "Capitalization rate",
      "status": "average",
      "icon": Icons.analytics,
    },
    {
      "metric": "Break-even Time",
      "value": 8.5,
      "description": "Years to recover investment",
      "status": "good",
      "icon": Icons.schedule,
    },
  ];

  List<Map<String, dynamic>> projectionData = [
    {"year": "Year 1", "value": 520000, "rent": 300000, "expenses": 60000},
    {"year": "Year 2", "value": 561600, "rent": 324000, "expenses": 64800},
    {"year": "Year 3", "value": 606528, "rent": 349920, "expenses": 69984},
    {"year": "Year 4", "value": 655050, "rent": 377914, "rent": 755583},
    {"year": "Year 5", "value": 707454, "rent": 408267, "expenses": 81653},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Investment Analysis"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {
              ss("Analysis saved to reports");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPropertyInfoCard(),
            _buildQuickMetricsCard(),
            _buildTabSection(),
            if (selectedTab == 0) _buildROIAnalysis(),
            if (selectedTab == 1) _buildCashFlowAnalysis(),
            if (selectedTab == 2) _buildProjectionAnalysis(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyInfoCard() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.home_work,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Property Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: disabledColor,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Property Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(double.tryParse(propertyValue) ?? 0).currency}",
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
                      "Down Payment",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(double.tryParse(downPayment) ?? 0).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monthly Rent",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(double.tryParse(monthlyRent) ?? 0).currency}",
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
                      "Loan Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(double.tryParse(loanAmount) ?? 0).currency}",
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
        ],
      ),
    );
  }

  Widget _buildQuickMetricsCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Quick Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: analysisResults.map((metric) {
              Color statusColor = metric["status"] == "positive" 
                  ? successColor 
                  : metric["status"] == "good" 
                      ? primaryColor 
                      : warningColor;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: statusColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(
                          metric["icon"] as IconData,
                          color: statusColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${metric["metric"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      metric["metric"] == "Monthly Cash Flow" || metric["metric"] == "Break-even Time"
                          ? metric["metric"] == "Monthly Cash Flow"
                              ? "\$${(metric["value"] as num).currency}"
                              : "${metric["value"]} years"
                          : "${metric["value"]}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    Text(
                      "${metric["description"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "ROI Analysis",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Cash Flow",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 2;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 2 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Projections",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildROIAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Return on Investment Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: successColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Investment",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(double.tryParse(downPayment) ?? 0).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Annual Rental Income",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((double.tryParse(monthlyRent) ?? 0) * 12).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Annual Expenses",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${((double.tryParse(maintenanceCost) ?? 0) * 12 + (double.tryParse(propertyTax) ?? 0)).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: disabledColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Net Annual Income",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${(((double.tryParse(monthlyRent) ?? 0) * 12) - ((double.tryParse(maintenanceCost) ?? 0) * 12 + (double.tryParse(propertyTax) ?? 0))).currency}",
                      style: TextStyle(
                        fontSize: 18,
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
              color: primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Expected ROI",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "12.5%",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCashFlowAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Monthly Cash Flow Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...List.generate(5, (index) {
            List<Map<String, dynamic>> cashFlowItems = [
              {"label": "Rental Income", "amount": double.tryParse(monthlyRent) ?? 0, "type": "income"},
              {"label": "Loan EMI", "amount": -18500, "type": "expense"},
              {"label": "Maintenance", "amount": -(double.tryParse(maintenanceCost) ?? 0), "type": "expense"},
              {"label": "Property Tax", "amount": -((double.tryParse(propertyTax) ?? 0) / 12), "type": "expense"},
              {"label": "Net Cash Flow", "amount": 15000, "type": "net"},
            ];
            
            var item = cashFlowItems[index];
            Color amountColor = item["type"] == "income" 
                ? successColor 
                : item["type"] == "expense" 
                    ? dangerColor 
                    : primaryColor;
            
            return Container(
              padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spMd),
              decoration: BoxDecoration(
                color: item["type"] == "net" 
                    ? primaryColor.withValues(alpha: 0.1) 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusXs),
                border: item["type"] == "net" 
                    ? Border.all(color: primaryColor.withValues(alpha: 0.3))
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${item["label"]}",
                    style: TextStyle(
                      fontSize: item["type"] == "net" ? 16 : 14,
                      fontWeight: item["type"] == "net" ? FontWeight.bold : FontWeight.normal,
                      color: item["type"] == "net" ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${(item["amount"] as double) >= 0 ? "+" : ""}\$${(item["amount"] as double).abs().currency}",
                    style: TextStyle(
                      fontSize: item["type"] == "net" ? 16 : 14,
                      fontWeight: item["type"] == "net" ? FontWeight.bold : FontWeight.w600,
                      color: amountColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProjectionAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "5-Year Investment Projection",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...projectionData.map((data) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: disabledColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: disabledColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data["year"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Property Value: \$${(data["value"] as num).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rental Income: \$${(data["rent"] as num).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Expenses: \$${(data["expenses"] as num).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Export Report",
            icon: Icons.download,
            size: bs.md,
            onPressed: () {
              ss("Investment analysis report exported");
            },
          ),
        ),
        Expanded(
          child: QButton(
            label: "Compare Properties",
            icon: Icons.compare,
            size: bs.md,
            onPressed: () {
              ss("Opening property comparison");
            },
          ),
        ),
      ],
    );
  }
}
