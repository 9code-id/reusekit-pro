import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary5View extends StatefulWidget {
  @override
  State<GrlSummary5View> createState() => _GrlSummary5ViewState();
}

class _GrlSummary5ViewState extends State<GrlSummary5View> {
  List<Map<String, dynamic>> financialData = [
    {
      "category": "Revenue",
      "current": 2450000.0,
      "previous": 2180000.0,
      "target": 2500000.0,
      "color": successColor,
      "icon": Icons.trending_up,
    },
    {
      "category": "Expenses",
      "current": 1650000.0,
      "previous": 1580000.0,
      "target": 1600000.0,
      "color": dangerColor,
      "icon": Icons.trending_down,
    },
    {
      "category": "Profit",
      "current": 800000.0,
      "previous": 600000.0,
      "target": 900000.0,
      "color": primaryColor,
      "icon": Icons.attach_money,
    },
    {
      "category": "Cash Flow",
      "current": 450000.0,
      "previous": 380000.0,
      "target": 500000.0,
      "color": infoColor,
      "icon": Icons.account_balance,
    },
  ];

  List<Map<String, dynamic>> departmentBudgets = [
    {
      "department": "Sales & Marketing",
      "allocated": 450000.0,
      "spent": 387000.0,
      "percentage": 86.0,
      "status": "On Track",
    },
    {
      "department": "Research & Development",
      "allocated": 320000.0,
      "spent": 298000.0,
      "percentage": 93.1,
      "status": "On Track",
    },
    {
      "department": "Operations",
      "allocated": 280000.0,
      "spent": 294000.0,
      "percentage": 105.0,
      "status": "Over Budget",
    },
    {
      "department": "Human Resources",
      "allocated": 180000.0,
      "spent": 145000.0,
      "percentage": 80.6,
      "status": "Under Budget",
    },
    {
      "department": "IT & Technology",
      "allocated": 220000.0,
      "spent": 205000.0,
      "percentage": 93.2,
      "status": "On Track",
    },
  ];

  List<Map<String, dynamic>> quarterlyProjections = [
    {
      "quarter": "Q1",
      "revenue": 580000.0,
      "expenses": 420000.0,
      "projected": 600000.0,
    },
    {
      "quarter": "Q2",
      "revenue": 640000.0,
      "expenses": 435000.0,
      "projected": 650000.0,
    },
    {
      "quarter": "Q3",
      "revenue": 615000.0,
      "expenses": 410000.0,
      "projected": 620000.0,
    },
    {
      "quarter": "Q4",
      "revenue": 615000.0,
      "expenses": 385000.0,
      "projected": 630000.0,
    },
  ];

  String selectedView = "overview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Financial Summary"),
        actions: [
          Icon(Icons.print, color: primaryColor),
          SizedBox(width: spSm),
          Icon(Icons.email, color: primaryColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QCategoryPicker(
              items: [
                {"label": "Overview", "value": "overview"},
                {"label": "Budgets", "value": "budgets"},
                {"label": "Projections", "value": "projections"},
              ],
              value: selectedView,
              onChanged: (index, label, value, item) {
                selectedView = value;
                setState(() {});
              },
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(204)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Financial Health Score",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "8.4",
                        style: TextStyle(
                          fontSize: fsH1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "/10",
                        style: TextStyle(
                          fontSize: fsH4,
                          color: Colors.white.withAlpha(179),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Excellent",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your financial performance is strong with consistent growth across all key metrics.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(179),
                    ),
                  ),
                ],
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: financialData.map((data) {
                final growthPercent = (((data["current"] as double) - (data["previous"] as double)) / (data["previous"] as double)) * 100;
                final targetPercent = ((data["current"] as double) / (data["target"] as double)) * 100;
                final isPositive = growthPercent >= 0;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (data["color"] as Color).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              data["icon"] as IconData,
                              color: data["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${data["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${(data["current"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            isPositive ? Icons.trending_up : Icons.trending_down,
                            color: isPositive ? successColor : dangerColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${isPositive ? '+' : ''}${growthPercent.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: isPositive ? successColor : dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${targetPercent.toStringAsFixed(0)}% of target",
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
            ),

            if (selectedView == "budgets") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Department Budget Analysis",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: departmentBudgets.map((budget) {
                        final percentage = budget["percentage"] as double;
                        final isOverBudget = percentage > 100;
                        final isUnderBudget = percentage < 85;
                        
                        Color statusColor = successColor;
                        if (isOverBudget) statusColor = dangerColor;
                        if (isUnderBudget) statusColor = warningColor;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${budget["department"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(26),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${budget["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: (percentage / 100).clamp(0.0, 1.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: statusColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${percentage.toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Spent: \$${(budget["spent"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "Budget: \$${(budget["allocated"] as double).currency}",
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
                    ),
                  ],
                ),
              ),
            ],

            if (selectedView == "projections") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quarterly Projections",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      spacing: spSm,
                      children: quarterlyProjections.map((quarter) {
                        final profit = (quarter["revenue"] as double) - (quarter["expenses"] as double);
                        final projectedProfit = (quarter["projected"] as double) - (quarter["expenses"] as double);
                        final variance = profit - projectedProfit;
                        final isPositiveVariance = variance >= 0;
                        
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${quarter["quarter"]} 2024",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        isPositiveVariance ? Icons.trending_up : Icons.trending_down,
                                        color: isPositiveVariance ? successColor : dangerColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${isPositiveVariance ? '+' : ''}\$${variance.abs().toStringAsFixed(0)}K",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isPositiveVariance ? successColor : dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Revenue",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${(quarter["revenue"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
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
                                          "Expenses",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${(quarter["expenses"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: dangerColor,
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
                                          "Profit",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${profit.currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule Email",
                    icon: Icons.schedule_send,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
