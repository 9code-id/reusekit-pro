import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCardManagementView extends StatefulWidget {
  const BfaCardManagementView({super.key});

  @override
  State<BfaCardManagementView> createState() => _BfaCardManagementViewState();
}

class _BfaCardManagementViewState extends State<BfaCardManagementView> {
  int selectedCardIndex = 0;
  
  List<Map<String, dynamic>> cards = [
    {
      "id": "card_001",
      "name": "Premium Debit Card",
      "number": "**** 1234",
      "type": "Debit",
      "status": "Active",
      "balance": 2500000.0,
      "issueDate": "01/2022",
      "expiryDate": "12/2026",
      "isBlocked": false,
      "isDamaged": false,
      "color": Colors.blue,
    },
    {
      "id": "card_002", 
      "name": "Platinum Credit Card",
      "number": "**** 5678",
      "type": "Credit",
      "status": "Active",
      "limit": 10000000.0,
      "used": 1500000.0,
      "issueDate": "06/2021",
      "expiryDate": "08/2027",
      "isBlocked": false,
      "isDamaged": false,
      "color": Colors.black,
    },
    {
      "id": "card_003",
      "name": "Business Card",
      "number": "**** 9012",
      "type": "Business",
      "status": "Blocked",
      "balance": 500000.0,
      "issueDate": "03/2023",
      "expiryDate": "03/2028",
      "isBlocked": true,
      "isDamaged": false,
      "color": Colors.orange,
    },
  ];
  
