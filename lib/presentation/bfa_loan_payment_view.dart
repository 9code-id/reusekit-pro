import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaLoanPaymentView extends StatefulWidget {
  const BfaLoanPaymentView({super.key});

  @override
  State<BfaLoanPaymentView> createState() => _BfaLoanPaymentViewState();
}

class _BfaLoanPaymentViewState extends State<BfaLoanPaymentView> {
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Paid Off", "value": "Paid Off"},
  ];

  List<Map<String, dynamic>> loans = [
    {
      "id": 1,
      "lender": "Chase Bank",
      "loanType": "Home Loan",
      "accountNumber": "HL-789456123",
      "principalAmount": 250000.00,
      "remainingBalance": 180500.00,
      "monthlyPayment": 1850.75,
      "interestRate": 3.5,
      "dueDate": "2025-01-15",
      "nextPayment": 1850.75,
      "status": "Active",
      "termRemaining": "18 years 6 months",
      "icon": Icons.home,
      "color": Colors.blue,
      "autoPayEnabled": true
    },
    {
      "id": 2,
      "lender": "Toyota Financial",
      "loanType": "Auto Loan",
      "accountNumber": "AL-456789012",
      "principalAmount": 35000.00,
      "remainingBalance": 18200.50,
      "monthlyPayment": 485.25,
      "interestRate": 4.2,
      "dueDate": "2025-01-20",
      "nextPayment": 485.25,
      "status": "Active",
      "termRemaining": "3 years 2 months",
      "icon": Icons.directions_car,
      "color": Colors.green,
      "autoPayEnabled": false
    },
    {
      "id": 3,
      "lender": "Student Loan Corp",
      "loanType": "Student Loan",
      "accountNumber": "SL-123456789",
      "principalAmount": 45000.00,
      "remainingBalance": 28750.00,
      "monthlyPayment": 380.00,
      "interestRate": 5.8,
      "dueDate": "2025-01-10",
      "nextPayment": 380.00,
      "status": "Overdue",
      "termRemaining": "6 years 8 months",
      "icon": Icons.school,
      "color": Colors.purple,
      "autoPayEnabled": false
    },
    {
      "id": 4,
      "lender": "Personal Credit Union",
      "loanType": "Personal Loan",
      "accountNumber": "PL-987654321",
      "principalAmount": 15000.00,
      "remainingBalance": 5200.00,
      "monthlyPayment": 350.00,
      "interestRate": 7.5,
      "dueDate": "2025-01-25",
      "nextPayment": 350.00,
      "status": "Active",
      "termRemaining": "1 year 3 months",
      "icon": Icons.account_balance,
      "color": Colors.orange,
      "autoPayEnabled": true
    },
    {
      "id": 5,
      "lender": "Small Business Bank",
      "loanType": "Business Loan",
      "accountNumber": "BL-555666777",
      "principalAmount": 50000.00,
      "remainingBalance": 0.00,
      "monthlyPayment": 0.00,
      "interestRate": 6.0,
      "dueDate": "2024-12-30",
      "nextPayment": 0.00,
      "status": "Paid Off",
      "termRemaining": "Completed",
      "icon": Icons.business,
      "color": Colors.grey,
      "autoPayEnabled": false
    }
  ];

  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": 1,
      "lender": "Chase Bank",
      "loanType": "Home Loan",
      "amount": 1850.75,
      "date": "2024-12-15T10:30:00",
      "status": "Success",
      "transactionId": "LN789456123",
      "principal": 650.75,
      "interest": 1200.00
    },
    {
      "id": 2,
      "lender": "Toyota Financial",
      "amount": 485.25,
      "loanType": "Auto Loan",
      "date": "2024-12-20T14:20:00",
      "status": "Success",
      "transactionId": "LN456789012",
      "principal": 365.25,
      "interest": 120.00
    }
  ];

  List<Map<String, dynamic>> get filteredLoans {
    if (selectedFilter == "All") return loans;
    return loans.where((loan) => loan["status"] == selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Overdue":
        return dangerColor;
      case "Paid Off":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  int get overdue => loans.where((loan) => loan["status"] == "Overdue").length;
  int get active => loans.where((loan) => loan["status"] == "Active").length;
  double get totalMonthlyPayment => loans
      .where((loan) => loan["status"] == "Active" || loan["status"] == "Overdue")
      .map((loan) => loan["monthlyPayment"] as double)
      .fold(0.0, (sum, amount) => sum + amount);
  double get totalRemainingBalance => loans
      .where((loan) => loan["status"] == "Active" || loan["status"] == "Overdue")
      .map((loan) => loan["remainingBalance"] as double)
      .fold(0.0, (sum, amount) => sum + amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Payments"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              // navigateTo(LoanCalculatorView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.account_balance,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loan Overview",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${loans.where((l) => l["status"] != "Paid Off").length} active loans",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
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
                          children: [
                            Text(
                              "Monthly Payment",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "\$${totalMonthlyPayment.currency}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Total Balance",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "\$${totalRemainingBalance.currency}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: successColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$active",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                      color: dangerColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: dangerColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Overdue",
                              style: TextStyle(
                                fontSize: 14,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$overdue",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filter Options
            QCategoryPicker(
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Loans List
            ...filteredLoans.map((loan) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: loan["status"] == "Overdue"
                      ? Border.all(color: dangerColor.withAlpha(128))
                      : null,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (loan["color"] as Color).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            loan["icon"] as IconData,
                            color: loan["color"] as Color,
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
                                      "${loan["lender"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(loan["status"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${loan["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(loan["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${loan["loanType"]} • ${loan["accountNumber"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (loan["autoPayEnabled"])
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: successColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Auto-pay enabled",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    if (loan["status"] != "Paid Off") ...[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Remaining Balance",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(loan["remainingBalance"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Interest Rate",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(loan["interestRate"] as num).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
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
                      Row(
                        children: [
                          Text(
                            "Next payment due: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(loan["dueDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: loan["status"] == "Overdue" ? dangerColor : primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${loan["termRemaining"]} remaining",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: loan["status"] == "Overdue" ? "Pay Now (Overdue)" : "Make Payment",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo(PayLoanView(loan));
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.auto_awesome,
                            size: bs.sm,
                            onPressed: () {
                              // Setup auto-pay
                            },
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // Show options
                            },
                          ),
                        ],
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 32,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Loan Paid Off!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Congratulations on completing your ${loan["loanType"].toLowerCase()}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),

            // Recent Payments
            if (paymentHistory.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
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
                          child: Text(
                            "Recent Payments",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigateTo(LoanPaymentHistoryView());
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...paymentHistory.take(3).map((payment) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${payment["lender"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${payment["loanType"]} • ${DateTime.parse(payment["date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(payment["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            // Tools
            Container(
              width: double.infinity,
              child: QButton(
                label: "Loan Calculator",
                icon: Icons.calculate,
                onPressed: () {
                  // navigateTo(LoanCalculatorView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
