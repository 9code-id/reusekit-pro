import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSoilRecommendationsView extends StatefulWidget {
  const AmaSoilRecommendationsView({super.key});

  @override
  State<AmaSoilRecommendationsView> createState() => _AmaSoilRecommendationsViewState();
}

class _AmaSoilRecommendationsViewState extends State<AmaSoilRecommendationsView> {
  List<Map<String, dynamic>> recommendations = [
    {
      "id": "REC001",
      "fieldName": "North Field",
      "priority": "High",
      "category": "Nutrition",
      "title": "Nitrogen Deficiency Treatment",
      "description": "Apply nitrogen fertilizer to address low nitrogen levels affecting crop growth",
      "recommendation": "Apply 25 lbs/acre of nitrogen fertilizer (urea or ammonium sulfate)",
      "expectedResult": "Improved leaf color and growth rate within 2-3 weeks",
      "cost": 450,
      "timeframe": "Within 1 week",
      "season": "Spring",
      "cropStage": "Vegetative Growth",
      "urgency": "Immediate",
      "effectiveness": 95,
      "steps": [
        "Test soil moisture - ensure adequate moisture for nutrient uptake",
        "Apply fertilizer evenly using spreader equipment",
        "Water lightly if no rain expected within 48 hours",
        "Monitor plant response after 10-14 days"
      ],
      "equipment": ["Fertilizer spreader", "Soil moisture meter"],
      "materials": ["Urea fertilizer (500 lbs)", "Water for irrigation"],
      "precautions": ["Avoid application before heavy rain", "Don't over-apply to prevent burning"]
    },
    {
      "id": "REC002",
      "fieldName": "South Field",
      "priority": "Medium",
      "category": "pH Management",
      "title": "Soil Acidification Treatment",
      "description": "Increase soil pH from 5.2 to optimal range of 6.0-7.0 for better nutrient availability",
      "recommendation": "Apply 2 tons/acre of agricultural lime",
      "expectedResult": "pH improvement to 6.2-6.5 range within 3-6 months",
      "cost": 350,
      "timeframe": "Within 2 weeks",
      "season": "Fall/Winter",
      "cropStage": "Pre-planting",
      "urgency": "Moderate",
      "effectiveness": 88,
      "steps": [
        "Conduct soil test to confirm current pH",
        "Calculate lime requirement based on soil type",
        "Apply lime using spreader during dry conditions",
        "Incorporate lime into soil with tillage",
        "Retest pH after 3-4 months"
      ],
      "equipment": ["Lime spreader", "Tillage equipment"],
      "materials": ["Agricultural lime (4 tons)", "pH test kit"],
      "precautions": ["Don't apply lime with fertilizer", "Avoid windy conditions during application"]
    },
    {
      "id": "REC003",
      "fieldName": "East Field",
      "priority": "Low",
      "category": "Organic Matter",
      "title": "Soil Organic Matter Enhancement",
      "description": "Increase soil organic matter content to improve soil structure and water retention",
      "recommendation": "Apply 3 cubic yards/acre of well-composted organic matter",
      "expectedResult": "Improved soil structure and 0.5% increase in organic matter",
      "cost": 280,
      "timeframe": "Within 1 month",
      "season": "Fall",
      "cropStage": "Post-harvest",
      "urgency": "Low",
      "effectiveness": 75,
      "steps": [
        "Source quality compost or organic matter",
        "Test compost for maturity and C:N ratio",
        "Spread compost evenly across field",
        "Incorporate into top 6 inches of soil",
        "Monitor soil structure improvement over season"
      ],
      "equipment": ["Manure spreader", "Disk harrow"],
      "materials": ["Compost (60 cubic yards)", "Soil test supplies"],
      "precautions": ["Ensure compost is fully decomposed", "Avoid fresh manure application"]
    },
    {
      "id": "REC004",
      "fieldName": "West Field",
      "priority": "High",
      "category": "Micronutrients",
      "title": "Iron Deficiency Correction",
      "description": "Address iron chlorosis affecting crop growth and yield potential",
      "recommendation": "Apply chelated iron fertilizer at 5 lbs/acre",
      "expectedResult": "Improved leaf green color and reduced chlorosis within 1-2 weeks",
      "cost": 125,
      "timeframe": "Within 3 days",
      "season": "Spring",
      "cropStage": "Early Growth",
      "urgency": "Immediate",
      "effectiveness": 92,
      "steps": [
        "Confirm iron deficiency with tissue analysis",
        "Choose appropriate chelated iron product",
        "Apply during cool, cloudy conditions",
        "Ensure adequate soil moisture for uptake",
        "Monitor leaf color response weekly"
      ],
      "equipment": ["Sprayer", "Mixing tank"],
      "materials": ["Chelated iron fertilizer", "Adjuvant"],
      "precautions": ["Avoid application in hot weather", "Don't mix with high pH water"]
    },
  ];

