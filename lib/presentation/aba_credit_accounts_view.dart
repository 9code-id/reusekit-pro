import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaCreditAccountsView extends StatefulWidget {
  const AbaCreditAccountsView({super.key});

  @override
  State<AbaCreditAccountsView> createState() => _AbaCreditAccountsViewState();
}

class _AbaCreditAccountsViewState extends State<AbaCreditAccountsView> {
  String searchQuery = "";
  String selectedType = "";
  String sortBy = "name";

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": ""},
    {"label": "Credit Cards", "value": "credit_card"},
    {"label": "Line of Credit", "value": "line_of_credit"},
    {"label": "Business Credit", "value": "business_credit"},
    {"label": "Equipment Financing", "value": "equipment"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Account Name", "value": "name"},
    {"label": "Credit Limit (High to Low)", "value": "limit_desc"},
    {"label": "Available Credit", "value": "available_desc"},
    {"label": "Balance (High to Low)", "value": "balance_desc"},
    {"label": "Interest Rate", "value": "rate_asc"},
  ];

  List<Map<String, dynamic>> creditAccounts = [
    {
      "id": "1",
      "accountName": "Business Platinum Card",
      "accountNumber": "****4567",
      "fullAccountNumber": "4567890123456789",
      "issuer": "Chase Bank",
      "accountType": "Business Credit Card",
      "creditLimit": 50000.00,
      "currentBalance": 8750.25,
      "availableCredit": 41249.75,
      "interestRate": 18.99,
      "minimumPayment": 350.00,
      "dueDate": "2024-12-28",
      "lastPayment": "2024-11-15",
      "lastPaymentAmount": 1250.00,
      "isActive": true,
      "rewardsProgram": "Ultimate Rewards",
      "rewardsBalance": 12500,
      "currency": "USD",
    },
    {
      "id": "2",
      "accountName": "Equipment Line of Credit",
      "accountNumber": "****8901",
      "fullAccountNumber": "8901234567890123",
      "issuer": "Wells Fargo",
      "accountType": "Line of Credit",
      "creditLimit": 150000.00,
      "currentBalance": 45000.00,
      "availableCredit": 105000.00,
      "interestRate": 12.50,
      "minimumPayment": 900.00,
      "dueDate": "2024-12-20",
      "lastPayment": "2024-11-20",
      "lastPaymentAmount": 5000.00,
      "isActive": true,
      "rewardsProgram": "",
      "rewardsBalance": 0,
      "currency": "USD",
    },
    {
      "id": "3",
      "accountName": "Corporate Travel Card",
      "accountNumber": "****2345",
      "fullAccountNumber": "2345678901234567",
      "issuer": "American Express",
      "accountType": "Business Credit Card",
      "creditLimit": 25000.00,
      "currentBalance": 3250.80,
      "availableCredit": 21749.20,
      "interestRate": 16.24,
      "minimumPayment": 130.00,
      "dueDate": "2024-12-25",
      "lastPayment": "2024-11-18",
      "lastPaymentAmount": 2100.00,
      "isActive": true,
      "rewardsProgram": "Membership Rewards",
      "rewardsBalance": 8750,
      "currency": "USD",
    },
    {
      "id": "4",
      "accountName": "Working Capital Credit",
      "accountNumber": "****6789",
      "fullAccountNumber": "6789012345678901",
      "issuer": "Bank of America",
      "accountType": "Business Line of Credit",
      "creditLimit": 75000.00,
      "currentBalance": 22500.00,
      "availableCredit": 52500.00,
      "interestRate": 8.75,
      "minimumPayment": 450.00,
      "dueDate": "2024-12-30",
      "lastPayment": "2024-11-22",
      "lastPaymentAmount": 7500.00,
      "isActive": true,
      "rewardsProgram": "",
      "rewardsBalance": 0,
      "currency": "USD",
    },
    {
      "id": "5",
      "accountName": "Fleet Fuel Card",
      "accountNumber": "****0123",
      "fullAccountNumber": "0123456789012345",
      "issuer": "Shell Business",
      "accountType": "Fleet Credit Card",
      "creditLimit": 15000.00,
      "currentBalance": 4850.60,
      "availableCredit": 10149.40,
      "interestRate": 21.99,
      "minimumPayment": 194.00,
      "dueDate": "2024-12-22",
      "lastPayment": "2024-11-10",
      "lastPaymentAmount": 850.00,
      "isActive": true,
      "rewardsProgram": "Shell Rewards",
      "rewardsBalance": 550,
      "currency": "USD",
    },
    {
      "id": "6",
      "accountName": "Emergency Credit Line",
      "accountNumber": "****4567",
      "fullAccountNumber": "4567890123456789",
      "issuer": "Citibank",
      "accountType": "Line of Credit",
      "creditLimit": 100000.00,
      "currentBalance": 0.00,
      "availableCredit": 100000.00,
      "interestRate": 9.99,
      "minimumPayment": 0.00,
      "dueDate": "",
      "lastPayment": "2024-09-15",
      "lastPaymentAmount": 25000.00,
      "isActive": false,
      "rewardsProgram": "",
      "rewardsBalance": 0,
      "currency": "USD",
    },
  ];

