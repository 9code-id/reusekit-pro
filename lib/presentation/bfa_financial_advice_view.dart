import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaFinancialAdviceView extends StatefulWidget {
  const BfaFinancialAdviceView({super.key});

  @override
  State<BfaFinancialAdviceView> createState() => _BfaFinancialAdviceViewState();
}

class _BfaFinancialAdviceViewState extends State<BfaFinancialAdviceView> {
  String selectedCategory = "All Advice";
  bool showCompletedAdvice = false;
  
  List<Map<String, dynamic>> adviceCategories = [
    {"label": "All Advice", "value": "All Advice"},
    {"label": "Budgeting", "value": "Budgeting"},
    {"label": "Savings", "value": "Savings"},
    {"label": "Investing", "value": "Investing"},
    {"label": "Debt Management", "value": "Debt Management"},
    {"label": "Credit Score", "value": "Credit Score"},
  ];

  List<Map<String, dynamic>> financialAdvice = [
    {
      "id": 1,
      "title": "Build Your Emergency Fund",
      "category": "Savings",
      "priority": "High",
      "description": "You should aim to save 3-6 months of expenses in an emergency fund. Based on your spending, target \$15,000-\$25,000.",
      "currentAmount": 8500.0,
      "targetAmount": 20000.0,
      "actionSteps": [
        "Open a high-yield savings account",
        "Set up automatic transfers of \$500/month",
        "Keep emergency fund separate from other savings",
        "Review and adjust target amount quarterly",
      ],
      "timeframe": "12 months",
      "difficulty": "Medium",
      "potentialSavings": 0.0,
      "completed": false,
      "icon": Icons.security,
      "color": dangerColor,
    },
    {
      "id": 2,
      "title": "Optimize Your Credit Card Usage",
      "category": "Credit Score",
      "priority": "Medium",
      "description": "Use your cashback credit cards for recurring expenses to maximize rewards while building credit history.",
      "currentAmount": 0.0,
      "targetAmount": 0.0,
      "actionSteps": [
        "Use credit card for all recurring bills",
        "Set up automatic payments for full balance",
        "Monitor credit utilization (keep under 30%)",
        "Check credit score monthly",
      ],
      "timeframe": "3 months",
      "difficulty": "Easy",
      "potentialSavings": 150.0,
      "completed": false,
      "icon": Icons.credit_card,
      "color": successColor,
    },
    {
      "id": 3,
      "title": "Create a Retirement Investment Plan",
      "category": "Investing",
      "priority": "High",
      "description": "Start investing 15% of your income for retirement. Consider opening an IRA or maximizing your 401(k) contributions.",
      "currentAmount": 2500.0,
      "targetAmount": 10000.0,
      "actionSteps": [
        "Research employer 401(k) matching",
        "Open Roth IRA if eligible",
        "Set up automatic monthly contributions",
        "Diversify investments across index funds",
      ],
      "timeframe": "6 months",
      "difficulty": "Medium",
      "potentialSavings": 0.0,
      "completed": false,
      "icon": Icons.trending_up,
      "color": primaryColor,
    },
    {
      "id": 4,
      "title": "Reduce Dining Out Expenses",
      "category": "Budgeting",
      "priority": "Medium",
      "description": "You're spending 30% more on dining out than recommended. Try meal planning and cooking at home more often.",
      "currentAmount": 1250.0,
      "targetAmount": 800.0,
      "actionSteps": [
        "Plan weekly meals in advance",
        "Grocery shop with a list",
        "Limit dining out to 2-3 times per week",
        "Try cooking new recipes at home",
      ],
      "timeframe": "2 months",
      "difficulty": "Easy",
      "potentialSavings": 450.0,
      "completed": false,
      "icon": Icons.restaurant,
      "color": warningColor,
    },
    {
      "id": 5,
      "title": "Pay Down High-Interest Debt",
      "category": "Debt Management",
      "priority": "High",
      "description": "Focus on paying off credit card debt with interest rates above 20% first using the avalanche method.",
      "currentAmount": 3500.0,
      "targetAmount": 0.0,
      "actionSteps": [
        "List all debts by interest rate",
        "Make minimum payments on all debts",
        "Put extra money toward highest rate debt",
        "Consider debt consolidation if beneficial",
      ],
      "timeframe": "18 months",
      "difficulty": "Hard",
      "potentialSavings": 800.0,
      "completed": false,
      "icon": Icons.trending_down,
      "color": dangerColor,
    },
    {
      "id": 6,
      "title": "Review and Cancel Unused Subscriptions",
      "category": "Budgeting",
      "priority": "Low",
      "description": "You have several subscriptions you haven't used in the past 3 months. Cancel them to save money.",
      "currentAmount": 0.0,
      "targetAmount": 0.0,
      "actionSteps": [
        "Review all subscription charges",
        "Cancel unused streaming services",
        "Downgrade premium plans if possible",
        "Set calendar reminders to review quarterly",
      ],
      "timeframe": "1 week",
      "difficulty": "Easy",
      "potentialSavings": 45.0,
      "completed": true,
      "icon": Icons.subscriptions,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> financialTips = [
    {
      "title": "50/30/20 Rule",
      "description": "Allocate 50% of income to needs, 30% to wants, and 20% to savings and debt repayment.",
      "category": "Budgeting",
      "icon": Icons.pie_chart,
    },
    {
      "title": "Dollar-Cost Averaging",
      "description": "Invest a fixed amount regularly regardless of market conditions to reduce investment risk.",
      "category": "Investing",
      "icon": Icons.timeline,
    },
    {
      "title": "Credit Utilization",
      "description": "Keep credit card balances below 30% of your credit limit to maintain a good credit score.",
      "category": "Credit Score",
      "icon": Icons.account_balance,
    },
    {
      "title": "Compound Interest",
      "description": "Start investing early to take advantage of compound interest - your money grows exponentially over time.",
      "category": "Investing",
      "icon": Icons.auto_graph,
    },
  ];

  List<Map<String, dynamic>> getFilteredAdvice() {
    List<Map<String, dynamic>> filtered = financialAdvice;
    
    if (selectedCategory != "All Advice") {
      filtered = filtered.where((advice) => advice["category"] == selectedCategory).toList();
    }
    
    if (!showCompletedAdvice) {
      filtered = filtered.where((advice) => !(advice["completed"] as bool)).toList();
    }
    
    // Sort by priority
    filtered.sort((a, b) {
      Map<String, int> priorityOrder = {"High": 3, "Medium": 2, "Low": 1};
      return (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0);
    });
    
    return filtered;
  }

  double getAdviceProgress(Map<String, dynamic> advice) {
    if (advice["targetAmount"] == 0.0) return 0.0;
    double current = advice["currentAmount"] as double;
    double target = advice["targetAmount"] as double;
    return (current / target * 100).clamp(0.0, 100.0);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredAdvice = getFilteredAdvice();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Advice"),
        actions: [
          IconButton(
            onPressed: () {
              // Get personalized advice
            },
            icon: Icon(Icons.psychology),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            QDropdownField(
              label: "Advice Category",
              items: adviceCategories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            QSwitch(
              items: [
                {
                  "label": "Show completed advice",
                  "value": true,
                  "checked": showCompletedAdvice,
                }
              ],
              value: [
                if (showCompletedAdvice)
                  {
                    "label": "Show completed advice",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showCompletedAdvice = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Financial Health Score
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Financial Health Score",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.72,
                            child: Container(
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "72/100",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Good! You're on track with most financial basics. Focus on building your emergency fund and reducing debt.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Personalized Advice
            Text(
              "Personalized Advice (${filteredAdvice.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: filteredAdvice.map((advice) {
                bool isCompleted = advice["completed"] as bool;
                double progress = getAdviceProgress(advice);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: isCompleted ? Border.all(
                      color: successColor.withAlpha(50),
                      width: 1,
                    ) : Border(
                      left: BorderSide(
                        width: 4,
                        color: advice["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: isCompleted 
                                  ? successColor.withAlpha(20)
                                  : (advice["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              isCompleted ? Icons.check_circle : advice["icon"] as IconData,
                              color: isCompleted ? successColor : advice["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${advice["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(advice["priority"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${advice["priority"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _getPriorityColor(advice["priority"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${advice["category"]} • ${advice["timeframe"]} • ${advice["difficulty"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if ((advice["potentialSavings"] as double) > 0) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Save",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${(advice["potentialSavings"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                      
                      Text(
                        "${advice["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      if (progress > 0 && !isCompleted) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Progress: \$${(advice["currentAmount"] as double).currency} of \$${(advice["targetAmount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${progress.toStringAsFixed(0)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: advice["color"] as Color,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (progress / 100).clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: advice["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Action Steps
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (advice["color"] as Color).withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Action Steps:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Column(
                              spacing: spXs,
                              children: (advice["actionSteps"] as List<String>).map((step) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 6),
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: advice["color"] as Color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        step,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      if (!isCompleted) ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Mark as Completed",
                            icon: Icons.check,
                            size: bs.sm,
                            onPressed: () {
                              // Mark advice as completed
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

            // Financial Tips
            Text(
              "Financial Tips",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: financialTips.map((tip) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          tip["icon"] as IconData,
                          color: infoColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${tip["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${tip["description"]}",
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
                );
              }).toList(),
            ),

            // Get More Advice
            Container(
              width: double.infinity,
              child: QButton(
                label: "Get Personalized Advice",
                icon: Icons.psychology,
                size: bs.sm,
                onPressed: () {
                  // Get more personalized advice
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
