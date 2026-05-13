import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCashCountView extends StatefulWidget {
  const PosCashCountView({Key? key}) : super(key: key);

  @override
  State<PosCashCountView> createState() => _PosCashCountViewState();
}

class _PosCashCountViewState extends State<PosCashCountView> {
  String countType = "manual";
  String countReason = "routine_check";
  String notes = "";
  bool isProcessing = false;

  List<Map<String, dynamic>> countTypeOptions = [
    {"label": "Manual Count", "value": "manual"},
    {"label": "Quick Count", "value": "quick"},
    {"label": "Full Audit", "value": "audit"},
  ];

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "Routine Check", "value": "routine_check"},
    {"label": "Shift Change", "value": "shift_change"},
    {"label": "Discrepancy Investigation", "value": "discrepancy"},
    {"label": "Manager Request", "value": "manager_request"},
    {"label": "Till Balancing", "value": "till_balance"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> denominationCounts = [
    {"type": "bills", "value": 100.00, "count": "", "label": "\$100 Bills", "icon": Icons.money},
    {"type": "bills", "value": 50.00, "count": "", "label": "\$50 Bills", "icon": Icons.money},
    {"type": "bills", "value": 20.00, "count": "", "label": "\$20 Bills", "icon": Icons.money},
    {"type": "bills", "value": 10.00, "count": "", "label": "\$10 Bills", "icon": Icons.money},
    {"type": "bills", "value": 5.00, "count": "", "label": "\$5 Bills", "icon": Icons.money},
    {"type": "bills", "value": 1.00, "count": "", "label": "\$1 Bills", "icon": Icons.money},
    {"type": "coins", "value": 0.25, "count": "", "label": "Quarters (25¢)", "icon": Icons.monetization_on},
    {"type": "coins", "value": 0.10, "count": "", "label": "Dimes (10¢)", "icon": Icons.monetization_on},
    {"type": "coins", "value": 0.05, "count": "", "label": "Nickels (5¢)", "icon": Icons.monetization_on},
    {"type": "coins", "value": 0.01, "count": "", "label": "Pennies (1¢)", "icon": Icons.monetization_on},
  ];

  Map<String, dynamic> expectedAmounts = {
    "total": 1850.75,
    "bills": 1800.00,
    "coins": 50.75,
  };

  double get totalCounted {
    double total = 0;
    for (var denomination in denominationCounts) {
      int count = int.tryParse(denomination["count"]) ?? 0;
      double value = denomination["value"] as double;
      total += count * value;
    }
    return total;
  }

  double get billsTotal {
    double total = 0;
    for (var denomination in denominationCounts.where((d) => d["type"] == "bills")) {
      int count = int.tryParse(denomination["count"]) ?? 0;
      double value = denomination["value"] as double;
      total += count * value;
    }
    return total;
  }

  double get coinsTotal {
    double total = 0;
    for (var denomination in denominationCounts.where((d) => d["type"] == "coins")) {
      int count = int.tryParse(denomination["count"]) ?? 0;  
      double value = denomination["value"] as double;
      total += count * value;
    }
    return total;
  }

  double get variance {
    return totalCounted - (expectedAmounts["total"] as double);
  }

  void _clearAllCounts() {
    for (var denomination in denominationCounts) {
      denomination["count"] = "";
    }
    setState(() {});
  }

  void _saveCount() async {
    isProcessing = true;
    setState(() {});

    showLoading();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    hideLoading();
    isProcessing = false;
    setState(() {});

    ss("Cash count saved successfully");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cash Count"),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: _clearAllCounts,
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo(CashCountHistoryView)
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Count Information
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
                  Text(
                    "Count Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Count Type",
                    items: countTypeOptions,
                    value: countType,
                    onChanged: (value, label) {
                      countType = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Reason for Count",
                    items: reasonOptions,
                    value: countReason,
                    onChanged: (value, label) {
                      countReason = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Expected vs Counted Summary
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
                  Text(
                    "Count Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.blue.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Expected",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "\$${(expectedAmounts["total"] as double).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fsH6,
                                  color: Colors.blue,
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
                            color: Colors.green.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Counted",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "\$${totalCounted.currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fsH6,
                                  color: Colors.green,
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
                            color: variance >= 0 ? Colors.green.withAlpha(10) : Colors.red.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Variance",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${variance >= 0 ? '+' : ''}\$${variance.abs().currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fsH6,
                                  color: variance >= 0 ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Bills Count Section
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
                      Icon(Icons.money, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Bills Count",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "\$${billsTotal.currency}",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...denominationCounts.where((d) => d["type"] == "bills").map((denomination) {
                    int index = denominationCounts.indexOf(denomination);
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.grey.withAlpha(20)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              denomination["icon"] as IconData,
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${denomination["label"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QNumberField(
                              label: "Count",
                              value: denomination["count"],
                              onChanged: (value) {
                                denominationCounts[index]["count"] = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            width: 80,
                            child: Text(
                              "\$${((int.tryParse(denomination["count"]) ?? 0) * (denomination["value"] as double)).currency}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: primaryColor,
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

            SizedBox(height: spMd),

            // Coins Count Section
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
                      Icon(Icons.monetization_on, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Coins Count",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.orange.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "\$${coinsTotal.currency}",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...denominationCounts.where((d) => d["type"] == "coins").map((denomination) {
                    int index = denominationCounts.indexOf(denomination);
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.grey.withAlpha(20)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: Colors.orange.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              denomination["icon"] as IconData,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${denomination["label"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QNumberField(
                              label: "Count",
                              value: denomination["count"],
                              onChanged: (value) {
                                denominationCounts[index]["count"] = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            width: 80,
                            child: Text(
                              "\$${((int.tryParse(denomination["count"]) ?? 0) * (denomination["value"] as double)).currency}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: primaryColor,
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

            SizedBox(height: spMd),

            // Final Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: variance.abs() > 5.0 ? Colors.red.withAlpha(10) : Colors.green.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: variance.abs() > 5.0 ? Colors.red.withAlpha(30) : Colors.green.withAlpha(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Bills Total:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${billsTotal.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Coins Total:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${coinsTotal.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        "Total Counted:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${totalCounted.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Variance:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${variance >= 0 ? '+' : ''}\$${variance.abs().currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: variance >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  if (variance.abs() > 5.0) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.orange.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: Colors.orange, size: 18),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Significant variance detected. Please recount and verify.",
                              style: TextStyle(
                                color: Colors.orange.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Notes Section
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
                  Text(
                    "Count Notes",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Notes (Optional)",
                    value: notes,
                    hint: "Add any notes about discrepancies, damaged bills, or other observations...",
                    onChanged: (value) {
                      notes = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear All",
                    color: Colors.grey,
                    size: bs.md,
                    onPressed: _clearAllCounts,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Save Count",
                    icon: Icons.save,
                    size: bs.md,
                    onPressed: isProcessing ? null : _saveCount,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
