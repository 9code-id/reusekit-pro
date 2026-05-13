import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaTransferMoneyView extends StatefulWidget {
  const BfaTransferMoneyView({super.key});

  @override
  State<BfaTransferMoneyView> createState() => _BfaTransferMoneyViewState();
}

class _BfaTransferMoneyViewState extends State<BfaTransferMoneyView> {
  final formKey = GlobalKey<FormState>();
  
  String fromAccount = "****5678";
  String transferType = "bank_transfer";
  String recipientType = "saved";
  String selectedBeneficiary = "";
  String recipientName = "";
  String recipientAccount = "";
  String bankName = "";
  String routingNumber = "";
  String amount = "";
  String description = "";
  String transferDate = DateTime.now().toIso8601String().split('T')[0];
  String transferTime = "immediate";
  bool saveAsBeneficiary = false;
  bool sendNotification = true;

  // Sample accounts
  List<Map<String, dynamic>> accountItems = [
    {"label": "Savings Account - \$12,575.00 (****5678)", "value": "****5678"},
    {"label": "Current Account - \$8,420.50 (****9012)", "value": "****9012"},
    {"label": "Credit Account - \$2,100.00 (****3456)", "value": "****3456"},
  ];

  // Sample transfer types
  List<Map<String, dynamic>> transferTypeItems = [
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Wire Transfer", "value": "wire_transfer"},
    {"label": "International Transfer", "value": "international"},
    {"label": "Same Bank Transfer", "value": "same_bank"},
  ];

  // Sample beneficiaries
  List<Map<String, dynamic>> beneficiaryItems = [
    {"label": "John Williams - ****1234", "value": "john_williams"},
    {"label": "Sarah Johnson - ****5678", "value": "sarah_johnson"},
    {"label": "Michael Brown - ****9012", "value": "michael_brown"},
    {"label": "Add New Beneficiary", "value": "new"},
  ];

