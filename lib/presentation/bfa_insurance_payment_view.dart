import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaInsurancePaymentView extends StatefulWidget {
  const BfaInsurancePaymentView({super.key});

  @override
  State<BfaInsurancePaymentView> createState() => _BfaInsurancePaymentViewState();
}

class _BfaInsurancePaymentViewState extends State<BfaInsurancePaymentView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> insuranceCategories = [
    {"label": "All", "value": "All"},
    {"label": "Health", "value": "Health"},
    {"label": "Auto", "value": "Auto"},
    {"label": "Life", "value": "Life"},
    {"label": "Home", "value": "Home"},
    {"label": "Travel", "value": "Travel"},
  ];

  List<Map<String, dynamic>> insurancePolicies = [
    {
      "id": 1,
      "provider": "Blue Cross Health Insurance",
      "policyNumber": "BCHS-789456123",
      "category": "Health",
      "premium": 450.00,
      "dueDate": "2025-01-25",
      "status": "Active",
      "coverage": "Family Plan",
      "renewalDate": "2025-12-25",
      "icon": Icons.health_and_safety,
      "color": Colors.blue,
      "members": ["John Doe", "Jane Doe", "Kids"]
    },
    {
      "id": 2,
      "provider": "State Farm Auto Insurance",
      "policyNumber": "SF-456789012",
      "category": "Auto",
      "premium": 180.50,
      "dueDate": "2025-01-15",
      "status": "Active",
      "coverage": "Full Coverage",
      "renewalDate": "2025-06-15",
      "icon": Icons.directions_car,
      "color": Colors.green,
      "vehicles": ["Honda Accord 2022", "Toyota Camry 2020"]
    },
    {
      "id": 3,
      "provider": "MetLife Insurance",
      "policyNumber": "ML-123456789",
      "category": "Life",
      "premium": 125.00,
      "dueDate": "2025-01-30",
      "status": "Active",
      "coverage": "\$500,000 Term Life",
      "renewalDate": "2025-07-30",
      "icon": Icons.favorite,
      "color": Colors.red,
      "beneficiaries": ["Jane Doe", "Children"]
    },
    {
      "id": 4,
      "provider": "Allstate Home Insurance",
      "policyNumber": "AS-987654321",
      "category": "Home",
      "premium": 220.75,
      "dueDate": "2025-01-20",
      "status": "Overdue",
      "coverage": "Homeowner's Policy",
      "renewalDate": "2025-08-20",
      "icon": Icons.home,
      "color": Colors.orange,
      "property": "123 Main St, Anytown"
    },
    {
      "id": 5,
      "provider": "Travel Guard Insurance",
      "policyNumber": "TG-555666777",
      "category": "Travel",
      "premium": 85.00,
      "dueDate": "2025-02-01",
      "status": "Pending",
      "coverage": "International Travel",
      "renewalDate": "2025-02-01",
      "icon": Icons.flight,
      "color": Colors.purple,
      "trips": ["Europe Trip 2025"]
    }
  ];

  List<Map<String, dynamic>> paymentHistory = [
    {
      "id": 1,
      "provider": "Blue Cross Health Insurance",
      "amount": 450.00,
      "date": "2024-12-25T10:30:00",
      "status": "Success",
      "transactionId": "INS789456123",
      "category": "Health"
    },
    {
      "id": 2,
      "provider": "State Farm Auto Insurance",
      "amount": 180.50,
      "date": "2024-12-15T14:20:00",
      "status": "Success",
      "transactionId": "INS456789012",
      "category": "Auto"
    }
  ];

  List<Map<String, dynamic>> get filteredPolicies {
    if (selectedCategory == "All") return insurancePolicies;
    return insurancePolicies.where((policy) => policy["category"] == selectedCategory).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "Expired":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  int get overdueCount => insurancePolicies.where((policy) => policy["status"] == "Overdue").length;
  int get activeCount => insurancePolicies.where((policy) => policy["status"] == "Active").length;
  double get totalDue => insurancePolicies
      .where((policy) => policy["status"] != "Active" || policy["status"] == "Overdue")
      .map((policy) => policy["premium"] as double)
      .fold(0.0, (sum, amount) => sum + amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insurance Payment"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(AddInsurancePolicyView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Overview
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.security,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Insurance Overview",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${insurancePolicies.length} active policies",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
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
                        child: Column(
                          children: [
                            Text(
                              "Active Policies",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "$activeCount",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (overdueCount > 0)
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(230),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "$overdueCount",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Total Due",
                              style: TextStyle(
                                color: Colors.white.withAlpha(230),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "\$${totalDue.currency}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: successColor,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$activeCount",
                          style: TextStyle(
                            fontSize: fsH4,
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
              ],
            ),

            // Category Filter
            QCategoryPicker(
              items: insuranceCategories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Insurance Policies List
            ...filteredPolicies.map((policy) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: policy["status"] == "Overdue"
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
                            color: (policy["color"] as Color).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            policy["icon"] as IconData,
                            color: policy["color"] as Color,
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
                                      "${policy["provider"]}",
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
                                      color: _getStatusColor(policy["status"]).withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${policy["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(policy["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Policy: ${policy["policyNumber"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${policy["category"]} • ${policy["coverage"]}",
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
                                "Premium",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(policy["premium"] as double).currency}",
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
                                "${DateTime.parse(policy["dueDate"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: policy["status"] == "Overdue" ? dangerColor : primaryColor,
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
                                "Renewal",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(policy["renewalDate"]).dMMMy}",
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
                    // Policy Details
                    if (policy["members"] != null) ...[
                      Row(
                        children: [
                          Text(
                            "Members: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (policy["members"] as List).join(", "),
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (policy["vehicles"] != null) ...[
                      Row(
                        children: [
                          Text(
                            "Vehicles: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (policy["vehicles"] as List).join(", "),
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (policy["property"] != null) ...[
                      Row(
                        children: [
                          Text(
                            "Property: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${policy["property"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
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
                            label: policy["status"] == "Overdue" ? "Pay Now (Overdue)" : "Pay Premium",
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo(PayInsuranceView(policy));
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            // Show policy options
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            // Recent Payments
            if (paymentHistory.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Recent Payments",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigateTo(InsurancePaymentHistoryView());
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
                    SizedBox(height: spSm),
                    ...paymentHistory.take(3).map((payment) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${payment["provider"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${payment["category"]} • ${DateTime.parse(payment["date"]).dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(payment["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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

            // Add New Policy
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add New Insurance Policy",
                icon: Icons.add,
                onPressed: () {
                  // navigateTo(AddInsurancePolicyView());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
