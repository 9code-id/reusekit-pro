import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet4View extends StatefulWidget {
  @override
  State<GrlWallet4View> createState() => _GrlWallet4ViewState();
}

class _GrlWallet4ViewState extends State<GrlWallet4View> {
  String recipientName = "";
  String recipientEmail = "";
  String amount = "";
  String note = "";
  String selectedAccount = "Main Account";
  
  List<Map<String, dynamic>> accounts = [
    {
      "name": "Main Account",
      "number": "**** 1234",
      "balance": 8500.0,
      "type": "Checking"
    },
    {
      "name": "Savings Account", 
      "number": "**** 5678",
      "balance": 12300.0,
      "type": "Savings"
    },
    {
      "name": "Business Account",
      "number": "**** 9012", 
      "balance": 3200.0,
      "type": "Business"
    }
  ];

  List<Map<String, dynamic>> recentContacts = [
    {
      "name": "John Smith",
      "email": "john@example.com",
      "avatar": "JS",
      "color": Colors.blue
    },
    {
      "name": "Sarah Wilson",
      "email": "sarah@example.com", 
      "avatar": "SW",
      "color": Colors.pink
    },
    {
      "name": "Mike Johnson",
      "email": "mike@example.com",
      "avatar": "MJ", 
      "color": Colors.green
    },
    {
      "name": "Emma Davis",
      "email": "emma@example.com",
      "avatar": "ED",
      "color": Colors.purple
    }
  ];

  List<String> quickAmounts = ["10", "25", "50", "100", "200", "500"];

  final formKey = GlobalKey<FormState>();

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
            spacing: spMd,
            children: [
              // From Account Selection
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From Account",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Select Account",
                      items: accounts.map((account) => {
                        "label": "${account["name"]} - \$${(account["balance"] as double).currency}",
                        "value": account["name"],
                      }).toList(),
                      value: selectedAccount,
                      onChanged: (value, label) {
                        selectedAccount = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Recent Contacts
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Contacts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QHorizontalScroll(
                      children: recentContacts.map((contact) {
                        return _buildContactItem(contact);
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Recipient Details
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Recipient Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
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
                      label: "Email or Phone",
                      value: recipientEmail,
                      validator: Validator.email,
                      onChanged: (value) {
                        recipientEmail = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Amount Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
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
                    Text(
                      "Quick Amounts",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: quickAmounts.map((quickAmount) {
                        return GestureDetector(
                          onTap: () {
                            amount = quickAmount;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: amount == quickAmount 
                                  ? primaryColor.withAlpha(30)
                                  : disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: amount == quickAmount 
                                    ? primaryColor
                                    : disabledColor,
                              ),
                            ),
                            child: Text(
                              "\$$quickAmount",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: amount == quickAmount 
                                    ? primaryColor
                                    : disabledBoldColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Note Section
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Add Note (Optional)",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Note",
                      value: note,
                      hint: "Add a message for the recipient",
                      onChanged: (value) {
                        note = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Transaction Summary
              if (amount.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(100)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Transaction Summary",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      _buildSummaryRow("Amount:", "\$${amount}"),
                      _buildSummaryRow("Transfer Fee:", "\$0.00"),
                      _buildSummaryRow("Total:", "\$${amount}"),
                    ],
                  ),
                ),

              // Send Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send Money",
                  icon: Icons.send,
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _showConfirmationDialog();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return GestureDetector(
      onTap: () {
        recipientName = contact["name"];
        recipientEmail = contact["email"];
        setState(() {});
      },
      child: Container(
        width: 80,
        margin: EdgeInsets.only(right: spSm),
        child: Column(
          spacing: spXs,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: contact["color"] as Color,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Center(
                child: Text(
                  "${contact["avatar"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text(
              "${contact["name"]}".split(" ").first,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Transfer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Send \$${amount} to ${recipientName}?"),
            SizedBox(height: spSm),
            Text(
              "From: ${selectedAccount}",
              style: TextStyle(color: disabledBoldColor),
            ),
            Text(
              "To: ${recipientEmail}",
              style: TextStyle(color: disabledBoldColor),
            ),
            if (note.isNotEmpty)
              Text(
                "Note: ${note}",
                style: TextStyle(color: disabledBoldColor),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Confirm",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Money sent successfully!");
            },
          ),
        ],
      ),
    );
  }
}
