import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyTaxView extends StatefulWidget {
  const ReaPropertyTaxView({super.key});

  @override
  State<ReaPropertyTaxView> createState() => _ReaPropertyTaxViewState();
}

class _ReaPropertyTaxViewState extends State<ReaPropertyTaxView> {
  List<Map<String, dynamic>> properties = [
    {
      "id": 1,
      "address": "123 Oak Street, Downtown",
      "propertyValue": 450000,
      "annualTax": 4500,
      "taxRate": 1.0,
      "dueDate": "2024-12-31",
      "status": "Due",
      "lastPaid": "2023-12-15",
      "paymentHistory": [
        {"year": 2023, "amount": 4200, "datePaid": "2023-12-15", "status": "Paid"},
        {"year": 2022, "amount": 4000, "datePaid": "2022-12-20", "status": "Paid"},
        {"year": 2021, "amount": 3800, "datePaid": "2021-12-18", "status": "Paid"},
      ]
    },
    {
      "id": 2,
      "address": "456 Pine Avenue, Suburbs",
      "propertyValue": 320000,
      "annualTax": 2880,
      "taxRate": 0.9,
      "dueDate": "2024-11-30",
      "status": "Paid",
      "lastPaid": "2024-11-25",
      "paymentHistory": [
        {"year": 2024, "amount": 2880, "datePaid": "2024-11-25", "status": "Paid"},
        {"year": 2023, "amount": 2750, "datePaid": "2023-11-28", "status": "Paid"},
        {"year": 2022, "amount": 2600, "datePaid": "2022-11-30", "status": "Paid"},
      ]
    },
    {
      "id": 3,
      "address": "789 Maple Drive, Lakeside",
      "propertyValue": 680000,
      "annualTax": 8160,
      "taxRate": 1.2,
      "dueDate": "2025-01-15",
      "status": "Overdue",
      "lastPaid": "2023-01-10",
      "paymentHistory": [
        {"year": 2023, "amount": 7650, "datePaid": "2023-01-10", "status": "Paid"},
        {"year": 2022, "amount": 7200, "datePaid": "2022-01-15", "status": "Paid"},
      ]
    },
  ];

  int selectedTabIndex = 0;
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Properties", "value": "All"},
    {"label": "Due", "value": "Due"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Overdue", "value": "Overdue"},
  ];

  List<Map<String, dynamic>> getFilteredProperties() {
    if (selectedFilter == "All") return properties;
    return properties.where((property) => property["status"] == selectedFilter).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Due":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Tax"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add new property tax record");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Cards
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_balance,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "\$${((properties.map((p) => p["annualTax"] as int).reduce((a, b) => a + b)).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Annual Tax",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${properties.where((p) => p["status"] == "Due").length}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Payments Due",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning,
                          color: dangerColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${properties.where((p) => p["status"] == "Overdue").length}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Overdue",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Dropdown
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QDropdownField(
              label: "Filter Properties",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Properties List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: getFilteredProperties().length,
              itemBuilder: (context, index) {
                final property = getFilteredProperties()[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
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
                      // Property Header
                      Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${property["address"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Value: \$${((property["propertyValue"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: getStatusColor(property["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${property["status"]}",
                              style: TextStyle(
                                color: getStatusColor(property["status"]),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Divider(color: disabledColor),
                      
                      // Tax Information
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Annual Tax",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${((property["annualTax"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                                  "Tax Rate",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${property["taxRate"]}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                                  "Due Date",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${DateTime.parse(property["dueDate"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: getStatusColor(property["status"]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      // Last Payment Info
                      if (property["lastPaid"] != null)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Last paid: ${DateTime.parse(property["lastPaid"]).dMMMy}",
                                style: TextStyle(
                                  color: successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      // Action Buttons
                      Row(
                        spacing: spSm,
                        children: [
                          Expanded(
                            child: QButton(
                              label: property["status"] == "Paid" ? "View Receipt" : "Pay Now",
                              size: bs.sm,
                              onPressed: () {
                                if (property["status"] == "Paid") {
                                  si("View payment receipt");
                                } else {
                                  ss("Redirecting to payment gateway");
                                }
                              },
                            ),
                          ),
                          QButton(
                            icon: Icons.history,
                            size: bs.sm,
                            onPressed: () {
                              _showPaymentHistory(property);
                            },
                          ),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              _showPropertyOptions(property);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentHistory(Map<String, dynamic> property) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment History"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${property["address"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: spMd),
              ...(property["paymentHistory"] as List).map((payment) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(30)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Year ${payment["year"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Paid: ${DateTime.parse(payment["datePaid"]).dMMMy}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${((payment["amount"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showPropertyOptions(Map<String, dynamic> property) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Property Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Property Details"),
              onTap: () {
                Navigator.pop(context);
                si("Edit property details");
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text("Download Tax Statement"),
              onTap: () {
                Navigator.pop(context);
                ss("Tax statement downloaded");
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Set Payment Reminder"),
              onTap: () {
                Navigator.pop(context);
                ss("Payment reminder set");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Remove Property", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to remove this property?");
                if (isConfirmed) {
                  properties.removeWhere((p) => p["id"] == property["id"]);
                  setState(() {});
                  ss("Property removed successfully");
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
