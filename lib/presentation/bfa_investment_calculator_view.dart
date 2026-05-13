import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
import 'dart:math' as Math;

class BfaInvestmentCalculatorView extends StatefulWidget {
  const BfaInvestmentCalculatorView({super.key});

  @override
  State<BfaInvestmentCalculatorView> createState() => _BfaInvestmentCalculatorViewState();
}

class _BfaInvestmentCalculatorViewState extends State<BfaInvestmentCalculatorView> {
  int selectedCalculator = 0;
  
  // SIP Calculator
  String sipAmount = "5000";
  String sipPeriod = "10";
  String sipRate = "12";
  double sipTotalAmount = 0;
  double sipMaturityAmount = 0;
  double sipGains = 0;
  
  // Lumpsum Calculator
  String lumpAmount = "100000";
  String lumpPeriod = "5";
  String lumpRate = "10";
  double lumpMaturityAmount = 0;
  double lumpGains = 0;
  
  // PPF Calculator
  String ppfAmount = "150000";
  String ppfPeriod = "15";
  String ppfRate = "7.1";
  double ppfMaturityAmount = 0;
  double ppfGains = 0;
  
  // Goal Calculator
  String goalAmount = "2000000";
  String goalPeriod = "20";
  String goalRate = "12";
  double goalMonthlySIP = 0;
  double goalTotalInvestment = 0;

  final List<Map<String, dynamic>> calculatorTypes = [
    {
      "label": "SIP Calculator",
      "value": 0,
      "icon": Icons.trending_up,
      "description": "Calculate returns for monthly SIP investments"
    },
    {
      "label": "Lumpsum Calculator", 
      "value": 1,
      "icon": Icons.account_balance_wallet,
      "description": "Calculate returns for one-time investments"
    },
    {
      "label": "PPF Calculator",
      "value": 2,
      "icon": Icons.savings,
      "description": "Calculate PPF maturity and tax benefits"
    },
    {
      "label": "Goal Calculator",
      "value": 3,
      "icon": Icons.flag,
      "description": "Plan investments to achieve financial goals"
    },
  ];

  @override
  void initState() {
    super.initState();
    calculateSIP();
  }

  void calculateSIP() {
    double principal = double.tryParse(sipAmount) ?? 0;
    double years = double.tryParse(sipPeriod) ?? 0;
    double rate = (double.tryParse(sipRate) ?? 0) / 100 / 12;
    double months = years * 12;
    
    if (principal > 0 && rate > 0 && months > 0) {
      sipMaturityAmount = principal * ((Math.pow(1 + rate, months) - 1) / rate) * (1 + rate);
      sipTotalAmount = principal * months;
      sipGains = sipMaturityAmount - sipTotalAmount;
    }
    setState(() {});
  }

  void calculateLumpsum() {
    double principal = double.tryParse(lumpAmount) ?? 0;
    double years = double.tryParse(lumpPeriod) ?? 0;
    double rate = (double.tryParse(lumpRate) ?? 0) / 100;
    
    if (principal > 0 && rate > 0 && years > 0) {
      lumpMaturityAmount = principal * Math.pow(1 + rate, years);
      lumpGains = lumpMaturityAmount - principal;
    }
    setState(() {});
  }

  void calculatePPF() {
    double principal = double.tryParse(ppfAmount) ?? 0;
    double years = double.tryParse(ppfPeriod) ?? 0;
    double rate = (double.tryParse(ppfRate) ?? 0) / 100;
    
    if (principal > 0 && rate > 0 && years > 0) {
      ppfMaturityAmount = principal * ((Math.pow(1 + rate, years) - 1) / rate);
      ppfGains = ppfMaturityAmount - (principal * years);
    }
    setState(() {});
  }

