import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaBankAccountsView extends StatefulWidget {
  const AbaBankAccountsView({super.key});

  @override
  State<AbaBankAccountsView> createState() => _AbaBankAccountsViewState();
}

class _AbaBankAccountsViewState extends State<AbaBankAccountsView> {
  String searchQuery = "";
  String selectedBank = "";
  String sortBy = "name";
  String selectedFilter = "all";

  List<Map<String, dynamic>> bankItems = [
    {"label": "All Banks", "value": ""},
    {"label": "Chase Bank", "value": "chase"},
    {"label": "Wells Fargo", "value": "wells_fargo"},
    {"label": "Bank of America", "value": "boa"},
    {"label": "Citibank", "value": "citibank"},
    {"label": "TD Bank", "value": "td_bank"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Account Name", "value": "name"},
    {"label": "Balance (High to Low)", "value": "balance_desc"},
    {"label": "Balance (Low to High)", "value": "balance_asc"},
    {"label": "Bank Name", "value": "bank"},
    {"label": "Recently Added", "value": "date_desc"},
  ];

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Accounts", "value": "all"},
    {"label": "Active Only", "value": "active"},
    {"label": "Inactive Only", "value": "inactive"},
    {"label": "High Balance", "value": "high_balance"},
  ];

  List<Map<String, dynamic>> bankAccounts = [
    {
      "id": "1",
      "accountName": "Primary Business Checking",
      "accountNumber": "****1234",
      "fullAccountNumber": "1234567890123456",
      "bankName": "Chase Bank",
      "accountType": "Business Checking",
      "balance": 45750.30,
      "currency": "USD",
      "isActive": true,
      "lastTransaction": "2024-12-15",
      "branchCode": "CHB001",
      "routingNumber": "021000021",
      "interestRate": 0.35,
      "minimumBalance": 1000.00,
      "monthlyFee": 15.00,
      "dateOpened": "2023-05-15",
      "accountManager": "Sarah Johnson",
      "managerPhone": "(555) 123-4567",
    },
    {
      "id": "2", 
      "accountName": "Emergency Reserve Fund",
      "accountNumber": "****5678",
      "fullAccountNumber": "5678901234567890",
      "bankName": "Wells Fargo",
      "accountType": "High-Yield Savings",
      "balance": 125000.00,
      "currency": "USD",
      "isActive": true,
      "lastTransaction": "2024-12-14",
      "branchCode": "WF002",
      "routingNumber": "121000248",
      "interestRate": 4.25,
      "minimumBalance": 10000.00,
      "monthlyFee": 0.00,
      "dateOpened": "2023-08-22",
      "accountManager": "Michael Chen",
      "managerPhone": "(555) 234-5678",
    },
    {
      "id": "3",
      "accountName": "Payroll Distribution Account",
      "accountNumber": "****9012", 
      "fullAccountNumber": "9012345678901234",
      "bankName": "Bank of America",
      "accountType": "Business Checking",
      "balance": 67890.45,
      "currency": "USD",
      "isActive": true,
      "lastTransaction": "2024-12-16",
      "branchCode": "BOA003",
      "routingNumber": "111000025",
      "interestRate": 0.15,
      "minimumBalance": 5000.00,
      "monthlyFee": 25.00,
      "dateOpened": "2023-03-10",
      "accountManager": "Lisa Rodriguez",
      "managerPhone": "(555) 345-6789",
    },
    {
      "id": "4",
      "accountName": "Tax Escrow Account",
      "accountNumber": "****3456",
      "fullAccountNumber": "3456789012345678",
      "bankName": "Citibank",
      "accountType": "Money Market",
      "balance": 38500.75,
      "currency": "USD",
      "isActive": true,
      "lastTransaction": "2024-12-13",
      "branchCode": "CITI004",
      "routingNumber": "021000089",
      "interestRate": 3.15,
      "minimumBalance": 2500.00,
      "monthlyFee": 0.00,
      "dateOpened": "2023-09-05",
      "accountManager": "David Kim",
      "managerPhone": "(555) 456-7890",
    },
    {
      "id": "5",
      "accountName": "Investment Holding Account",
      "accountNumber": "****7890",
      "fullAccountNumber": "7890123456789012",
      "bankName": "TD Bank", 
      "accountType": "Premium Checking",
      "balance": 92300.00,
      "currency": "USD",
      "isActive": true,
      "lastTransaction": "2024-12-12",
      "branchCode": "TD005",
      "routingNumber": "211370545",
      "interestRate": 0.75,
      "minimumBalance": 25000.00,
      "monthlyFee": 30.00,
      "dateOpened": "2023-11-20",
      "accountManager": "Jennifer Lee",
      "managerPhone": "(555) 567-8901",
    },
    {
      "id": "6",
      "accountName": "Petty Cash Account",
      "accountNumber": "****2468",
      "fullAccountNumber": "2468135797531086",
      "bankName": "Chase Bank",
      "accountType": "Basic Checking",
      "balance": 2500.00,
      "currency": "USD",
      "isActive": false,
      "lastTransaction": "2024-11-28",
      "branchCode": "CHB006",
      "routingNumber": "021000021",
      "interestRate": 0.05,
      "minimumBalance": 100.00,
      "monthlyFee": 12.00,
      "dateOpened": "2023-01-15",
      "accountManager": "Sarah Johnson",
      "managerPhone": "(555) 123-4567",
    },
  ];

