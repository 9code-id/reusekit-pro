import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCashInView extends StatefulWidget {
  const PosCashInView({Key? key}) : super(key: key);

  @override
  State<PosCashInView> createState() => _PosCashInViewState();
}

class _PosCashInViewState extends State<PosCashInView> {
  final formKey = GlobalKey<FormState>();
  String amount = "";
  String reason = "change_fund";
  String description = "";
  String receivedFrom = "";
  String referenceNumber = "";
  bool requiresApproval = false;
  bool isProcessing = false;

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "Change Fund", "value": "change_fund"},
    {"label": "Cash Deposit", "value": "cash_deposit"},
    {"label": "Till Adjustment", "value": "till_adjustment"},
    {"label": "Bank Drop", "value": "bank_drop"},
    {"label": "Refund Return", "value": "refund_return"},
    {"label": "Petty Cash", "value": "petty_cash"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> denominationBreakdown = [
    {"type": "bills", "value": 100.00, "quantity": "0", "label": "\$100 Bills"},
    {"type": "bills", "value": 50.00, "quantity": "0", "label": "\$50 Bills"},
    {"type": "bills", "value": 20.00, "quantity": "0", "label": "\$20 Bills"},
    {"type": "bills", "value": 10.00, "quantity": "0", "label": "\$10 Bills"},
    {"type": "bills", "value": 5.00, "quantity": "0", "label": "\$5 Bills"},
    {"type": "bills", "value": 1.00, "quantity": "0", "label": "\$1 Bills"},
    {"type": "coins", "value": 0.25, "quantity": "0", "label": "Quarters"},
    {"type": "coins", "value": 0.10, "quantity": "0", "label": "Dimes"},
    {"type": "coins", "value": 0.05, "quantity": "0", "label": "Nickels"},
    {"type": "coins", "value": 0.01, "quantity": "0", "label": "Pennies"},
  ];

  List<Map<String, dynamic>> recentCashIns = [
    {
      "id": "CI-2024-015",
      "amount": 500.00,
      "reason": "Change Fund",
      "time": "14:30",
      "cashier": "Sarah M.",
      "status": "completed"
    },
    {
      "id": "CI-2024-014",
      "amount": 200.00,
      "reason": "Till Adjustment",
      "time": "12:15",
      "cashier": "John D.",
      "status": "completed"
    },
    {
      "id": "CI-2024-013",
      "amount": 1000.00,
      "reason": "Bank Drop",
      "time": "11:45",
      "cashier": "Manager",
      "status": "pending_approval"
    },
  ];

  double get totalBreakdown {
    double total = 0;
    for (var denomination in denominationBreakdown) {
      int quantity = int.tryParse(denomination["quantity"]) ?? 0;
      double value = denomination["value"] as double;
      total += quantity * value;
    }
    return total;
  }

  bool get hasVariance {
    double enteredAmount = double.tryParse(amount) ?? 0;
    return (enteredAmount - totalBreakdown).abs() > 0.01 && enteredAmount > 0 && totalBreakdown > 0;
  }

  void _processCashIn() async {
    if (!formKey.currentState!.validate()) return;

    double enteredAmount = double.tryParse(amount) ?? 0;
    if (enteredAmount <= 0) {
      se("Please enter a valid amount");
      return;
    }

    if (hasVariance) {
      bool isConfirmed = await confirm("Amount entered (\$${enteredAmount.currency}) doesn't match breakdown total (\$${totalBreakdown.currency}). Continue?");
      if (!isConfirmed) return;
    }

    if (enteredAmount > 1000 && reason != "bank_drop") {
      bool isConfirmed = await confirm("Large cash in amount detected. This may require manager approval. Continue?");
      if (!isConfirmed) return;
      requiresApproval = true;
    }

    isProcessing = true;
    setState(() {});

    showLoading();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    hideLoading();
    isProcessing = false;
    setState(() {});

    if (requiresApproval) {
      si("Cash in submitted for approval");
    } else {
      ss("Cash in processed successfully");
    }
    back();
  }

  void _clearBreakdown() {
    for (var denomination in denominationBreakdown) {
      denomination["quantity"] = "0";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cash In"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo(CashInHistoryView)
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
              // Cash In Information
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
                      "Cash In Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QNumberField(
                      label: "Amount (\$)",
                      value: amount,
                      validator: Validator.required,
                      onChanged: (value) {
                        amount = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Reason for Cash In",
                      items: reasonOptions,
                      value: reason,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        reason = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Received From",
                      value: receivedFrom,
                      hint: "e.g., Bank, Customer, Manager",
                      validator: Validator.required,
                      onChanged: (value) {
                        receivedFrom = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Reference Number (Optional)",
                      value: referenceNumber,
                      hint: "Receipt number, deposit slip, etc.",
                      onChanged: (value) {
                        referenceNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Amount Verification
              if (double.tryParse(amount) != null && (double.tryParse(amount) ?? 0) > 0) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (double.tryParse(amount) ?? 0) > 500 
                        ? Colors.orange.withAlpha(10) 
                        : Colors.green.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: (double.tryParse(amount) ?? 0) > 500 
                          ? Colors.orange.withAlpha(30) 
                          : Colors.green.withAlpha(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (double.tryParse(amount) ?? 0) > 500 
                            ? Icons.warning 
                            : Icons.check_circle,
                        color: (double.tryParse(amount) ?? 0) > 500 
                            ? Colors.orange 
                            : Colors.green,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amount: \$${(double.tryParse(amount) ?? 0).currency}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: primaryColor,
                              ),
                            ),
                            if ((double.tryParse(amount) ?? 0) > 500)
                              Text(
                                "Large amount - may require approval",
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),
              ],

              // Denomination Breakdown (Optional)
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
                          "Denomination Breakdown (Optional)",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        if (totalBreakdown > 0) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: hasVariance ? Colors.orange.withAlpha(20) : Colors.green.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Total: \$${totalBreakdown.currency}",
                              style: TextStyle(
                                color: hasVariance ? Colors.orange : Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                        ],
                        GestureDetector(
                          onTap: _clearBreakdown,
                          child: Text(
                            "Clear",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (hasVariance) ...[
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.orange.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning, color: Colors.orange, size: 16),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Variance: \$${((double.tryParse(amount) ?? 0) - totalBreakdown).abs().currency}",
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                    ...denominationBreakdown.where((d) => d["type"] == "bills").map((denomination) {
                      int index = denominationBreakdown.indexOf(denomination);
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
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
                                label: "Qty",
                                value: denomination["quantity"],
                                onChanged: (value) {
                                  denominationBreakdown[index]["quantity"] = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 80,
                              child: Text(
                                "\$${((int.tryParse(denomination["quantity"]) ?? 0) * (denomination["value"] as double)).currency}",
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
                    ...denominationBreakdown.where((d) => d["type"] == "coins").map((denomination) {
                      int index = denominationBreakdown.indexOf(denomination);
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
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
                                label: "Qty",
                                value: denomination["quantity"],
                                onChanged: (value) {
                                  denominationBreakdown[index]["quantity"] = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 80,
                              child: Text(
                                "\$${((int.tryParse(denomination["quantity"]) ?? 0) * (denomination["value"] as double)).currency}",
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

              // Description
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
                      "Additional Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Description (Optional)",
                      value: description,
                      hint: "Add any additional notes about this cash in transaction...",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Recent Cash Ins
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
                      "Recent Cash Ins",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recentCashIns.length,
                      itemBuilder: (context, index) {
                        final cashIn = recentCashIns[index];
                        final isPending = cashIn["status"] == "pending_approval";
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: index < recentCashIns.length - 1 ? spSm : 0),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: isPending ? Colors.orange.withAlpha(20) : Colors.green.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  isPending ? Icons.pending : Icons.add_circle,
                                  color: isPending ? Colors.orange : Colors.green,
                                  size: 18,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${cashIn["id"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${cashIn["time"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Text(
                                          "${cashIn["reason"]} • ${cashIn["cashier"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "\$${(cashIn["amount"] as double).currency}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isPending)
                                      Container(
                                        margin: EdgeInsets.only(top: spXs),
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Pending Approval",
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
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
                      label: "Process Cash In",
                      icon: Icons.add_circle,
                      size: bs.md,
                      onPressed: isProcessing ? null : _processCashIn,
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
}
