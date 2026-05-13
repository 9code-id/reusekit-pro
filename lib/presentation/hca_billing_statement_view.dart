import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaBillingStatementView extends StatefulWidget {
  const HcaBillingStatementView({super.key});

  @override
  State<HcaBillingStatementView> createState() => _HcaBillingStatementViewState();
}

class _HcaBillingStatementViewState extends State<HcaBillingStatementView> {
  String selectedPeriod = "current";
  String selectedProvider = "all";
  String sortBy = "date";

  List<Map<String, dynamic>> billingStatements = [
    {
      "id": "BS001",
      "provider": "City General Hospital",
      "serviceDate": "2024-12-15",
      "dueDate": "2025-01-15",
      "totalAmount": 2450.00,
      "insurancePaid": 1960.00,
      "patientOwes": 490.00,
      "status": "pending",
      "services": [
        {"description": "Emergency Room Visit", "amount": 1200.00},
        {"description": "X-Ray Chest", "amount": 350.00},
        {"description": "Laboratory Tests", "amount": 900.00}
      ]
    },
    {
      "id": "BS002",
      "provider": "Wellness Clinic",
      "serviceDate": "2024-12-10",
      "dueDate": "2025-01-10",
      "totalAmount": 180.00,
      "insurancePaid": 144.00,
      "patientOwes": 36.00,
      "status": "paid",
      "services": [
        {"description": "Annual Check-up", "amount": 150.00},
        {"description": "Blood Pressure Check", "amount": 30.00}
      ]
    },
    {
      "id": "BS003",
      "provider": "Dental Care Center",
      "serviceDate": "2024-12-05",
      "dueDate": "2024-12-20",
      "totalAmount": 620.00,
      "insurancePaid": 310.00,
      "patientOwes": 310.00,
      "status": "overdue",
      "services": [
        {"description": "Dental Cleaning", "amount": 120.00},
        {"description": "Cavity Filling", "amount": 500.00}
      ]
    },
    {
      "id": "BS004",
      "provider": "Eye Care Specialists",
      "serviceDate": "2024-11-28",
      "dueDate": "2024-12-28",
      "totalAmount": 450.00,
      "insurancePaid": 360.00,
      "patientOwes": 90.00,
      "status": "processing",
      "services": [
        {"description": "Eye Examination", "amount": 200.00},
        {"description": "Contact Lens Fitting", "amount": 250.00}
      ]
    }
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"type": "Credit Card", "lastFour": "4567", "default": true},
    {"type": "Bank Account", "lastFour": "8901", "default": false},
    {"type": "HSA Account", "lastFour": "2345", "default": false}
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "paid": return successColor;
      case "pending": return warningColor;
      case "overdue": return dangerColor;
      case "processing": return infoColor;
      default: return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> get filteredStatements {
    return billingStatements.where((statement) {
      if (selectedProvider != "all" && statement["provider"] != selectedProvider) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing Statements"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              ss("Billing statements exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.filter_list, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: [
                            {"label": "Current Month", "value": "current"},
                            {"label": "Last 3 Months", "value": "3months"},
                            {"label": "Last 6 Months", "value": "6months"},
                            {"label": "Last Year", "value": "year"}
                          ],
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Provider",
                          items: [
                            {"label": "All Providers", "value": "all"},
                            {"label": "City General Hospital", "value": "City General Hospital"},
                            {"label": "Wellness Clinic", "value": "Wellness Clinic"},
                            {"label": "Dental Care Center", "value": "Dental Care Center"}
                          ],
                          value: selectedProvider,
                          onChanged: (value, label) {
                            selectedProvider = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Outstanding Balance Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Text(
                    "Outstanding Balance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${((filteredStatements.fold(0.0, (sum, item) => sum + (item["patientOwes"] as double)))).currency}",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Overdue",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "\$${((filteredStatements.where((s) => s["status"] == "overdue").fold(0.0, (sum, item) => sum + (item["patientOwes"] as double)))).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Due Soon",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                          Text(
                            "\$${((filteredStatements.where((s) => s["status"] == "pending").fold(0.0, (sum, item) => sum + (item["patientOwes"] as double)))).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
                    label: "Pay All Overdue",
                    color: dangerColor,
                    size: bs.sm,
                    onPressed: () {
                      ss("Redirecting to payment portal");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Set Up Auto-Pay",
                    size: bs.sm,
                    onPressed: () {
                      ss("Auto-pay setup initiated");
                    },
                  ),
                ),
              ],
            ),

            // Billing Statements List
            ...filteredStatements.map((statement) {
              return Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor("${statement["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${statement["provider"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Statement #${statement["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${statement["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${statement["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor("${statement["status"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Service Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse("${statement["serviceDate"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
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
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse("${statement["dueDate"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Amount:",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "\$${((statement["totalAmount"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Insurance Paid:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "\$${((statement["insurancePaid"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "You Owe:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${((statement["patientOwes"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Services breakdown
                    ExpansionTile(
                      title: Text(
                        "Service Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: [
                        ...(statement["services"] as List).map((service) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: spXs),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${service["description"]}",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                Text(
                                  "\$${((service["amount"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                    if (statement["status"] != "paid") ...[
                      Divider(height: 1),
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                ss("Viewing statement details");
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Pay Now",
                              color: successColor,
                              size: bs.sm,
                              onPressed: () {
                                ss("Redirecting to payment");
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),

            // Payment Methods Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Methods",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Add New",
                        size: bs.sm,
                        onPressed: () {
                          ss("Adding new payment method");
                        },
                      ),
                    ],
                  ),
                  ...paymentMethods.map((method) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: method["default"] ? primaryColor.withAlpha(10) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: method["default"] 
                          ? Border.all(color: primaryColor, width: 1)
                          : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            method["type"] == "Credit Card" 
                              ? Icons.credit_card 
                              : Icons.account_balance,
                            color: method["default"] ? primaryColor : disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${method["type"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "****${method["lastFour"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (method["default"])
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "DEFAULT",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
