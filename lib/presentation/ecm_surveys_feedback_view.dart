import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSurveysFeedbackView extends StatefulWidget {
  const EcmSurveysFeedbackView({super.key});

  @override
  State<EcmSurveysFeedbackView> createState() => _EcmSurveysFeedbackViewState();
}

class _EcmSurveysFeedbackViewState extends State<EcmSurveysFeedbackView> {
  int currentTab = 0;
  String selectedStatus = "All";
  String selectedType = "All Types";
  String searchQuery = "";
  
  List<Map<String, dynamic>> surveys = [
    {
      "id": "SRV001",
      "title": "Customer Satisfaction Survey",
      "description": "Quarterly customer satisfaction assessment",
      "type": "Customer Feedback",
      "status": "Active",
      "responses": 245,
      "target": 500,
      "rating": 4.2,
      "completionRate": 68.5,
      "createdDate": "2024-03-01",
      "endDate": "2024-03-31",
      "questions": 15,
      "icon": Icons.sentiment_satisfied,
      "color": successColor,
    },
    {
      "id": "SRV002",
      "title": "Product Feature Request",
      "description": "Collect feedback on new product features",
      "type": "Product Feedback",
      "status": "Active",
      "responses": 89,
      "target": 200,
      "rating": 3.8,
      "completionRate": 44.5,
      "createdDate": "2024-03-10",
      "endDate": "2024-04-10",
      "questions": 12,
      "icon": Icons.lightbulb,
      "color": primaryColor,
    },
    {
      "id": "SRV003",
      "title": "Website Usability Study",
      "description": "Evaluate website user experience and navigation",
      "type": "UX Research",
      "status": "Completed",
      "responses": 150,
      "target": 150,
      "rating": 4.5,
      "completionRate": 100.0,
      "createdDate": "2024-02-15",
      "endDate": "2024-03-15",
      "questions": 20,
      "icon": Icons.web,
      "color": infoColor,
    },
    {
      "id": "SRV004",
      "title": "Employee Satisfaction Survey",
      "description": "Internal employee satisfaction and engagement",
      "type": "Internal Survey",
      "status": "Draft",
      "responses": 0,
      "target": 50,
      "rating": 0.0,
      "completionRate": 0.0,
      "createdDate": "2024-03-20",
      "endDate": "2024-04-20",
      "questions": 18,
      "icon": Icons.people,
      "color": warningColor,
    },
    {
      "id": "SRV005",
      "title": "Mobile App Feedback",
      "description": "Collect feedback on mobile app performance",
      "type": "App Feedback",
      "status": "Active",
      "responses": 67,
      "target": 300,
      "rating": 3.9,
      "completionRate": 22.3,
      "createdDate": "2024-03-05",
      "endDate": "2024-04-05",
      "questions": 10,
      "icon": Icons.phone_android,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> feedbackData = [
    {
      "id": "FB001",
      "surveyId": "SRV001",
      "surveyTitle": "Customer Satisfaction Survey",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.j@email.com",
      "rating": 5,
      "comment": "Excellent service and product quality. Very satisfied with the purchase experience.",
      "category": "Service Quality",
      "sentiment": "Positive",
      "date": "2024-03-18",
      "helpful": true,
      "tags": ["service", "quality", "satisfaction"],
    },
    {
      "id": "FB002",
      "surveyId": "SRV002",
      "surveyTitle": "Product Feature Request",
      "customerName": "Mike Chen",
      "customerEmail": "mike.c@email.com",
      "rating": 4,
      "comment": "Would love to see dark mode feature added to the app. Also, better search functionality would be great.",
      "category": "Feature Request",
      "sentiment": "Constructive",
      "date": "2024-03-17",
      "helpful": true,
      "tags": ["feature", "dark-mode", "search"],
    },
    {
      "id": "FB003",
      "surveyId": "SRV001",
      "surveyTitle": "Customer Satisfaction Survey",
      "customerName": "Emily Davis",
      "customerEmail": "emily.d@email.com",
      "rating": 2,
      "comment": "Delivery was delayed and customer support was not responsive. Product quality is okay but experience was poor.",
      "category": "Delivery & Support",
      "sentiment": "Negative",
      "date": "2024-03-16",
      "helpful": true,
      "tags": ["delivery", "support", "delay"],
    },
    {
      "id": "FB004",
      "surveyId": "SRV003",
      "surveyTitle": "Website Usability Study",
      "customerName": "Alex Thompson",
      "customerEmail": "alex.t@email.com",
      "rating": 5,
      "comment": "Website is very user-friendly and easy to navigate. Checkout process is smooth and secure.",
      "category": "Website Experience",
      "sentiment": "Positive",
      "date": "2024-03-15",
      "helpful": true,
      "tags": ["website", "navigation", "checkout"],
    },
    {
      "id": "FB005",
      "surveyId": "SRV005",
      "surveyTitle": "Mobile App Feedback",
      "customerName": "Lisa Wong",
      "customerEmail": "lisa.w@email.com",
      "rating": 3,
      "comment": "App works fine but sometimes crashes when loading product images. Could use some performance improvements.",
      "category": "Technical Issues",
      "sentiment": "Neutral",
      "date": "2024-03-14",
      "helpful": true,
      "tags": ["app", "crash", "performance"],
    },
  ];

  List<Map<String, dynamic>> analytics = [
    {
      "metric": "Total Surveys",
      "value": 5,
      "change": "+2",
      "trend": "up",
      "icon": Icons.quiz,
      "color": primaryColor,
    },
    {
      "metric": "Active Surveys",
      "value": 3,
      "change": "+1",
      "trend": "up",
      "icon": Icons.play_circle,
      "color": successColor,
    },
    {
      "metric": "Total Responses",
      "value": 551,
      "change": "+87",
      "trend": "up",
      "icon": Icons.feedback,
      "color": infoColor,
    },
    {
      "metric": "Avg. Rating",
      "value": 4.1,
      "change": "+0.3",
      "trend": "up",
      "icon": Icons.star,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Customer Feedback", "value": "Customer Feedback"},
    {"label": "Product Feedback", "value": "Product Feedback"},
    {"label": "UX Research", "value": "UX Research"},
    {"label": "Internal Survey", "value": "Internal Survey"},
    {"label": "App Feedback", "value": "App Feedback"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Surveys & Feedback",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Surveys", icon: Icon(Icons.quiz)),
        Tab(text: "Feedback", icon: Icon(Icons.feedback)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSurveysTab(),
        _buildFeedbackTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    double totalResponses = surveys.fold(0.0, (sum, item) => sum + (item["responses"] as int));
    double avgRating = surveys.where((s) => s["rating"] > 0).fold(0.0, (sum, item) => sum + (item["rating"] as double)) / 
                      surveys.where((s) => s["rating"] > 0).length;
    int activeSurveys = surveys.where((s) => s["status"] == "Active").length;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Cards
          ResponsiveGridView(
            minItemWidth: 200,
            children: analytics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: metric["trend"] == "up" 
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                metric["trend"] == "up" 
                                    ? Icons.trending_up 
                                    : Icons.trending_down,
                                size: 12,
                                color: metric["trend"] == "up" 
                                    ? successColor 
                                    : dangerColor,
                              ),
                              SizedBox(width: spXxs),
                              Text(
                                "${metric["change"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: metric["trend"] == "up" 
                                      ? successColor 
                                      : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${metric["metric"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${metric["value"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Recent Surveys
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Recent Surveys",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...surveys.take(3).map((survey) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (survey["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: (survey["color"] as Color).withAlpha(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          survey["icon"] as IconData,
                          color: survey["color"] as Color,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${survey["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${survey["responses"]}/${survey["target"]} responses",
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
                            color: survey["status"] == "Active"
                                ? successColor.withAlpha(20)
                                : survey["status"] == "Completed"
                                    ? primaryColor.withAlpha(20)
                                    : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${survey["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: survey["status"] == "Active"
                                  ? successColor
                                  : survey["status"] == "Completed"
                                      ? primaryColor
                                      : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Recent Feedback
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Recent Feedback",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...feedbackData.take(3).map((feedback) {
                  Color sentimentColor = feedback["sentiment"] == "Positive"
                      ? successColor
                      : feedback["sentiment"] == "Negative"
                          ? dangerColor
                          : warningColor;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: sentimentColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: sentimentColor.withAlpha(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${feedback["customerName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (feedback["rating"] as int)
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 12,
                                  color: warningColor,
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${feedback["comment"]}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXxs,
                              ),
                              decoration: BoxDecoration(
                                color: sentimentColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${feedback["sentiment"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: sentimentColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              DateTime.parse(feedback["date"]).dMMMy,
                              style: TextStyle(
                                fontSize: 10,
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
          ),

          // Quick Actions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: [
                    _buildActionCard(
                      "Create Survey",
                      "Design new customer survey",
                      Icons.add_circle,
                      primaryColor,
                    ),
                    _buildActionCard(
                      "View Reports",
                      "Generate feedback reports",
                      Icons.analytics,
                      infoColor,
                    ),
                    _buildActionCard(
                      "Manage Templates",
                      "Edit survey templates",
                      Icons.description,
                      successColor,
                    ),
                    _buildActionCard(
                      "Export Data",
                      "Download survey responses",
                      Icons.file_download,
                      warningColor,
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

  Widget _buildSurveysTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filter Row
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Action Row
          Row(
            children: [
              Expanded(
                child: Text(
                  "Survey Management",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Create Survey",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Surveys List
          ...surveys.map((survey) {
            double progressPercentage = (survey["responses"] as int) / (survey["target"] as int) * 100;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: survey["color"] as Color,
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
                          color: (survey["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          survey["icon"] as IconData,
                          color: survey["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${survey["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${survey["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: survey["status"] == "Active"
                              ? successColor.withAlpha(20)
                              : survey["status"] == "Completed"
                                  ? primaryColor.withAlpha(20)
                                  : survey["status"] == "Draft"
                                      ? warningColor.withAlpha(20)
                                      : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${survey["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: survey["status"] == "Active"
                                ? successColor
                                : survey["status"] == "Completed"
                                    ? primaryColor
                                    : survey["status"] == "Draft"
                                        ? warningColor
                                        : disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Response Progress",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${survey["responses"]}/${survey["target"]} (${progressPercentage.toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      LinearProgressIndicator(
                        value: progressPercentage / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          survey["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Survey Details
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Questions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${survey["questions"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Avg. Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXxs),
                                Text(
                                  "${(survey["rating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Type",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${survey["type"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "End Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              DateTime.parse(survey["endDate"]).dMMMy,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Results",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: survey["status"] == "Draft" ? "Publish" : "Edit",
                          size: bs.sm,
                          onPressed: () {},
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

  Widget _buildFeedbackTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Feedback",
                  value: searchQuery,
                  hint: "Search by customer name or comment...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          // Feedback List
          ...feedbackData.map((feedback) {
            Color sentimentColor = feedback["sentiment"] == "Positive"
                ? successColor
                : feedback["sentiment"] == "Negative"
                    ? dangerColor
                    : warningColor;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: sentimentColor,
                  ),
                ),
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
                              "${feedback["customerName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${feedback["customerEmail"]}",
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
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: sentimentColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${feedback["sentiment"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: sentimentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Text(
                    "Survey: ${feedback["surveyTitle"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Text(
                        "Rating: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < (feedback["rating"] as int)
                                ? Icons.star
                                : Icons.star_border,
                            size: 16,
                            color: warningColor,
                          );
                        }),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${feedback["rating"]}/5",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: sentimentColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: sentimentColor.withAlpha(20),
                      ),
                    ),
                    child: Text(
                      "${feedback["comment"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Text(
                        "Category: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${feedback["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        DateTime.parse(feedback["date"]).dMMMy,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if ((feedback["tags"] as List).isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: spSm),
                      child: Wrap(
                        spacing: spSm,
                        children: (feedback["tags"] as List).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "#$tag",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reply",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Mark Helpful",
                          size: bs.sm,
                          onPressed: () {},
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Overview
          Text(
            "Survey Analytics",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Key Metrics
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard(
                "Response Rate",
                "74.2%",
                Icons.trending_up,
                successColor,
                "+5.3% from last month",
              ),
              _buildAnalyticsCard(
                "Completion Rate",
                "68.5%",
                Icons.check_circle,
                infoColor,
                "+2.1% from last month",
              ),
              _buildAnalyticsCard(
                "Customer Satisfaction",
                "4.1/5",
                Icons.sentiment_satisfied,
                warningColor,
                "+0.3 from last month",
              ),
              _buildAnalyticsCard(
                "Net Promoter Score",
                "67",
                Icons.thumb_up,
                primaryColor,
                "+8 from last month",
              ),
            ],
          ),

          // Sentiment Analysis
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sentiment Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildSentimentBar("Positive", 65, successColor),
                SizedBox(height: spSm),
                _buildSentimentBar("Neutral", 25, warningColor),
                SizedBox(height: spSm),
                _buildSentimentBar("Negative", 10, dangerColor),
              ],
            ),
          ),

          // Top Categories
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Feedback Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                _buildCategoryItem("Service Quality", 89, primaryColor),
                _buildCategoryItem("Product Features", 67, infoColor),
                _buildCategoryItem("Delivery & Support", 45, successColor),
                _buildCategoryItem("Website Experience", 34, warningColor),
                _buildCategoryItem("Technical Issues", 23, dangerColor),
              ],
            ),
          ),

          // Export Actions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Export & Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 200,
                  children: [
                    _buildExportCard(
                      "Survey Responses",
                      "Export all survey data",
                      Icons.file_download,
                      primaryColor,
                    ),
                    _buildExportCard(
                      "Analytics Report",
                      "Generate insights report",
                      Icons.analytics,
                      infoColor,
                    ),
                    _buildExportCard(
                      "Customer Feedback",
                      "Export feedback comments",
                      Icons.feedback,
                      successColor,
                    ),
                    _buildExportCard(
                      "Performance Metrics",
                      "Download KPI dashboard",
                      Icons.dashboard,
                      warningColor,
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

  Widget _buildActionCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Access",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentBar(String label, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "$percentage%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: disabledColor,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String category, int count, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spMd),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Export",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
