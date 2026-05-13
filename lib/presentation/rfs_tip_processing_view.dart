import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsTipProcessingView extends StatefulWidget {
  const RfsTipProcessingView({super.key});

  @override
  State<RfsTipProcessingView> createState() => _RfsTipProcessingViewState();
}

class _RfsTipProcessingViewState extends State<RfsTipProcessingView> {
  int selectedTab = 0;
  String tipAmount = "";
  String tipPercentage = "18";
  String customTipAmount = "";
  bool enableAutoTip = true;
  bool enableTipSuggestions = true;
  bool allowCustomTips = true;

  List<Map<String, dynamic>> tipTransactions = [
    {
      "id": "TIP001",
      "employeeName": "Sarah Martinez",
      "billAmount": 45.80,
      "tipAmount": 8.24,
      "tipPercentage": 18,
      "customer": "John Smith",
      "timestamp": "2024-06-19 15:45",
      "table": "Table 5",
      "paymentMethod": "Credit Card"
    },
    {
      "id": "TIP002",
      "employeeName": "Mike Johnson",
      "billAmount": 78.50,
      "tipAmount": 15.70,
      "tipPercentage": 20,
      "customer": "Emily Davis",
      "timestamp": "2024-06-19 15:30",
      "table": "Table 12",
      "paymentMethod": "Digital Wallet"
    },
    {
      "id": "TIP003",
      "employeeName": "Lisa Chen",
      "billAmount": 32.25,
      "tipAmount": 5.00,
      "tipPercentage": 15,
      "customer": "Robert Wilson",
      "timestamp": "2024-06-19 15:15",
      "table": "Table 8",
      "paymentMethod": "Cash"
    },
    {
      "id": "TIP004",
      "employeeName": "David Brown",
      "billAmount": 125.90,
      "tipAmount": 25.18,
      "tipPercentage": 20,
      "customer": "Maria Garcia",
      "timestamp": "2024-06-19 14:55",
      "table": "Table 3",
      "paymentMethod": "Credit Card"
    }
  ];

  List<String> tipPercentages = ["15", "18", "20", "25"];
  
