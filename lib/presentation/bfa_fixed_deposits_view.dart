import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaFixedDepositsView extends StatefulWidget {
  const BfaFixedDepositsView({super.key});

  @override
  State<BfaFixedDepositsView> createState() => _BfaFixedDepositsViewState();
}

class _BfaFixedDepositsViewState extends State<BfaFixedDepositsView> {
  bool loading = false;
  int selectedTab = 0;
  
  // FD Calculator variables
  double principalAmount = 10000.0;
  double interestRate = 7.5;
  int tenure = 12; // months
  String compoundFrequency = "monthly";

  List<Map<String, dynamic>> activeDeposits = [
    {
      "id": 1,
      "fdNumber": "FD001234567",
      "principalAmount": 50000.0,
      "interestRate": 7.8,
      "maturityAmount": 54875.0,
      "startDate": "2024-01-15",
      "maturityDate": "2025-01-15",
      "tenure": 12,
      "status": "Active",
      "interestEarned": 2500.0,
      "nextInterestDate": "2024-02-15",
      "canBreak": true,
    },
    {
      "id": 2,
      "fdNumber": "FD001234568",
      "principalAmount": 100000.0,
      "interestRate": 8.2,
      "maturityAmount": 217103.0,
      "startDate": "2023-06-10",
      "maturityDate": "2026-06-10",
      "tenure": 36,
      "status": "Active",
      "interestEarned": 12500.0,
      "nextInterestDate": "2024-02-10",
      "canBreak": true,
    },
    {
      "id": 3,
      "fdNumber": "FD001234569",
      "principalAmount": 25000.0,
      "interestRate": 7.2,
      "maturityAmount": 26800.0,
      "startDate": "2024-03-01",
      "maturityDate": "2025-03-01",
      "tenure": 12,
      "status": "Active",
      "interestEarned": 750.0,
      "nextInterestDate": "2024-04-01",
      "canBreak": false,
    },
  ];

  List<Map<String, dynamic>> maturedDeposits = [
    {
      "id": 4,
      "fdNumber": "FD001234566",
      "principalAmount": 75000.0,
      "interestRate": 7.5,
      "maturityAmount": 82500.0,
      "startDate": "2022-12-15",
      "maturityDate": "2023-12-15",
      "tenure": 12,
      "status": "Matured",
      "interestEarned": 7500.0,
      "isReinvested": false,
    },
  ];

  List<Map<String, dynamic>> fdSchemes = [
    {
      "name": "Regular FD",
      "description": "Standard fixed deposit with competitive rates",
      "minAmount": 1000.0,
      "maxAmount": 1000000.0,
      "interestRates": [
        {"tenure": "6 months", "rate": 6.5},
        {"tenure": "1 year", "rate": 7.5},
        {"tenure": "2 years", "rate": 8.0},
        {"tenure": "3 years", "rate": 8.2},
        {"tenure": "5 years", "rate": 8.5},
      ],
      "features": ["Competitive rates", "Flexible tenure", "Auto-renewal option"],
    },
    {
      "name": "Senior Citizen FD",
      "description": "Special rates for senior citizens (60+ years)",
      "minAmount": 1000.0,
      "maxAmount": 1000000.0,
      "interestRates": [
        {"tenure": "6 months", "rate": 7.0},
        {"tenure": "1 year", "rate": 8.0},
        {"tenure": "2 years", "rate": 8.5},
        {"tenure": "3 years", "rate": 8.7},
        {"tenure": "5 years", "rate": 9.0},
      ],
      "features": ["Higher rates", "Additional 0.5% interest", "Priority service"],
    },
    {
      "name": "Flexi FD",
      "description": "Flexible deposit with withdrawal facility",
      "minAmount": 5000.0,
      "maxAmount": 500000.0,
      "interestRates": [
        {"tenure": "1 year", "rate": 7.0},
        {"tenure": "2 years", "rate": 7.5},
        {"tenure": "3 years", "rate": 7.8},
      ],
      "features": ["Partial withdrawal", "No penalty on withdrawal", "Flexible tenure"],
    },
  ];

