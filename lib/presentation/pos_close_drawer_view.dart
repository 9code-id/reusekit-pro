import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCloseDrawerView extends StatefulWidget {
  const PosCloseDrawerView({Key? key}) : super(key: key);

  @override
  State<PosCloseDrawerView> createState() => _PosCloseDrawerViewState();
}

class _PosCloseDrawerViewState extends State<PosCloseDrawerView> {
  final formKey = GlobalKey<FormState>();
  String cashierName = "Sarah Mitchell";
  String notes = "";
  String reason = "shift_end";
  bool isProcessing = false;
  bool printReceipt = true;

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "Shift End", "value": "shift_end"},
    {"label": "Break", "value": "break"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Emergency", "value": "emergency"},
    {"label": "Other", "value": "other"},
  ];

  Map<String, dynamic> shiftSummary = {
    "start_time": "09:00",
    "current_time": "17:30",
    "hours_worked": "8h 30m",
    "starting_float": 200.00,
    "cash_sales": 2450.75,
    "cash_received": 2650.75,
    "cash_paid_out": 125.50,
    "expected_balance": 2525.25,
    "transaction_count": 67,
    "refund_count": 4,
    "void_count": 2,
  };

  List<Map<String, dynamic>> denominationCounts = [
    {"type": "bills", "value": 100.00, "count": "12", "total": 1200.00},
    {"type": "bills", "value": 50.00, "count": "8", "total": 400.00},
    {"type": "bills", "value": 20.00, "count": "15", "total": 300.00},
    {"type": "bills", "value": 10.00, "count": "18", "total": 180.00},
    {"type": "bills", "value": 5.00, "count": "25", "total": 125.00},
    {"type": "bills", "value": 1.00, "count": "45", "total": 45.00},
    {"type": "coins", "value": 0.25, "count": "80", "total": 20.00},
    {"type": "coins", "value": 0.10, "count": "120", "total": 12.00},
    {"type": "coins", "value": 0.05, "count": "150", "total": 7.50},
    {"type": "coins", "value": 0.01, "count": "275", "total": 2.75},
  ];

  double get countedTotal {
    double total = 0;
    for (var denomination in denominationCounts) {
      int count = int.tryParse(denomination["count"]) ?? 0;
      double value = denomination["value"] as double;
      total += count * value;
    }
    return total;
  }

  double get variance {
    return countedTotal - (shiftSummary["expected_balance"] as double);
  }

  void _closeDrawer() async {
    if (!formKey.currentState!.validate()) return;

    if (variance.abs() > 5.00) {
      bool isConfirmed = await confirm("There is a variance of \$${variance.abs().currency}. Are you sure you want to close the drawer?");
      if (!isConfirmed) return;
    }

    isProcessing = true;
    setState(() {});

    showLoading();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    hideLoading();
    isProcessing = false;
    setState(() {});

    ss("Cash drawer closed successfully");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Close Cash Drawer"),
        actions: [
          if (printReceipt)
            IconButton(
              icon: Icon(Icons.print),
              onPressed: () {
                ss("Closing report printed");
              },
            ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shift Summary
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
                      "Shift Summary",
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cashier",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                cashierName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
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
                                "Shift Duration",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${shiftSummary["hours_worked"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
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
                                "Start Time",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${shiftSummary["start_time"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
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
                                "End Time",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${shiftSummary["current_time"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
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

              SizedBox(height: spMd),

              // Financial Summary
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
                      "Financial Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    _buildSummaryRow("Starting Float", shiftSummary["starting_float"] as double),
                    _buildSummaryRow("Cash Sales", shiftSummary["cash_sales"] as double),
                    _buildSummaryRow("Cash Paid Out", -(shiftSummary["cash_paid_out"] as double)),
                    Divider(),
                    _buildSummaryRow("Expected Balance", shiftSummary["expected_balance"] as double, isTotal: true),
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
                                  "Transactions",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${shiftSummary["transaction_count"]}",
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
                              color: Colors.orange.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Refunds",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${shiftSummary["refund_count"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fsH6,
                                    color: Colors.orange,
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
                              color: Colors.red.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Voids",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "${shiftSummary["void_count"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fsH6,
                                    color: Colors.red,
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

              // Cash Count
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
                        Text(
                          "Final Cash Count",
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
                            "Total: \$${countedTotal.currency}",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Bills Section
                    Text(
                      "Bills",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...denominationCounts.where((d) => d["type"] == "bills").map((denomination) {
                      int index = denominationCounts.indexOf(denomination);
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "\$${(denomination["value"] as double).toStringAsFixed(0)}",
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
                    
                    SizedBox(height: spSm),
                    
                    // Coins Section
                    Text(
                      "Coins",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...denominationCounts.where((d) => d["type"] == "coins").map((denomination) {
                      int index = denominationCounts.indexOf(denomination);
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${(denomination["value"] as double) < 1 ? ((denomination["value"] as double) * 100).toInt() : (denomination["value"] as double).toInt()}¢",
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

              // Variance Summary
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
                          "Expected Balance:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${(shiftSummary["expected_balance"] as double).currency}",
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
                          "Counted Balance:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$${countedTotal.currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          "Variance:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${variance >= 0 ? '+' : ''}\$${variance.abs().currency}",
                          style: TextStyle(
                            fontSize: 18,
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
                                "Large variance detected. Please verify the count.",
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

              // Closing Information
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
                      "Closing Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Reason for Closing",
                      items: reasonOptions,
                      value: reason,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        reason = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Closing Notes (Optional)",
                      value: notes,
                      hint: "Add any notes about the shift or discrepancies...",
                      onChanged: (value) {
                        notes = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            label: "Print Closing Report",
                            items: [
                              {
                                "label": "Print Report",
                                "value": true,
                                "checked": printReceipt,
                              }
                            ],
                            value: [
                              if (printReceipt)
                                {
                                  "label": "Print Report",
                                  "value": true,
                                  "checked": true,
                                }
                            ],
                            onChanged: (values, ids) {
                              printReceipt = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
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
                      label: "Cancel",
                      color: Colors.grey,
                      size: bs.md,
                      onPressed: () {
                        back();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Close Drawer",
                      icon: Icons.lock,
                      size: bs.md,
                      onPressed: isProcessing ? null : _closeDrawer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Spacer(),
          Text(
            "${amount < 0 ? '-' : ''}\$${amount.abs().currency}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? primaryColor : (amount < 0 ? Colors.red : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
