import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction3View extends StatefulWidget {
  const GrlTransaction3View({Key? key}) : super(key: key);

  @override
  State<GrlTransaction3View> createState() => _GrlTransaction3ViewState();
}

class _GrlTransaction3ViewState extends State<GrlTransaction3View> {
  final formKey = GlobalKey<FormState>();
  
  String recipient = "";
  String accountNumber = "";
  String amount = "";
  String description = "";
  String selectedPaymentMethod = "bank_transfer";
  bool saveAsTemplate = false;
  bool schedulePayment = false;
  String selectedDate = DateTime.now().add(Duration(days: 1)).toIso8601String();
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "label": "Bank Transfer",
      "value": "bank_transfer",
      "icon": Icons.account_balance,
      "fee": 2.50,
    },
    {
      "label": "Credit Card",
      "value": "credit_card", 
      "icon": Icons.credit_card,
      "fee": 3.99,
    },
    {
      "label": "Digital Wallet",
      "value": "digital_wallet",
      "icon": Icons.account_balance_wallet,
      "fee": 1.50,
    },
  ];

  List<Map<String, dynamic>> recentRecipients = [
    {
      "name": "John Smith",
      "account": "**** 1234",
      "bank": "Chase Bank",
      "avatar": "JS",
    },
    {
      "name": "Sarah Wilson",
      "account": "**** 5678",
      "bank": "Wells Fargo",
      "avatar": "SW",
    },
    {
      "name": "Mike Johnson",
      "account": "**** 9012",
      "bank": "Bank of America",
      "avatar": "MJ",
    },
  ];

  Map<String, dynamic> get selectedMethod {
    return paymentMethods.firstWhere(
      (method) => method["value"] == selectedPaymentMethod,
      orElse: () => paymentMethods.first,
    );
  }

  double get processingFee {
    return selectedMethod["fee"] as double;
  }

  double get totalAmount {
    double amt = double.tryParse(amount) ?? 0.0;
    return amt + processingFee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Money"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Recent Recipients
              Text(
                "Recent Recipients",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QHorizontalScroll(
                children: List.generate(recentRecipients.length, (index) {
                  final recipient = recentRecipients[index];
                  return Container(
                    width: 120,
                    margin: EdgeInsets.only(
                      right: index < recentRecipients.length - 1 ? spSm : 0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        this.recipient = recipient["name"];
                        accountNumber = recipient["account"];
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Center(
                              child: Text(
                                "${recipient["avatar"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${recipient["name"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${recipient["bank"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              // Recipient Details
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                      "Recipient Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Recipient Name",
                      value: recipient,
                      validator: Validator.required,
                      hint: "Enter recipient's full name",
                      onChanged: (value) {
                        recipient = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Account Number",
                      value: accountNumber,
                      validator: Validator.required,
                      hint: "Enter account number",
                      onChanged: (value) {
                        accountNumber = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Amount
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                      "Amount",
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
                    if (amount.isNotEmpty && double.tryParse(amount) != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Amount",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${(double.tryParse(amount) ?? 0.0).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Processing Fee",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${processingFee.currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: disabledOutlineBorderColor),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Total Amount",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${totalAmount.currency}",
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
                  ],
                ),
              ),

              // Payment Method
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                      "Payment Method",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Select Payment Method",
                      items: paymentMethods,
                      value: selectedPaymentMethod,
                      onChanged: (value, label) {
                        selectedPaymentMethod = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: selectedMethod["fee"] > 2.0 
                            ? warningColor.withAlpha(10)
                            : successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: selectedMethod["fee"] > 2.0 
                              ? warningColor.withAlpha(50)
                              : successColor.withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            selectedMethod["icon"] as IconData,
                            color: selectedMethod["fee"] > 2.0 
                                ? warningColor
                                : successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${selectedMethod["label"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Processing fee: \$${(selectedMethod["fee"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Description & Options
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
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
                      "Additional Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Description (Optional)",
                      value: description,
                      hint: "What's this payment for?",
                      onChanged: (value) {
                        description = value;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Save as template for future use",
                          "value": true,
                          "checked": saveAsTemplate,
                        }
                      ],
                      value: [
                        if (saveAsTemplate)
                          {
                            "label": "Save as template for future use",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        saveAsTemplate = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Schedule this payment",
                          "value": true,
                          "checked": schedulePayment,
                        }
                      ],
                      value: [
                        if (schedulePayment)
                          {
                            "label": "Schedule this payment",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        schedulePayment = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (schedulePayment)
                      QDatePicker(
                        label: "Schedule Date",
                        value: DateTime.parse(selectedDate),
                        onChanged: (value) {
                          selectedDate = value.toIso8601String();
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

              // Send Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: schedulePayment ? "Schedule Payment" : "Send Money",
                  size: bs.md,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      bool isConfirmed = await confirm(
                        "Are you sure you want to ${schedulePayment ? 'schedule' : 'send'} \$${totalAmount.currency} to $recipient?"
                      );
                      if (isConfirmed) {
                        showLoading();
                        await Future.delayed(Duration(seconds: 2));
                        hideLoading();
                        ss(schedulePayment 
                            ? "Payment scheduled successfully" 
                            : "Money sent successfully");
                        back();
                      }
                    }
                  },
                ),
              ),

              // Security Notice
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: infoColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Your transaction is protected by bank-level security and encryption.",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