  double get billAmount => 67.80;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tip Processing",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Process Tips", icon: Icon(Icons.attach_money)),
        Tab(text: "Tip History", icon: Icon(Icons.history)),
        Tab(text: "Employee Tips", icon: Icon(Icons.people)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildProcessTipsTab(),
        _buildTipHistoryTab(),
        _buildEmployeeTipsTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildProcessTipsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bill Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Bill",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Table 7 • Order #1234",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${billAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tip Suggestions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tip Suggestions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 100,
                  children: tipPercentages.map((percentage) {
                    double tipValue = billAmount * (int.parse(percentage) / 100);
                    bool isSelected = tipPercentage == percentage;
                    
                    return GestureDetector(
                      onTap: () {
                        tipPercentage = percentage;
                        tipAmount = tipValue.toStringAsFixed(2);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${percentage}%",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$${tipValue.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
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

          // Custom Tip
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Custom Tip Amount",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QNumberField(
                  label: "Tip Amount (\$)",
                  value: customTipAmount,
                  hint: "Enter custom tip amount",
                  onChanged: (value) {
                    customTipAmount = value;
                    if (value.isNotEmpty) {
                      double customValue = double.tryParse(value) ?? 0;
                      double percentage = (customValue / billAmount) * 100;
                      tipPercentage = percentage.toStringAsFixed(0);
                    }
                    setState(() {});
                  },
                ),
                if (customTipAmount.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 16),
                        SizedBox(width: spSm),
                        Text(
                          "This is ${((double.tryParse(customTipAmount) ?? 0) / billAmount * 100).toStringAsFixed(1)}% of the bill",
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

          // Total Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bill Amount:",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${billAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tip (${tipPercentage}%):",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${(customTipAmount.isNotEmpty ? (double.tryParse(customTipAmount) ?? 0) : billAmount * (int.parse(tipPercentage) / 100)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Divider(color: primaryColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "\$${(billAmount + (customTipAmount.isNotEmpty ? (double.tryParse(customTipAmount) ?? 0) : billAmount * (int.parse(tipPercentage) / 100))).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Process Tip",
                  size: bs.md,
                  onPressed: () {
                    showLoading();
                    Future.delayed(Duration(seconds: 2), () {
                      hideLoading();
                      ss("Tip processed successfully!");
                      customTipAmount = "";
                      tipPercentage = "18";
                      setState(() {});
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                size: bs.md,
                onPressed: () {
                  customTipAmount = "";
                  tipPercentage = "18";
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.trending_up, color: successColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "\$54.12",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Tips Today",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.percent, color: infoColor, size: 32),
                      SizedBox(height: spXs),
                      Text(
                        "18.5%",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Average Tip %",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Tip Transactions
          ...tipTransactions.map((tip) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: successColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${tip["id"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${tip["employeeName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(tip["tipAmount"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${tip["tipPercentage"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${tip["customer"]} • ${tip["table"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${(tip["billAmount"] as double).toStringAsFixed(2)} bill",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.payment, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${tip["paymentMethod"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${tip["timestamp"]}",
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEmployeeTipsTab() {
    Map<String, List<Map<String, dynamic>>> employeeTips = {};
    
    for (var tip in tipTransactions) {
      String employeeName = tip["employeeName"] as String;
      if (!employeeTips.containsKey(employeeName)) {
        employeeTips[employeeName] = [];
      }
      employeeTips[employeeName]!.add(tip);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          // Employee Tip Summary
          ...employeeTips.entries.map((entry) {
            String employeeName = entry.key;
            List<Map<String, dynamic>> tips = entry.value;
            double totalTips = tips.fold(0.0, (sum, tip) => sum + (tip["tipAmount"] as double));
            double averagePercentage = tips.fold(0.0, (sum, tip) => sum + (tip["tipPercentage"] as int)) / tips.length;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(Icons.person, color: primaryColor, size: 24),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              employeeName,
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${tips.length} transactions today",
                              style: TextStyle(
                                fontSize: 14,
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
                            "\$${totalTips.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Avg ${averagePercentage.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Individual tip transactions for this employee
                  ...tips.map((tip) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(top: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${tip["customer"]} • ${tip["table"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "\$${(tip["tipAmount"] as double).toStringAsFixed(2)} (${tip["tipPercentage"]}%)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tip Processing Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tip Processing Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable automatic tip suggestions",
                      "value": "auto_tip",
                      "checked": enableAutoTip,
                    },
                    {
                      "label": "Show tip percentage suggestions",
                      "value": "tip_suggestions",
                      "checked": enableTipSuggestions,
                    },
                    {
                      "label": "Allow custom tip amounts",
                      "value": "custom_tips",
                      "checked": allowCustomTips,
                    }
                  ],
                  value: [
                    if (enableAutoTip)
                      {"label": "Enable automatic tip suggestions", "value": "auto_tip", "checked": true},
                    if (enableTipSuggestions)
                      {"label": "Show tip percentage suggestions", "value": "tip_suggestions", "checked": true},
                    if (allowCustomTips)
                      {"label": "Allow custom tip amounts", "value": "custom_tips", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    enableAutoTip = values.any((v) => v["value"] == "auto_tip");
                    enableTipSuggestions = values.any((v) => v["value"] == "tip_suggestions");
                    allowCustomTips = values.any((v) => v["value"] == "custom_tips");
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Default Tip Percentages
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Default Tip Percentages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Minimum %",
                        value: "15",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Standard %",
                        value: "18",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QNumberField(
                        label: "Good Service %",
                        value: "20",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QNumberField(
                        label: "Excellent %",
                        value: "25",
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tip Distribution Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tip Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Distribute tips among all staff",
                      "value": "distribute_tips",
                      "checked": false,
                    },
                    {
                      "label": "Track individual employee tips",
                      "value": "individual_tips",
                      "checked": true,
                    }
                  ],
                  value: [
                    {"label": "Track individual employee tips", "value": "individual_tips", "checked": true}
                  ],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          QButton(
            label: "Save Tip Settings",
            size: bs.md,
            onPressed: () {
              ss("Tip processing settings saved successfully!");
            },
          ),
        ],
      ),
    );
  }
}