  List<Map<String, dynamic>> get filteredAccounts {
    var filtered = bankAccounts.where((account) {
      final matchesSearch = searchQuery.isEmpty ||
          (account["accountName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (account["accountNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (account["bankName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (account["accountType"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesBank = selectedBank.isEmpty || 
          (account["bankName"] as String).toLowerCase().contains(selectedBank.replaceAll("_", " "));
      
      bool matchesFilter = true;
      switch (selectedFilter) {
        case "active":
          matchesFilter = account["isActive"] as bool;
          break;
        case "inactive":
          matchesFilter = !(account["isActive"] as bool);
          break;
        case "high_balance":
          matchesFilter = (account["balance"] as double) > 50000;
          break;
        default:
          matchesFilter = true;
      }
      
      return matchesSearch && matchesBank && matchesFilter;
    }).toList();

    switch (sortBy) {
      case "balance_desc":
        filtered.sort((a, b) => (b["balance"] as double).compareTo(a["balance"] as double));
        break;
      case "balance_asc":
        filtered.sort((a, b) => (a["balance"] as double).compareTo(b["balance"] as double));
        break;
      case "bank":
        filtered.sort((a, b) => (a["bankName"] as String).compareTo(b["bankName"] as String));
        break;
      case "date_desc":
        filtered.sort((a, b) => DateTime.parse(b["dateOpened"]).compareTo(DateTime.parse(a["dateOpened"])));
        break;
      default:
        filtered.sort((a, b) => (a["accountName"] as String).compareTo(b["accountName"] as String));
    }

    return filtered;
  }

  double get totalBalance {
    return bankAccounts
        .where((account) => account["isActive"] as bool)
        .fold(0.0, (sum, account) => sum + (account["balance"] as double));
  }

  int get activeAccountsCount {
    return bankAccounts.where((account) => account["isActive"] as bool).length;
  }

  Color _getAccountTypeColor(String accountType) {
    switch (accountType.toLowerCase()) {
      case 'business checking':
        return primaryColor;
      case 'high-yield savings':
        return successColor;
      case 'money market':
        return infoColor;
      case 'premium checking':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Accounts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add account
            },
          ),
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              ss("Account balances synchronized");
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
            // Summary Cards
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
                        "Total Bank Balance",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(230),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white.withAlpha(230),
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "\$${totalBalance.currency}",
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "$activeAccountsCount Active",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
                          "${bankAccounts.length} Total",
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
                          label: "Search accounts",
                          value: searchQuery,
                          hint: "Search by name, number, bank, or type",
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
                          label: "Filter by Bank",
                          items: bankItems,
                          value: selectedBank,
                          onChanged: (value, label) {
                            selectedBank = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter Type",
                          items: filterItems,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Sort by",
                    items: sortItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
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
                          Icons.trending_up,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Avg Interest",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${(bankAccounts.map((a) => a["interestRate"] as double).reduce((a, b) => a + b) / bankAccounts.length).toStringAsFixed(2)}%",
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
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_balance,
                          color: infoColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Banks",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${bankAccounts.map((a) => a["bankName"]).toSet().length}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
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
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Monthly Fees",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${bankAccounts.where((a) => a["isActive"] as bool).map((a) => a["monthlyFee"] as double).reduce((a, b) => a + b).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Accounts Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bank Accounts (${filteredAccounts.length})",
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
                    // Navigate to add account
                  },
                ),
              ],
            ),

            // Accounts List
            ...filteredAccounts.map((account) {
              final isActive = account["isActive"] as bool;
              final balance = account["balance"] as double;
              final interestRate = account["interestRate"] as double;
              final monthlyFee = account["monthlyFee"] as double;
              final accountType = account["accountType"] as String;
              final typeColor = _getAccountTypeColor(accountType);
              
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
                              color: typeColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.account_balance,
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
                                      "${account["bankName"]}",
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
                                    color: typeColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    accountType,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: typeColor,
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
                                "\$${balance.currency}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isActive ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${account["currency"]}",
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
                          // Account Details Grid
                          Row(
                            children: [
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
                                      "Monthly Fee",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "\$${monthlyFee.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: monthlyFee > 0 ? warningColor : successColor,
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
                                      "Last Activity",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse(account["lastTransaction"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          // Account Manager Info
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
                                  Icons.person,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Account Manager",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${account["accountManager"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${account["managerPhone"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
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
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to account details
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Transactions",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to transactions
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

            // Add Account Button at Bottom
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Bank Account",
                icon: Icons.add,
                size: bs.md,
                onPressed: () {
                  // Navigate to add account
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
