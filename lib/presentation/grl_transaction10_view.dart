import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction10View extends StatefulWidget {
  @override
  State<GrlTransaction10View> createState() => _GrlTransaction10ViewState();
}

class _GrlTransaction10ViewState extends State<GrlTransaction10View> {
  String recipientName = "";
  String recipientPhone = "";
  String amount = "";
  String note = "";
  String selectedContact = "";

  List<Map<String, dynamic>> recentContacts = [
    {
      "name": "John Smith",
      "phone": "+1 555-0123",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "last_transfer": "2024-01-10",
    },
    {
      "name": "Sarah Johnson",
      "phone": "+1 555-0124",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=woman",
      "last_transfer": "2024-01-08",
    },
    {
      "name": "Mike Davis",
      "phone": "+1 555-0125",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=man",
      "last_transfer": "2024-01-05",
    },
    {
      "name": "Emily Wilson",
      "phone": "+1 555-0126",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=girl",
      "last_transfer": "2024-01-03",
    },
  ];

  List<Map<String, dynamic>> quickAmounts = [
    {"amount": 10, "label": "\$10"},
    {"amount": 25, "label": "\$25"},
    {"amount": 50, "label": "\$50"},
    {"amount": 100, "label": "\$100"},
    {"amount": 200, "label": "\$200"},
    {"amount": 500, "label": "\$500"},
  ];

  Map<String, dynamic> accountBalance = {
    "available": 1250.75,
    "pending": 45.20,
  };

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Available Balance",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "\$${((accountBalance["available"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if ((accountBalance["pending"] as double) > 0) ...[
                      SizedBox(height: spXs),
                      Text(
                        "\$${((accountBalance["pending"] as double).toDouble()).currency} pending",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Recent Contacts
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
                children: [
                  // Add New Contact
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 70,
                      margin: EdgeInsets.only(right: spSm),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(
                                color: primaryColor,
                                style: BorderStyle.solid,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Add Contact",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Recent Contacts
                  ...recentContacts.map((contact) {
                    bool isSelected = selectedContact == "${contact["phone"]}";
                    return GestureDetector(
                      onTap: () {
                        selectedContact = "${contact["phone"]}";
                        recipientName = "${contact["name"]}";
                        recipientPhone = "${contact["phone"]}";
                        setState(() {});
                      },
                      child: Container(
                        width: 70,
                        margin: EdgeInsets.only(right: spSm),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: isSelected
                                  ? Border.all(color: primaryColor, width: 2)
                                  : null,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${contact["avatar"]}",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${contact["name"]}".split(' ')[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? primaryColor : disabledBoldColor,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
              SizedBox(height: spMd),

              // Recipient Details
              Text(
                "Recipient Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "Recipient Name",
                value: recipientName,
                hint: "Enter recipient's full name",
                validator: Validator.required,
                onChanged: (value) {
                  recipientName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "Phone Number",
                value: recipientPhone,
                hint: "+1 555-0123",
                validator: Validator.required,
                onChanged: (value) {
                  recipientPhone = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Amount Section
              Text(
                "Transfer Amount",
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
                hint: "0.00",
                validator: Validator.required,
                onChanged: (value) {
                  amount = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              // Quick Amount Buttons
              Text(
                "Quick Amount",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: quickAmounts.map((quickAmount) {
                  bool isSelected = amount == "${quickAmount["amount"]}";
                  return GestureDetector(
                    onTap: () {
                      amount = "${quickAmount["amount"]}";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: isSelected ? null : Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Text(
                        "${quickAmount["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spMd),

              // Note Section
              QMemoField(
                label: "Note (Optional)",
                value: note,
                hint: "Add a note for the recipient",
                onChanged: (value) {
                  note = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Transfer Summary
              if (amount.isNotEmpty && recipientName.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(color: primaryColor.withAlpha(50)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transfer Summary",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "To:",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            recipientName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Amount:",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(double.tryParse(amount) ?? 0.0).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transfer Fee:",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Free",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: spMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "\$${(double.tryParse(amount) ?? 0.0).toStringAsFixed(2)}",
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
                SizedBox(height: spMd),
              ],

              // Security Notice
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your transfer is secured with bank-level encryption and requires authentication to complete.",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: QButton(
                        label: "Save as Draft",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Continue",
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
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        title: Text(
          "Confirm Transfer",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You are about to send:",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "\$${(double.tryParse(amount) ?? 0.0).toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "To: $recipientName",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "Phone: $recipientPhone",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            if (note.isNotEmpty) ...[
              SizedBox(height: spSm),
              Text(
                "Note: $note",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: disabledBoldColor),
            ),
          ),
          QButton(
            label: "Send Money",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              _processTransfer();
            },
          ),
        ],
      ),
    );
  }

  void _processTransfer() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: primaryColor),
            SizedBox(height: spMd),
            Text(
              "Processing Transfer...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );

    // Simulate processing delay
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 64,
            ),
            SizedBox(height: spMd),
            Text(
              "Transfer Successful!",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your money has been sent to $recipientName",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Done",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                // Reset form
                recipientName = "";
                recipientPhone = "";
                amount = "";
                note = "";
                selectedContact = "";
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
