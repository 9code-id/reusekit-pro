import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReport4View extends StatefulWidget {
  @override
  State<GrlReport4View> createState() => _GrlReport4ViewState();
}

class _GrlReport4ViewState extends State<GrlReport4View> {
  int selectedTab = 0;
  String selectedPeriod = "month";
  
  List<Map<String, dynamic>> periods = [
    {"label": "This Month", "value": "month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> incomeStatements = [
    {
      "category": "Revenue",
      "items": [
        {"name": "Product Sales", "amount": 485000.0, "change": 12.5},
        {"name": "Service Revenue", "amount": 125000.0, "change": 8.2},
        {"name": "Subscription Revenue", "amount": 89000.0, "change": 15.7},
        {"name": "Other Income", "amount": 15000.0, "change": -2.1},
      ],
    },
    {
      "category": "Cost of Goods Sold",
      "items": [
        {"name": "Direct Materials", "amount": -185000.0, "change": 10.5},
        {"name": "Direct Labor", "amount": -95000.0, "change": 7.8},
        {"name": "Manufacturing Overhead", "amount": -45000.0, "change": 5.2},
      ],
    },
    {
      "category": "Operating Expenses",
      "items": [
        {"name": "Salaries & Benefits", "amount": -125000.0, "change": 6.5},
        {"name": "Rent & Utilities", "amount": -35000.0, "change": 3.2},
        {"name": "Marketing & Advertising", "amount": -28000.0, "change": 15.8},
        {"name": "Office Supplies", "amount": -12000.0, "change": -8.5},
        {"name": "Professional Services", "amount": -18000.0, "change": 4.2},
      ],
    },
  ];

  List<Map<String, dynamic>> balanceSheetData = [
    {
      "category": "Current Assets",
      "items": [
        {"name": "Cash & Cash Equivalents", "amount": 245000.0, "percentage": 25.8},
        {"name": "Accounts Receivable", "amount": 185000.0, "percentage": 19.5},
        {"name": "Inventory", "amount": 125000.0, "percentage": 13.2},
        {"name": "Prepaid Expenses", "amount": 35000.0, "percentage": 3.7},
      ],
    },
    {
      "category": "Fixed Assets",
      "items": [
        {"name": "Property, Plant & Equipment", "amount": 285000.0, "percentage": 30.0},
        {"name": "Accumulated Depreciation", "amount": -125000.0, "percentage": -13.2},
        {"name": "Intangible Assets", "amount": 75000.0, "percentage": 7.9},
        {"name": "Other Assets", "amount": 25000.0, "percentage": 2.6},
      ],
    },
    {
      "category": "Liabilities",
      "items": [
        {"name": "Accounts Payable", "amount": -95000.0, "percentage": -10.0},
        {"name": "Short-term Debt", "amount": -45000.0, "percentage": -4.7},
        {"name": "Long-term Debt", "amount": -185000.0, "percentage": -19.5},
        {"name": "Accrued Expenses", "amount": -35000.0, "percentage": -3.7},
      ],
    },
  ];

  List<Map<String, dynamic>> cashFlowData = [
    {
      "category": "Operating Activities",
      "items": [
        {"name": "Net Income", "amount": 145000.0, "change": 18.5},
        {"name": "Depreciation", "amount": 25000.0, "change": 0.0},
        {"name": "Changes in Working Capital", "amount": -15000.0, "change": -25.8},
        {"name": "Other Operating Activities", "amount": 8000.0, "change": 12.5},
      ],
    },
    {
      "category": "Investing Activities",
      "items": [
        {"name": "Capital Expenditures", "amount": -45000.0, "change": 35.2},
        {"name": "Asset Purchases", "amount": -25000.0, "change": 15.8},
        {"name": "Investment Sales", "amount": 15000.0, "change": -45.2},
      ],
    },
    {
      "category": "Financing Activities",
      "items": [
        {"name": "Debt Payments", "amount": -35000.0, "change": -15.2},
        {"name": "Equity Financing", "amount": 85000.0, "change": 185.5},
        {"name": "Dividends Paid", "amount": -25000.0, "change": 8.5},
      ],
    },
  ];

  List<Map<String, dynamic>> keyRatios = [
    {
      "category": "Profitability",
      "ratios": [
        {"name": "Gross Profit Margin", "value": 52.5, "unit": "%", "trend": "up"},
        {"name": "Net Profit Margin", "value": 18.2, "unit": "%", "trend": "up"},
        {"name": "ROA", "value": 15.8, "unit": "%", "trend": "stable"},
        {"name": "ROE", "value": 24.5, "unit": "%", "trend": "up"},
      ],
    },
    {
      "category": "Liquidity",
      "ratios": [
        {"name": "Current Ratio", "value": 2.8, "unit": "x", "trend": "up"},
        {"name": "Quick Ratio", "value": 1.9, "unit": "x", "trend": "stable"},
        {"name": "Cash Ratio", "value": 1.2, "unit": "x", "trend": "up"},
      ],
    },
    {
      "category": "Efficiency",
      "ratios": [
        {"name": "Asset Turnover", "value": 1.4, "unit": "x", "trend": "stable"},
        {"name": "Inventory Turnover", "value": 8.5, "unit": "x", "trend": "up"},
        {"name": "Receivables Turnover", "value": 12.2, "unit": "x", "trend": "down"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Financial Report",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Income", icon: Icon(Icons.trending_up)),
        Tab(text: "Balance", icon: Icon(Icons.account_balance)),
        Tab(text: "Cash Flow", icon: Icon(Icons.water_drop)),
        Tab(text: "Ratios", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildIncomeStatementTab(),
        _buildBalanceSheetTab(),
        _buildCashFlowTab(),
        _buildRatiosTab(),
      ],
    );
  }

  Widget _buildIncomeStatementTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPeriodSelector(),
          _buildIncomeSummary(),
          _buildIncomeStatement(),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
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
          Text(
            "Financial Period",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QCategoryPicker(
            items: periods,
            value: selectedPeriod,
            onChanged: (index, label, value, item) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeSummary() {
    double totalRevenue = incomeStatements[0]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double totalCOGS = incomeStatements[1]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double).abs());
    double totalExpenses = incomeStatements[2]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double).abs());
    double netIncome = totalRevenue - totalCOGS - totalExpenses;

    List<Map<String, dynamic>> summaryData = [
      {
        "title": "Total Revenue",
        "amount": totalRevenue,
        "icon": Icons.trending_up,
        "color": successColor,
      },
      {
        "title": "Total COGS",
        "amount": totalCOGS,
        "icon": Icons.inventory,
        "color": warningColor,
      },
      {
        "title": "Operating Expenses",
        "amount": totalExpenses,
        "icon": Icons.trending_down,
        "color": dangerColor,
      },
      {
        "title": "Net Income",
        "amount": netIncome,
        "icon": Icons.account_balance_wallet,
        "color": primaryColor,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: summaryData.map((data) {
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
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (data["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      data["icon"] as IconData,
                      color: data["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${data["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${((data["amount"] as double).abs()).currency}",
                style: TextStyle(
                  fontSize: 20,
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

  Widget _buildIncomeStatement() {
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
          Text(
            "Income Statement Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: incomeStatements.map((section) {
              Color categoryColor = section["category"] == "Revenue" ? successColor :
                                  section["category"] == "Cost of Goods Sold" ? warningColor : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            section["category"] == "Revenue" ? Icons.trending_up :
                            section["category"] == "Cost of Goods Sold" ? Icons.inventory : Icons.trending_down,
                            color: categoryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${section["category"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: (section["items"] as List).map<Widget>((item) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((item["amount"] as double).abs()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (item["amount"] as double) >= 0 ? successColor : dangerColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: (item["change"] as double) >= 0 ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${(item["change"] as double) >= 0 ? '+' : ''}${(item["change"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: (item["change"] as double) >= 0 ? successColor : dangerColor,
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
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceSheetTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildBalanceSheetSummary(),
          _buildBalanceSheetDetails(),
        ],
      ),
    );
  }

  Widget _buildBalanceSheetSummary() {
    double totalAssets = balanceSheetData[0]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double)) +
                        balanceSheetData[1]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double totalLiabilities = balanceSheetData[2]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double).abs());
    double equity = totalAssets - totalLiabilities;

    List<Map<String, dynamic>> summaryData = [
      {
        "title": "Total Assets",
        "amount": totalAssets,
        "icon": Icons.account_balance,
        "color": primaryColor,
      },
      {
        "title": "Total Liabilities",
        "amount": totalLiabilities,
        "icon": Icons.warning,
        "color": dangerColor,
      },
      {
        "title": "Shareholders' Equity",
        "amount": equity,
        "icon": Icons.trending_up,
        "color": successColor,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: summaryData.map((data) {
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
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (data["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      data["icon"] as IconData,
                      color: data["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${data["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${((data["amount"] as double)).currency}",
                style: TextStyle(
                  fontSize: 20,
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

  Widget _buildBalanceSheetDetails() {
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
          Text(
            "Balance Sheet Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: balanceSheetData.map((section) {
              Color categoryColor = section["category"] == "Current Assets" ? successColor :
                                  section["category"] == "Fixed Assets" ? infoColor : dangerColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            section["category"] == "Current Assets" ? Icons.savings :
                            section["category"] == "Fixed Assets" ? Icons.business : Icons.warning,
                            color: categoryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${section["category"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: (section["items"] as List).map<Widget>((item) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((item["amount"] as double).abs()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (item["amount"] as double) >= 0 ? successColor : dangerColor,
                                    ),
                                  ),
                                  Text(
                                    "${(item["percentage"] as double).abs().toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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

  Widget _buildCashFlowTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCashFlowSummary(),
          _buildCashFlowDetails(),
        ],
      ),
    );
  }

  Widget _buildCashFlowSummary() {
    double operatingCF = cashFlowData[0]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double investingCF = cashFlowData[1]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double financingCF = cashFlowData[2]["items"].fold(0.0, (sum, item) => sum + (item["amount"] as double));
    double netCF = operatingCF + investingCF + financingCF;

    List<Map<String, dynamic>> summaryData = [
      {
        "title": "Operating Cash Flow",
        "amount": operatingCF,
        "icon": Icons.business,
        "color": successColor,
      },
      {
        "title": "Investing Cash Flow",
        "amount": investingCF,
        "icon": Icons.trending_down,
        "color": dangerColor,
      },
      {
        "title": "Financing Cash Flow",
        "amount": financingCF,
        "icon": Icons.account_balance,
        "color": infoColor,
      },
      {
        "title": "Net Cash Flow",
        "amount": netCF,
        "icon": Icons.water_drop,
        "color": primaryColor,
      },
    ];

    return ResponsiveGridView(
      minItemWidth: 200,
      children: summaryData.map((data) {
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
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (data["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      data["icon"] as IconData,
                      color: data["color"] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${data["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${((data["amount"] as double).abs()).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: (data["amount"] as double) >= 0 ? successColor : dangerColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCashFlowDetails() {
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
          Text(
            "Cash Flow Statement",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: cashFlowData.map((section) {
              Color categoryColor = section["category"] == "Operating Activities" ? successColor :
                                  section["category"] == "Investing Activities" ? warningColor : infoColor;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            section["category"] == "Operating Activities" ? Icons.business :
                            section["category"] == "Investing Activities" ? Icons.trending_down : Icons.account_balance,
                            color: categoryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${section["category"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      children: (section["items"] as List).map<Widget>((item) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${(item["amount"] as double) >= 0 ? '+' : ''}\$${((item["amount"] as double).abs()).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (item["amount"] as double) >= 0 ? successColor : dangerColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: (item["change"] as double) >= 0 ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${(item["change"] as double) >= 0 ? '+' : ''}${(item["change"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: (item["change"] as double) >= 0 ? successColor : dangerColor,
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
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRatiosTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: keyRatios.map((category) {
          Color categoryColor = category["category"] == "Profitability" ? successColor :
                               category["category"] == "Liquidity" ? infoColor : warningColor;

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
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        category["category"] == "Profitability" ? Icons.trending_up :
                        category["category"] == "Liquidity" ? Icons.water_drop : Icons.analytics,
                        color: categoryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${category["category"]} Ratios",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: categoryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: (category["ratios"] as List).map<Widget>((ratio) {
                    Color trendColor = ratio["trend"] == "up" ? successColor :
                                     ratio["trend"] == "down" ? dangerColor : warningColor;
                    IconData trendIcon = ratio["trend"] == "up" ? Icons.trending_up :
                                       ratio["trend"] == "down" ? Icons.trending_down : Icons.trending_flat;

                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: trendColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: trendColor,
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
                                  "${ratio["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Icon(
                                trendIcon,
                                color: trendColor,
                                size: 16,
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${(ratio["value"] as double).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${ratio["unit"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
