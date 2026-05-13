import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaSipCalculatorView extends StatefulWidget {
  const BfaSipCalculatorView({super.key});

  @override
  State<BfaSipCalculatorView> createState() => _BfaSipCalculatorViewState();
}

class _BfaSipCalculatorViewState extends State<BfaSipCalculatorView> {
  int currentTab = 0;
  
  // SIP Calculator
  String monthlyInvestment = "5000";
  String expectedReturn = "12";
  String timePeriod = "10";
  double totalInvestment = 0.0;
  double estimatedReturns = 0.0;
  double maturityAmount = 0.0;
  
  // SWP Calculator
  String initialInvestment = "1000000";
  String withdrawalAmount = "10000";
  String withdrawalPeriod = "10";
  String swpReturn = "10";
  double finalAmount = 0.0;
  double totalWithdrawn = 0.0;
  
  // Lumpsum Calculator
  String lumpsumAmount = "100000";
  String lumpsumReturn = "12";
  String lumpsumPeriod = "5";
  double lumpsumMaturity = 0.0;
  double lumpsumGains = 0.0;
  
  List<Map<String, dynamic>> sipComparisons = [
    {
      "fundName": "HDFC Equity Fund",
      "category": "Large Cap",
      "returns_1y": 15.2,
      "returns_3y": 12.8,
      "returns_5y": 14.5,
      "rating": 4,
      "riskLevel": "Moderate",
      "minSip": 500,
    },
    {
      "fundName": "SBI Small Cap Fund",
      "category": "Small Cap",
      "returns_1y": 18.7,
      "returns_3y": 16.2,
      "returns_5y": 19.1,
      "rating": 5,
      "riskLevel": "High",
      "minSip": 1000,
    },
    {
      "fundName": "ICICI Prudential Balanced",
      "category": "Hybrid",
      "returns_1y": 11.5,
      "returns_3y": 10.8,
      "returns_5y": 12.2,
      "rating": 4,
      "riskLevel": "Low",
      "minSip": 500,
    },
  ];
  
  List<Map<String, dynamic>> sipGoals = [
    {
      "goalName": "Child Education",
      "targetAmount": 2500000,
      "timeHorizon": 15,
      "requiredSip": 8500,
      "riskTolerance": "Moderate",
      "category": "Education",
      "progress": 25,
    },
    {
      "goalName": "Retirement Planning",
      "targetAmount": 10000000,
      "timeHorizon": 25,
      "requiredSip": 12000,
      "riskTolerance": "High",
      "category": "Retirement",
      "progress": 15,
    },
    {
      "goalName": "Home Purchase",
      "targetAmount": 5000000,
      "timeHorizon": 8,
      "requiredSip": 35000,
      "riskTolerance": "Moderate",
      "category": "Property",
      "progress": 40,
    },
  ];

  @override
  void initState() {
    super.initState();
    _calculateSIP();
  }

  void _calculateSIP() {
    double monthlyAmount = double.tryParse(monthlyInvestment) ?? 0;
    double annualReturn = (double.tryParse(expectedReturn) ?? 0) / 100;
    int months = (double.tryParse(timePeriod) ?? 0).toInt() * 12;
    
    totalInvestment = monthlyAmount * months;
    
    if (annualReturn > 0 && months > 0) {
      double monthlyReturn = annualReturn / 12;
      maturityAmount = monthlyAmount * (((1 + monthlyReturn).toDouble() - 1) / monthlyReturn) * (1 + monthlyReturn);
      for (int i = 0; i < months - 1; i++) {
        maturityAmount = maturityAmount * (1 + monthlyReturn) + monthlyAmount;
      }
    } else {
      maturityAmount = totalInvestment;
    }
    
    estimatedReturns = maturityAmount - totalInvestment;
    setState(() {});
  }

  void _calculateSWP() {
    double initial = double.tryParse(initialInvestment) ?? 0;
    double withdrawal = double.tryParse(withdrawalAmount) ?? 0;
    int months = (double.tryParse(withdrawalPeriod) ?? 0).toInt() * 12;
    double monthlyReturn = (double.tryParse(swpReturn) ?? 0) / 100 / 12;
    
    double balance = initial;
    totalWithdrawn = 0;
    
    for (int i = 0; i < months; i++) {
      balance = balance * (1 + monthlyReturn) - withdrawal;
      totalWithdrawn += withdrawal;
      if (balance < 0) break;
    }
    
    finalAmount = balance > 0 ? balance : 0;
    setState(() {});
  }

  void _calculateLumpsum() {
    double amount = double.tryParse(lumpsumAmount) ?? 0;
    double annualReturn = (double.tryParse(lumpsumReturn) ?? 0) / 100;
    int years = (double.tryParse(lumpsumPeriod) ?? 0).toInt();
    
    lumpsumMaturity = amount * (1 + annualReturn) * years.toDouble();
    lumpsumGains = lumpsumMaturity - amount;
    setState(() {});
  }