  List<Map<String, dynamic>> get filteredAccounts {
    var filtered = creditAccounts.where((account) {
      final matchesSearch = searchQuery.isEmpty ||
          (account["accountName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (account["accountNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (account["issuer"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (account["accountType"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesType = selectedType.isEmpty ||
          (account["accountType"] as String).toLowerCase().contains(selectedType.replaceAll("_", " "));
      
      return matchesSearch && matchesType;
    }).toList();

    switch (sortBy) {
      case "limit_desc":
        filtered.sort((a, b) => (b["creditLimit"] as double).compareTo(a["creditLimit"] as double));
        break;
      case "available_desc":
        filtered.sort((a, b) => (b["availableCredit"] as double).compareTo(a["availableCredit"] as double));
        break;
      case "balance_desc":
        filtered.sort((a, b) => (b["currentBalance"] as double).compareTo(a["currentBalance"] as double));
        break;
      case "rate_asc":
        filtered.sort((a, b) => (a["interestRate"] as double).compareTo(b["interestRate"] as double));
        break;
      default:
        filtered.sort((a, b) => (a["accountName"] as String).compareTo(b["accountName"] as String));
    }

    return filtered;
  }

  double get totalCreditLimit {
    return creditAccounts
        .where((account) => account["isActive"] as bool)
        .fold(0.0, (sum, account) => sum + (account["creditLimit"] as double));
  }

  double get totalBalance {
    return creditAccounts
        .where((account) => account["isActive"] as bool)
        .fold(0.0, (sum, account) => sum + (account["currentBalance"] as double));
  }

  double get totalAvailable {
    return creditAccounts
        .where((account) => account["isActive"] as bool)
        .fold(0.0, (sum, account) => sum + (account["availableCredit"] as double));
  }

  double get utilizationRate {
    if (totalCreditLimit == 0) return 0;
    return (totalBalance / totalCreditLimit) * 100;
  }

  Color _getUtilizationColor(double utilization) {
    if (utilization < 30) return successColor;
    if (utilization < 70) return warningColor;
    return dangerColor;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credit Accounts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add credit account
            },
          ),
          IconButton(
            icon: Icon(Icons.payment),
            onPressed: () {
              // Navigate to make payments
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Credit Summary Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Credit Available",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(230),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.credit_card,
                        color: Colors.white.withAlpha(230),
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "\$${totalAvailable.currency}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Utilization: ${utilizationRate.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "\$${totalCreditLimit.currency} Limit",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${totalAvailable.currency}",
                          style: TextStyle(
                            fontSize: 16,
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: dangerColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.payment,
                          color: dangerColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Balance",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${totalBalance.currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
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
                      color: _getUtilizationColor(utilizationRate).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: _getUtilizationColor(utilizationRate).withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.donut_large,
                          color: _getUtilizationColor(utilizationRate),
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Utilization",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getUtilizationColor(utilizationRate),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${utilizationRate.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getUtilizationColor(utilizationRate),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search credit accounts",
                          value: searchQuery,
                          hint: "Search by name, number, issuer, or type",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Type",
                          items: typeItems,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: sortItems,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Accounts Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Credit Accounts (${filteredAccounts.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Add Account",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to add credit account
                  },
                ),
              ],
            ),

            // Credit Accounts List
            ...filteredAccounts.map((account) {
              final isActive = account["isActive"] as bool;
              final currentBalance = account["currentBalance"] as double;
              final creditLimit = account["creditLimit"] as double;
              final availableCredit = account["availableCredit"] as double;
              final interestRate = account["interestRate"] as double;
              final minimumPayment = account["minimumPayment"] as double;
              final utilization = creditLimit > 0 ? (currentBalance / creditLimit) * 100 : 0.0;
              final utilizationColor = _getUtilizationColor(utilization);
              final rewardsProgram = account["rewardsProgram"] as String;
              final rewardsBalance = account["rewardsBalance"] as int;
              
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isActive ? primaryColor.withAlpha(30) : disabledOutlineBorderColor,
                    width: isActive ? 2 : 1,
                  ),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    // Header Section
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isActive ? primaryColor.withAlpha(10) : disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isActive ? primaryColor : disabledBoldColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.credit_card,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${account["accountName"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: isActive ? successColor : dangerColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        isActive ? "Active" : "Inactive",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${account["issuer"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      " • ${account["accountNumber"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: utilizationColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${account["accountType"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: utilizationColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${currentBalance.currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "of \$${creditLimit.currency}",
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

                    // Details Section
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        spacing: spMd,
                        children: [
                          // Credit Utilization Bar
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Credit Utilization",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${utilization.toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: utilizationColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: utilization / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: utilizationColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Account Details Grid
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Available Credit",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "\$${availableCredit.currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: successColor,
                                        fontWeight: FontWeight.bold,
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
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${interestRate.toStringAsFixed(2)}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: warningColor,
                                        fontWeight: FontWeight.bold,
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
                                      "Min Payment",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "\$${minimumPayment.currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dangerColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Rewards Program (if available)
                          if (rewardsProgram.isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: infoColor.withAlpha(30)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: infoColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          rewardsProgram,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${rewardsBalance.toString().currency} points available",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: infoColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Payment Info
                          if (account["dueDate"] != "")
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: warningColor.withAlpha(30)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: warningColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payment Due",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: warningColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${DateTime.parse(account["dueDate"]).dMMMy} - \$${minimumPayment.currency}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: warningColor,
                                          ),
                                        ),
                                      ],
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
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to payment
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to account details
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show more options
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Add Credit Account Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Credit Account",
                icon: Icons.add,
                size: bs.md,
                onPressed: () {
                  // Navigate to add credit account
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

