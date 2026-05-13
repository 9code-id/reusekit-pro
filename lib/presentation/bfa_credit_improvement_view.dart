import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCreditImprovementView extends StatefulWidget {
  const BfaCreditImprovementView({super.key});

  @override
  State<BfaCreditImprovementView> createState() => _BfaCreditImprovementViewState();
}

class _BfaCreditImprovementViewState extends State<BfaCreditImprovementView> {
  int currentTab = 0;
  String selectedGoal = "Improve Score";
  
  List<Map<String, dynamic>> goals = [
    {"label": "Improve Score", "value": "Improve Score"},
    {"label": "Reduce Debt", "value": "Reduce Debt"},
    {"label": "Build History", "value": "Build History"},
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "title": "Pay Down Credit Cards",
      "description": "Reduce your credit utilization to under 30%",
      "impact": "High",
      "timeline": "2-3 months",
      "current": 45,
      "target": 25,
      "icon": Icons.credit_card,
      "color": successColor,
      "priority": 1,
    },
    {
      "title": "Pay Bills On Time",
      "description": "Set up automatic payments to avoid late fees",
      "impact": "High",
      "timeline": "1 month",
      "current": 95,
      "target": 100,
      "icon": Icons.schedule,
      "color": warningColor,
      "priority": 2,
    },
    {
      "title": "Keep Old Accounts Open",
      "description": "Maintain older accounts to improve credit age",
      "impact": "Medium",
      "timeline": "6+ months",
      "current": 6.2,
      "target": 8.0,
      "icon": Icons.history,
      "color": infoColor,
      "priority": 3,
    },
    {
      "title": "Limit New Credit Applications",
      "description": "Avoid unnecessary hard inquiries",
      "impact": "Medium",
      "timeline": "3-6 months",
      "current": 3,
      "target": 1,
      "icon": Icons.block,
      "color": dangerColor,
      "priority": 4,
    },
  ];

  List<Map<String, dynamic>> progress = [
    {
      "month": "Jan 2024",
      "score": 720,
      "improvement": 0,
    },
    {
      "month": "Feb 2024",
      "score": 735,
      "improvement": 15,
    },
    {
      "month": "Mar 2024",
      "score": 750,
      "improvement": 15,
    },
    {
      "month": "Apr 2024",
      "score": 765,
      "improvement": 15,
    },
    {
      "month": "May 2024",
      "score": 785,
      "improvement": 20,
    },
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "title": "Review Credit Report",
      "description": "Check for errors and disputed items",
      "completed": true,
      "due_date": "2024-05-01",
      "category": "Monitoring",
    },
    {
      "title": "Pay Credit Card Balance",
      "description": "Reduce Chase Freedom balance by \$1,000",
      "completed": false,
      "due_date": "2024-06-15",
      "category": "Debt Reduction",
    },
    {
      "title": "Set Up Auto Pay",
      "description": "Enable automatic payments for all accounts",
      "completed": false,
      "due_date": "2024-06-20",
      "category": "Payment History",
    },
    {
      "title": "Request Credit Limit Increase",
      "description": "Contact Bank of America for limit increase",
      "completed": false,
      "due_date": "2024-07-01",
      "category": "Utilization",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Credit Improvement",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Recommendations", icon: Icon(Icons.lightbulb)),
        Tab(text: "Progress", icon: Icon(Icons.trending_up)),
        Tab(text: "Action Plan", icon: Icon(Icons.assignment)),
        Tab(text: "Education", icon: Icon(Icons.school)),
      ],
      tabChildren: [
        _buildRecommendationsTab(),
        _buildProgressTab(),
        _buildActionPlanTab(),
        _buildEducationTab(),
      ],
    );
  }

  Widget _buildRecommendationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.gps_fixed,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  "Credit Improvement Goal",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Increase score by 50+ points in 6 months",
                  style: TextStyle(
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),

          QDropdownField(
            label: "Improvement Goal",
            items: goals,
            value: selectedGoal,
            onChanged: (value, label) {
              selectedGoal = value;
              setState(() {});
            },
          ),

          Text(
            "Personalized Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...recommendations.map((rec) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: rec["color"] as Color,
                  ),
                ),
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
                          color: (rec["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          rec["icon"] as IconData,
                          color: rec["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${rec["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${rec["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: rec["priority"] == 1 ? dangerColor.withAlpha(20) : 
                                 rec["priority"] == 2 ? warningColor.withAlpha(20) : 
                                 infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Priority ${rec["priority"]}",
                          style: TextStyle(
                            color: rec["priority"] == 1 ? dangerColor : 
                                   rec["priority"] == 2 ? warningColor : 
                                   infoColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Impact",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${rec["impact"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
                                "Timeline",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${rec["timeline"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
                                "Progress",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${rec["current"]} → ${rec["target"]}",
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
                  ),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Start This Action",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Credit Score Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Current Score",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "785",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "+65 points improvement since January",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: progress.length,
                    itemBuilder: (context, index) {
                      final month = progress[index];
                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spSm),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if ((month["improvement"] as int) > 0)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "+${month["improvement"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            SizedBox(height: spXs),
                            Container(
                              height: ((month["score"] as int) - 600) / 200 * 120,
                              width: 40,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXs)),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${month["score"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${month["month"]}".split(' ')[0],
                              style: TextStyle(
                                fontSize: 10,
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

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: successColor.withAlpha(60)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "65",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Points Gained",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: infoColor.withAlpha(60)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "5",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Months Progress",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Next Milestone",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Reach 800+ for Excellent Credit",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                LinearProgressIndicator(
                  value: 0.75,
                  backgroundColor: disabledColor.withAlpha(60),
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
                Text(
                  "15 points to go",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionPlanTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Action Plan",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...tasks.map((task) {
            bool isCompleted = task["completed"] as bool;
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: isCompleted ? successColor : primaryColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: isCompleted ? successColor : disabledBoldColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${task["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isCompleted ? disabledBoldColor : primaryColor,
                                decoration: isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            Text(
                              "${task["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(task["category"] as String).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${task["category"]}",
                          style: TextStyle(
                            color: _getCategoryColor(task["category"] as String),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${task["due_date"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        if (!isCompleted) ...[
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              task["completed"] = true;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Mark Complete",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Task",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Credit Education",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Container(
            width: double.infinity,
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
                  "Credit Score Factors",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                _buildFactorItem("Payment History", "35%", "Most important factor", successColor),
                _buildFactorItem("Credit Utilization", "30%", "Keep below 30%", warningColor),
                _buildFactorItem("Length of Credit History", "15%", "Older accounts are better", infoColor),
                _buildFactorItem("Credit Mix", "10%", "Diverse account types", primaryColor),
                _buildFactorItem("New Credit", "10%", "Limit new applications", dangerColor),
              ],
            ),
          ),

          Container(
            width: double.infinity,
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
                  "Credit Score Ranges",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                _buildScoreRange("Excellent", "750-850", successColor),
                _buildScoreRange("Good", "700-749", infoColor),
                _buildScoreRange("Fair", "650-699", warningColor),
                _buildScoreRange("Poor", "600-649", dangerColor),
                _buildScoreRange("Very Poor", "300-599", dangerColor),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: infoColor.withAlpha(60)),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: infoColor,
                  size: 24,
                ),
                Text(
                  "Quick Tips",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Column(
                  spacing: spXs,
                  children: [
                    _buildTipItem("Pay all bills on time, every time"),
                    _buildTipItem("Keep credit utilization below 30%"),
                    _buildTipItem("Don't close old credit accounts"),
                    _buildTipItem("Check your credit report regularly"),
                    _buildTipItem("Only apply for credit when necessary"),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "View More Resources",
              icon: Icons.library_books,
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFactorItem(String title, String percentage, String description, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
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
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    percentage,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              Text(
                description,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScoreRange(String label, String range, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
        Text(
          range,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTipItem(String tip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: infoColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Monitoring":
        return infoColor;
      case "Debt Reduction":
        return successColor;
      case "Payment History":
        return warningColor;
      case "Utilization":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
