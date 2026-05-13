import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaRecurringTransfersView extends StatefulWidget {
  const BfaRecurringTransfersView({super.key});

  @override
  State<BfaRecurringTransfersView> createState() => _BfaRecurringTransfersViewState();
}

class _BfaRecurringTransfersViewState extends State<BfaRecurringTransfersView> {
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> recurringTransfers = [
    {
      "id": 1,
      "recipient": "John Smith",
      "account": "****1234",
      "bank": "Chase Bank",
      "amount": 500.00,
      "frequency": "Monthly",
      "nextDate": "2025-01-15",
      "status": "Active",
      "description": "Rent Payment",
      "createdDate": "2024-01-15",
      "avatar": "https://picsum.photos/40/40?random=1&face"
    },
    {
      "id": 2,
      "recipient": "Emily Johnson",
      "account": "****5678",
      "bank": "Bank of America",
      "amount": 1200.00,
      "frequency": "Weekly",
      "nextDate": "2025-01-10",
      "status": "Active",
      "description": "Allowance",
      "createdDate": "2024-03-10",
      "avatar": "https://picsum.photos/40/40?random=2&face"
    },
    {
      "id": 3,
      "recipient": "Michael Brown",
      "account": "****9012",
      "bank": "Wells Fargo",
      "amount": 800.00,
      "frequency": "Bi-weekly",
      "nextDate": "2025-01-12",
      "status": "Paused",
      "description": "Investment Fund",
      "createdDate": "2024-05-20",
      "avatar": "https://picsum.photos/40/40?random=3&face"
    },
    {
      "id": 4,
      "recipient": "Sarah Davis",
      "account": "****3456",
      "bank": "Citibank",
      "amount": 300.00,
      "frequency": "Monthly",
      "nextDate": "2025-01-25",
      "status": "Active",
      "description": "Utilities",
      "createdDate": "2024-02-25",
      "avatar": "https://picsum.photos/40/40?random=4&face"
    },
    {
      "id": 5,
      "recipient": "David Wilson",
      "account": "****7890",
      "bank": "TD Bank",
      "amount": 150.00,
      "frequency": "Weekly",
      "nextDate": "2025-01-08",
      "status": "Completed",
      "description": "Grocery Fund",
      "createdDate": "2024-12-08",
      "avatar": "https://picsum.photos/40/40?random=5&face"
    }
  ];

  List<Map<String, dynamic>> get filteredTransfers {
    if (selectedFilter == "All") return recurringTransfers;
    return recurringTransfers.where((transfer) => 
      transfer["status"] == selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Paused":
        return warningColor;
      case "Completed":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recurring Transfers"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(AddRecurringTransferView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Quick Stats
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Monthly Transfers",
                          style: TextStyle(
                            color: Colors.white.withAlpha(230),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((recurringTransfers.where((t) => t["frequency"] == "Monthly" && t["status"] == "Active").map((t) => t["amount"] as double).fold(0.0, (sum, amount) => sum + amount))).currency}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.repeat,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),

            // Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All", "value": "All"},
                {"label": "Active", "value": "Active"},
                {"label": "Paused", "value": "Paused"},
                {"label": "Completed", "value": "Completed"},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Transfers List
            ...filteredTransfers.map((transfer) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${transfer["avatar"]}"),
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
                                      "${transfer["recipient"]}",
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
                                      color: _getStatusColor(transfer["status"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${transfer["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(transfer["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${transfer["bank"]} • ${transfer["account"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(transfer["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
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
                                "Frequency",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${transfer["frequency"]}",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Next Transfer",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(transfer["nextDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (transfer["description"] != null) ...[
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "Description: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${transfer["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: transfer["status"] == "Paused" ? "Resume" : "Pause",
                            size: bs.sm,
                            onPressed: () {
                              // Handle pause/resume
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Edit",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(EditRecurringTransferView(transfer));
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // Show options menu
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Add New Transfer Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Setup New Recurring Transfer",
                icon: Icons.add,
                onPressed: () {
                  // navigateTo(AddRecurringTransferView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