  // Sample timing options
  List<Map<String, dynamic>> timingItems = [
    {"label": "Immediate", "value": "immediate"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Recurring", "value": "recurring"},
  ];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer Money"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo('BfaTransferHistoryView')
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Quick Transfer Options
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(150)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Transfer",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Send money securely to anyone, anywhere",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    SizedBox(height: spLg),
                    QHorizontalScroll(
                      children: [
                        _buildQuickTransferCard("Pay Bills", Icons.receipt, () {
                          //navigateTo('BfaPayBillsView')
                        }),
                        _buildQuickTransferCard("Mobile Recharge", Icons.phone_android, () {
                          //navigateTo('BfaMobileRechargeView')
                        }),
                        _buildQuickTransferCard("QR Pay", Icons.qr_code_scanner, () {
                          //navigateTo('BfaQrPayView')
                        }),
                      ],
                    ),
                  ],
                ),
              ),

              // From Account Selection
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Transfer From",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    QDropdownField(
                      label: "Select Account",
                      items: accountItems,
                      value: fromAccount,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        fromAccount = value;
                        setState(() {});
                      },
                    ),

                    QDropdownField(
                      label: "Transfer Type",
                      items: transferTypeItems,
                      value: transferType,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        transferType = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Recipient Details
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Transfer To",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    QDropdownField(
                      label: "Select Beneficiary",
                      items: beneficiaryItems,
                      value: selectedBeneficiary,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedBeneficiary = value;
                        if (value == "new") {
                          recipientType = "new";
                        } else {
                          recipientType = "saved";
                          // Auto-fill beneficiary details
                          _fillBeneficiaryDetails(value);
                        }
                        setState(() {});
                      },
                    ),

                    if (recipientType == "new" || selectedBeneficiary == "new") ...[
                      QTextField(
                        label: "Recipient Name",
                        value: recipientName,
                        validator: Validator.required,
                        onChanged: (value) {
                          recipientName = value;
                          setState(() {});
                        },
                      ),

                      QTextField(
                        label: "Account Number",
                        value: recipientAccount,
                        validator: Validator.required,
                        onChanged: (value) {
                          recipientAccount = value;
                          setState(() {});
                        },
                      ),

                      QTextField(
                        label: "Bank Name",
                        value: bankName,
                        validator: Validator.required,
                        onChanged: (value) {
                          bankName = value;
                          setState(() {});
                        },
                      ),

                      if (transferType == "wire_transfer" || transferType == "international") ...[
                        QTextField(
                          label: "Routing Number / SWIFT Code",
                          value: routingNumber,
                          validator: Validator.required,
                          onChanged: (value) {
                            routingNumber = value;
                            setState(() {});
                          },
                        ),
                      ],

                      Row(
                        children: [
                          Expanded(
                            child: QSwitch(
                              items: [
                                {
                                  "label": "Save as Beneficiary",
                                  "value": true,
                                  "checked": saveAsBeneficiary,
                                }
                              ],
                              value: [
                                if (saveAsBeneficiary)
                                  {
                                    "label": "Save as Beneficiary",
                                    "value": true,
                                    "checked": true
                                  }
                              ],
                              onChanged: (values, ids) {
                                saveAsBeneficiary = values.isNotEmpty;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Transfer Details
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Transfer Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    QNumberField(
                      label: "Amount (\$)",
                      value: amount,
                      validator: Validator.required,
                      onChanged: (value) {
                        amount = value;
                        setState(() {});
                      },
                    ),

                    QMemoField(
                      label: "Description (Optional)",
                      value: description,
                      hint: "Enter transfer description or reference",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),

                    QDropdownField(
                      label: "Transfer Timing",
                      items: timingItems,
                      value: transferTime,
                      onChanged: (value, label) {
                        transferTime = value;
                        setState(() {});
                      },
                    ),

                    if (transferTime == "scheduled" || transferTime == "recurring") ...[
                      QDatePicker(
                        label: "Transfer Date",
                        value: DateTime.parse(transferDate),
                        onChanged: (value) {
                          transferDate = value.toIso8601String().split('T')[0];
                          setState(() {});
                        },
                      ),
                    ],

                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            items: [
                              {
                                "label": "Send Notification",
                                "value": true,
                                "checked": sendNotification,
                              }
                            ],
                            value: [
                              if (sendNotification)
                                {
                                  "label": "Send Notification",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              sendNotification = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Transfer Fee Information
              if (amount.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Transfer Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      _buildSummaryRow("Transfer Amount", "\$${(double.tryParse(amount) ?? 0.0).currency}"),
                      _buildSummaryRow("Transfer Fee", "\$${_calculateFee().currency}"),
                      Divider(color: disabledOutlineBorderColor),
                      _buildSummaryRow("Total Amount", "\$${((double.tryParse(amount) ?? 0.0) + _calculateFee()).currency}", true),
                    ],
                  ),
                ),
              ],

              // Transfer Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Processing..." : "Review Transfer",
                  icon: Icons.send,
                  size: bs.md,
                  onPressed: loading ? null : () async {
                    if (formKey.currentState!.validate()) {
                      loading = true;
                      setState(() {});
                      
                      // Simulate processing
                      await Future.delayed(Duration(seconds: 2));
                      
                      loading = false;
                      setState(() {});
                      
                      //navigateTo('BfaTransferConfirmationView')
                      ss("Transfer details reviewed successfully");
                    }
                  },
                ),
              ),

              // Recent Transfers
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Transfers",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //navigateTo('BfaTransferHistoryView')
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    _buildRecentTransferItem("John Williams", "****1234", "\$500.00", "Dec 14"),
                    _buildRecentTransferItem("Sarah Johnson", "****5678", "\$250.00", "Dec 13"),
                    _buildRecentTransferItem("Michael Brown", "****9012", "\$1,000.00", "Dec 12"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTransferCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(40),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: Colors.white.withAlpha(60)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                icon,
                color: primaryColor,
                size: 20,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, [bool isBold = false]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: isBold ? primaryColor : disabledBoldColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransferItem(String name, String account, String amount, String date) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.person,
              color: primaryColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  account,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateFee() {
    double transferAmount = double.tryParse(amount) ?? 0.0;
    double feePercentage = 0.0;
    
    switch (transferType) {
      case "bank_transfer":
        feePercentage = 0.01; // 1%
        break;
      case "wire_transfer":
        feePercentage = 0.015; // 1.5%
        break;
      case "international":
        feePercentage = 0.025; // 2.5%
        break;
      case "same_bank":
        feePercentage = 0.005; // 0.5%
        break;
    }
    
    return transferAmount * feePercentage;
  }

  void _fillBeneficiaryDetails(String beneficiaryId) {
    switch (beneficiaryId) {
      case "john_williams":
        recipientName = "John Williams";
        recipientAccount = "****1234";
        bankName = "ABC Bank";
        break;
      case "sarah_johnson":
        recipientName = "Sarah Johnson";
        recipientAccount = "****5678";
        bankName = "XYZ Bank";
        break;
      case "michael_brown":
        recipientName = "Michael Brown";
        recipientAccount = "****9012";
        bankName = "DEF Bank";
        break;
    }
  }
}
