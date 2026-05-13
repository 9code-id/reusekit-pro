import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaRecurringDepositsView extends StatefulWidget {
  const BfaRecurringDepositsView({super.key});

  @override
  State<BfaRecurringDepositsView> createState() => _BfaRecurringDepositsViewState();
}

class _BfaRecurringDepositsViewState extends State<BfaRecurringDepositsView> {
  bool loading = false;
  int selectedTab = 0;
  
  // RD Calculator variables
  double monthlyAmount = 1000.0;
  double interestRate = 7.5;
  int tenure = 12; // months
  String paymentFrequency = "monthly";

  List<Map<String, dynamic>> activeRDs = [
    {
      "id": 1,
      "rdNumber": "RD001234567",
      "monthlyAmount": 2000.0,
      "interestRate": 7.8,
      "maturityAmount": 25850.0,
      "startDate": "2024-01-15",
      "maturityDate": "2025-01-15",
      "tenure": 12,
      "status": "Active",
      "totalDeposited": 6000.0,
      "interestEarned": 240.0,
      "nextDueDate": "2024-02-15",
      "installmentsPaid": 3,
      "installmentsPending": 9,
      "autoDebit": true,
    },
    {
      "id": 2,
      "rdNumber": "RD001234568",
      "monthlyAmount": 5000.0,
      "interestRate": 8.0,
      "maturityAmount": 193584.0,
      "startDate": "2023-06-10",
      "maturityDate": "2026-06-10",
      "tenure": 36,
      "status": "Active",
      "totalDeposited": 75000.0,
      "interestEarned": 4500.0,
      "nextDueDate": "2024-02-10",
      "installmentsPaid": 15,
      "installmentsPending": 21,
      "autoDebit": false,
    },
    {
      "id": 3,
      "rdNumber": "RD001234569",
      "monthlyAmount": 1500.0,
      "interestRate": 7.2,
      "maturityAmount": 38875.0,
      "startDate": "2024-03-01",
      "maturityDate": "2026-03-01",
      "tenure": 24,
      "status": "Active",
      "totalDeposited": 7500.0,
      "interestEarned": 340.0,
      "nextDueDate": "2024-02-01",
      "installmentsPaid": 5,
      "installmentsPending": 19,
      "autoDebit": true,
    },
  ];

  List<Map<String, dynamic>> maturedRDs = [
    {
      "id": 4,
      "rdNumber": "RD001234566",
      "monthlyAmount": 3000.0,
      "interestRate": 7.5,
      "maturityAmount": 95800.0,
      "startDate": "2021-12-15",
      "maturityDate": "2023-12-15",
      "tenure": 24,
      "status": "Matured",
      "totalDeposited": 72000.0,
      "interestEarned": 23800.0,
      "installmentsPaid": 24,
      "isReinvested": false,
    },
  ];

  List<Map<String, dynamic>> rdSchemes = [
    {
      "name": "Regular RD",
      "description": "Standard recurring deposit with flexible tenure",
      "minAmount": 100.0,
      "maxAmount": 50000.0,
      "interestRates": [
        {"tenure": "6 months", "rate": 6.5},
        {"tenure": "1 year", "rate": 7.5},
        {"tenure": "2 years", "rate": 8.0},
        {"tenure": "3 years", "rate": 8.2},
        {"tenure": "5 years", "rate": 8.5},
      ],
      "features": ["Flexible monthly amount", "Auto-debit facility", "Premature withdrawal"],
    },
    {
      "name": "Child RD",
      "description": "Special RD scheme for children's future",
      "minAmount": 250.0,
      "maxAmount": 25000.0,
      "interestRates": [
        {"tenure": "1 year", "rate": 8.0},
        {"tenure": "2 years", "rate": 8.5},
        {"tenure": "3 years", "rate": 8.7},
        {"tenure": "5 years", "rate": 9.0},
      ],
      "features": ["Higher interest rates", "Tax benefits", "Education loan eligibility"],
    },
    {
      "name": "Senior Citizen RD",
      "description": "Enhanced returns for senior citizens (60+ years)",
      "minAmount": 500.0,
      "maxAmount": 100000.0,
      "interestRates": [
        {"tenure": "1 year", "rate": 8.0},
        {"tenure": "2 years", "rate": 8.5},
        {"tenure": "3 years", "rate": 8.7},
        {"tenure": "5 years", "rate": 9.0},
      ],
      "features": ["Additional 0.5% interest", "Priority service", "Medical insurance benefit"],
    },
  ];

