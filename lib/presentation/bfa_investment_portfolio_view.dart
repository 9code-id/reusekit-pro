import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaInvestmentPortfolioView extends StatefulWidget {
  const BfaInvestmentPortfolioView({super.key});

  @override
  State<BfaInvestmentPortfolioView> createState() => _BfaInvestmentPortfolioViewState();
}

class _BfaInvestmentPortfolioViewState extends State<BfaInvestmentPortfolioView> {
  int selectedPeriod = 0;
  String selectedCategory = "All";
  bool loading = false;

  List<Map<String, dynamic>> portfolioData = [
    {
      "name": "Technology Stocks",
      "type": "Equity",
      "investment": 50000.0,
      "currentValue": 65000.0,
      "returns": 15000.0,
      "returnPercentage": 30.0,
      "allocation": 35.0,
      "icon": Icons.computer,
      "color": const Color(0xFF2196F3),
    },
    {
      "name": "Mutual Funds",
      "type": "Mutual Fund",
      "investment": 30000.0,
      "currentValue": 35000.0,
      "returns": 5000.0,
      "returnPercentage": 16.67,
      "allocation": 25.0,
      "icon": Icons.trending_up,
      "color": const Color(0xFF4CAF50),
    },
    {
      "name": "Government Bonds",
      "type": "Bond",
      "investment": 25000.0,
      "currentValue": 26500.0,
      "returns": 1500.0,
      "returnPercentage": 6.0,
      "allocation": 20.0,
      "icon": Icons.security,
      "color": const Color(0xFFFF9800),
    },
    {
      "name": "Fixed Deposits",
      "type": "Fixed Deposit",
      "investment": 20000.0,
      "currentValue": 21200.0,
      "returns": 1200.0,
      "returnPercentage": 6.0,
      "allocation": 15.0,
      "icon": Icons.savings,
      "color": const Color(0xFF9C27B0),
    },
    {
      "name": "Gold ETF",
      "type": "Commodity",
      "investment": 15000.0,
      "currentValue": 15750.0,
      "returns": 750.0,
      "returnPercentage": 5.0,
      "allocation": 5.0,
      "icon": Icons.diamond,
      "color": const Color(0xFFFFD700),
    },
  ];

  List<Map<String, dynamic>> performanceData = [
    {"period": "1M", "return": 2.5},
    {"period": "3M", "return": 8.2},
    {"period": "6M", "return": 15.3},
    {"period": "1Y", "return": 22.8},
    {"period": "3Y", "return": 45.6},
  ];

  List<String> categories = ["All", "Equity", "Mutual Fund", "Bond", "Fixed Deposit", "Commodity"];

  double get totalInvestment => portfolioData.fold(0.0, (sum, item) => sum + (item["investment"] as double));
  double get totalCurrentValue => portfolioData.fold(0.0, (sum, item) => sum + (item["currentValue"] as double));
  double get totalReturns => portfolioData.fold(0.0, (sum, item) => sum + (item["returns"] as double));
  double get totalReturnPercentage => (totalReturns / totalInvestment) * 100;

  List<Map<String, dynamic>> get filteredPortfolio {
    if (selectedCategory == "All") return portfolioData;
    return portfolioData.where((item) => item["type"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Investment Portfolio"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh portfolio data
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPortfolioSummary(),
                  SizedBox(height: spLg),
                  _buildPerformanceSection(),
                  SizedBox(height: spLg),
                  _buildCategoryFilter(),
                  SizedBox(height: spMd),
                  _buildPortfolioList(),
                  SizedBox(height: spLg),
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildPortfolioSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Portfolio Value",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.trending_up,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "\$${totalCurrentValue.currency}",
            style: TextStyle(
              color: Colors.white,
              fontSize: fsH1,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: totalReturns >= 0 ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${totalReturns >= 0 ? '+' : ''}\$${totalReturns.currency} (${totalReturnPercentage.toStringAsFixed(1)}%)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "vs invested \$${totalInvestment.currency}",
                style: TextStyle(
                  color: Colors.white.withAlpha(180),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Performance",
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
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: performanceData.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> data = entry.value;
                  bool isSelected = selectedPeriod == index;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedPeriod = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${data["period"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(data["return"] as double) >= 0 ? '+' : ''}${(data["return"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              color: isSelected ? Colors.white : primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Investments by Category",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QCategoryPicker(
          items: categories.map((category) => {
            "label": category,
            "value": category,
          }).toList(),
          value: selectedCategory,
          onChanged: (index, label, value, item) {
            selectedCategory = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPortfolioList() {
    return Column(
      children: filteredPortfolio.map((investment) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (investment["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      investment["icon"] as IconData,
                      color: investment["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${investment["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${investment["type"]}",
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
                        "\$${(investment["currentValue"] as double).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${(investment["returnPercentage"] as double) >= 0 ? '+' : ''}${(investment["returnPercentage"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: (investment["returnPercentage"] as double) >= 0 ? successColor : dangerColor,
                        ),
                      ),
                    ],
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
                          "Invested",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(investment["investment"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
                          "Returns",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(investment["returns"] as double) >= 0 ? '+' : ''}\$${(investment["returns"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: (investment["returns"] as double) >= 0 ? successColor : dangerColor,
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
                          "Allocation",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(investment["allocation"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (investment["allocation"] as double) / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: investment["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Add Investment",
                icon: Icons.add,
                size: bs.md,
                onPressed: () {
                  // Navigate to add investment
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Rebalance",
                icon: Icons.balance,
                size: bs.md,
                onPressed: () {
                  // Navigate to rebalancing
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "View Analytics",
                icon: Icons.analytics,
                size: bs.md,
                onPressed: () {
                  // Navigate to detailed analytics
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Export Report",
                icon: Icons.download,
                size: bs.md,
                onPressed: () {
                  // Export portfolio report
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
