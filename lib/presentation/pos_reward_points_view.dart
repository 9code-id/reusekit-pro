import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosRewardPointsView extends StatefulWidget {
  const PosRewardPointsView({super.key});

  @override
  State<PosRewardPointsView> createState() => _PosRewardPointsViewState();
}

class _PosRewardPointsViewState extends State<PosRewardPointsView> {
  String searchQuery = "";
  String selectedFilter = "";
  String selectedCustomer = "";
  String pointsAmount = "";
  String reasonNote = "";

  List<Map<String, dynamic>> customers = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 555-0123",
      "totalPoints": 1250,
      "availablePoints": 850,
      "lifetimeEarned": 3400,
      "lifetimeRedeemed": 2550,
      "joinDate": "2024-01-15",
      "lastActivity": "2 hours ago",
      "tier": "Gold",
      "tierColor": Colors.amber,
    },
    {
      "id": "2",
      "name": "Mike Chen",
      "email": "mike.chen@email.com", 
      "phone": "+1 555-0124",
      "totalPoints": 2150,
      "availablePoints": 2150,
      "lifetimeEarned": 5680,
      "lifetimeRedeemed": 3530,
      "joinDate": "2023-11-08",
      "lastActivity": "1 day ago",
      "tier": "Platinum",
      "tierColor": Colors.grey,
    },
    {
      "id": "3",
      "name": "Emma Davis",
      "email": "emma.davis@email.com",
      "phone": "+1 555-0125", 
      "totalPoints": 450,
      "availablePoints": 450,
      "lifetimeEarned": 890,
      "lifetimeRedeemed": 440,
      "joinDate": "2024-03-22",
      "lastActivity": "3 days ago",
      "tier": "Silver",
      "tierColor": Colors.grey[400],
    },
  ];

  List<Map<String, dynamic>> recentTransactions = [
    {
      "id": "1",
      "customerId": "1",
      "customerName": "Sarah Johnson",
      "type": "earned",
      "points": 50,
      "reason": "Purchase",
      "orderId": "ORD-001",
      "timestamp": "2024-06-19T10:30:00",
      "staff": "John Doe",
    },
    {
      "id": "2",
      "customerId": "2", 
      "customerName": "Mike Chen",
      "type": "redeemed",
      "points": 200,
      "reason": "Discount Applied",
      "orderId": "ORD-002",
      "timestamp": "2024-06-19T09:15:00",
      "staff": "Jane Smith",
    },
    {
      "id": "3",
      "customerId": "1",
      "customerName": "Sarah Johnson", 
      "type": "bonus",
      "points": 100,
      "reason": "Birthday Bonus",
      "orderId": null,
      "timestamp": "2024-06-18T14:20:00",
      "staff": "System",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reward Points"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _showAddPointsDialog,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildPointsOverview(),
            _buildCustomersList(),
            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search customers...",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Filter by Tier",
          items: [
            {"label": "All Tiers", "value": ""},
            {"label": "Platinum", "value": "Platinum"},
            {"label": "Gold", "value": "Gold"},
            {"label": "Silver", "value": "Silver"},
          ],
          value: selectedFilter,
          onChanged: (value, label) {
            selectedFilter = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPointsOverview() {
    int totalActivePoints = customers.fold(0, (sum, customer) => sum + (customer["availablePoints"] as int));
    int totalLifetimeEarned = customers.fold(0, (sum, customer) => sum + (customer["lifetimeEarned"] as int));
    int totalLifetimeRedeemed = customers.fold(0, (sum, customer) => sum + (customer["lifetimeRedeemed"] as int));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
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
              Icon(
                Icons.stars,
                color: warningColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "${(totalActivePoints / 1000).toStringAsFixed(1)}K",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Active Points",
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
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "${(totalLifetimeEarned / 1000).toStringAsFixed(1)}K",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Lifetime Earned",
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
              Icon(
                Icons.trending_down,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(height: spSm),
              Text(
                "${(totalLifetimeRedeemed / 1000).toStringAsFixed(1)}K",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Lifetime Redeemed",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Customers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...customers.map((customer) => _buildCustomerCard(customer)),
      ],
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: customer["tierColor"] as Color,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${customer["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${customer["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (customer["tierColor"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${customer["tier"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: customer["tierColor"] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "• ${customer["lastActivity"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showCustomerOptionsDialog(customer),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${customer["availablePoints"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Available",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${((customer["lifetimeEarned"] as int) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Earned",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: disabledOutlineBorderColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${((customer["lifetimeRedeemed"] as int) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Redeemed",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Recent Transactions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...recentTransactions.map((transaction) => _buildTransactionItem(transaction)),
      ],
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    Color statusColor = transaction["type"] == "earned" ? successColor : 
                       transaction["type"] == "redeemed" ? dangerColor : infoColor;
    IconData statusIcon = transaction["type"] == "earned" ? Icons.add_circle : 
                         transaction["type"] == "redeemed" ? Icons.remove_circle : Icons.card_giftcard;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${transaction["customerName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${transaction["reason"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (transaction["orderId"] != null) ...[
                  Text(
                    "Order: ${transaction["orderId"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledColor,
                    ),
                  ),
                ],
                Text(
                  "by ${transaction["staff"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${transaction["type"] == "redeemed" ? "-" : "+"}${transaction["points"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              Text(
                DateTime.parse("${transaction["timestamp"]}").dMMMy,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddPointsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add/Deduct Points"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Select Customer",
              items: customers.map((customer) => {
                "label": "${customer["name"]}",
                "value": "${customer["id"]}",
              }).toList(),
              value: selectedCustomer,
              onChanged: (value, label) {
                selectedCustomer = value;
                setState(() {});
              },
            ),
            QNumberField(
              label: "Points Amount",
              value: pointsAmount,
              onChanged: (value) {
                pointsAmount = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Reason/Note",
              value: reasonNote,
              onChanged: (value) {
                reasonNote = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              QButton(
                label: "Deduct",
                size: bs.sm,
                onPressed: () {
                  Navigator.pop(context);
                  sw("Points deducted from customer account");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: () {
                  Navigator.pop(context);
                  ss("Points added to customer account");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCustomerOptionsDialog(Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${customer["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Available Points: ${customer["availablePoints"]}"),
            Text("Lifetime Earned: ${customer["lifetimeEarned"]}"),
            Text("Lifetime Redeemed: ${customer["lifetimeRedeemed"]}"),
            Text("Member Since: ${customer["joinDate"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "View History",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Viewing customer points history");
            },
          ),
        ],
      ),
    );
  }
}
