import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaProfileView extends StatefulWidget {
  const BfaProfileView({super.key});

  @override
  State<BfaProfileView> createState() => _BfaProfileViewState();
}

class _BfaProfileViewState extends State<BfaProfileView> {
  Map<String, dynamic> userProfile = {
    "name": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "phone": "+1 (555) 123-4567",
    "avatar": "https://picsum.photos/120/120?random=1&keyword=woman",
    "memberSince": "2019-03-15",
    "accountType": "Premium",
    "accountNumber": "****1234",
    "totalBalance": 45750.80,
    "creditScore": 785,
    "loyaltyPoints": 2450,
    "status": "verified",
  };

  List<Map<String, dynamic>> accountSummary = [
    {
      "name": "Checking Account",
      "number": "****1234",
      "balance": 15750.50,
      "type": "checking",
      "icon": Icons.account_balance_wallet,
    },
    {
      "name": "Savings Account",
      "number": "****5678",
      "balance": 25000.30,
      "type": "savings",
      "icon": Icons.savings,
    },
    {
      "name": "Credit Card",
      "number": "****9012",
      "balance": -5000.00,
      "type": "credit",
      "icon": Icons.credit_card,
    },
    {
      "name": "Investment",
      "number": "****3456",
      "balance": 10000.00,
      "type": "investment",
      "icon": Icons.trending_up,
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "title": "Grocery Store",
      "amount": -125.50,
      "date": "2024-06-14",
      "category": "Shopping",
      "icon": Icons.shopping_cart,
    },
    {
      "title": "Salary Deposit",
      "amount": 3500.00,
      "date": "2024-06-13",
      "category": "Income",
      "icon": Icons.attach_money,
    },
    {
      "title": "Electric Bill",
      "amount": -89.75,
      "date": "2024-06-12",
      "category": "Utilities",
      "icon": Icons.flash_on,
    },
    {
      "title": "Restaurant",
      "amount": -67.20,
      "date": "2024-06-11",
      "category": "Food",
      "icon": Icons.restaurant,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Transfer Money",
      "subtitle": "Send to anyone",
      "icon": Icons.send,
      "color": primaryColor,
    },
    {
      "title": "Pay Bills",
      "subtitle": "Utility payments",
      "icon": Icons.receipt_long,
      "color": successColor,
    },
    {
      "title": "Deposit Check",
      "subtitle": "Mobile deposit",
      "icon": Icons.photo_camera,
      "color": infoColor,
    },
    {
      "title": "Find ATM",
      "subtitle": "Nearby locations",
      "icon": Icons.location_on,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> profileActions = [
    {
      "title": "Personal Information",
      "subtitle": "Update your details",
      "icon": Icons.person,
      "action": "personal_info",
    },
    {
      "title": "Security Settings",
      "subtitle": "Password & privacy",
      "icon": Icons.security,
      "action": "security",
    },
    {
      "title": "Notification Preferences",
      "subtitle": "Manage alerts",
      "icon": Icons.notifications,
      "action": "notifications",
    },
    {
      "title": "Linked Accounts",
      "subtitle": "External accounts",
      "icon": Icons.link,
      "action": "linked_accounts",
    },
    {
      "title": "Documents",
      "subtitle": "Statements & reports",
      "icon": Icons.description,
      "action": "documents",
    },
    {
      "title": "Help & Support",
      "subtitle": "Get assistance",
      "icon": Icons.help,
      "action": "support",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            _buildProfileHeader(),
            _buildQuickActions(),
            _buildAccountSummary(),
            _buildRecentTransactions(),
            _buildProfileSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
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
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage("${userProfile["avatar"]}"),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userProfile["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.account_balance, color: Colors.white.withAlpha(200), size: 16),
                        SizedBox(width: 4),
                        Text(
                          "${userProfile["accountNumber"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, color: Colors.white, size: 12),
                          SizedBox(width: 4),
                          Text(
                            "${userProfile["accountType"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  _editProfile();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildProfileStat(
                  "Total Balance",
                  "\$${(userProfile["totalBalance"] as double).currency}",
                  Icons.account_balance_wallet,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildProfileStat(
                  "Credit Score",
                  "${userProfile["creditScore"]}",
                  Icons.grade,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildProfileStat(
                  "Points",
                  "${userProfile["loyaltyPoints"]}",
                  Icons.star,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: quickActions.map((action) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (action["color"] as Color).withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      action["icon"],
                      color: action["color"],
                      size: 28,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${action["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${action["subtitle"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Open",
                      size: bs.sm,
                      onPressed: () {
                        _handleQuickAction(action["title"]);
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAccountSummary() {
    return Container(
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
            children: [
              Text(
                "Account Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigate to accounts view
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

          ...accountSummary.map((account) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      account["icon"],
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${account["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${account["number"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${account["balance"] < 0 ? '-' : ''}\$${((account["balance"] as double).abs()).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: account["balance"] < 0 ? dangerColor : successColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Container(
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
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigate to transactions view
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

          ...recentTransactions.take(3).map((transaction) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (transaction["amount"] as double) < 0 
                          ? dangerColor.withAlpha(20) 
                          : successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      transaction["icon"],
                      color: (transaction["amount"] as double) < 0 ? dangerColor : successColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${transaction["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${transaction["category"]} • ${transaction["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${(transaction["amount"] as double) < 0 ? '-' : '+'}\$${((transaction["amount"] as double).abs()).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: (transaction["amount"] as double) < 0 ? dangerColor : successColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProfileSettings() {
    return Container(
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
            "Profile Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...profileActions.map((action) {
            return GestureDetector(
              onTap: () {
                _handleProfileAction(action["action"]);
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      action["icon"],
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${action["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${action["subtitle"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: dangerColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: QButton(
              label: "Sign Out",
              size: bs.md,
              icon: Icons.logout,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to sign out?");
                if (isConfirmed) {
                  _signOut();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editProfile() {
    // Navigate to profile edit view
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case "Transfer Money":
        // Navigate to transfer view
        break;
      case "Pay Bills":
        // Navigate to bill payment view
        break;
      case "Deposit Check":
        // Navigate to check deposit view
        break;
      case "Find ATM":
        // Navigate to ATM locator view
        break;
    }
  }

  void _handleProfileAction(String action) {
    switch (action) {
      case "personal_info":
        // Navigate to personal info view
        break;
      case "security":
        // Navigate to security settings view
        break;
      case "notifications":
        // Navigate to notification preferences view
        break;
      case "linked_accounts":
        // Navigate to linked accounts view
        break;
      case "documents":
        // Navigate to documents view
        break;
      case "support":
        // Navigate to help & support view
        break;
    }
  }

  void _signOut() {
    showLoading();
    
    // Simulate sign out process
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      // Navigate to login view
    });
  }
}