  List<Map<String, dynamic>> paymentFrequencyOptions = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Half Yearly", "value": "half_yearly"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recurring Deposits"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _openNewRD();
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
    List<String> tabs = ["Active RDs", "Calculator", "RD Schemes"];
    
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
        return _buildActiveRDsTab();
      case 1:
        return _buildCalculatorTab();
      case 2:
        return _buildRDSchemesTab();
      default:
        return _buildActiveRDsTab();
    }
  }

  Widget _buildActiveRDsTab() {
    double totalMonthlyAmount = activeRDs.fold(0.0, 
        (sum, rd) => sum + (rd["monthlyAmount"] as double));
    double totalMaturityAmount = activeRDs.fold(0.0, 
        (sum, rd) => sum + (rd["maturityAmount"] as double));
    double totalDeposited = activeRDs.fold(0.0, 
        (sum, rd) => sum + (rd["totalDeposited"] as double));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRDSummaryCard(totalMonthlyAmount, totalMaturityAmount, totalDeposited),
        SizedBox(height: spLg),
        Text(
          "Active Recurring Deposits",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        if (activeRDs.isEmpty)
          _buildEmptyRDState(),
        if (activeRDs.isNotEmpty)
          Column(
            children: activeRDs.map((rd) => _buildRDCard(rd)).toList(),
          ),
        if (maturedRDs.isNotEmpty) ...[
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
            children: maturedRDs.map((rd) => _buildRDCard(rd)).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildRDSummaryCard(double totalMonthlyAmount, double totalMaturityAmount, double totalDeposited) {
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
            "RD Portfolio Summary",
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
                        "\$${totalMonthlyAmount.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Monthly Savings",
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
                        "Total Maturity",
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
                        "\$${totalDeposited.currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Total Deposited",
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

  Widget _buildEmptyRDState() {
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
              Icons.savings,
              color: disabledColor,
              size: 64,
            ),
            SizedBox(height: spMd),
            Text(
              "No Recurring Deposits Found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Start saving with our recurring deposit schemes and build a secure financial future",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Open New RD",
              size: bs.md,
              onPressed: () {
                _openNewRD();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRDCard(Map<String, dynamic> rd) {
    bool isMatured = rd["status"] == "Matured";
    bool hasAutoDebit = rd["autoDebit"] ?? false;
    int installmentsPaid = rd["installmentsPaid"] as int;
    int totalInstallments = rd["tenure"] as int;
    double progress = installmentsPaid / totalInstallments;
    
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
                      "${rd["rdNumber"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                            color: isMatured 
                                ? successColor.withAlpha(30)
                                : primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${rd["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isMatured ? successColor : primaryColor,
                            ),
                          ),
                        ),
                        if (!isMatured && hasAutoDebit) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Auto-Debit",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              if (!isMatured)
                QButton(
                  icon: Icons.more_vert,
                  size: bs.sm,
                  onPressed: () {
                    _showRDOptions(rd);
                  },
                ),
            ],
          ),
          SizedBox(height: spMd),
          if (!isMatured) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Progress: $installmentsPaid of $totalInstallments installments",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
            SizedBox(height: spMd),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monthly Amount",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(rd["monthlyAmount"] as double).currency}",
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
                      "${rd["interestRate"]}% p.a.",
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
                      "\$${(rd["maturityAmount"] as double).currency}",
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
                      "Total Deposited",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(rd["totalDeposited"] as double).currency}",
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
                      "${DateTime.parse(rd["startDate"]).dMMMy}",
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
                      "${DateTime.parse(rd["maturityDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMatured)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next Due",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${DateTime.parse(rd["nextDueDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (!isMatured) ...[
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Pay Installment",
                    size: bs.sm,
                    onPressed: () {
                      _payInstallment(rd);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: hasAutoDebit ? "Disable Auto-Debit" : "Enable Auto-Debit",
                  size: bs.sm,
                  onPressed: () {
                    _toggleAutoDebit(rd);
                  },
                ),
              ],
            ),
          ],
          if (isMatured) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Reinvest",
                size: bs.md,
                onPressed: () {
                  _reinvestRD(rd);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCalculatorTab() {
    // Calculate maturity amount for RD
    double maturityAmount = _calculateRDMaturityAmount(
      monthlyAmount,
      interestRate,
      tenure,
    );
    double totalDeposited = monthlyAmount * tenure;
    double totalInterest = maturityAmount - totalDeposited;

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
                "RD Calculator Results",
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
                "Calculate Your RD Returns",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QNumberField(
                label: "Monthly Deposit Amount (\$)",
                value: monthlyAmount.toString(),
                onChanged: (value) {
                  monthlyAmount = double.tryParse(value) ?? 0.0;
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Total Deposits: \$${totalDeposited.currency}",
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
            ],
          ),
        ),
        SizedBox(height: spMd),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Open RD with These Terms",
            size: bs.md,
            onPressed: () {
              _openNewRDWithCalculation();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRDSchemesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available RD Schemes",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        Column(
          children: rdSchemes.map((scheme) => _buildRDSchemeCard(scheme)).toList(),
        ),
      ],
    );
  }

  Widget _buildRDSchemeCard(Map<String, dynamic> scheme) {
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
                      "Min Monthly Amount",
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
                      "Max Monthly Amount",
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

  double _calculateRDMaturityAmount(double monthlyAmount, double rate, int months) {
    // RD Maturity calculation: M = P × [((1+r)^n - 1) / r] × (1+r)
    // Where: P = monthly deposit, r = monthly interest rate, n = number of months
    double monthlyRate = (rate / 100) / 12;
    double amount = monthlyAmount * (((pow(1 + monthlyRate, months.toDouble()) - 1) / monthlyRate) * (1 + monthlyRate));
    return amount;
  }

  double pow(double base, double exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent.round(); i++) {
      result *= base;
    }
    return result;
  }

  void _openNewRD() {
    ss("Opening new RD application");
  }

  void _openNewRDWithCalculation() {
    ss("Opening RD with calculated terms: \$${monthlyAmount.currency} monthly at ${interestRate}% for ${tenure} months");
  }

  void _showRDOptions(Map<String, dynamic> rd) {
    ss("Showing options for RD: ${rd["rdNumber"]}");
  }

  void _payInstallment(Map<String, dynamic> rd) {
    ss("Paying installment for RD: ${rd["rdNumber"]}");
  }

  void _toggleAutoDebit(Map<String, dynamic> rd) {
    bool currentStatus = rd["autoDebit"] as bool;
    rd["autoDebit"] = !currentStatus;
    setState(() {});
    ss("Auto-debit ${!currentStatus ? 'enabled' : 'disabled'} for RD: ${rd["rdNumber"]}");
  }

  void _reinvestRD(Map<String, dynamic> rd) {
    ss("Reinvesting RD: ${rd["rdNumber"]}");
  }

  void _applyForScheme(Map<String, dynamic> scheme) {
    ss("Applying for scheme: ${scheme["name"]}");
  }
}