  void calculateGoal() {
    double target = double.tryParse(goalAmount) ?? 0;
    double years = double.tryParse(goalPeriod) ?? 0;
    double rate = (double.tryParse(goalRate) ?? 0) / 100 / 12;
    double months = years * 12;
    
    if (target > 0 && rate > 0 && months > 0) {
      goalMonthlySIP = target * rate / ((Math.pow(1 + rate, months) - 1) * (1 + rate));
      goalTotalInvestment = goalMonthlySIP * months;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Investment Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Show calculator tips
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Investment Calculators",
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Plan your investments and calculate returns",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: spLg),
            
            // Calculator Type Selection
            QCategoryPicker(
              items: calculatorTypes.map((type) => {
                "label": "${type["label"]}",
                "value": type["value"],
              }).toList(),
              value: selectedCalculator,
              onChanged: (index, label, value, item) {
                selectedCalculator = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Selected Calculator Description
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    calculatorTypes[selectedCalculator]["icon"],
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${calculatorTypes[selectedCalculator]["description"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Calculator Forms
            if (selectedCalculator == 0) _buildSIPCalculator(),
            if (selectedCalculator == 1) _buildLumpsumCalculator(),
            if (selectedCalculator == 2) _buildPPFCalculator(),
            if (selectedCalculator == 3) _buildGoalCalculator(),
          ],
        ),
      ),
    );
  }

  Widget _buildSIPCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SIP Calculator",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Input Form
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QNumberField(
                label: "Monthly SIP Amount (₹)",
                value: sipAmount,
                onChanged: (value) {
                  sipAmount = value;
                  calculateSIP();
                },
              ),
              QNumberField(
                label: "Investment Period (Years)",
                value: sipPeriod,
                onChanged: (value) {
                  sipPeriod = value;
                  calculateSIP();
                },
              ),
              QNumberField(
                label: "Expected Annual Return (%)",
                value: sipRate,
                onChanged: (value) {
                  sipRate = value;
                  calculateSIP();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spLg),
        
        // Results
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Text(
                "SIP Calculation Results",
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
                    child: _buildResultCard(
                      "Total Investment",
                      "₹${sipTotalAmount.toStringAsFixed(0)}",
                      Icons.account_balance_wallet,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildResultCard(
                      "Total Gains",
                      "₹${sipGains.toStringAsFixed(0)}",
                      Icons.trending_up,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              _buildResultCardFull(
                "Maturity Amount",
                "₹${sipMaturityAmount.toStringAsFixed(0)}",
                Icons.savings,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLumpsumCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lumpsum Calculator",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QNumberField(
                label: "Investment Amount (₹)",
                value: lumpAmount,
                onChanged: (value) {
                  lumpAmount = value;
                  calculateLumpsum();
                },
              ),
              QNumberField(
                label: "Investment Period (Years)",
                value: lumpPeriod,
                onChanged: (value) {
                  lumpPeriod = value;
                  calculateLumpsum();
                },
              ),
              QNumberField(
                label: "Expected Annual Return (%)",
                value: lumpRate,
                onChanged: (value) {
                  lumpRate = value;
                  calculateLumpsum();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spLg),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [successColor, successColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Text(
                "Lumpsum Calculation Results",
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
                    child: _buildResultCard(
                      "Principal Amount",
                      "₹${lumpAmount}",
                      Icons.account_balance_wallet,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildResultCard(
                      "Total Gains",
                      "₹${lumpGains.toStringAsFixed(0)}",
                      Icons.trending_up,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              _buildResultCardFull(
                "Maturity Amount",
                "₹${lumpMaturityAmount.toStringAsFixed(0)}",
                Icons.savings,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPPFCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PPF Calculator",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QNumberField(
                label: "Annual Investment (₹)",
                value: ppfAmount,
                onChanged: (value) {
                  ppfAmount = value;
                  calculatePPF();
                },
              ),
              QNumberField(
                label: "Investment Period (Years)",
                value: ppfPeriod,
                onChanged: (value) {
                  ppfPeriod = value;
                  calculatePPF();
                },
              ),
              QNumberField(
                label: "Interest Rate (%)",
                value: ppfRate,
                onChanged: (value) {
                  ppfRate = value;
                  calculatePPF();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spLg),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [warningColor, warningColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Text(
                "PPF Calculation Results",
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
                    child: _buildResultCard(
                      "Total Investment",
                      "₹${((double.tryParse(ppfAmount) ?? 0) * (double.tryParse(ppfPeriod) ?? 0)).toStringAsFixed(0)}",
                      Icons.account_balance_wallet,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildResultCard(
                      "Total Interest",
                      "₹${ppfGains.toStringAsFixed(0)}",
                      Icons.trending_up,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              _buildResultCardFull(
                "Maturity Amount",
                "₹${ppfMaturityAmount.toStringAsFixed(0)}",
                Icons.savings,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGoalCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Goal Calculator",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spMd,
            children: [
              QNumberField(
                label: "Target Amount (₹)",
                value: goalAmount,
                onChanged: (value) {
                  goalAmount = value;
                  calculateGoal();
                },
              ),
              QNumberField(
                label: "Time Period (Years)",
                value: goalPeriod,
                onChanged: (value) {
                  goalPeriod = value;
                  calculateGoal();
                },
              ),
              QNumberField(
                label: "Expected Annual Return (%)",
                value: goalRate,
                onChanged: (value) {
                  goalRate = value;
                  calculateGoal();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spLg),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [infoColor, infoColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Column(
            children: [
              Text(
                "Goal Planning Results",
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
                    child: _buildResultCard(
                      "Monthly SIP Required",
                      "₹${goalMonthlySIP.toStringAsFixed(0)}",
                      Icons.calendar_month,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildResultCard(
                      "Total Investment",
                      "₹${goalTotalInvestment.toStringAsFixed(0)}",
                      Icons.account_balance_wallet,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              _buildResultCardFull(
                "Target Amount",
                "₹${goalAmount}",
                Icons.flag,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.white.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCardFull(String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.white.withAlpha(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withAlpha(200),
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
