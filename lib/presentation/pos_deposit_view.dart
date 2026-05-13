import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosDepositView extends StatefulWidget {
  const PosDepositView({Key? key}) : super(key: key);

  @override
  State<PosDepositView> createState() => _PosDepositViewState();
}

class _PosDepositViewState extends State<PosDepositView> {
  final formKey = GlobalKey<FormState>();
  String amount = "";
  String depositType = "bank_deposit";
  String bankAccount = "";
  String description = "";
  String depositSlipNumber = "";
  String transportedBy = "";
  bool includeCash = true;
  bool includeChecks = false;
  bool includeCreditCard = false;
  bool isProcessing = false;

  List<Map<String, dynamic>> depositTypeOptions = [
    {"label": "Bank Deposit", "value": "bank_deposit"},
    {"label": "Safe Drop", "value": "safe_drop"},
    {"label": "Armored Car", "value": "armored_car"},
    {"label": "Manager Pickup", "value": "manager_pickup"},
    {"label": "Night Drop", "value": "night_drop"},
  ];

  List<Map<String, dynamic>> bankAccounts = [
    {"label": "Main Operating Account - ****1234", "value": "main_operating"},
    {"label": "Daily Deposits Account - ****5678", "value": "daily_deposits"},
    {"label": "Business Savings - ****9012", "value": "business_savings"},
  ];

  List<Map<String, dynamic>> denominationBreakdown = [
    {"type": "bills", "value": 100.00, "quantity": "8", "label": "\$100 Bills"},
    {"type": "bills", "value": 50.00, "quantity": "12", "label": "\$50 Bills"},
    {"type": "bills", "value": 20.00, "quantity": "25", "label": "\$20 Bills"},
    {"type": "bills", "value": 10.00, "quantity": "18", "label": "\$10 Bills"},
    {"type": "bills", "value": 5.00, "quantity": "22", "label": "\$5 Bills"},
    {"type": "bills", "value": 1.00, "quantity": "45", "label": "\$1 Bills"},
    {"type": "coins", "value": 0.25, "quantity": "80", "label": "Quarters"},
    {"type": "coins", "value": 0.10, "quantity": "120", "label": "Dimes"},
    {"type": "coins", "value": 0.05, "quantity": "100", "label": "Nickels"},
    {"type": "coins", "value": 0.01, "quantity": "250", "label": "Pennies"},
  ];

  Map<String, dynamic> summaryData = {
    "cash_sales": 2450.75,
    "check_payments": 340.50,
    "credit_card_tips": 125.25,
    "total_to_deposit": 2916.50,
    "float_retained": 200.00,
    "net_deposit": 2716.50,
  };

  List<Map<String, dynamic>> recentDeposits = [
    {
      "id": "DEP-2024-008",
      "amount": 2850.00,
      "type": "Bank Deposit",
      "date": "Today, 16:30",
      "status": "completed",
      "slip_number": "BD-240123-001"
    },
    {
      "id": "DEP-2024-007",
      "amount": 1950.75,
      "type": "Safe Drop",
      "date": "Yesterday, 18:00",
      "status": "completed",
      "slip_number": "SD-240122-003"
    },
    {
      "id": "DEP-2024-006",
      "amount": 3200.25,
      "type": "Armored Car",
      "date": "Jan 21, 14:15",
      "status": "pending",
      "slip_number": "AC-240121-005"
    },
  ];

  double get totalCashBreakdown {
    double total = 0;
    for (var denomination in denominationBreakdown) {
      int quantity = int.tryParse(denomination["quantity"]) ?? 0;
      double value = denomination["value"] as double;
      total += quantity * value;
    }
    return total;
  }

  double get calculatedDepositAmount {
    double total = 0;
    if (includeCash) total += totalCashBreakdown;
    if (includeChecks) total += summaryData["check_payments"] as double;
    if (includeCreditCard) total += summaryData["credit_card_tips"] as double;
    return total;
  }