  List<Map<String, dynamic>> compoundingOptions = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Half Yearly", "value": "half_yearly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fixed Deposits"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _openNewFD();
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildTabNavigation(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: _buildTabContent(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTabNavigation() {
    List<String> tabs = ["Active FDs", "Calculator", "FD Schemes"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tab = entry.value;
          bool isSelected = selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : disabledBoldColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildActiveFDsTab();
      case 1:
        return _buildCalculatorTab();
      case 2:
        return _buildFDSchemesTab();
      default:
        return _buildActiveFDsTab();
    }
  }

  Widget _buildActiveFDsTab() {
    double totalInvestment = activeDeposits.fold(0.0, 
        (sum, fd) => sum + (fd["principalAmount"] as double));
    double totalMaturityAmount = activeDeposits.fold(0.0, 
        (sum, fd) => sum + (fd["maturityAmount"] as double));
    double totalInterestEarned = activeDeposits.fold(0.0, 
        (sum, fd) => sum + (fd["interestEarned"] as double));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFDSummaryCard(totalInvestment, totalMaturityAmount, totalInterestEarned),
        SizedBox(height: spLg),
        Text(
          "Active Fixed Deposits",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        if (activeDeposits.isEmpty)
          _buildEmptyFDState(),
        if (activeDeposits.isNotEmpty)
          Column(
            children: activeDeposits.map((fd) => _buildFDCard(fd)).toList(),
          ),
        if (maturedDeposits.isNotEmpty) ...[
          SizedBox(height: spLg),
          Text(
            "Matured Deposits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: maturedDeposits.map((fd) => _buildFDCard(fd)).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildFDSummaryCard(double totalInvestment, double totalMaturityAmount, double totalInterestEarned) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Portfolio Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalInvestment.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Investment",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalMaturityAmount.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Maturity Value",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalInterestEarned.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Interest Earned",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFDState() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.account_balance,
              color: disabledColor,
              size: 64,
            ),
            SizedBox(height: spMd),
            Text(
              "No Fixed Deposits Found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Start investing in fixed deposits to earn guaranteed returns",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Open New FD",
              size: bs.md,
              onPressed: () {
                _openNewFD();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFDCard(Map<String, dynamic> fd) {
    bool isMatured = fd["status"] == "Matured";
    bool canBreak = fd["canBreak"] ?? false;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: isMatured ? successColor : primaryColor,
            width: 4,
          ),
        ),
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
                      "${fd["fdNumber"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: isMatured 
                            ? successColor.withAlpha(30)
                            : primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${fd["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isMatured ? successColor : primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMatured && canBreak)
                QButton(
                  icon: Icons.more_vert,
                  size: bs.sm,
                  onPressed: () {
                    _showFDOptions(fd);
                  },
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
                      "Principal Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(fd["principalAmount"] as double).currency}",
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
                      "Interest Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${fd["interestRate"]}% p.a.",
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
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Maturity Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(fd["maturityAmount"] as double).currency}",
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
                      isMatured ? "Interest Earned" : "Interest Earned",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(fd["interestEarned"] as double).currency}",
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
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(fd["startDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Maturity Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(fd["maturityDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Tenure",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${fd["tenure"]} months",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isMatured) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Reinvest",
                size: bs.md,
                onPressed: () {
                  _reinvestFD(fd);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCalculatorTab() {
    // Calculate maturity amount
    double maturityAmount = _calculateMaturityAmount(
      principalAmount,
      interestRate,
      tenure,
      compoundFrequency,
    );
    double totalInterest = maturityAmount - principalAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [successColor, successColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FD Calculator Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "\$${maturityAmount.currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Maturity Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "\$${totalInterest.currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Total Interest",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: spLg),
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
                "Calculate Your FD Returns",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QNumberField(
                label: "Principal Amount (\$)",
                value: principalAmount.toString(),
                onChanged: (value) {
                  principalAmount = double.tryParse(value) ?? 0.0;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              QNumberField(
                label: "Interest Rate (% per annum)",
                value: interestRate.toString(),
                onChanged: (value) {
                  interestRate = double.tryParse(value) ?? 0.0;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              QNumberField(
                label: "Tenure (months)",
                value: tenure.toString(),
                onChanged: (value) {
                  tenure = int.tryParse(value) ?? 0;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Compounding Frequency",
                items: compoundingOptions,
                value: compoundFrequency,
                onChanged: (value, label) {
                  compoundFrequency = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Open FD with These Terms",
            size: bs.md,
            onPressed: () {
              _openNewFDWithCalculation();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFDSchemesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available FD Schemes",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Column(
          children: fdSchemes.map((scheme) => _buildFDSchemeCard(scheme)).toList(),
        ),
      ],
    );
  }

  Widget _buildFDSchemeCard(Map<String, dynamic> scheme) {
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
          Text(
            "${scheme["name"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${scheme["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
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
                      "Min Investment",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(scheme["minAmount"] as double).currency}",
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
                      "Max Investment",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(scheme["maxAmount"] as double).currency}",
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
          SizedBox(height: spMd),
          Text(
            "Interest Rates",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            children: (scheme["interestRates"] as List).map((rate) {
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${rate["tenure"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${rate["rate"]}% p.a.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Text(
            "Features",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: (scheme["features"] as List).map((feature) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$feature",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Apply Now",
              size: bs.md,
              onPressed: () {
                _applyForScheme(scheme);
              },
            ),
          ),
        ],
      ),
    );
  }

  double _calculateMaturityAmount(
    double principal,
    double rate,
    int tenureMonths,
    String frequency,
  ) {
    int compoundsPerYear;
    switch (frequency) {
      case "monthly":
        compoundsPerYear = 12;
        break;
      case "quarterly":
        compoundsPerYear = 4;
        break;
      case "half_yearly":
        compoundsPerYear = 2;
        break;
      case "yearly":
        compoundsPerYear = 1;
        break;
      default:
        compoundsPerYear = 12;
    }

    double years = tenureMonths / 12.0;
    double rateDecimal = rate / 100.0;
    double amount = principal * pow(1 + (rateDecimal / compoundsPerYear), compoundsPerYear * years);
    
    return amount;
  }

  double pow(double base, double exponent) {
    // Simple power calculation for compound interest
    double result = 1.0;
    for (int i = 0; i < exponent.round(); i++) {
      result *= base;
    }
    return result;
  }

  void _openNewFD() {
    ss("Opening new FD application");
  }

  void _openNewFDWithCalculation() {
    ss("Opening FD with calculated terms: \$${principalAmount.currency} at ${interestRate}% for ${tenure} months");
  }

  void _showFDOptions(Map<String, dynamic> fd) {
    ss("Showing options for FD: ${fd["fdNumber"]}");
  }

  void _reinvestFD(Map<String, dynamic> fd) {
    ss("Reinvesting FD: ${fd["fdNumber"]}");
  }

  void _applyForScheme(Map<String, dynamic> scheme) {
    ss("Applying for scheme: ${scheme["name"]}");
  }
}
