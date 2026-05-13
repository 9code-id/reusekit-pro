import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCardLimitsView extends StatefulWidget {
  const BfaCardLimitsView({super.key});

  @override
  State<BfaCardLimitsView> createState() => _BfaCardLimitsViewState();
}

class _BfaCardLimitsViewState extends State<BfaCardLimitsView> {
  String selectedCard = "card_001";
  
  // Current limits
  double dailySpendingLimit = 100000.0;
  double dailyWithdrawalLimit = 50000.0;
  double monthlySpendingLimit = 500000.0;
  double monthlyWithdrawalLimit = 200000.0;
  double onlineTransactionLimit = 25000.0;
  double internationalLimit = 150000.0;
  
  // Usage tracking
  double dailySpent = 35000.0;
  double dailyWithdrawn = 15000.0;
  double monthlySpent = 245000.0;
  double monthlyWithdrawn = 85000.0;
  double onlineSpent = 12000.0;
  double internationalSpent = 45000.0;
  
  List<Map<String, dynamic>> cards = [
    {
      "id": "card_001",
      "name": "Premium Debit Card",
      "number": "**** 1234",
      "type": "Debit",
      "color": Colors.blue,
    },
    {
      "id": "card_002",
      "name": "Platinum Credit Card",
      "number": "**** 5678", 
      "type": "Credit",
      "color": Colors.black,
    },
    {
      "id": "card_003",
      "name": "Business Card",
      "number": "**** 9012",
      "type": "Business",
      "color": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Limits"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showLimitHistory();
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
              height: 80,
              child: QHorizontalScroll(
                children: cards.map((card) {
                  final isSelected = selectedCard == card["id"];
                  
                  return GestureDetector(
                    onTap: () {
                      selectedCard = card["id"];
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${card["name"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${card["number"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(230),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
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
            
            // Daily Limits
            _buildLimitSection(
              "Daily Limits",
              [
                _buildLimitCard(
                  "Daily Spending",
                  dailySpendingLimit,
                  dailySpent,
                  Icons.shopping_cart,
                  Colors.blue,
                  () => _editLimit("Daily Spending", dailySpendingLimit, (value) {
                    dailySpendingLimit = value;
                    setState(() {});
                  }),
                ),
                _buildLimitCard(
                  "Daily Withdrawal",
                  dailyWithdrawalLimit,
                  dailyWithdrawn,
                  Icons.atm,
                  Colors.green,
                  () => _editLimit("Daily Withdrawal", dailyWithdrawalLimit, (value) {
                    dailyWithdrawalLimit = value;
                    setState(() {});
                  }),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Monthly Limits
            _buildLimitSection(
              "Monthly Limits",
              [
                _buildLimitCard(
                  "Monthly Spending",
                  monthlySpendingLimit,
                  monthlySpent,
                  Icons.calendar_month,
                  Colors.purple,
                  () => _editLimit("Monthly Spending", monthlySpendingLimit, (value) {
                    monthlySpendingLimit = value;
                    setState(() {});
                  }),
                ),
                _buildLimitCard(
                  "Monthly Withdrawal",
                  monthlyWithdrawalLimit,
                  monthlyWithdrawn,
                  Icons.account_balance,
                  Colors.orange,
                  () => _editLimit("Monthly Withdrawal", monthlyWithdrawalLimit, (value) {
                    monthlyWithdrawalLimit = value;
                    setState(() {});
                  }),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Transaction Type Limits
            _buildLimitSection(
              "Transaction Type Limits",
              [
                _buildLimitCard(
                  "Online Transaction",
                  onlineTransactionLimit,
                  onlineSpent,
                  Icons.online_prediction,
                  Colors.cyan,
                  () => _editLimit("Online Transaction", onlineTransactionLimit, (value) {
                    onlineTransactionLimit = value;
                    setState(() {});
                  }),
                ),
                _buildLimitCard(
                  "International",
                  internationalLimit,
                  internationalSpent,
                  Icons.public,
                  Colors.red,
                  () => _editLimit("International", internationalLimit, (value) {
                    internationalLimit = value;
                    setState(() {});
                  }),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Quick Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reset All Limits",
                          size: bs.sm,
                          onPressed: () {
                            _resetAllLimits();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Apply Template",
                          size: bs.sm,
                          onPressed: () {
                            _showTemplateDialog();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Information Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Important Information",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• Limit changes take effect immediately\n"
                    "• Usage resets daily/monthly automatically\n"
                    "• You can temporarily increase limits for travel\n"
                    "• All limit changes are logged for security",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLimitSection(String title, List<Widget> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: cards,
        ),
      ],
    );
  }

  Widget _buildLimitCard(
    String title,
    double limit,
    double used,
    IconData icon,
    Color color,
    VoidCallback onEdit,
  ) {
    final percentage = (used / limit).clamp(0.0, 1.0);
    final remaining = limit - used;
    
    return Container(
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Limit: \$${(limit.toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, size: 18),
                onPressed: onEdit,
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Progress Bar
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: percentage > 0.8 ? dangerColor : color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
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
                      "Used",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(used.toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: percentage > 0.8 ? dangerColor : color,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Remaining",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(remaining.toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (percentage > 0.8) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: spXs,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Approaching limit",
                style: TextStyle(
                  fontSize: 10,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _editLimit(String limitName, double currentLimit, Function(double) onChanged) {
    String value = currentLimit.toInt().toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $limitName"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QNumberField(
              label: "New Limit (\$)",
              value: value,
              onChanged: (newValue) {
                value = newValue;
              },
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Changes will take effect immediately and cannot be undone.",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update Limit",
            size: bs.sm,
            onPressed: () {
              double newLimit = double.tryParse(value) ?? currentLimit;
              onChanged(newLimit);
              Navigator.pop(context);
              ss("$limitName updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _resetAllLimits() async {
    bool isConfirmed = await confirm(
      "Are you sure you want to reset all limits to default values?"
    );
    
    if (isConfirmed) {
      dailySpendingLimit = 100000.0;
      dailyWithdrawalLimit = 50000.0;
      monthlySpendingLimit = 500000.0;
      monthlyWithdrawalLimit = 200000.0;
      onlineTransactionLimit = 25000.0;
      internationalLimit = 150000.0;
      
      setState(() {});
      ss("All limits reset to default values");
    }
  }

  void _showTemplateDialog() {
    String selectedTemplate = "conservative";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Apply Limit Template"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Template",
              items: [
                {"label": "Conservative (Low Limits)", "value": "conservative"},
                {"label": "Standard (Default Limits)", "value": "standard"},
                {"label": "Liberal (High Limits)", "value": "liberal"},
                {"label": "Business (Business Limits)", "value": "business"},
              ],
              value: selectedTemplate,
              onChanged: (value, label) {
                selectedTemplate = value;
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
            label: "Apply Template",
            size: bs.sm,
            onPressed: () {
              _applyTemplate(selectedTemplate);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _applyTemplate(String template) {
    switch (template) {
      case "conservative":
        dailySpendingLimit = 50000.0;
        dailyWithdrawalLimit = 25000.0;
        monthlySpendingLimit = 250000.0;
        monthlyWithdrawalLimit = 100000.0;
        onlineTransactionLimit = 15000.0;
        internationalLimit = 75000.0;
        break;
      case "standard":
        dailySpendingLimit = 100000.0;
        dailyWithdrawalLimit = 50000.0;
        monthlySpendingLimit = 500000.0;
        monthlyWithdrawalLimit = 200000.0;
        onlineTransactionLimit = 25000.0;
        internationalLimit = 150000.0;
        break;
      case "liberal":
        dailySpendingLimit = 200000.0;
        dailyWithdrawalLimit = 100000.0;
        monthlySpendingLimit = 1000000.0;
        monthlyWithdrawalLimit = 400000.0;
        onlineTransactionLimit = 50000.0;
        internationalLimit = 300000.0;
        break;
      case "business":
        dailySpendingLimit = 500000.0;
        dailyWithdrawalLimit = 200000.0;
        monthlySpendingLimit = 2000000.0;
        monthlyWithdrawalLimit = 800000.0;
        onlineTransactionLimit = 100000.0;
        internationalLimit = 500000.0;
        break;
    }
    
    setState(() {});
    ss("$template template applied successfully");
  }

  void _showLimitHistory() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Limit Change History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Daily Spending Limit Changed",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "From \$75,000 to \$100,000",
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "June ${15 - index}, 2024 at 2:30 PM",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