  List<Map<String, dynamic>> savedPlans = [
    {
      "id": "PLAN001",
      "name": "Spring Nutrition Plan",
      "fields": ["North Field", "South Field"],
      "totalCost": 800,
      "duration": "4 weeks",
      "status": "Active",
      "progress": 65,
      "createdDate": "2024-06-01",
    },
    {
      "id": "PLAN002", 
      "name": "pH Correction Program",
      "fields": ["South Field", "West Field"],
      "totalCost": 475,
      "duration": "12 weeks",
      "status": "Planned",
      "progress": 0,
      "createdDate": "2024-06-10",
    },
  ];

  String selectedField = "All Fields";
  String selectedPriority = "All Priorities";
  String selectedCategory = "All Categories";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soil Recommendations"),
        actions: [
          IconButton(
            icon: Icon(Icons.create_new_folder),
            onPressed: () {
              // navigateTo('create-plan')
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // navigateTo('recommendation-history')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.recommend,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Soil Improvement Recommendations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "AI-powered recommendations based on soil analysis",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filter Section
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                QDropdownField(
                  label: "Field",
                  items: [
                    {"label": "All Fields", "value": "All Fields"},
                    {"label": "North Field", "value": "North Field"},
                    {"label": "South Field", "value": "South Field"},
                    {"label": "East Field", "value": "East Field"},
                    {"label": "West Field", "value": "West Field"},
                  ],
                  value: selectedField,
                  onChanged: (value, label) {
                    selectedField = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "All Priorities", "value": "All Priorities"},
                    {"label": "High", "value": "High"},
                    {"label": "Medium", "value": "Medium"},
                    {"label": "Low", "value": "Low"},
                  ],
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Category",
                  items: [
                    {"label": "All Categories", "value": "All Categories"},
                    {"label": "Nutrition", "value": "Nutrition"},
                    {"label": "pH Management", "value": "pH Management"},
                    {"label": "Organic Matter", "value": "Organic Matter"},
                    {"label": "Micronutrients", "value": "Micronutrients"},
                  ],
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Plan",
                    icon: Icons.auto_awesome,
                    size: bs.sm,
                    onPressed: () {
                      _showGeneratePlanDialog();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export PDF",
                    icon: Icons.picture_as_pdf,
                    size: bs.sm,
                    onPressed: () {
                      ss("Recommendations exported to PDF");
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Recommendations List
            Text(
              "Current Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final rec = recommendations[index];
                Color priorityColor = successColor;
                if ("${rec["priority"]}" == "High") priorityColor = dangerColor;
                if ("${rec["priority"]}" == "Medium") priorityColor = warningColor;

                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: priorityColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${rec["priority"]} Priority",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: priorityColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${rec["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${rec["fieldName"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Text(
                        "${rec["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      SizedBox(height: spXs),

                      Text(
                        "${rec["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      SizedBox(height: spSm),

                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: successColor.withAlpha(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lightbulb,
                                  size: 16,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Recommendation",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${rec["recommendation"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spSm),

                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 200,
                        children: [
                          _buildInfoCard("Cost", "\$${rec["cost"]}", Icons.attach_money, infoColor),
                          _buildInfoCard("Timeframe", "${rec["timeframe"]}", Icons.schedule, warningColor),
                          _buildInfoCard("Effectiveness", "${rec["effectiveness"]}%", Icons.trending_up, successColor),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                _showRecommendationDetails(rec);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            label: "Add to Plan",
                            icon: Icons.add,
                            size: bs.sm,
                            onPressed: () {
                              ss("Added to treatment plan");
                            },
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.share,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: spLg),

            // Saved Plans Section
            Text(
              "Saved Treatment Plans",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: savedPlans.length,
              itemBuilder: (context, index) {
                final plan = savedPlans[index];
                Color statusColor = successColor;
                if ("${plan["status"]}" == "Planned") statusColor = warningColor;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${plan["name"]}",
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
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${plan["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Text(
                            "Fields: ${(plan["fields"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "\$${plan["totalCost"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${plan["duration"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),

                      if ("${plan["status"]}" == "Active") ...[
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: (plan["progress"] as int) / 100,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(successColor),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${plan["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Plan",
                              size: bs.sm,
                              onPressed: () {
                                // navigateTo('view-plan')
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            label: "Edit",
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              // navigateTo('edit-plan')
                            },
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
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          SizedBox(width: spXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRecommendationDetails(Map<String, dynamic> rec) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${rec["title"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Implementation Steps:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...(rec["steps"] as List<String>).asMap().entries.map((entry) =>
                Padding(
                  padding: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${entry.key + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Expected Result:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${rec["expectedResult"]}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Recommendation marked as applied");
            },
            child: Text("Mark as Applied"),
          ),
        ],
      ),
    );
  }

  void _showGeneratePlanDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Generate Treatment Plan"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Generate a comprehensive treatment plan based on current recommendations?"),
            SizedBox(height: spMd),
            QTextField(
              label: "Plan Name",
              value: "",
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Treatment plan generated successfully");
            },
            child: Text("Generate"),
          ),
        ],
      ),
    );
  }
}
