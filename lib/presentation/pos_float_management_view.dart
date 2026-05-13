import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosFloatManagementView extends StatefulWidget {
  const PosFloatManagementView({Key? key}) : super(key: key);

  @override
  State<PosFloatManagementView> createState() => _PosFloatManagementViewState();
}

class _PosFloatManagementViewState extends State<PosFloatManagementView> {
  int selectedTab = 0;
  String newFloatAmount = "";
  String adjustmentReason = "denomination_change";
  String adjustmentAmount = "";
  String adjustmentType = "increase";
  String notes = "";
  bool isProcessing = false;

  List<Map<String, dynamic>> adjustmentReasons = [
    {"label": "Denomination Change", "value": "denomination_change"},
    {"label": "Over/Short Correction", "value": "over_short_correction"},
    {"label": "Bank Order Delivery", "value": "bank_order"},
    {"label": "Store Policy Change", "value": "policy_change"},
    {"label": "Seasonal Adjustment", "value": "seasonal"},
    {"label": "Manager Override", "value": "manager_override"},
    {"label": "Other", "value": "other"},
  ];

  Map<String, dynamic> currentFloat = {
    "amount": 250.00,
    "last_updated": "Today, 09:00",
    "updated_by": "Store Manager",
    "status": "active",
    "breakdown": {
      "100": 1,
      "50": 2,
      "20": 3,
      "10": 5,
      "5": 8,
      "1": 20,
      "quarter": 20,
      "dime": 30,
      "nickel": 20,
      "penny": 100,
    }
  };

  List<Map<String, dynamic>> recommendedFloats = [
    {
      "name": "Standard Float",
      "amount": 200.00,
      "description": "Basic operational float for regular business hours",
      "breakdown": {
        "100": 0, "50": 2, "20": 3, "10": 4, "5": 6, "1": 20,
        "quarter": 20, "dime": 30, "nickel": 20, "penny": 100
      }
    },
    {
      "name": "High Volume Float",
      "amount": 350.00,
      "description": "Enhanced float for busy periods and high-volume days",
      "breakdown": {
        "100": 1, "50": 3, "20": 5, "10": 8, "5": 10, "1": 25,
        "quarter": 40, "dime": 50, "nickel": 30, "penny": 150
      }
    },
    {
      "name": "Minimal Float",
      "amount": 150.00,
      "description": "Reduced float for low-volume periods or security reasons",
      "breakdown": {
        "100": 0, "50": 1, "20": 2, "10": 3, "5": 4, "1": 15,
        "quarter": 16, "dime": 20, "nickel": 16, "penny": 80
      }
    },
  ];

  List<Map<String, dynamic>> floatHistory = [
    {
      "date": "Jan 23, 2024",
      "time": "09:00",
      "action": "Float Set",
      "amount": 250.00,
      "reason": "Store Policy Change",
      "cashier": "Store Manager",
      "notes": "Updated float amount for new policy"
    },
    {
      "date": "Jan 22, 2024",
      "time": "18:30",
      "action": "Float Adjusted",
      "amount": 25.00,
      "reason": "Denomination Change",
      "cashier": "Sarah M.",
      "notes": "Added more quarters for change"
    },
    {
      "date": "Jan 22, 2024",
      "time": "09:15",
      "action": "Float Set",
      "amount": 200.00,
      "reason": "Shift Start",
      "cashier": "John D.",
      "notes": "Standard opening float"
    },
    {
      "date": "Jan 21, 2024",
      "time": "16:45",
      "action": "Float Adjusted",
      "amount": -50.00,
      "reason": "Over/Short Correction",
      "cashier": "Manager",
      "notes": "Correcting yesterday's overage"
    },
  ];

  Map<String, dynamic> floatAnalytics = {
    "average_daily_usage": 125.50,
    "peak_change_needed": 85.75,
    "most_used_denominations": ["quarters", "dimes", "ones"],
    "recommended_adjustment": 25.00,
    "efficiency_score": 87.5,
  };

  double get recommendedFloatBreakdownTotal {
    if (selectedTab < recommendedFloats.length) {
      var breakdown = recommendedFloats[selectedTab]["breakdown"] as Map<String, dynamic>;
      double total = 0;
      
      // Bills
      total += (breakdown["100"] as int) * 100;
      total += (breakdown["50"] as int) * 50;
      total += (breakdown["20"] as int) * 20;
      total += (breakdown["10"] as int) * 10;
      total += (breakdown["5"] as int) * 5;
      total += (breakdown["1"] as int) * 1;
      
      // Coins
      total += (breakdown["quarter"] as int) * 0.25;
      total += (breakdown["dime"] as int) * 0.10;
      total += (breakdown["nickel"] as int) * 0.05;
      total += (breakdown["penny"] as int) * 0.01;
      
      return total;
    }
    return 0;
  }

  void _setNewFloat() async {
    double amount = double.tryParse(newFloatAmount) ?? 0;
    if (amount <= 0) {
      se("Please enter a valid float amount");
      return;
    }

    if (amount > 500) {
      bool isConfirmed = await confirm("Float amount is quite high (\$${amount.currency}). This may require manager approval. Continue?");
      if (!isConfirmed) return;
    }

    isProcessing = true;
    setState(() {});

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    isProcessing = false;
    setState(() {});

    ss("Float amount updated successfully");
    newFloatAmount = "";
    setState(() {});
  }

