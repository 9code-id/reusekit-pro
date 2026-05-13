import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaFinancialDashboardView extends StatefulWidget {
  const HhaFinancialDashboardView({super.key});

  @override
  State<HhaFinancialDashboardView> createState() => _HhaFinancialDashboardViewState();
}

class _HhaFinancialDashboardViewState extends State<HhaFinancialDashboardView> {
  String selectedPeriod = "This Month";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> financialMetrics = [
    {
      "title": "Total Revenue",
      "value": 245678.50,
      "change": 15.8,
      "target": 220000.0,
      "icon": Icons.attach_money,
      "color": 0xFF4CAF50,
    },
    {
      "title": "Net Profit",
      "value": 67543.20,
      "change": 18.5,
      "target": 55000.0,
      "icon": Icons.trending_up,
      "color": 0xFF2196F3,
    },
    {
      "title": "Operating Expenses",
      "value": 178135.30,
      "change": 8.2,
      "target": 165000.0,
      "icon": Icons.receipt,
      "color": 0xFFFF9800,
    },
    {
      "title": "Gross Margin",
      "value": 27.5,
      "change": 2.3,
      "target": 25.0,
      "icon": Icons.percent,
      "color": 0xFF9C27B0,
      "isPercentage": true,
    },
  ];

  List<Map<String, dynamic>> revenueBreakdown = [
    {
      "category": "Room Revenue",
      "amount": 165432.30,
      "percentage": 67.3,
      "change": 12.3,
      "color": 0xFF2196F3,
      "icon": Icons.hotel,
    },
    {
      "category": "Food & Beverage",
      "amount": 54321.80,
      "percentage": 22.1,
      "change": 8.7,
      "color": 0xFFFF9800,
      "icon": Icons.restaurant,
    },
    {
      "category": "Spa & Wellness",
      "amount": 19154.20,
      "percentage": 7.8,
      "change": 18.5,
      "color": 0xFF9C27B0,
      "icon": Icons.spa,
    },
    {
      "category": "Other Services",
      "amount": 6770.20,
      "percentage": 2.8,
      "change": 25.4,
      "color": 0xFF4CAF50,
      "icon": Icons.room_service,
    },
  ];

  List<Map<String, dynamic>> expenseCategories = [
    {
      "category": "Staff Costs",
      "amount": 89567.50,
      "percentage": 50.3,
      "budget": 85000.0,
      "color": 0xFF2196F3,
      "icon": Icons.people,
    },
    {
      "category": "Utilities",
      "amount": 34215.80,
      "percentage": 19.2,
      "budget": 32000.0,
      "color": 0xFFFF9800,
      "icon": Icons.electrical_services,
    },
    {
      "category": "Maintenance",
      "amount": 28450.30,
      "percentage": 16.0,
      "budget": 30000.0,
      "color": 0xFF4CAF50,
      "icon": Icons.build,
    },
    {
      "category": "Marketing",
      "amount": 15678.90,
      "percentage": 8.8,
      "budget": 18000.0,
      "color": 0xFF9C27B0,
      "icon": Icons.campaign,
    },
    {
      "category": "Other",
      "amount": 10222.80,
      "percentage": 5.7,
      "budget": 12000.0,
      "color": 0xFFE91E63,
      "icon": Icons.category,
    },
  ];

  List<Map<String, dynamic>> cashFlowData = [
    {
      "month": "Oct",
      "income": 198500.00,
      "expenses": 145300.00,
      "profit": 53200.00,
    },
    {
      "month": "Nov",
      "income": 215300.00,
      "expenses": 158600.00,
      "profit": 56700.00,
    },
    {
      "month": "Dec",
      "income": 235600.00,
      "expenses": 167200.00,
      "profit": 68400.00,
    },
    {
      "month": "Jan",
      "income": 201400.00,
      "expenses": 152800.00,
      "profit": 48600.00,
    },
    {
      "month": "Feb",
      "income": 218900.00,
      "expenses": 161200.00,
      "profit": 57700.00,
    },
    {
      "month": "Mar",
      "income": 245678.50,
      "expenses": 178135.30,
      "profit": 67543.20,
    },
  ];