  void _processDeposit() async {
    if (!formKey.currentState!.validate()) return;

    double enteredAmount = double.tryParse(amount) ?? 0;
    if (enteredAmount <= 0) {
      se("Please enter a valid deposit amount");
      return;
    }

    if ((enteredAmount - calculatedDepositAmount).abs() > 0.01 && calculatedDepositAmount > 0) {
      bool isConfirmed = await confirm("Entered amount (\$${enteredAmount.currency}) doesn't match calculated amount (\$${calculatedDepositAmount.currency}). Continue?");
      if (!isConfirmed) return;
    }

    isProcessing = true;
    setState(() {});

    showLoading();

    // Simulate API call
    await Future.delayed(Duration(seconds: 3));

    hideLoading();
    isProcessing = false;
    setState(() {});

    ss("Deposit processed successfully");
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Process Deposit"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo(DepositHistoryView)
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
              // Deposit Summary
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
                      "Deposit Summary",
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
                              color: Colors.green.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Total Available",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${(summaryData["total_to_deposit"] as double).currency}",
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
                              color: Colors.blue.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Float Retained",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${(summaryData["float_retained"] as double).currency}",
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
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Net Deposit",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "\$${(summaryData["net_deposit"] as double).currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fsH6,
                                    color: primaryColor,
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

              // Deposit Information
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
                      "Deposit Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QNumberField(
                      label: "Deposit Amount (\$)",
                      value: amount,
                      validator: Validator.required,
                      onChanged: (value) {
                        amount = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Deposit Type",
                      items: depositTypeOptions,
                      value: depositType,
                      onChanged: (value, label) {
                        depositType = value;
                        setState(() {});
                      },
                    ),
                    if (depositType == "bank_deposit") ...[
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Bank Account",
                        items: bankAccounts,
                        value: bankAccount,
                        validator: Validator.required,
                        onChanged: (value, label) {
                          bankAccount = value;
                          setState(() {});
                        },
                      ),
                    ],
                    SizedBox(height: spSm),
                    QTextField(
                      label: depositType == "bank_deposit" ? "Deposit Slip Number" : "Reference Number",
                      value: depositSlipNumber,
                      hint: depositType == "bank_deposit" ? "Bank deposit slip number" : "Reference or tracking number",
                      validator: Validator.required,
                      onChanged: (value) {
                        depositSlipNumber = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Transported By",
                      value: transportedBy,
                      hint: "Name of person handling the deposit",
                      validator: Validator.required,
                      onChanged: (value) {
                        transportedBy = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Deposit Composition
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
                          "Deposit Composition",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        if (calculatedDepositAmount > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.blue.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Calculated: \$${calculatedDepositAmount.currency}",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    // Deposit Type Selection
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            label: "Include Cash",
                            items: [
                              {
                                "label": "Cash (\$${totalCashBreakdown.currency})",
                                "value": true,
                                "checked": includeCash,
                              }
                            ],
                            value: [
                              if (includeCash)
                                {
                                  "label": "Cash (\$${totalCashBreakdown.currency})",
                                  "value": true,
                                  "checked": true,
                                }
                            ],
                            onChanged: (values, ids) {
                              includeCash = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            label: "Include Checks",
                            items: [
                              {
                                "label": "Checks (\$${(summaryData["check_payments"] as double).currency})",
                                "value": true,
                                "checked": includeChecks,
                              }
                            ],
                            value: [
                              if (includeChecks)
                                {
                                  "label": "Checks (\$${(summaryData["check_payments"] as double).currency})",
                                  "value": true,
                                  "checked": true,
                                }
                            ],
                            onChanged: (values, ids) {
                              includeChecks = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            label: "Include Credit Card Tips",
                            items: [
                              {
                                "label": "CC Tips (\$${(summaryData["credit_card_tips"] as double).currency})",
                                "value": true,
                                "checked": includeCreditCard,
                              }
                            ],
                            value: [
                              if (includeCreditCard)
                                {
                                  "label": "CC Tips (\$${(summaryData["credit_card_tips"] as double).currency})",
                                  "value": true,
                                  "checked": true,
                                }
                            ],
                            onChanged: (values, ids) {
                              includeCreditCard = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (includeCash) ...[
                SizedBox(height: spMd),

                // Cash Breakdown
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
                            "Cash Breakdown",
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
                              "Total: \$${totalCashBreakdown.currency}",
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
                      
                      // Bills
                      Text(
                        "Bills",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...denominationBreakdown.where((d) => d["type"] == "bills").take(3).map((denomination) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${denomination["label"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${denomination["quantity"]} × \$${(denomination["value"] as double).toStringAsFixed(0)}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${((int.tryParse(denomination["quantity"]) ?? 0) * (denomination["value"] as double)).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      
                      GestureDetector(
                        onTap: () {
                          //navigateTo(CashBreakdownDetailView)
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              Text(
                                "View Complete Breakdown",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward, color: primaryColor, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: spMd),

              // Additional Notes
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
                      hint: "Add any notes about this deposit...",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Recent Deposits
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
                      "Recent Deposits",
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
                      itemCount: recentDeposits.length,
                      itemBuilder: (context, index) {
                        final deposit = recentDeposits[index];
                        final isPending = deposit["status"] == "pending";
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: index < recentDeposits.length - 1 ? spSm : 0),
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
                                  isPending ? Icons.pending : Icons.account_balance,
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
                                          "${deposit["id"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "${deposit["date"]}",
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
                                          "${deposit["type"]} • ${deposit["slip_number"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "\$${(deposit["amount"] as double).currency}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isPending ? Colors.orange : Colors.green,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
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
                      label: "Process Deposit",
                      icon: Icons.account_balance,
                      size: bs.md,
                      onPressed: isProcessing ? null : _processDeposit,
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
