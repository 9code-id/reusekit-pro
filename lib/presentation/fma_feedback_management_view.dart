import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaFeedbackManagementView extends StatefulWidget {
  const FmaFeedbackManagementView({super.key});

  @override
  State<FmaFeedbackManagementView> createState() => _FmaFeedbackManagementViewState();
}

class _FmaFeedbackManagementViewState extends State<FmaFeedbackManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> feedbackCategories = [
    {"label": "All", "value": "All"},
    {"label": "Food Quality", "value": "Food Quality"},
    {"label": "Service", "value": "Service"},
    {"label": "Cleanliness", "value": "Cleanliness"},
    {"label": "Pricing", "value": "Pricing"},
    {"label": "Ambiance", "value": "Ambiance"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> feedbackStatuses = [
    {"label": "All", "value": "All"},
    {"label": "New", "value": "New"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Resolved", "value": "Resolved"},
    {"label": "Closed", "value": "Closed"},
  ];

  List<Map<String, dynamic>> feedbackList = [
    {
      "id": "1",
      "customerName": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1 555-0123",
      "category": "Food Quality",
      "rating": 4,
      "subject": "Excellent pasta dish",
      "message": "The carbonara was absolutely delicious! The pasta was perfectly cooked and the sauce was creamy. Will definitely order again.",
      "status": "Resolved",
      "priority": "Medium",
      "submittedAt": "2024-06-18 14:30:00",
      "resolvedAt": "2024-06-18 16:45:00",
      "assignedTo": "Manager",
      "response": "Thank you for the wonderful feedback! We're glad you enjoyed our carbonara.",
      "images": ["https://picsum.photos/200/150?random=1&keyword=pasta"],
      "isPositive": true
    },
    {
      "id": "2",
      "customerName": "Mike Chen",
      "email": "mike.chen@email.com",
      "phone": "+1 555-0124",
      "category": "Service",
      "rating": 2,
      "subject": "Slow service during lunch",
      "message": "Waited 45 minutes for my order during lunch hour. The staff seemed overwhelmed and not well organized. Food was good but the wait was unacceptable.",
      "status": "In Progress",
      "priority": "High",
      "submittedAt": "2024-06-17 12:15:00",
      "resolvedAt": null,
      "assignedTo": "Service Manager",
      "response": "We apologize for the delay. We're reviewing our lunch hour staffing and processes.",
      "images": [],
      "isPositive": false
    },
    {
      "id": "3",
      "customerName": "Emily Davis",
      "email": "emily.d@email.com",
      "phone": "+1 555-0125",
      "category": "Cleanliness",
      "rating": 1,
      "subject": "Dirty table and restroom",
      "message": "The table was sticky and had crumbs from previous customers. The restroom was also not clean. This is concerning for a restaurant.",
      "status": "New",
      "priority": "High",
      "submittedAt": "2024-06-19 10:00:00",
      "resolvedAt": null,
      "assignedTo": null,
      "response": null,
      "images": ["https://picsum.photos/200/150?random=2&keyword=table"],
      "isPositive": false
    },
    {
      "id": "4",
      "customerName": "David Wilson",
      "email": "d.wilson@email.com",
      "phone": "+1 555-0126",
      "category": "Ambiance",
      "rating": 5,
      "subject": "Perfect atmosphere for date night",
      "message": "The lighting, music, and overall atmosphere was perfect for our anniversary dinner. The staff was attentive without being intrusive.",
      "status": "Resolved",
      "priority": "Low",
      "submittedAt": "2024-06-16 19:30:00",
      "resolvedAt": "2024-06-17 09:00:00",
      "assignedTo": "Manager",
      "response": "Thank you for choosing us for your special occasion! We're thrilled it was perfect.",
      "images": [],
      "isPositive": true
    },
    {
      "id": "5",
      "customerName": "Lisa Brown",
      "email": "lisa.brown@email.com",
      "phone": "+1 555-0127",
      "category": "Pricing",
      "rating": 3,
      "subject": "Portion sizes vs price",
      "message": "The food quality is good but the portions are quite small for the price. Would like to see better value for money.",
      "status": "Closed",
      "priority": "Medium",
      "submittedAt": "2024-06-15 18:45:00",
      "resolvedAt": "2024-06-16 14:30:00",
      "assignedTo": "Manager",
      "response": "We appreciate your feedback. We'll review our portion sizes and pricing structure.",
      "images": ["https://picsum.photos/200/150?random=3&keyword=food"],
      "isPositive": false
    },
  ];

  List<Map<String, dynamic>> get filteredFeedback {
    return feedbackList.where((feedback) {
      bool matchesSearch = feedback["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          feedback["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          feedback["message"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || feedback["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || feedback["status"] == selectedStatus;
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "New": return dangerColor;
      case "In Progress": return warningColor;
      case "Resolved": return successColor;
      case "Closed": return disabledBoldColor;
      default: return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High": return dangerColor;
      case "Medium": return warningColor;
      case "Low": return successColor;
      default: return primaryColor;
    }
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return successColor;
    if (rating >= 3) return warningColor;
    return dangerColor;
  }

  Widget _buildStarsRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: warningColor,
          size: 16,
        );
      }),
    );
  }

  Widget _buildOverviewTab() {
    int totalFeedback = feedbackList.length;
    int newFeedback = feedbackList.where((f) => f["status"] == "New").length;
    int positiveFeedback = feedbackList.where((f) => f["isPositive"] == true).length;
    double avgRating = feedbackList.map((f) => f["rating"] as int).reduce((a, b) => a + b) / feedbackList.length;
    
    Map<String, int> categoryStats = {};
    for (var feedback in feedbackList) {
      String category = feedback["category"];
      categoryStats[category] = (categoryStats[category] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.feedback, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalFeedback",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Feedback",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.notification_important, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$newFeedback",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "New Feedback",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.thumb_up, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$positiveFeedback",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Positive Reviews",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${avgRating.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Average Rating",
                      textAlign: TextAlign.center,
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

          // Category Breakdown
          Text(
            "Feedback by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: categoryStats.entries.map((entry) {
                double percentage = entry.value / totalFeedback;
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${entry.value} (${(percentage * 100).toStringAsFixed(1)}%)",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(102),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          // Recent Feedback
          Text(
            "Recent Feedback",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: feedbackList.take(3).map((feedback) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: feedback["isPositive"] == true ? successColor : dangerColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
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
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              _buildStarsRating(feedback["rating"]),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(feedback["status"]).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${feedback["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(feedback["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${feedback["subject"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${feedback["message"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${feedback["category"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${feedback["submittedAt"].toString().substring(0, 16)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
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
    );
  }

  Widget _buildFeedbackTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Search feedback...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: feedbackCategories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: feedbackStatuses,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Feedback List
          Column(
            spacing: spSm,
            children: filteredFeedback.map((feedback) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: feedback["isPositive"] == true ? successColor : dangerColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
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
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${feedback["email"]} • ${feedback["phone"]}",
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor(feedback["status"]).withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${feedback["status"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(feedback["status"]),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            _buildStarsRating(feedback["rating"]),
                          ],
                        ),
                      ],
                    ),
                    
                    Text(
                      "${feedback["subject"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    
                    Text(
                      "${feedback["message"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),

                    if ((feedback["images"] as List).isNotEmpty) ...[
                      Text(
                        "Attachments:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (feedback["images"] as List).length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: spSm),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${(feedback["images"] as List)[index]}",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${feedback["category"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(feedback["priority"]).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${feedback["priority"]} Priority",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(feedback["priority"]),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${feedback["submittedAt"].toString().substring(0, 16)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),

                    if (feedback["assignedTo"] != null) ...[
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person, color: infoColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Assigned to: ${feedback["assignedTo"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    if (feedback["response"] != null) ...[
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Our Response:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: successColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${feedback["response"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Respond",
                            size: bs.sm,
                            onPressed: () {
                              ss("Responding to ${feedback["customerName"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Update Status",
                            size: bs.sm,
                            onPressed: () {
                              ss("Updating feedback status");
                            },
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Feedback Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "All Feedback", icon: Icon(Icons.feedback)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildFeedbackTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