  List<Map<String, dynamic>> budgetComparison = [
    {"category": "Revenue", "actual": 245678.50, "budget": 220000.0, "variance": 25678.50},
    {"category": "Room Revenue", "actual": 165432.30, "budget": 150000.0, "variance": 15432.30},
    {"category": "F&B Revenue", "actual": 54321.80, "budget": 50000.0, "variance": 4321.80},
    {"category": "Staff Costs", "actual": 89567.50, "budget": 85000.0, "variance": -4567.50},
    {"category": "Utilities", "actual": 34215.80, "budget": 32000.0, "variance": -2215.80},
    {"category": "Marketing", "actual": 15678.90, "budget": 18000.0, "variance": 2321.10},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Financial Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Revenue", icon: Icon(Icons.attach_money)),
        Tab(text: "Expenses", icon: Icon(Icons.receipt)),
        Tab(text: "Budget", icon: Icon(Icons.account_balance)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRevenueTab(),
        _buildExpensesTab(),
        _buildBudgetTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Filter
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Financial Metrics
          Text(
            "Financial Overview",
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
            children: financialMetrics.map((metric) {
              final isPositive = (metric["change"] as double) >= 0;
              final isOnTarget = metric["title"] == "Operating Expenses"
                ? (metric["value"] as double) <= (metric["target"] as double)
                : (metric["value"] as double) >= (metric["target"] as double);
              
              return Container(
                padding: EdgeInsets.all(spMd),
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
                            color: Color(metric["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: Color(metric["color"] as int),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${metric["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Text(
                      metric["isPercentage"] == true
                        ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                        : "\$${((metric["value"] as double)).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Icon(
                          isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                          color: isPositive ? successColor : dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${isPositive ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: isPositive ? successColor : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          isOnTarget ? Icons.check_circle : Icons.error,
                          color: isOnTarget ? successColor : warningColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),

          // Cash Flow Chart
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cash Flow Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cashFlowData.length,
                    itemBuilder: (context, index) {
                      final data = cashFlowData[index];
                      final income = (data["income"] as double);
                      final expenses = (data["expenses"] as double);
                      final profit = (data["profit"] as double);
                      final maxValue = cashFlowData.map((d) => d["income"] as double).reduce((a, b) => a > b ? a : b);
                      
                      final incomeHeight = (income / maxValue) * 180;
                      final expenseHeight = (expenses / maxValue) * 180;
                      
                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spMd),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(profit / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: 12,
                                color: profit >= 0 ? successColor : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: incomeHeight,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Container(
                                    height: expenseHeight,
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            
                            Text(
                              "${data["month"]}",
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
                SizedBox(height: spSm),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Income",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Expenses",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue Breakdown",
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
            itemCount: revenueBreakdown.length,
            itemBuilder: (context, index) {
              final revenue = revenueBreakdown[index];
              final amount = (revenue["amount"] as double);
              final percentage = (revenue["percentage"] as double);
              final change = (revenue["change"] as double);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: Color(revenue["color"] as int),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Color(revenue["color"] as int).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        revenue["icon"] as IconData,
                        color: Color(revenue["color"] as int),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${revenue["category"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${amount.currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(revenue["color"] as int),
                            ),
                          ),
                          SizedBox(height: spXs),
                          
                          LinearProgressIndicator(
                            value: percentage / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(revenue["color"] as int),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: Color(revenue["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${percentage.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(revenue["color"] as int),
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "+${change.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expense Categories",
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
            itemCount: expenseCategories.length,
            itemBuilder: (context, index) {
              final expense = expenseCategories[index];
              final amount = (expense["amount"] as double);
              final percentage = (expense["percentage"] as double);
              final budget = (expense["budget"] as double);
              final isOverBudget = amount > budget;
              final variance = amount - budget;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: isOverBudget ? dangerColor : Color(expense["color"] as int),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Color(expense["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            expense["icon"] as IconData,
                            color: Color(expense["color"] as int),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${expense["category"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${percentage.toStringAsFixed(1)}% of total expenses",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isOverBudget 
                              ? dangerColor.withAlpha(20)
                              : successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            isOverBudget ? "Over Budget" : "On Budget",
                            style: TextStyle(
                              fontSize: 12,
                              color: isOverBudget ? dangerColor : successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Actual: \$${amount.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Budget: \$${budget.currency}",
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
                              "${isOverBudget ? '+' : ''}\$${variance.abs().currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isOverBudget ? dangerColor : successColor,
                              ),
                            ),
                            Text(
                              "${isOverBudget ? 'over' : 'under'} budget",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Budget vs Actual Comparison",
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
            itemCount: budgetComparison.length,
            itemBuilder: (context, index) {
              final budget = budgetComparison[index];
              final actual = (budget["actual"] as double);
              final budgetAmount = (budget["budget"] as double);
              final variance = (budget["variance"] as double);
              final isPositive = variance >= 0;
              final achievement = (actual / budgetAmount) * 100;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
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
                            "${budget["category"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: achievement >= 100 
                              ? (budget["category"].toString().contains("Revenue") ? successColor.withAlpha(20) : dangerColor.withAlpha(20))
                              : (budget["category"].toString().contains("Revenue") ? warningColor.withAlpha(20) : successColor.withAlpha(20)),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${achievement.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: achievement >= 100 
                                ? (budget["category"].toString().contains("Revenue") ? successColor : dangerColor)
                                : (budget["category"].toString().contains("Revenue") ? warningColor : successColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Actual: \$${actual.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Budget: \$${budgetAmount.currency}",
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
                            Row(
                              children: [
                                Icon(
                                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                  color: isPositive ? successColor : dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${isPositive ? '+' : ''}\$${variance.abs().currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isPositive ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${((variance / budgetAmount) * 100).abs().toStringAsFixed(1)}% variance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    LinearProgressIndicator(
                      value: achievement / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        achievement >= 100 
                          ? (budget["category"].toString().contains("Revenue") ? successColor : dangerColor)
                          : warningColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
