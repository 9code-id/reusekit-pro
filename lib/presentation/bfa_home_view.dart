import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaHomeView extends StatefulWidget {
  const BfaHomeView({super.key});

  @override
  State<BfaHomeView> createState() => _BfaHomeViewState();
}

class _BfaHomeViewState extends State<BfaHomeView> {
  int currentIndex = 0;
  bool showBalance = true;
  
  Map<String, dynamic> userAccount = {
    "name": "John Doe",
    "accountNumber": "****1234",
    "balance": 2847.50,
    "availableBalance": 2847.50,
    "accountType": "Premium Checking",
    "avatar": "https://picsum.photos/100/100?random=1"
  };

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "txn001",
      "type": "credit",
      "description": "Salary Deposit - ABC Corp",
      "amount": 3500.00,
      "date": "2024-03-15T09:30:00Z",
      "balance": 2847.50,
      "category": "Income",
      "status": "completed"
    },
    {
      "id": "txn002", 
      "type": "debit",
      "description": "Grocery Store - Fresh Market",
      "amount": 89.45,
      "date": "2024-03-14T14:20:00Z",
      "balance": 2758.05,
      "category": "Groceries",
      "status": "completed"
    },
    {
      "id": "txn003",
      "type": "debit",
      "description": "Gas Station - Shell",
      "amount": 45.20,
      "date": "2024-03-14T08:15:00Z",
      "balance": 2712.85,
      "category": "Transportation",
      "status": "completed"
    },
    {
      "id": "txn004",
      "type": "debit",
      "description": "Online Transfer - Jane Smith",
      "amount": 250.00,
      "date": "2024-03-13T16:45:00Z",
      "balance": 2667.65,
      "category": "Transfer",
      "status": "pending"
    }
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Transfer Money",
      "icon": Icons.send,
      "color": Colors.blue,
      "route": "transfer"
    },
    {
      "title": "Pay Bills",
      "icon": Icons.receipt,
      "color": Colors.green,
      "route": "bills"
    },
    {
      "title": "Deposit Check",
      "icon": Icons.camera_alt,
      "color": Colors.orange,
      "route": "deposit"
    },
    {
      "title": "ATM Locator",
      "icon": Icons.location_on,
      "color": Colors.red,
      "route": "atm"
    }
  ];

  List<Map<String, dynamic>> bankingServices = [
    {
      "title": "Credit Cards",
      "subtitle": "Apply for a new card",
      "icon": Icons.credit_card,
      "badge": "New",
      "color": Colors.purple
    },
    {
      "title": "Personal Loans",
      "subtitle": "Quick approval",
      "icon": Icons.attach_money,
      "badge": null,
      "color": Colors.teal
    },
    {
      "title": "Investment",
      "subtitle": "Start investing today",
      "icon": Icons.trending_up,
      "badge": "Popular",
      "color": Colors.indigo
    },
    {
      "title": "Insurance",
      "subtitle": "Protect what matters",
      "icon": Icons.security,
      "badge": null,
      "color": Colors.brown
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "BFA Digital Banking",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: "Accounts",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz),
          label: "Transfer",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: "Bills",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: "More",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildAccountsTab(),
        _buildTransferTab(),
        _buildBillsTab(),
        _buildMoreTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Welcome Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(userAccount["avatar"]),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "${userAccount["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _toggleBalanceVisibility(),
                      child: Icon(
                        showBalance ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Account Balance Card
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${userAccount["accountType"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "Account ${userAccount["accountNumber"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Available Balance",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                              Text(
                                showBalance 
                                    ? "\$${(userAccount["availableBalance"] as double).currency}"
                                    : "****",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              currentIndex = 1;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 120,
                  children: quickActions.map((action) => _buildQuickActionCard(action)).toList(),
                ),
              ],
            ),
          ),

          // Recent Transactions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to all transactions
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
                ...recentTransactions.take(3).map((transaction) => _buildTransactionItem(transaction)),
              ],
            ),
          ),

          // Banking Services
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Banking Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Discover our financial products and services",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                ...bankingServices.map((service) => _buildServiceCard(service)),
              ],
            ),
          ),

          // Security Notice
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.security, color: successColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your account is secure",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "We use bank-level encryption to protect your data",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Account Details",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          // Account details content would go here
        ],
      ),
    );
  }

  Widget _buildTransferTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Transfer Money",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          // Transfer functionality would go here
        ],
      ),
    );
  }

  Widget _buildBillsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Pay Bills",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          // Bill payment functionality would go here
        ],
      ),
    );
  }

  Widget _buildMoreTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "More Options",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          // Additional options would go here
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: (action["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (action["color"] as Color).withAlpha(50)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusSm),
          onTap: () => _handleQuickAction(action["route"]),
          child: Column(
            spacing: spSm,
            children: [
              Icon(
                action["icon"] as IconData,
                size: 32,
                color: action["color"] as Color,
              ),
              Text(
                "${action["title"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: action["color"] as Color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    bool isCredit = transaction["type"] == "credit";
    DateTime date = DateTime.parse(transaction["date"]);
    Color amountColor = isCredit ? successColor : dangerColor;
    String amountSign = isCredit ? "+" : "-";
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: amountColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: amountColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${transaction["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${transaction["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  date.dMMMy,
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
            spacing: spXs,
            children: [
              Text(
                "$amountSign\$${(transaction["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: transaction["status"] == "completed" 
                      ? successColor.withAlpha(20) 
                      : warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${transaction["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: transaction["status"] == "completed" 
                        ? successColor 
                        : warningColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusXs),
          onTap: () => _handleServiceTap(service["title"]),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (service["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  service["icon"] as IconData,
                  color: service["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${service["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if (service["badge"] != null) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${service["badge"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${service["subtitle"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Icon(
                Icons.arrow_forward,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleBalanceVisibility() {
    showBalance = !showBalance;
    setState(() {});
  }

  void _handleQuickAction(String route) {
    switch (route) {
      case "transfer":
        currentIndex = 2;
        setState(() {});
        break;
      case "bills":
        currentIndex = 3;
        setState(() {});
        break;
      case "deposit":
        ss("Mobile check deposit feature coming soon");
        break;
      case "atm":
        ss("ATM locator feature coming soon");
        break;
    }
  }

  void _handleServiceTap(String serviceName) {
    switch (serviceName) {
      case "Credit Cards":
        ss("Credit card application coming soon");
        break;
      case "Personal Loans":
        ss("Personal loan application coming soon");
        break;
      case "Investment":
        ss("Investment platform coming soon");
        break;
      case "Insurance":
        ss("Insurance products coming soon");
        break;
    }
  }
}
