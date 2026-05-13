import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaMobileRechargeView extends StatefulWidget {
  const BfaMobileRechargeView({super.key});

  @override
  State<BfaMobileRechargeView> createState() => _BfaMobileRechargeViewState();
}

class _BfaMobileRechargeViewState extends State<BfaMobileRechargeView> {
  String phoneNumber = "";
  String selectedOperator = "";
  String selectedPlan = "";
  double customAmount = 0.0;
  
  List<Map<String, dynamic>> operators = [
    {
      "name": "Verizon",
      "value": "verizon",
      "logo": "https://picsum.photos/60/40?random=1&telecom",
      "color": Colors.red,
    },
    {
      "name": "AT&T",
      "value": "att",
      "logo": "https://picsum.photos/60/40?random=2&telecom",
      "color": Colors.blue,
    },
    {
      "name": "T-Mobile",
      "value": "tmobile",
      "logo": "https://picsum.photos/60/40?random=3&telecom",
      "color": Colors.pink,
    },
    {
      "name": "Sprint",
      "value": "sprint",
      "logo": "https://picsum.photos/60/40?random=4&telecom",
      "color": Colors.yellow.shade700,
    },
  ];

  List<Map<String, dynamic>> quickAmounts = [
    {"amount": 10.0, "description": "Basic Top-up"},
    {"amount": 25.0, "description": "Standard Plan"},
    {"amount": 50.0, "description": "Premium Plan"},
    {"amount": 100.0, "description": "Family Plan"},
  ];

  List<Map<String, dynamic>> rechargeHistory = [
    {
      "id": 1,
      "phoneNumber": "+1 555-123-4567",
      "operator": "Verizon",
      "amount": 50.0,
      "date": "2025-01-10T14:30:00",
      "status": "Success",
      "transactionId": "TXN789456123"
    },
    {
      "id": 2,
      "phoneNumber": "+1 555-987-6543",
      "operator": "AT&T",
      "amount": 25.0,
      "date": "2025-01-08T10:15:00",
      "status": "Success",
      "transactionId": "TXN456789012"
    },
    {
      "id": 3,
      "phoneNumber": "+1 555-555-5555",
      "operator": "T-Mobile",
      "amount": 100.0,
      "date": "2025-01-05T16:45:00",
      "status": "Failed",
      "transactionId": "TXN123456789"
    }
  ];

  List<Map<String, dynamic>> savedNumbers = [
    {
      "name": "My Phone",
      "number": "+1 555-123-4567",
      "operator": "Verizon",
      "avatar": "https://picsum.photos/40/40?random=1&face"
    },
    {
      "name": "Mom",
      "number": "+1 555-987-6543",
      "operator": "AT&T",
      "avatar": "https://picsum.photos/40/40?random=2&face"
    },
    {
      "name": "Dad",
      "number": "+1 555-555-5555",
      "operator": "T-Mobile",
      "avatar": "https://picsum.photos/40/40?random=3&face"
    }
  ];

  Color _getOperatorColor(String operatorName) {
    final operator = operators.firstWhere(
      (op) => op["name"] == operatorName,
      orElse: () => {"color": primaryColor},
    );
    return operator["color"] as Color;
  }

  void _selectQuickAmount(double amount) {
    customAmount = amount;
    setState(() {});
  }

  void _selectSavedNumber(Map<String, dynamic> contact) {
    phoneNumber = contact["number"];
    selectedOperator = contact["operator"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile Recharge"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Show recharge history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header Info
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
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.phone_android,
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
                          "Mobile Recharge",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Instant top-up for all carriers",
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
            ),

            // Saved Numbers
            if (savedNumbers.isNotEmpty) ...[
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
                      "Saved Numbers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QHorizontalScroll(
                      children: savedNumbers.map((contact) {
                        return GestureDetector(
                          onTap: () => _selectSavedNumber(contact),
                          child: Container(
                            width: 120,
                            padding: EdgeInsets.all(spSm),
                            margin: EdgeInsets.only(right: spSm),
                            decoration: BoxDecoration(
                              color: phoneNumber == contact["number"]
                                  ? primaryColor.withAlpha(51)
                                  : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: phoneNumber == contact["number"]
                                  ? Border.all(color: primaryColor)
                                  : Border.all(color: disabledOutlineBorderColor),
                            ),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage("${contact["avatar"]}"),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${contact["name"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${contact["operator"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            // Phone Number Input
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
                    "Phone Number",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Enter phone number",
                    value: phoneNumber,
                    hint: "+1 555-123-4567",
                    onChanged: (value) {
                      phoneNumber = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Operator Selection
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
                    "Select Operator",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: operators.map((operator) {
                      return GestureDetector(
                        onTap: () {
                          selectedOperator = operator["name"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: selectedOperator == operator["name"]
                                ? (operator["color"] as Color).withAlpha(51)
                                : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: selectedOperator == operator["name"]
                                ? Border.all(color: operator["color"] as Color)
                                : Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  image: DecorationImage(
                                    image: NetworkImage("${operator["logo"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${operator["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: selectedOperator == operator["name"]
                                        ? operator["color"] as Color
                                        : primaryColor,
                                  ),
                                ),
                              ),
                              if (selectedOperator == operator["name"])
                                Icon(
                                  Icons.check_circle,
                                  color: operator["color"] as Color,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Quick Amount Selection
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
                    "Select Amount",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: quickAmounts.map((amount) {
                      return GestureDetector(
                        onTap: () => _selectQuickAmount(amount["amount"]),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: customAmount == amount["amount"]
                                ? primaryColor.withAlpha(51)
                                : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: customAmount == amount["amount"]
                                ? Border.all(color: primaryColor)
                                : Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "\$${(amount["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: customAmount == amount["amount"]
                                      ? primaryColor
                                      : primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${amount["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spSm),
                  QNumberField(
                    label: "Custom Amount (\$)",
                    value: customAmount > 0 ? customAmount.toString() : "",
                    hint: "Enter custom amount",
                    onChanged: (value) {
                      customAmount = double.tryParse(value) ?? 0.0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Recent Recharge History
            if (rechargeHistory.isNotEmpty) ...[
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
                            "Recent Recharges",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // navigateTo(RechargeHistoryView());
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
                    ...rechargeHistory.take(3).map((recharge) {
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
                                color: _getOperatorColor(recharge["operator"]).withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.phone_android,
                                color: _getOperatorColor(recharge["operator"]),
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${recharge["phoneNumber"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${recharge["operator"]} • ${DateTime.parse(recharge["date"]).dMMMy}",
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
                                  "\$${(recharge["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: recharge["status"] == "Success"
                                        ? successColor.withAlpha(51)
                                        : dangerColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${recharge["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: recharge["status"] == "Success"
                                          ? successColor
                                          : dangerColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            // Recharge Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Recharge Now - \$${customAmount.currency}",
                icon: Icons.phone_android,
                onPressed: phoneNumber.isNotEmpty && selectedOperator.isNotEmpty && customAmount > 0
                    ? () {
                        // Handle recharge
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
