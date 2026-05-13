import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCashOutView extends StatefulWidget {
  const PosCashOutView({Key? key}) : super(key: key);

  @override
  State<PosCashOutView> createState() => _PosCashOutViewState();
}

class _PosCashOutViewState extends State<PosCashOutView> {
  final formKey = GlobalKey<FormState>();
  String amount = "";
  String reason = "customer_refund";
  String description = "";
  String paidTo = "";
  String referenceNumber = "";
  String managerCode = "";
  bool requiresApproval = false;
  bool isProcessing = false;

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "Customer Refund", "value": "customer_refund"},
    {"label": "Petty Cash", "value": "petty_cash"},
    {"label": "Expenses", "value": "expenses"},
    {"label": "Bank Deposit", "value": "bank_deposit"},
    {"label": "Vendor Payment", "value": "vendor_payment"},
    {"label": "Till Adjustment", "value": "till_adjustment"},
    {"label": "Employee Advance", "value": "employee_advance"},
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

  List<Map<String, dynamic>> recentCashOuts = [
    {
      "id": "CO-2024-025",
      "amount": 45.80,
      "reason": "Customer Refund",
      "time": "15:20",
      "cashier": "Sarah M.",
      "status": "completed"
    },
    {
      "id": "CO-2024-024",
      "amount": 125.00,
      "reason": "Petty Cash",
      "time": "14:30",
      "cashier": "John D.",
      "status": "pending_approval"
    },
    {
      "id": "CO-2024-023",
      "amount": 500.00,
      "reason": "Bank Deposit",
      "time": "13:15",
      "cashier": "Manager",
      "status": "completed"
    },
  ];

  Map<String, dynamic> drawerBalance = {
    "current_balance": 1650.75,
    "available_cash": 1450.75,
    "minimum_float": 200.00,
  };

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

  bool get hasInsufficientFunds {
    double enteredAmount = double.tryParse(amount) ?? 0;
    double remainingBalance = (drawerBalance["current_balance"] as double) - enteredAmount - (drawerBalance["minimum_float"] as double);
    return remainingBalance < 0;
  }

  void _processCashOut() async {
    if (!formKey.currentState!.validate()) return;

    double enteredAmount = double.tryParse(amount) ?? 0;
    if (enteredAmount <= 0) {
      se("Please enter a valid amount");
      return;
    }

    if (hasInsufficientFunds) {
      se("Insufficient funds. Available cash: \$${(drawerBalance["available_cash"] as double).currency}");
      return;
    }

    if (hasVariance) {
      bool isConfirmed = await confirm("Amount entered (\$${enteredAmount.currency}) doesn't match breakdown total (\$${totalBreakdown.currency}). Continue?");
      if (!isConfirmed) return;
    }

    if (enteredAmount > 100 && (reason == "petty_cash" || reason == "expenses")) {
      if (managerCode.isEmpty) {
        se("Manager authorization required for amounts over \$100");
        return;
      }
      requiresApproval = true;
    }

    if (enteredAmount > 500) {
      bool isConfirmed = await confirm("Large cash out amount detected. This requires manager approval. Continue?");
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
      si("Cash out submitted for approval");
    } else {
      ss("Cash out processed successfully");
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
        title: Text("Cash Out"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo(CashOutHistoryView)
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
              // Drawer Balance Info
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: Colors.blue.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: Colors.blue, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available Cash: \$${(drawerBalance["available_cash"] as double).currency}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "Minimum Float: \$${(drawerBalance["minimum_float"] as double).currency}",
                            style: TextStyle(
                              color: disabledBoldColor,
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

              // Cash Out Information
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
                      "Cash Out Information",
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
                      label: "Reason for Cash Out",
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
                      label: "Paid To",
                      value: paidTo,
                      hint: "Customer name, vendor, etc.",
                      validator: Validator.required,
                      onChanged: (value) {
                        paidTo = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Reference Number (Optional)",
                      value: referenceNumber,
                      hint: "Receipt number, invoice number, etc.",
                      onChanged: (value) {
                        referenceNumber = value;
                        setState(() {});
                      },
                    ),
                    if ((double.tryParse(amount) ?? 0) > 100 && (reason == "petty_cash" || reason == "expenses")) ...[
                      SizedBox(height: spSm),
                      QTextField(
                        label: "Manager Authorization Code",
                        value: managerCode,
                        hint: "Required for amounts over \$100",
                        validator: Validator.required,
                        onChanged: (value) {
                          managerCode = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Amount Verification
              if (double.tryParse(amount) != null && (double.tryParse(amount) ?? 0) > 0) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: hasInsufficientFunds 
                        ? Colors.red.withAlpha(10)
                        : (double.tryParse(amount) ?? 0) > 500 
                            ? Colors.orange.withAlpha(10) 
                            : Colors.green.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: hasInsufficientFunds 
                          ? Colors.red.withAlpha(30)
                          : (double.tryParse(amount) ?? 0) > 500 
                              ? Colors.orange.withAlpha(30) 
                              : Colors.green.withAlpha(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        hasInsufficientFunds 
                            ? Icons.error
                            : (double.tryParse(amount) ?? 0) > 500 
                                ? Icons.warning 
                                : Icons.check_circle,
                        color: hasInsufficientFunds 
                            ? Colors.red
                            : (double.tryParse(amount) ?? 0) > 500 
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
                            if (hasInsufficientFunds)
                              Text(
                                "Insufficient funds - exceeds available cash",
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 12,
                                ),
                              )
                            else if ((double.tryParse(amount) ?? 0) > 500)
                              Text(
                                "Large amount - requires manager approval",
                                style: TextStyle(
                                  color: Colors.orange.shade700,
                                  fontSize: 12,
                                ),
                              )
                            else
                              Text(
                                "Remaining balance: \$${((drawerBalance["current_balance"] as double) - (double.tryParse(amount) ?? 0)).currency}",
                                style: TextStyle(
                                  color: Colors.green.shade700,
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
                              color: hasVariance ? Colors.orange.withAlpha(20) : Colors.red.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Total: \$${totalBreakdown.currency}",
                              style: TextStyle(
                                color: hasVariance ? Colors.orange : Colors.red,
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
                                  color: Colors.red,
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
                                  color: Colors.red,
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
                      hint: "Add any additional notes about this cash out transaction...",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Recent Cash Outs
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
                      "Recent Cash Outs",
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
                      itemCount: recentCashOuts.length,
                      itemBuilder: (context, index) {
                        final cashOut = recentCashOuts[index];
                        final isPending = cashOut["status"] == "pending_approval";
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: index < recentCashOuts.length - 1 ? spSm : 0),
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
                                  color: isPending ? Colors.orange.withAlpha(20) : Colors.red.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  isPending ? Icons.pending : Icons.remove_circle,
                                  color: isPending ? Colors.orange : Colors.red,
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
                                          "${cashOut["id"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${cashOut["time"]}",
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
                                          "${cashOut["reason"]} • ${cashOut["cashier"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "-\$${(cashOut["amount"] as double).currency}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
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
                      label: "Process Cash Out",
                      icon: Icons.remove_circle,
                      size: bs.md,
                      onPressed: isProcessing || hasInsufficientFunds ? null : _processCashOut,
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
