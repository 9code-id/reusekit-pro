import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaBillPaymentView extends StatefulWidget {
  const BfaBillPaymentView({super.key});

  @override
  State<BfaBillPaymentView> createState() => _BfaBillPaymentViewState();
}

class _BfaBillPaymentViewState extends State<BfaBillPaymentView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> billCategories = [
    {"label": "All", "value": "All"},
    {"label": "Utilities", "value": "Utilities"},
    {"label": "Internet", "value": "Internet"},
    {"label": "Phone", "value": "Phone"},
    {"label": "Insurance", "value": "Insurance"},
    {"label": "Credit Card", "value": "Credit Card"},
  ];

  List<Map<String, dynamic>> bills = [
    {
      "id": 1,
      "name": "Electric Company",
      "category": "Utilities",
      "account": "ACC-789456123",
      "amount": 125.50,
      "dueDate": "2025-01-20",
      "status": "Pending",
      "lastPaid": "2024-12-20",
      "icon": Icons.electrical_services,
      "color": Colors.amber,
      "description": "Monthly electricity bill"
    },
    {
      "id": 2,
      "name": "Internet Provider",
      "category": "Internet",
      "account": "INT-456789012",
      "amount": 89.99,
      "dueDate": "2025-01-15",
      "status": "Overdue",
      "lastPaid": "2024-11-15",
      "icon": Icons.wifi,
      "color": Colors.blue,
      "description": "High-speed internet service"
    },
    {
      "id": 3,
      "name": "Mobile Carrier",
      "category": "Phone",
      "account": "MOB-123456789",
      "amount": 65.00,
      "dueDate": "2025-01-25",
      "status": "Paid",
      "lastPaid": "2024-12-25",
      "icon": Icons.phone,
      "color": Colors.green,
      "description": "Monthly phone plan"
    },
    {
      "id": 4,
      "name": "Water Company",
      "category": "Utilities",
      "account": "WAT-987654321",
      "amount": 78.25,
      "dueDate": "2025-01-18",
      "status": "Pending",
      "lastPaid": "2024-12-18",
      "icon": Icons.water_drop,
      "color": Colors.cyan,
      "description": "Monthly water service"
    },
    {
      "id": 5,
      "name": "Health Insurance",
      "category": "Insurance",
      "account": "INS-555666777",
      "amount": 450.00,
      "dueDate": "2025-01-30",
      "status": "Pending",
      "lastPaid": "2024-12-30",
      "icon": Icons.health_and_safety,
      "color": Colors.red,
      "description": "Monthly health insurance premium"
    },
    {
      "id": 6,
      "name": "Credit Card",
      "category": "Credit Card",
      "account": "****1234",
      "amount": 320.75,
      "dueDate": "2025-01-12",
      "status": "Overdue",
      "lastPaid": "2024-11-12",
      "icon": Icons.credit_card,
      "color": Colors.purple,
      "description": "Monthly credit card payment"
    }
  ];

  List<Map<String, dynamic>> get filteredBills {
    if (selectedCategory == "All") return bills;
    return bills.where((bill) => bill["category"] == selectedCategory).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  int get overdueCount => bills.where((bill) => bill["status"] == "Overdue").length;
  int get pendingCount => bills.where((bill) => bill["status"] == "Pending").length;
  double get totalDue => bills
      .where((bill) => bill["status"] != "Paid")
      .map((bill) => bill["amount"] as double)
      .fold(0.0, (sum, amount) => sum + amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Payment"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(AddBillView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            Row(
              children: [
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
                          "$overdueCount",
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
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: warningColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 14,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$pendingCount",
                          style: TextStyle(
                            fontSize: fsH4,
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

            // Total Due Amount
            Container(
              width: double.infinity,
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
                  Text(
                    "Total Amount Due",
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${totalDue.currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Pay All Pending Bills",
                    color: Colors.white,
                    onPressed: () {
                      // Handle pay all
                    },
                  ),
                ],
              ),
            ),

            // Category Filter
            QCategoryPicker(
              items: billCategories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Bills List
            ...filteredBills.map((bill) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: bill["status"] == "Overdue"
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
                            color: (bill["color"] as Color).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            bill["icon"] as IconData,
                            color: bill["color"] as Color,
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
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(bill["status"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${bill["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(bill["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Account: ${bill["account"]}",
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
                                "\$${(bill["amount"] as double).currency}",
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
                                "Due Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(bill["dueDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: bill["status"] == "Overdue" ? dangerColor : primaryColor,
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
                                "Last Paid",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(bill["lastPaid"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    if (bill["description"] != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${bill["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    SizedBox(height: spSm),
                    if (bill["status"] != "Paid")
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: bill["status"] == "Overdue" ? "Pay Now (Overdue)" : "Pay Bill",
                          onPressed: () {
                            // navigateTo(PayBillView(bill));
                          },
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),

            // Add New Bill
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Bill",
                icon: Icons.add,
                onPressed: () {
                  // navigateTo(AddBillView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