  List<Map<String, dynamic>> managementOptions = [
    {
      "title": "Block/Unblock Card",
      "subtitle": "Temporarily disable your card",
      "icon": Icons.block,
      "color": Colors.red,
      "action": "block"
    },
    {
      "title": "Change PIN",
      "subtitle": "Update your card PIN",
      "icon": Icons.pin,
      "color": Colors.blue,
      "action": "pin"
    },
    {
      "title": "Set Limits",
      "subtitle": "Manage spending limits",
      "icon": Icons.settings,
      "color": Colors.green,
      "action": "limits"
    },
    {
      "title": "Replace Card",
      "subtitle": "Order replacement card",
      "icon": Icons.credit_card,
      "color": Colors.orange,
      "action": "replace"
    },
    {
      "title": "View Statement",
      "subtitle": "Download monthly statement",
      "icon": Icons.description,
      "color": Colors.purple,
      "action": "statement"
    },
    {
      "title": "Report Issue",
      "subtitle": "Report lost or stolen card",
      "icon": Icons.report_problem,
      "color": Colors.red,
      "action": "report"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentCard = cards[selectedCardIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // View management history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Selection
            Text(
              "Select Card",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: cards.asMap().entries.map((entry) {
                  final index = entry.key;
                  final card = entry.value;
                  final isSelected = selectedCardIndex == index;
                  
                  return GestureDetector(
                    onTap: () {
                      selectedCardIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: card["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: isSelected 
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
                        boxShadow: isSelected ? [shadowLg] : [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${card["name"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: card["status"] == "Active" 
                                    ? Colors.green 
                                    : Colors.red,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${card["number"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(230),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${card["type"]} • ${card["status"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Card Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Card Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: currentCard["status"] == "Active" 
                            ? successColor.withAlpha(30)
                            : dangerColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${currentCard["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: currentCard["status"] == "Active" 
                              ? successColor 
                              : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  _buildInfoRow("Card Name", "${currentCard["name"]}"),
                  _buildInfoRow("Card Type", "${currentCard["type"]}"),
                  _buildInfoRow("Issue Date", "${currentCard["issueDate"]}"),
                  _buildInfoRow("Expiry Date", "${currentCard["expiryDate"]}"),
                  
                  if (currentCard["type"] == "Credit") ...[
                    _buildInfoRow(
                      "Credit Limit", 
                      "\$${((currentCard["limit"] as double).toDouble()).currency}"
                    ),
                    _buildInfoRow(
                      "Available Credit", 
                      "\$${(((currentCard["limit"] as double) - (currentCard["used"] as double)).toDouble()).currency}",
                      valueColor: successColor
                    ),
                  ] else ...[
                    _buildInfoRow(
                      "Available Balance", 
                      "\$${((currentCard["balance"] as double).toDouble()).currency}",
                      valueColor: successColor
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Management Options
            Text(
              "Management Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: managementOptions.map((option) {
                return GestureDetector(
                  onTap: () {
                    _handleManagementAction(option["action"]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (option["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            option["icon"] as IconData,
                            color: option["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${option["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${option["subtitle"]}",
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
            
            SizedBox(height: spLg),
            
            // Quick Stats
            Container(
              width: double.infinity,
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
                    "This Month's Activity",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "47",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Transactions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey.shade300,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((1250000.0).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Total Spent",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey.shade300,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "\$${((26595.0).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Avg. per Transaction",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _handleManagementAction(String action) {
    final currentCard = cards[selectedCardIndex];
    
    switch (action) {
      case "block":
        _showBlockCardDialog();
        break;
      case "pin":
        _showChangePinDialog();
        break;
      case "limits":
        _showSetLimitsDialog();
        break;
      case "replace":
        _showReplaceCardDialog();
        break;
      case "statement":
        _downloadStatement();
        break;
      case "report":
        _showReportIssueDialog();
        break;
    }
  }

  void _showBlockCardDialog() {
    final currentCard = cards[selectedCardIndex];
    final isBlocked = currentCard["isBlocked"] as bool;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isBlocked ? "Unblock Card" : "Block Card"),
        content: Text(
          isBlocked 
            ? "Are you sure you want to unblock this card?"
            : "Are you sure you want to block this card? You won't be able to use it for transactions."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: isBlocked ? "Unblock" : "Block",
            size: bs.sm,
            onPressed: () {
              currentCard["isBlocked"] = !isBlocked;
              currentCard["status"] = isBlocked ? "Active" : "Blocked";
              setState(() {});
              Navigator.pop(context);
              ss(isBlocked ? "Card unblocked successfully" : "Card blocked successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showChangePinDialog() {
    String currentPin = "";
    String newPin = "";
    String confirmPin = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change PIN"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Current PIN",
              value: currentPin,
              obscureText: true,
              onChanged: (value) {
                currentPin = value;
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "New PIN",
              value: newPin,
              obscureText: true,
              onChanged: (value) {
                newPin = value;
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Confirm New PIN",
              value: confirmPin,
              obscureText: true,
              onChanged: (value) {
                confirmPin = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Change PIN",
            size: bs.sm,
            onPressed: () {
              if (newPin == confirmPin && newPin.length == 4) {
                Navigator.pop(context);
                ss("PIN changed successfully");
              } else {
                se("PINs don't match or invalid length");
              }
            },
          ),
        ],
      ),
    );
  }

  void _showSetLimitsDialog() {
    String dailyLimit = "100000";
    String monthlyLimit = "500000";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Set Transaction Limits"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "Daily Limit (\$)",
              value: dailyLimit,
              onChanged: (value) {
                dailyLimit = value;
              },
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Monthly Limit (\$)",
              value: monthlyLimit,
              onChanged: (value) {
                monthlyLimit = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save Limits",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Transaction limits updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showReplaceCardDialog() {
    String reason = "damaged";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Replace Card"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reason for replacement:"),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Reason",
              items: [
                {"label": "Damaged Card", "value": "damaged"},
                {"label": "Lost Card", "value": "lost"},
                {"label": "Stolen Card", "value": "stolen"},
                {"label": "Expired Card", "value": "expired"},
              ],
              value: reason,
              onChanged: (value, label) {
                reason = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Order Replacement",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Replacement card ordered. You'll receive it in 3-5 business days.");
            },
          ),
        ],
      ),
    );
  }

  void _downloadStatement() {
    ss("Statement downloaded successfully");
  }

  void _showReportIssueDialog() {
    String issueType = "lost";
    String description = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Report Issue"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Issue Type",
              items: [
                {"label": "Lost Card", "value": "lost"},
                {"label": "Stolen Card", "value": "stolen"},
                {"label": "Unauthorized Transaction", "value": "unauthorized"},
                {"label": "Card Not Working", "value": "not_working"},
              ],
              value: issueType,
              onChanged: (value, label) {
                issueType = value;
              },
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Description",
              value: description,
              onChanged: (value) {
                description = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Report Issue",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Issue reported successfully. Our team will contact you soon.");
            },
          ),
        ],
      ),
    );
  }
}
