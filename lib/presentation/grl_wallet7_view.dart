import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet7View extends StatefulWidget {
  @override
  State<GrlWallet7View> createState() => _GrlWallet7ViewState();
}

class _GrlWallet7ViewState extends State<GrlWallet7View> {
  List<Map<String, dynamic>> bills = [
    {
      "id": "1",
      "name": "Electric Bill",
      "company": "PowerCorp",
      "amount": 89.50,
      "dueDate": "2024-02-15",
      "status": "due",
      "category": "Utilities",
      "icon": Icons.electrical_services,
      "color": Colors.orange,
      "accountNumber": "****1234",
      "autopay": true
    },
    {
      "id": "2",
      "name": "Internet Bill",
      "company": "NetProvider",
      "amount": 65.00,
      "dueDate": "2024-02-10",
      "status": "overdue",
      "category": "Utilities",
      "icon": Icons.wifi,
      "color": Colors.blue,
      "accountNumber": "****5678",
      "autopay": false
    },
    {
      "id": "3",
      "name": "Water Bill",
      "company": "AquaServices",
      "amount": 45.75,
      "dueDate": "2024-02-20",
      "status": "paid",
      "category": "Utilities",
      "icon": Icons.water_drop,
      "color": Colors.cyan,
      "accountNumber": "****9012",
      "autopay": true
    },
    {
      "id": "4",
      "name": "Phone Bill",
      "company": "MobileTech",
      "amount": 85.00,
      "dueDate": "2024-02-25",
      "status": "upcoming",
      "category": "Communication",
      "icon": Icons.phone,
      "color": Colors.green,
      "accountNumber": "****3456",
      "autopay": false
    },
    {
      "id": "5",
      "name": "Netflix",
      "company": "Netflix Inc.",
      "amount": 15.99,
      "dueDate": "2024-02-28",
      "status": "upcoming",
      "category": "Entertainment",
      "icon": Icons.tv,
      "color": Colors.red,
      "accountNumber": "****7890",
      "autopay": true
    },
    {
      "id": "6",
      "name": "Spotify Premium",
      "company": "Spotify AB",
      "amount": 9.99,
      "dueDate": "2024-02-12",
      "status": "due",
      "category": "Entertainment",
      "icon": Icons.music_note,
      "color": Colors.green,
      "accountNumber": "****2468",
      "autopay": true
    }
  ];

  String selectedFilter = "All";
  List<String> filters = ["All", "Due", "Overdue", "Paid", "Upcoming"];

  List<Map<String, dynamic>> get filteredBills {
    if (selectedFilter == "All") return bills;
    return bills.where((bill) => bill["status"] == selectedFilter.toLowerCase()).toList();
  }

  double get totalDue {
    return bills
        .where((bill) => bill["status"] == "due" || bill["status"] == "overdue")
        .fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
  }

  double get totalPaid {
    return bills
        .where((bill) => bill["status"] == "paid")
        .fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
  }

  double get totalUpcoming {
    return bills
        .where((bill) => bill["status"] == "upcoming")
        .fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
  }

  int get overdueCount {
    return bills.where((bill) => bill["status"] == "overdue").length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Pay"),
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
            // Bills Summary
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
                    "Bills Overview",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (overdueCount > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(100),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "$overdueCount bill${overdueCount > 1 ? 's' : ''} overdue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSummaryItem(
                        "Due Now",
                        totalDue,
                        Colors.red.withAlpha(100),
                      ),
                      _buildSummaryItem(
                        "Paid",
                        totalPaid,
                        Colors.green.withAlpha(100),
                      ),
                      _buildSummaryItem(
                        "Upcoming",
                        totalUpcoming,
                        Colors.blue.withAlpha(100),
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
                    label: "Pay All Due",
                    icon: Icons.payment,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Add Bill",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Filter
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: QDropdownField(
                label: "Filter by Status",
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

            // Bills List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredBills.length,
              itemBuilder: (context, index) {
                final bill = filteredBills[index];
                return _buildBillCard(bill);
              },
            ),

            // Autopay Settings
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
                    "AutoPay Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${bills.where((b) => b["autopay"] == true).length} bills on AutoPay",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Manage",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, double amount, Color backgroundColor) {
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

  Widget _buildBillCard(Map<String, dynamic> bill) {
    String status = bill["status"];
    Color statusColor = _getStatusColor(status);
    Color billColor = bill["color"] as Color;
    DateTime dueDate = DateTime.parse(bill["dueDate"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: status == "overdue" 
            ? Border.all(color: dangerColor.withAlpha(100), width: 2)
            : null,
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
                  color: billColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  bill["icon"] as IconData,
                  color: billColor,
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
                            "${bill["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${bill["company"]} • ${bill["accountNumber"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Due: ${dueDate.dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (bill["autopay"] == true) ...[
                          SizedBox(width: spSm),
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
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "\$${(bill["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          if (status != "paid")
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: status == "overdue" ? "Pay Now" : "Pay Bill",
                    icon: Icons.payment,
                    size: bs.sm,
                    onPressed: () {
                      _showPaymentDialog(bill);
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
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "overdue":
        return dangerColor;
      case "due":
        return warningColor;
      case "paid":
        return successColor;
      case "upcoming":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showPaymentDialog(Map<String, dynamic> bill) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Pay Bill"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pay ${bill["name"]}?"),
            SizedBox(height: spSm),
            Text(
              "Amount: \$${(bill["amount"] as double).currency}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Company: ${bill["company"]}",
              style: TextStyle(color: disabledBoldColor),
            ),
            Text(
              "Account: ${bill["accountNumber"]}",
              style: TextStyle(color: disabledBoldColor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Pay Now",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              bill["status"] = "paid";
              setState(() {});
              ss("Bill paid successfully!");
            },
          ),
        ],
      ),
    );
  }
}
