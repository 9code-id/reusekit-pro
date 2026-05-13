import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaEquityAccountsView extends StatefulWidget {
  const AbaEquityAccountsView({super.key});

  @override
  State<AbaEquityAccountsView> createState() => _AbaEquityAccountsViewState();
}

class _AbaEquityAccountsViewState extends State<AbaEquityAccountsView> {
  String searchQuery = "";
  String selectedCategory = "";
  String sortBy = "balance";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": ""},
    {"label": "Owner's Equity", "value": "owners_equity"},
    {"label": "Retained Earnings", "value": "retained_earnings"},
    {"label": "Capital Contributions", "value": "capital_contributions"},
    {"label": "Common Stock", "value": "common_stock"},
    {"label": "Treasury Stock", "value": "treasury_stock"},
    {"label": "Other Equity", "value": "other"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Balance (High to Low)", "value": "balance"},
    {"label": "Balance (Low to High)", "value": "balance_asc"},
    {"label": "Account Name", "value": "name"},
    {"label": "Category", "value": "category"},
    {"label": "Last Modified", "value": "date"},
  ];

  List<Map<String, dynamic>> equityAccounts = [
    {
      "id": "1",
      "accountName": "Owner's Equity - Primary",
      "category": "owners_equity",
      "categoryLabel": "Owner's Equity",
      "currentBalance": 485000.00,
      "openingBalance": 420000.00,
      "netChange": 65000.00,
      "lastModified": "2024-12-15",
      "description": "Primary owner's equity account representing total ownership stake",
      "isActive": true,
      "accountCode": "3000",
      "ytdChange": 65000.00,
      "percentChange": 15.48,
      "transactions": 24,
    },
    {
      "id": "2",
      "accountName": "Retained Earnings - Current Year",
      "category": "retained_earnings",
      "categoryLabel": "Retained Earnings",
      "currentBalance": 125000.00,
      "openingBalance": 95000.00,
      "netChange": 30000.00,
      "lastModified": "2024-12-16",
      "description": "Accumulated earnings retained in the business for current fiscal year",
      "isActive": true,
      "accountCode": "3200",
      "ytdChange": 30000.00,
      "percentChange": 31.58,
      "transactions": 18,
    },
    {
      "id": "3",
      "accountName": "Capital Contributions - Partner A",
      "category": "capital_contributions",
      "categoryLabel": "Capital Contributions",
      "currentBalance": 75000.00,
      "openingBalance": 50000.00,
      "netChange": 25000.00,
      "lastModified": "2024-11-30",
      "description": "Capital contributions made by Partner A during the fiscal year",
      "isActive": true,
      "accountCode": "3100",
      "ytdChange": 25000.00,
      "percentChange": 50.00,
      "transactions": 6,
    },
    {
      "id": "4",
      "accountName": "Common Stock - Authorized Shares",
      "category": "common_stock",
      "categoryLabel": "Common Stock",
      "currentBalance": 100000.00,
      "openingBalance": 100000.00,
      "netChange": 0.00,
      "lastModified": "2024-01-01",
      "description": "Common stock representing authorized shares at par value",
      "isActive": true,
      "accountCode": "3300",
      "ytdChange": 0.00,
      "percentChange": 0.00,
      "transactions": 1,
    },
    {
      "id": "5",
      "accountName": "Additional Paid-in Capital",
      "category": "capital_contributions",
      "categoryLabel": "Capital Contributions",
      "currentBalance": 45000.00,
      "openingBalance": 35000.00,
      "netChange": 10000.00,
      "lastModified": "2024-12-01",
      "description": "Amount received from stockholders in excess of par value",
      "isActive": true,
      "accountCode": "3310",
      "ytdChange": 10000.00,
      "percentChange": 28.57,
      "transactions": 4,
    },
    {
      "id": "6",
      "accountName": "Treasury Stock",
      "category": "treasury_stock",
      "categoryLabel": "Treasury Stock",
      "currentBalance": -15000.00,
      "openingBalance": -10000.00,
      "netChange": -5000.00,
      "lastModified": "2024-10-15",
      "description": "Company's own stock repurchased and held in treasury",
      "isActive": true,
      "accountCode": "3400",
      "ytdChange": -5000.00,
      "percentChange": 50.00,
      "transactions": 2,
    },
  ];

