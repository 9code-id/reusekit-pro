import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaLoanManagementView extends StatefulWidget {
  const AmaLoanManagementView({super.key});

  @override
  State<AmaLoanManagementView> createState() => _AmaLoanManagementViewState();
}

class _AmaLoanManagementViewState extends State<AmaLoanManagementView> {
  String selectedLoanType = "All Types";
  String selectedStatus = "All Status";
  String loanPurpose = "";
  String loanAmount = "";
  String interestRate = "";
  String loanTerm = "";
  String lender = "";
  String collateral = "";
  DateTime applicationDate = DateTime.now();
  
  bool showApplyForm = false;

  List<Map<String, dynamic>> loanTypeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Equipment Loan", "value": "Equipment Loan"},
    {"label": "Land Purchase", "value": "Land Purchase"},
    {"label": "Operating Loan", "value": "Operating Loan"},
    {"label": "Crop Insurance", "value": "Crop Insurance"},
    {"label": "Expansion Loan", "value": "Expansion Loan"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Paid Off", "value": "Paid Off"},
  ];

  List<Map<String, dynamic>> termOptions = [
    {"label": "6 months", "value": "6"},
    {"label": "1 year", "value": "12"},
    {"label": "2 years", "value": "24"},
    {"label": "3 years", "value": "36"},
    {"label": "5 years", "value": "60"},
    {"label": "7 years", "value": "84"},
    {"label": "10 years", "value": "120"},
  ];

  List<Map<String, dynamic>> loans = [
    {
      "id": "LN001",
      "purpose": "Tractor Purchase",
      "type": "Equipment Loan",
      "amount": 85000.0,
      "remaining": 62500.0,
      "interestRate": 4.5,
      "monthlyPayment": 1850.0,
      "startDate": "2022-03-15",
      "endDate": "2027-03-15",
      "lender": "Farm Credit Bank",
      "status": "Active",
      "nextPayment": "2024-07-15",
      "collateral": "John Deere 8370R Tractor",
    },
    {
      "id": "LN002",
      "purpose": "Land Expansion",
      "type": "Land Purchase",
      "amount": 250000.0,
      "remaining": 195000.0,
      "interestRate": 3.8,
      "monthlyPayment": 2750.0,
      "startDate": "2021-08-10",
      "endDate": "2031-08-10",
      "lender": "Agricultural Bank",
      "status": "Active",
      "nextPayment": "2024-07-10",
      "collateral": "40 acres farmland",
    },
    {
      "id": "LN003",
      "purpose": "Operating Capital",
      "type": "Operating Loan",
      "amount": 45000.0,
      "remaining": 12000.0,
      "interestRate": 5.2,
      "monthlyPayment": 950.0,
      "startDate": "2023-01-20",
      "endDate": "2025-01-20",
      "lender": "Local Credit Union",
      "status": "Active",
      "nextPayment": "2024-07-20",
      "collateral": "Equipment & Inventory",
    },
    {
      "id": "LN004",
      "purpose": "Irrigation System",
      "type": "Equipment Loan",
      "amount": 35000.0,
      "remaining": 0.0,
      "interestRate": 4.0,
      "monthlyPayment": 0.0,
      "startDate": "2019-05-12",
      "endDate": "2024-05-12",
      "lender": "Equipment Finance Corp",
      "status": "Paid Off",
      "nextPayment": "",
      "collateral": "Irrigation System",
    },
    {
      "id": "LN005",
      "purpose": "Grain Storage Facility",
      "type": "Expansion Loan",
      "amount": 120000.0,
      "remaining": 0.0,
      "interestRate": 0.0,
      "monthlyPayment": 0.0,
      "startDate": "",
      "endDate": "",
      "lender": "Farm Development Bank",
      "status": "Pending",
      "nextPayment": "",
      "collateral": "Proposed Grain Storage",
    },
  ];

  List<Map<String, dynamic>> loanProviders = [
    {
      "name": "Farm Credit Bank",
      "type": "Federal Credit",
      "interestRate": "3.5% - 6.2%",
      "specialties": ["Equipment", "Land", "Operating"],
      "rating": 4.8,
      "phone": "(555) 123-4567",
    },
    {
      "name": "Agricultural Bank",
      "type": "Commercial Bank",
      "interestRate": "3.8% - 7.1%",
      "specialties": ["Land Purchase", "Expansion"],
      "rating": 4.6,
      "phone": "(555) 234-5678",
    },
    {
      "name": "Local Credit Union",
      "type": "Credit Union",
      "interestRate": "4.2% - 6.8%",
      "specialties": ["Operating", "Small Equipment"],
      "rating": 4.7,
      "phone": "(555) 345-6789",
    },
    {
      "name": "USDA Rural Development",
      "type": "Government",
      "interestRate": "2.5% - 4.5%",
      "specialties": ["Beginning Farmers", "Conservation"],
      "rating": 4.9,
      "phone": "(555) 456-7890",
    },
  ];

  List<Map<String, dynamic>> paymentHistory = [
    {"date": "2024-06-15", "loan": "LN001", "amount": 1850.0, "type": "Regular Payment"},
    {"date": "2024-06-10", "loan": "LN002", "amount": 2750.0, "type": "Regular Payment"},
    {"date": "2024-06-20", "loan": "LN003", "amount": 950.0, "type": "Regular Payment"},
    {"date": "2024-05-15", "loan": "LN001", "amount": 1850.0, "type": "Regular Payment"},
    {"date": "2024-05-12", "loan": "LN004", "amount": 35000.0, "type": "Final Payment"},
  ];

