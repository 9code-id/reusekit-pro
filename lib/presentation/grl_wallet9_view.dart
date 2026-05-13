import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet9View extends StatefulWidget {
  @override
  State<GrlWallet9View> createState() => _GrlWallet9ViewState();
}

class _GrlWallet9ViewState extends State<GrlWallet9View> {
  List<Map<String, dynamic>> loans = [
    {
      "id": "1",
      "type": "Personal Loan",
      "lender": "First National Bank",
      "principalAmount": 15000.0,
      "currentBalance": 8500.0,
      "interestRate": 8.5,
      "monthlyPayment": 350.0,
      "nextPaymentDate": "2024-02-15",
      "remainingTerms": 24,
      "totalTerms": 48,
      "status": "active",
      "autopay": true,
      "icon": Icons.person,
      "color": Colors.blue
    },
    {
      "id": "2",
      "type": "Car Loan",
      "lender": "Auto Finance Corp",
      "principalAmount": 25000.0,
      "currentBalance": 18750.0,
      "interestRate": 6.2,
      "monthlyPayment": 485.0,
      "nextPaymentDate": "2024-02-20",
      "remainingTerms": 36,
      "totalTerms": 60,
      "status": "active",
      "autopay": false,
      "icon": Icons.directions_car,
      "color": Colors.green
    },
    {
      "id": "3",
      "type": "Home Loan",
      "lender": "Mortgage Solutions",
      "principalAmount": 180000.0,
      "currentBalance": 165000.0,
      "interestRate": 4.8,
      "monthlyPayment": 1250.0,
      "nextPaymentDate": "2024-02-01",
      "remainingTerms": 324,
      "totalTerms": 360,
      "status": "active",
      "autopay": true,
      "icon": Icons.home,
      "color": Colors.orange
    },
    {
      "id": "4",
      "type": "Student Loan",
      "lender": "Education Finance",
      "principalAmount": 35000.0,
      "currentBalance": 12500.0,
      "interestRate": 5.5,
      "monthlyPayment": 280.0,
      "nextPaymentDate": "2024-02-10",
      "remainingTerms": 45,
      "totalTerms": 120,
      "status": "active",
      "autopay": true,
      "icon": Icons.school,
      "color": Colors.purple
    },
    {
      "id": "5",
      "type": "Credit Card",
      "lender": "Premium Credit",
      "principalAmount": 5000.0,
      "currentBalance": 2750.0,
      "interestRate": 18.9,
      "monthlyPayment": 125.0,
      "nextPaymentDate": "2024-02-25",
      "remainingTerms": 0,
      "totalTerms": 0,
      "status": "active",
      "autopay": false,
      "icon": Icons.credit_card,
      "color": Colors.red
    }
  ];

  String selectedFilter = "All";
  List<String> filters = ["All", "Active", "High Interest", "Due Soon"];

  List<Map<String, dynamic>> get filteredLoans {
    if (selectedFilter == "All") return loans;
    if (selectedFilter == "Active") {
      return loans.where((loan) => loan["status"] == "active").toList();
    }
    if (selectedFilter == "High Interest") {
      return loans.where((loan) => (loan["interestRate"] as double) > 10.0).toList();
    }
    if (selectedFilter == "Due Soon") {
      return loans.where((loan) {
        DateTime nextPayment = DateTime.parse(loan["nextPaymentDate"]);
        DateTime now = DateTime.now();
        return nextPayment.difference(now).inDays <= 7;
      }).toList();
    }
    return loans;
  }

  double get totalDebt {
    return loans.fold(0.0, (sum, loan) => sum + (loan["currentBalance"] as double));
  }

  double get totalMonthlyPayments {
    return loans.fold(0.0, (sum, loan) => sum + (loan["monthlyPayment"] as double));
  }

  double get totalPrincipal {
    return loans.fold(0.0, (sum, loan) => sum + (loan["principalAmount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Debt Overview
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Total Outstanding Debt",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "\$${totalDebt.currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Monthly Payments: \$${totalMonthlyPayments.currency}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDebtStat(
                        "Original",
                        totalPrincipal,
                        Colors.white.withAlpha(100),
                      ),
                      _buildDebtStat(
                        "Remaining",
                        totalDebt,
                        Colors.red.withAlpha(100),
                      ),
                      _buildDebtStat(
                        "Paid Off",
                        totalPrincipal - totalDebt,
                        Colors.green.withAlpha(100),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Progress Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Debt Payoff Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: ((totalPrincipal - totalDebt) / totalPrincipal).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${(((totalPrincipal - totalDebt) / totalPrincipal) * 100).toStringAsFixed(1)}% paid off",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),

            // Filter Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: QDropdownField(
                label: "Filter Loans",
                items: filters.map((filter) => {
                  "label": filter,
                  "value": filter,
                }).toList(),
                value: selectedFilter,
                onChanged: (value, label) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Make Payment",
                    icon: Icons.payment,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Add Loan",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Loans List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredLoans.length,
              itemBuilder: (context, index) {
                final loan = filteredLoans[index];
                return _buildLoanCard(loan);
              },
            ),

            // Debt Insights
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Debt Management Insights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  _buildInsightItem(
                    "Highest Interest",
                    "Credit Card (18.9%)",
                    "Consider paying off first",
                    Icons.warning,
                    dangerColor,
                  ),
                  _buildInsightItem(
                    "Lowest Interest",
                    "Home Loan (4.8%)",
                    "Consider minimum payments",
                    Icons.info,
                    successColor,
                  ),
                  _buildInsightItem(
                    "AutoPay Active",
                    "${loans.where((l) => l["autopay"] == true).length} of ${loans.length} loans",
                    "Set up autopay for others",
                    Icons.auto_awesome,
                    infoColor,
                  ),
                  _buildInsightItem(
                    "Next Payment",
                    "Due in ${DateTime.parse(loans.first["nextPaymentDate"]).difference(DateTime.now()).inDays} days",
                    "\$${(loans.first["monthlyPayment"] as double).currency}",
                    Icons.schedule,
                    warningColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebtStat(String title, double amount, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanCard(Map<String, dynamic> loan) {
    double progress = ((loan["totalTerms"] as int) - (loan["remainingTerms"] as int)) / (loan["totalTerms"] as int);
    if (loan["totalTerms"] == 0) progress = 0.5; // For credit cards
    
    Color loanColor = loan["color"] as Color;
    DateTime nextPayment = DateTime.parse(loan["nextPaymentDate"]);
    int daysUntilPayment = nextPayment.difference(DateTime.now()).inDays;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: loanColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  loan["icon"] as IconData,
                  color: loanColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${loan["type"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (loan["autopay"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "AUTOPAY",
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${loan["lender"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(loan["interestRate"] as double).toStringAsFixed(1)}% APR",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Balance and Payment Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Balance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(loan["currentBalance"] as double).currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Monthly Payment",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${(loan["monthlyPayment"] as double).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: loanColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Progress Bar
          if (loan["totalTerms"] > 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${((loan["totalTerms"] as int) - (loan["remainingTerms"] as int))} of ${loan["totalTerms"]} payments",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: loanColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: loanColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${(progress * 100).toStringAsFixed(1)}% complete",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: loanColor,
                  ),
                ),
              ],
            ),

          // Next Payment Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: daysUntilPayment <= 7 
                  ? warningColor.withAlpha(30)
                  : infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: daysUntilPayment <= 7 ? warningColor : infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Next payment in $daysUntilPayment days (${nextPayment.dMMMy})",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Make Payment",
                  icon: Icons.payment,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String subtitle, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 18,
            ),
          ),
          SizedBox(width: spSm),
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
                  subtitle,
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
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
