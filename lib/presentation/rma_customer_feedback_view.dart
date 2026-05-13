import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCustomerFeedbackView extends StatefulWidget {
  const RmaCustomerFeedbackView({super.key});

  @override
  State<RmaCustomerFeedbackView> createState() => _RmaCustomerFeedbackViewState();
}

class _RmaCustomerFeedbackViewState extends State<RmaCustomerFeedbackView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";

  List<Map<String, dynamic>> feedbackData = [
    {
      "id": "FB001",
      "customer": "Sarah Johnson",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "email": "sarah.johnson@email.com",
      "rating": 5,
      "subject": "Excellent Customer Service",
      "message": "I had an issue with my order and the support team resolved it quickly and professionally. Very impressed!",
      "category": "Service",
      "status": "Resolved",
      "priority": "Medium",
      "date": "2024-06-18",
      "response": "Thank you for your positive feedback! We're glad we could help resolve your issue quickly.",
      "responded_by": "Customer Support Team",
      "response_date": "2024-06-18"
    },
    {
      "id": "FB002",
      "customer": "Michael Chen",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "email": "michael.chen@email.com",
      "rating": 2,
      "subject": "Product Quality Issues",
      "message": "The product I received doesn't match the description. Poor quality materials and finishing.",
      "category": "Product",
      "status": "Under Review",
      "priority": "High",
      "date": "2024-06-17",
      "response": "",
      "responded_by": "",
      "response_date": ""
    },
    {
      "id": "FB003",
      "customer": "Emma Davis",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "email": "emma.davis@email.com",
      "rating": 4,
      "subject": "Good Experience Overall",
      "message": "The product is good but shipping took longer than expected. Otherwise satisfied with the purchase.",
      "category": "Shipping",
      "status": "Resolved",
      "priority": "Low",
      "date": "2024-06-16",
      "response": "Thank you for your feedback. We're working on improving our shipping times.",
      "responded_by": "Logistics Team",
      "response_date": "2024-06-17"
    },
    {
      "id": "FB004",
      "customer": "David Wilson",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=man",
      "email": "david.wilson@email.com",
      "rating": 1,
      "subject": "Billing Problem",
      "message": "I was charged twice for the same order. This is unacceptable. Need immediate refund.",
      "category": "Billing",
      "status": "Pending",
      "priority": "High",
      "date": "2024-06-15",
      "response": "",
      "responded_by": "",
      "response_date": ""
    },
    {
      "id": "FB005",
      "customer": "Lisa Thompson",
      "avatar": "https://picsum.photos/80/80?random=5&keyword=woman",
      "email": "lisa.thompson@email.com",
      "rating": 5,
      "subject": "Amazing Product",
      "message": "Love this product! Exactly what I was looking for. Will definitely order again.",
      "category": "Product",
      "status": "Resolved",
      "priority": "Low",
      "date": "2024-06-14",
      "response": "Thank you for your wonderful review! We're so happy you love the product.",
      "responded_by": "Product Team",
      "response_date": "2024-06-15"
    }
  ];

  List<Map<String, dynamic>> get filteredFeedback {
    return feedbackData.where((feedback) {
      bool matchesSearch = "${feedback["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${feedback["subject"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || feedback["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || feedback["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Feedback",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "All Feedback", icon: Icon(Icons.feedback)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildFeedbackListTab(),
        _buildAnalyticsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildFeedbackListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildFeedbackStats(),
          _buildFeedbackList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search feedback",
          value: searchQuery,
          hint: "Search by customer name or subject",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Pending", "value": "Pending"},
                  {"label": "Under Review", "value": "Under Review"},
                  {"label": "Resolved", "value": "Resolved"},
                ],
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
                label: "Priority",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Low", "value": "Low"},
                  {"label": "Medium", "value": "Medium"},
                  {"label": "High", "value": "High"},
                ],
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeedbackStats() {
    int totalFeedback = feedbackData.length;
    int pendingFeedback = feedbackData.where((f) => f["status"] == "Pending").length;
    int resolvedFeedback = feedbackData.where((f) => f["status"] == "Resolved").length;
    double avgRating = feedbackData.fold(0.0, (sum, f) => sum + (f["rating"] as int)) / totalFeedback;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "$totalFeedback",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Feedback",
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "$pendingFeedback",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Pending",
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "${avgRating.toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Avg Rating",
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
    );
  }

  Widget _buildFeedbackList() {
    return Column(
      spacing: spSm,
      children: filteredFeedback.map((feedback) {
        return Container(
          padding: EdgeInsets.all(spMd),
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
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("${feedback["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${feedback["customer"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fsH6,
                          ),
                        ),
                        Text(
                          "${feedback["email"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(feedback["status"]).withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${feedback["status"]}",
                      style: TextStyle(
                        color: _getStatusColor(feedback["status"]),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (feedback["rating"] as int) ? Icons.star : Icons.star_border,
                        color: warningColor,
                        size: 16,
                      );
                    }),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(feedback["priority"]).withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${feedback["priority"]}",
                      style: TextStyle(
                        color: _getPriorityColor(feedback["priority"]),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "${feedback["subject"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                "${feedback["message"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 13,
                ),
              ),
              if ("${feedback["response"]}".isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Response:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${feedback["response"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Responded by ${feedback["responded_by"]} on ${feedback["response_date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Row(
                children: [
                  Text(
                    "${feedback["date"]}",
                    style: TextStyle(
                      color: disabledColor,
                      fontSize: 12,
                    ),
                  ),
                  Spacer(),
                  if (feedback["status"] != "Resolved") ...[
                    QButton(
                      label: "Respond",
                      size: bs.sm,
                      onPressed: () {
                        // Handle respond action
                      },
                    ),
                    SizedBox(width: spXs),
                  ],
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      // Handle more actions
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRatingDistribution(),
          _buildCategoryBreakdown(),
          _buildResponseTimeAnalytics(),
        ],
      ),
    );
  }

  Widget _buildRatingDistribution() {
    Map<int, int> ratingCounts = {};
    for (var feedback in feedbackData) {
      int rating = feedback["rating"] as int;
      ratingCounts[rating] = (ratingCounts[rating] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Rating Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...List.generate(5, (index) {
            int rating = 5 - index;
            int count = ratingCounts[rating] ?? 0;
            double percentage = count / feedbackData.length;
            
            return Row(
              children: [
                Row(
                  children: List.generate(rating, (i) => Icon(Icons.star, color: warningColor, size: 16)),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "$count",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    Map<String, int> categoryCounts = {};
    for (var feedback in feedbackData) {
      String category = feedback["category"] as String;
      categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Feedback by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categoryCounts.entries.map((entry) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${entry.value}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
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

  Widget _buildResponseTimeAnalytics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Response Time Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "2.4 hrs",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Avg Response Time",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "85%",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Response Rate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Generate Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Weekly Report",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Monthly Report",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                QButton(
                  label: "Custom Date Range Report",
                  size: bs.md,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Resolved":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Pending":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
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