  double get totalLoanAmount => loans.where((loan) => loan["status"] == "Active").fold(0.0, (sum, loan) => sum + (loan["amount"] as double));
  double get totalRemaining => loans.where((loan) => loan["status"] == "Active").fold(0.0, (sum, loan) => sum + (loan["remaining"] as double));
  double get monthlyPayments => loans.where((loan) => loan["status"] == "Active").fold(0.0, (sum, loan) => sum + (loan["monthlyPayment"] as double));
  
  List<Map<String, dynamic>> get filteredLoans {
    return loans.where((loan) {
      bool typeMatch = selectedLoanType == "All Types" || loan["type"] == selectedLoanType;
      bool statusMatch = selectedStatus == "All Status" || loan["status"] == selectedStatus;
      return typeMatch && statusMatch;
    }).toList();
  }

  void _applyForLoan() {
    if (loanPurpose.isNotEmpty && loanAmount.isNotEmpty) {
      // Add loan application logic
      loanPurpose = "";
      loanAmount = "";
      interestRate = "";
      loanTerm = "";
      lender = "";
      collateral = "";
      showApplyForm = false;
      
      setState(() {});
      ss("Loan application submitted successfully");
    } else {
      se("Please fill in required fields");
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Approved":
        return infoColor;
      case "Rejected":
        return dangerColor;
      case "Paid Off":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              //navigateTo('AmaLoanCalculatorView')
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo('AmaPaymentHistoryView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Loan Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(128)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Loan Portfolio",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.account_balance,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Manage your farm loans and financing",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(204),
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
                              "Total Borrowed",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${totalLoanAmount.currency}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
                              "Remaining",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(204),
                              ),
                            ),
                            Text(
                              "\$${totalRemaining.currency}",
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
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Monthly Payments: \$${monthlyPayments.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(204),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Apply for Loan",
                    icon: Icons.add,
                    size: bs.md,
                    onPressed: () {
                      showApplyForm = true;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Find Lenders",
                    icon: Icons.search,
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('AmaLenderDirectoryView')
                    },
                  ),
                ),
              ],
            ),

            // Apply for Loan Form
            if (showApplyForm) ...[
              Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Apply for Loan",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showApplyForm = false;
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Loan Purpose",
                      value: loanPurpose,
                      hint: "e.g. Equipment Purchase, Land Expansion",
                      onChanged: (value) {
                        loanPurpose = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Loan Amount (\$)",
                            value: loanAmount,
                            onChanged: (value) {
                              loanAmount = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Loan Term",
                            items: termOptions,
                            value: loanTerm,
                            onChanged: (value, label) {
                              loanTerm = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Expected Interest Rate (%)",
                            value: interestRate,
                            onChanged: (value) {
                              interestRate = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Application Date",
                            value: applicationDate,
                            onChanged: (value) {
                              applicationDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Preferred Lender",
                      value: lender,
                      hint: "Bank or financial institution",
                      onChanged: (value) {
                        lender = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Collateral",
                      value: collateral,
                      hint: "Asset to secure the loan",
                      onChanged: (value) {
                        collateral = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Cancel",
                            onPressed: () {
                              showApplyForm = false;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Apply",
                            onPressed: _applyForLoan,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Loan Type",
                    items: loanTypeOptions,
                    value: selectedLoanType,
                    onChanged: (value, label) {
                      selectedLoanType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Loan Statistics
            ResponsiveGridView(
              padding: EdgeInsets.all(spSm),
              minItemWidth: 200,
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
                      Row(
                        children: [
                          Icon(Icons.account_balance, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Active Loans",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${loans.where((loan) => loan["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Currently active",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.payment, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Monthly Payment",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "\$${monthlyPayments.currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Total monthly",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Row(
                        children: [
                          Icon(Icons.trending_down, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Paid Off Loans",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${loans.where((loan) => loan["status"] == "Paid Off").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Completed loans",
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

            // Loan List
            Text(
              "Your Loans",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: filteredLoans.map((loan) {
                  Color statusColor = _getStatusColor(loan["status"] as String);
                  double progress = loan["status"] == "Active" 
                      ? ((loan["amount"] as double) - (loan["remaining"] as double)) / (loan["amount"] as double)
                      : loan["status"] == "Paid Off" ? 1.0 : 0.0;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.account_balance,
                                color: statusColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${loan["purpose"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusColor.withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${loan["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: statusColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${loan["type"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${loan["id"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (loan["status"] == "Active") ...[
                          SizedBox(height: spSm),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount: \$${((loan["amount"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (loan["status"] == "Active")
                                  Text(
                                    "Remaining: \$${((loan["remaining"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${loan["lender"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (loan["status"] == "Active")
                                  Text(
                                    "Payment: \$${((loan["monthlyPayment"] as double)).currency}/mo",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        if (loan["nextPayment"] != null && (loan["nextPayment"] as String).isNotEmpty) ...[
                          SizedBox(height: spXs),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.schedule, color: warningColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "Next payment due: ${loan["nextPayment"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
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
              ),
            ),

            // Loan Providers
            Text(
              "Recommended Lenders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: loanProviders.map((provider) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.business,
                                color: primaryColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${provider["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${provider["type"]} • ${provider["interestRate"]}",
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
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      "${provider["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${provider["phone"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Text(
                              "Specialties: ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                (provider["specialties"] as List<String>).join(", "),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
            ),

            // Recent Payment History
            Text(
              "Recent Payments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: paymentHistory.take(5).map((payment) {
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.payment,
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
                              "${payment["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Loan ${payment["loan"]} • ${payment["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${((payment["amount"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
