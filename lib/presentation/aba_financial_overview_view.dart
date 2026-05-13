import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaFinancialOverviewView extends StatefulWidget {
  const AbaFinancialOverviewView({super.key});

  @override
  State<AbaFinancialOverviewView> createState() => _AbaFinancialOverviewViewState();
}

class _AbaFinancialOverviewViewState extends State<AbaFinancialOverviewView> {
  String selectedPeriod = "this_month";
  
  List<Map<String, dynamic>> periods = [
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "This Quarter", "value": "this_quarter"},
    {"label": "This Year", "value": "this_year"},
    {"label": "Custom Range", "value": "custom"},
  ];

  Map<String, Map<String, dynamic>> financialData = {
    "this_month": {
      "revenue": 68420.0,
      "expenses": 36240.0,
      "net_profit": 32180.0,
      "cash_flow": 45890.0,
      "accounts_receivable": 18460.0,
      "accounts_payable": 12350.0,
    },
    "last_month": {
      "revenue": 59230.0,
      "expenses": 33450.0,
      "net_profit": 25780.0,
      "cash_flow": 38920.0,
      "accounts_receivable": 16280.0,
      "accounts_payable": 11890.0,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Financial data refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            QDropdownField(
              label: "Time Period",
              items: periods,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Financial Summary Cards
            Text(
              "Financial Summary",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  "Total Revenue",
                  _getCurrentData()["revenue"],
                  successColor,
                  Icons.trending_up,
                  _getChangePercentage("revenue"),
                ),
                _buildSummaryCard(
                  "Total Expenses",
                  _getCurrentData()["expenses"],
                  dangerColor,
                  Icons.trending_down,
                  _getChangePercentage("expenses"),
                ),
                _buildSummaryCard(
                  "Net Profit",
                  _getCurrentData()["net_profit"],
                  primaryColor,
                  Icons.account_balance_wallet,
                  _getChangePercentage("net_profit"),
                ),
                _buildSummaryCard(
                  "Cash Flow",
                  _getCurrentData()["cash_flow"],
                  infoColor,
                  Icons.water_drop,
                  _getChangePercentage("cash_flow"),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Profit Margin Analysis
            Text(
              "Profitability Analysis",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profit Margins",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  _buildProfitMarginItem(
                    "Gross Profit Margin",
                    _calculateGrossMargin(),
                    successColor,
                  ),
                  _buildProfitMarginItem(
                    "Net Profit Margin",
                    _calculateNetMargin(),
                    primaryColor,
                  ),
                  _buildProfitMarginItem(
                    "Operating Margin",
                    _calculateOperatingMargin(),
                    infoColor,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Balance Sheet Summary
            Text(
              "Balance Sheet Summary",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildBalanceCard(
                  "Accounts Receivable",
                  _getCurrentData()["accounts_receivable"],
                  warningColor,
                  Icons.receipt_long,
                ),
                _buildBalanceCard(
                  "Accounts Payable",
                  _getCurrentData()["accounts_payable"],
                  dangerColor,
                  Icons.payment,
                ),
                _buildBalanceCard(
                  "Working Capital",
                  (_getCurrentData()["accounts_receivable"] as double) - 
                  (_getCurrentData()["accounts_payable"] as double),
                  successColor,
                  Icons.account_balance,
                ),
                _buildBalanceCard(
                  "Current Ratio",
                  2.4,
                  infoColor,
                  Icons.balance,
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Revenue vs Expenses Chart
            Text(
              "Revenue vs Expenses Trend",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              width: double.infinity,
              height: 250,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "6-Month Comparison",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text("Revenue", style: TextStyle(fontSize: 12)),
                          SizedBox(width: spSm),
                          Container(
                            width: 12,
                            height: 12,
                            color: dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text("Expenses", style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(6, (index) {
                        double revenueHeight = 60 + (index * 8.0) + (index % 2 * 20);
                        double expenseHeight = 40 + (index * 6.0) + (index % 3 * 15);
                        
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 20,
                              height: revenueHeight,
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: 20,
                              height: expenseHeight,
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "M${index + 1}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Key Financial Ratios
            Text(
              "Key Financial Ratios",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildRatioItem("Debt-to-Equity Ratio", "0.32", "Low Risk", successColor),
                  Divider(),
                  _buildRatioItem("Return on Investment", "24.5%", "Excellent", primaryColor),
                  Divider(),
                  _buildRatioItem("Quick Ratio", "1.8", "Good Liquidity", infoColor),
                  Divider(),
                  _buildRatioItem("Asset Turnover", "1.4", "Efficient", warningColor),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Cash Flow",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('AbaCashFlowSummaryView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        //navigateTo('AbaReportsView')
                      },
                      child: Text(
                        "Generate Report",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getCurrentData() {
    return financialData[selectedPeriod] ?? financialData["this_month"]!;
  }

  String _getChangePercentage(String key) {
    if (selectedPeriod == "this_month" && financialData.containsKey("last_month")) {
      double current = _getCurrentData()[key] ?? 0.0;
      double previous = financialData["last_month"]![key] ?? 0.0;
      double change = ((current - previous) / previous) * 100;
      return "${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}%";
    }
    return "+0.0%";
  }

  double _calculateGrossMargin() {
    double revenue = _getCurrentData()["revenue"] ?? 0.0;
    double expenses = _getCurrentData()["expenses"] ?? 0.0;
    return ((revenue - (expenses * 0.6)) / revenue) * 100;
  }

  double _calculateNetMargin() {
    double revenue = _getCurrentData()["revenue"] ?? 0.0;
    double netProfit = _getCurrentData()["net_profit"] ?? 0.0;
    return (netProfit / revenue) * 100;
  }

  double _calculateOperatingMargin() {
    double revenue = _getCurrentData()["revenue"] ?? 0.0;
    double expenses = _getCurrentData()["expenses"] ?? 0.0;
    return ((revenue - (expenses * 0.8)) / revenue) * 100;
  }

  Widget _buildSummaryCard(String title, double value, Color color, IconData icon, String change) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  color: change.startsWith('+') ? successColor : dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "\$${value.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(String title, double value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title.contains("Ratio") ? value.toStringAsFixed(1) : "\$${value.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfitMarginItem(String title, double percentage, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "${percentage.toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatioItem(String title, String value, String status, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