  List<Map<String, dynamic>> get filteredEquity {
    var filtered = equityAccounts.where((equity) {
      final matchesSearch = searchQuery.isEmpty ||
          (equity["accountName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (equity["categoryLabel"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (equity["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesCategory = selectedCategory.isEmpty || 
          equity["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory && (equity["isActive"] as bool);
    }).toList();

    switch (sortBy) {
      case "balance_asc":
        filtered.sort((a, b) => (a["currentBalance"] as double).compareTo(b["currentBalance"] as double));
        break;
      case "name":
        filtered.sort((a, b) => (a["accountName"] as String).compareTo(b["accountName"] as String));
        break;
      case "category":
        filtered.sort((a, b) => (a["categoryLabel"] as String).compareTo(b["categoryLabel"] as String));
        break;
      case "date":
        filtered.sort((a, b) => DateTime.parse(b["lastModified"]).compareTo(DateTime.parse(a["lastModified"])));
        break;
      default:
        filtered.sort((a, b) => (b["currentBalance"] as double).compareTo(a["currentBalance"] as double));
    }

    return filtered;
  }

  double get totalEquity {
    return equityAccounts
        .where((equity) => equity["isActive"] as bool)
        .fold(0.0, (sum, equity) => sum + (equity["currentBalance"] as double));
  }

  double get totalNetChange {
    return equityAccounts
        .where((equity) => equity["isActive"] as bool)
        .fold(0.0, (sum, equity) => sum + (equity["netChange"] as double));
  }

  double get totalOpeningBalance {
    return equityAccounts
        .where((equity) => equity["isActive"] as bool)
        .fold(0.0, (sum, equity) => sum + (equity["openingBalance"] as double));
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "owners_equity":
        return primaryColor;
      case "retained_earnings":
        return successColor;
      case "capital_contributions":
        return infoColor;
      case "common_stock":
        return warningColor;
      case "treasury_stock":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "owners_equity":
        return Icons.person;
      case "retained_earnings":
        return Icons.savings;
      case "capital_contributions":
        return Icons.trending_up;
      case "common_stock":
        return Icons.share;
      case "treasury_stock":
        return Icons.account_balance;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equity Accounts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add equity account
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          children: [
                            Icon(
                              Icons.account_balance,
                              color: Colors.white.withAlpha(230),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Equity",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${totalEquity.currency}",
                          style: TextStyle(
                            fontSize: 24,
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
                      gradient: LinearGradient(
                        colors: [successColor, successColor.withAlpha(200)],
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
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colors.white.withAlpha(230),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "YTD Change",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${totalNetChange >= 0 ? '+' : ''}\$${totalNetChange.abs().currency}",
                          style: TextStyle(
                            fontSize: 24,
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
            SizedBox(height: spMd),
            
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.insights,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Equity Growth Rate",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((totalNetChange / totalOpeningBalance) * 100).toStringAsFixed(1)}% YTD",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search equity accounts",
                    value: searchQuery,
                    hint: "Search by name or description",
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
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
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
            SizedBox(height: spLg),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Equity Accounts (${filteredEquity.length})",
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
                    // Navigate to add equity account
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            ...filteredEquity.map((equity) {
              final currentBalance = equity["currentBalance"] as double;
              final openingBalance = equity["openingBalance"] as double;
              final netChange = equity["netChange"] as double;
              final percentChange = equity["percentChange"] as double;
              final category = equity["category"] as String;
              final categoryColor = _getCategoryColor(category);
              final categoryIcon = _getCategoryIcon(category);
              final transactions = equity["transactions"] as int;
              final isNegativeBalance = currentBalance < 0;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: categoryColor.withAlpha(100)),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
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
                              color: categoryColor,
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              categoryIcon,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${equity["accountName"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: categoryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${equity["categoryLabel"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Code: ${equity["accountCode"]}",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${isNegativeBalance ? '(' : ''}\$${currentBalance.abs().currency}${isNegativeBalance ? ')' : ''}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isNegativeBalance ? dangerColor : categoryColor,
                                ),
                              ),
                              Text(
                                "${netChange >= 0 ? '+' : ''}${percentChange.toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: netChange >= 0 ? successColor : dangerColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${equity["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
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
                                      "Opening Balance",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "\$${openingBalance.currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
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
                                      "Net Change",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${netChange >= 0 ? '+' : ''}\$${netChange.abs().currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: netChange >= 0 ? successColor : dangerColor,
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
                                      "Transactions",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "$transactions",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
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
                                      "Last Modified",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse(equity["lastModified"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
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
                                child: QButton(
                                  label: "View Transactions",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to transactions
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Edit Account",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to edit account
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