  Widget _buildSIPCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                "SIP Calculator",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QNumberField(
                label: "Monthly Investment (₹)",
                value: monthlyInvestment,
                onChanged: (value) {
                  monthlyInvestment = value;
                  _calculateSIP();
                },
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Expected Annual Return (%)",
                value: expectedReturn,
                onChanged: (value) {
                  expectedReturn = value;
                  _calculateSIP();
                },
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Time Period (Years)",
                value: timePeriod,
                onChanged: (value) {
                  timePeriod = value;
                  _calculateSIP();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withAlpha(200)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Column(
            children: [
              Text(
                "Investment Summary",
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
                      "₹${totalInvestment.currency}",
                      Icons.account_balance_wallet,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildResultCard(
                      "Est. Returns",
                      "₹${estimatedReturns.currency}",
                      Icons.trending_up,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "Maturity Amount",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "₹${maturityAmount.currency}",
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
        ),
      ],
    );
  }

  Widget _buildSWPCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                "SWP Calculator",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QNumberField(
                label: "Initial Investment (₹)",
                value: initialInvestment,
                onChanged: (value) {
                  initialInvestment = value;
                  _calculateSWP();
                },
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Monthly Withdrawal (₹)",
                value: withdrawalAmount,
                onChanged: (value) {
                  withdrawalAmount = value;
                  _calculateSWP();
                },
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Withdrawal Period (Years)",
                value: withdrawalPeriod,
                onChanged: (value) {
                  withdrawalPeriod = value;
                  _calculateSWP();
                },
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Expected Annual Return (%)",
                value: swpReturn,
                onChanged: (value) {
                  swpReturn = value;
                  _calculateSWP();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.money_off,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Total Withdrawn",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "₹${totalWithdrawn.currency}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Final Amount",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "₹${finalAmount.currency}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLumpsumCalculator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                "Lumpsum Calculator",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QNumberField(
                label: "Investment Amount (₹)",
                value: lumpsumAmount,
                onChanged: (value) {
                  lumpsumAmount = value;
                  _calculateLumpsum();
                },
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Expected Annual Return (%)",
                value: lumpsumReturn,
                onChanged: (value) {
                  lumpsumReturn = value;
                  _calculateLumpsum();
                },
              ),
              SizedBox(height: spSm),
              QNumberField(
                label: "Time Period (Years)",
                value: lumpsumPeriod,
                onChanged: (value) {
                  lumpsumPeriod = value;
                  _calculateLumpsum();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [warningColor, warningColor.withAlpha(200)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Column(
            children: [
              Text(
                "Lumpsum Results",
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
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Principal",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(179),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "₹${((double.tryParse(lumpsumAmount) ?? 0)).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Gains",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(179),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "₹${lumpsumGains.currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(77),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "Maturity Value",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "₹${lumpsumMaturity.currency}",
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
        ),
      ],
    );
  }

  Widget _buildFundComparison() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top Mutual Funds for SIP",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...sipComparisons.map((fund) {
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
                            "${fund["fundName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${fund["category"]} • Min SIP: ₹${(fund["minSip"] as int).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: fund["riskLevel"] == "High" ? dangerColor :
                               fund["riskLevel"] == "Moderate" ? warningColor : successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${fund["riskLevel"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildFundMetric("1Y", "${(fund["returns_1y"] as double).toStringAsFixed(1)}%"),
                    ),
                    Expanded(
                      child: _buildFundMetric("3Y", "${(fund["returns_3y"] as double).toStringAsFixed(1)}%"),
                    ),
                    Expanded(
                      child: _buildFundMetric("5Y", "${(fund["returns_5y"] as double).toStringAsFixed(1)}%"),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (fund["rating"] as int) ? Icons.star : Icons.star_border,
                            color: warningColor,
                            size: 16,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Start SIP",
                    size: bs.sm,
                    onPressed: () {
                      ss("SIP started for ${fund["fundName"]}");
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildGoalPlanning() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SIP Goal Planning",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...sipGoals.map((goal) {
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: goal["category"] == "Education" ? infoColor :
                               goal["category"] == "Retirement" ? successColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        goal["category"] == "Education" ? Icons.school :
                        goal["category"] == "Retirement" ? Icons.elderly : Icons.home,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${goal["goalName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Target: ₹${((goal["targetAmount"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${goal["progress"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                LinearProgressIndicator(
                  value: (goal["progress"] as int) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(successColor),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildGoalMetric("Time Horizon", "${goal["timeHorizon"]} years"),
                    ),
                    Expanded(
                      child: _buildGoalMetric("Required SIP", "₹${((goal["requiredSip"] as int).toDouble()).currency}"),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('goal_details_view')
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Start SIP",
                        size: bs.sm,
                        onPressed: () {
                          ss("SIP started for ${goal["goalName"]}");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(179),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundMetric(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "SIP Calculator",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "SIP", icon: Icon(Icons.trending_up)),
        Tab(text: "SWP", icon: Icon(Icons.trending_down)),
        Tab(text: "Lumpsum", icon: Icon(Icons.account_balance_wallet)),
        Tab(text: "Funds", icon: Icon(Icons.compare)),
        Tab(text: "Goals", icon: Icon(Icons.flag)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSIPCalculator(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSWPCalculator(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildLumpsumCalculator(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildFundComparison(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildGoalPlanning(),
        ),
      ],
    );
  }
}