  void _adjustFloat() async {
    double amount = double.tryParse(adjustmentAmount) ?? 0;
    if (amount <= 0) {
      se("Please enter a valid adjustment amount");
      return;
    }

    isProcessing = true;
    setState(() {});

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    isProcessing = false;
    setState(() {});

    ss("Float adjustment applied successfully");
    adjustmentAmount = "";
    setState(() {});
  }

  void _applyRecommendedFloat(int index) async {
    var recommended = recommendedFloats[index];
    double amount = recommended["amount"] as double;

    bool isConfirmed = await confirm("Set float to ${recommended["name"]} (\$${amount.currency})?");
    if (!isConfirmed) return;

    isProcessing = true;
    setState(() {});

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    isProcessing = false;
    setState(() {});

    ss("Float set to ${recommended["name"]} successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Float Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo(FloatAnalyticsView)
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Float Status
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
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: Colors.green,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Float",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "\$${(currentFloat["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${currentFloat["status"]}".toUpperCase(),
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
                  Row(
                    children: [
                      Text(
                        "Last Updated: ${currentFloat["last_updated"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "By: ${currentFloat["updated_by"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Float Analytics Summary
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
                    "Float Analytics",
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Daily Usage",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${(floatAnalytics["average_daily_usage"] as double).currency}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Peak Need",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\$${(floatAnalytics["peak_change_needed"] as double).currency}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Efficiency",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${(floatAnalytics["efficiency_score"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.green,
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

            SizedBox(height: spMd),

            // Management Actions
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
                    "Float Management",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Set New Float
                  Text(
                    "Set New Float Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "New Float Amount (\$)",
                          value: newFloatAmount,
                          hint: "e.g., 250.00",
                          onChanged: (value) {
                            newFloatAmount = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Set Float",
                        icon: Icons.save,
                        size: bs.sm,
                        onPressed: isProcessing ? null : _setNewFloat,
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Adjust Current Float
                  Text(
                    "Adjust Current Float",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Adjustment Type",
                          items: [
                            {"label": "Increase", "value": "increase"},
                            {"label": "Decrease", "value": "decrease"},
                          ],
                          value: adjustmentType,
                          onChanged: (value, label) {
                            adjustmentType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Amount (\$)",
                          value: adjustmentAmount,
                          hint: "e.g., 25.00",
                          onChanged: (value) {
                            adjustmentAmount = value;
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
                        child: QDropdownField(
                          label: "Reason",
                          items: adjustmentReasons,
                          value: adjustmentReason,
                          onChanged: (value, label) {
                            adjustmentReason = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Apply",
                        icon: Icons.tune,
                        size: bs.sm,
                        onPressed: isProcessing ? null : _adjustFloat,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Recommended Float Configurations
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
                    "Recommended Float Configurations",
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
                    itemCount: recommendedFloats.length,
                    itemBuilder: (context, index) {
                      final float = recommendedFloats[index];
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: index < recommendedFloats.length - 1 ? spSm : 0),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: Colors.grey.withAlpha(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${float["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "${float["description"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${(float["amount"] as double).currency}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: primaryColor,
                                      ),
                                    ),
                                    QButton(
                                      label: "Apply",
                                      size: bs.sm,
                                      onPressed: () => _applyRecommendedFloat(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Quick breakdown preview
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.blue.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Breakdown Preview",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "Bills: \$${((float["breakdown"] as Map)["100"] * 100 + (float["breakdown"] as Map)["50"] * 50 + (float["breakdown"] as Map)["20"] * 20 + (float["breakdown"] as Map)["10"] * 10 + (float["breakdown"] as Map)["5"] * 5 + (float["breakdown"] as Map)["1"] * 1).toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Coins: \$${((float["breakdown"] as Map)["quarter"] * 0.25 + (float["breakdown"] as Map)["dime"] * 0.10 + (float["breakdown"] as Map)["nickel"] * 0.05 + (float["breakdown"] as Map)["penny"] * 0.01).toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
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

            // Float History
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
                        "Float History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          //navigateTo(FloatHistoryDetailView)
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: floatHistory.length.clamp(0, 3),
                    itemBuilder: (context, index) {
                      final history = floatHistory[index];
                      final isIncrease = (history["amount"] as double) > 0;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: index < 2 ? spSm : 0),
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
                                color: isIncrease ? Colors.green.withAlpha(20) : Colors.blue.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                history["action"] == "Float Set" ? Icons.settings : 
                                isIncrease ? Icons.trending_up : Icons.trending_down,
                                color: isIncrease ? Colors.green : Colors.blue,
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
                                        "${history["action"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${history["date"]} ${history["time"]}",
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
                                        "${history["reason"]} • ${history["cashier"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        history["action"] == "Float Set" 
                                            ? "\$${(history["amount"] as double).currency}"
                                            : "${isIncrease ? '+' : ''}\$${(history["amount"] as double).currency}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: history["action"] == "Float Set" 
                                              ? primaryColor 
                                              : isIncrease ? Colors.green : Colors.red,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (history["notes"] != null && (history["notes"] as String).isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: spXs),
                                      child: Text(
                                        "${history["notes"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 11,
                                          fontStyle: FontStyle.italic,
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
          ],
        ),
      ),
    );
  }
}
