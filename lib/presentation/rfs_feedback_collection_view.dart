import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsFeedbackCollectionView extends StatefulWidget {
  const RfsFeedbackCollectionView({super.key});

  @override
  State<RfsFeedbackCollectionView> createState() => _RfsFeedbackCollectionViewState();
}

class _RfsFeedbackCollectionViewState extends State<RfsFeedbackCollectionView> {
  String searchQuery = "";
  String selectedFilter = "all";
  String selectedRating = "all";
  String customerName = "";
  String customerEmail = "";
  String orderNumber = "";
  String feedbackComment = "";
  int selectedStars = 5;
  bool followUpRequired = false;
  bool isResolved = false;

  List<Map<String, dynamic>> feedbacks = [
    {
      "id": "FB001",
      "customer_name": "Emily Chen",
      "customer_email": "emily@example.com",
      "order_number": "ORD-2024-001",
      "rating": 5,
      "comment": "Absolutely delicious! The pasta was perfectly cooked and the service was outstanding. Will definitely order again!",
      "category": "food_quality",
      "date": "2024-06-15",
      "status": "resolved",
      "follow_up_required": false,
      "restaurant_response": "Thank you so much for your kind words! We're thrilled you enjoyed your meal.",
      "response_date": "2024-06-15"
    },
    {
      "id": "FB002",
      "customer_name": "James Wilson",
      "customer_email": "james@example.com",
      "order_number": "ORD-2024-002",
      "rating": 2,
      "comment": "Food arrived cold and took much longer than expected. The pizza was soggy and not what I ordered.",
      "category": "delivery",
      "date": "2024-06-14",
      "status": "pending",
      "follow_up_required": true,
      "restaurant_response": null,
      "response_date": null
    },
    {
      "id": "FB003",
      "customer_name": "Sarah Martinez",
      "customer_email": "sarah@example.com",
      "order_number": "ORD-2024-003",
      "rating": 4,
      "comment": "Great food quality but the packaging could be improved. Some sauce leaked in the bag.",
      "category": "packaging",
      "date": "2024-06-13",
      "status": "in_progress",
      "follow_up_required": true,
      "restaurant_response": "Thank you for the feedback. We're working on better packaging solutions.",
      "response_date": "2024-06-13"
    },
    {
      "id": "FB004",
      "customer_name": "David Brown",
      "customer_email": "david@example.com",
      "order_number": "ORD-2024-004",
      "rating": 1,
      "comment": "Worst experience ever. Food was burnt, delivery was 2 hours late, and customer service was rude.",
      "category": "service",
      "date": "2024-06-12",
      "status": "escalated",
      "follow_up_required": true,
      "restaurant_response": null,
      "response_date": null
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Feedback", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Escalated", "value": "escalated"},
    {"label": "Follow Up Required", "value": "follow_up"}
  ];

  List<Map<String, dynamic>> ratingFilterOptions = [
    {"label": "All Ratings", "value": "all"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"}
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Food Quality", "value": "food_quality"},
    {"label": "Delivery", "value": "delivery"},
    {"label": "Service", "value": "service"},
    {"label": "Packaging", "value": "packaging"},
    {"label": "Pricing", "value": "pricing"},
    {"label": "Other", "value": "other"}
  ];

  void _filterFeedback() {
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredFeedbacks {
    return feedbacks.where((feedback) {
      bool matchesSearch = feedback["customer_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          feedback["customer_email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          feedback["order_number"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          feedback["comment"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "all" ||
                          feedback["status"] == selectedFilter ||
                          (selectedFilter == "follow_up" && feedback["follow_up_required"] == true);
      
      bool matchesRating = selectedRating == "all" ||
                          feedback["rating"].toString() == selectedRating;
      
      return matchesSearch && matchesFilter && matchesRating;
    }).toList();
  }

  void _respondToFeedback(Map<String, dynamic> feedback, String response) {
    feedback["restaurant_response"] = response;
    feedback["response_date"] = DateTime.now().toIso8601String().split('T')[0];
    feedback["status"] = "resolved";
    setState(() {});
    ss("Response sent to customer");
  }

  void _updateFeedbackStatus(Map<String, dynamic> feedback, String status) {
    feedback["status"] = status;
    setState(() {});
    ss("Feedback status updated");
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return successColor;
    if (rating == 3) return warningColor;
    return dangerColor;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "resolved": return successColor;
      case "in_progress": return infoColor;
      case "escalated": return dangerColor;
      case "pending": return warningColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Collection"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () => _showFeedbackAnalytics(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QTextField(
                    label: "Search feedback",
                    value: searchQuery,
                    hint: "Enter customer name, email, order number, or comment",
                    onChanged: (value) {
                      searchQuery = value;
                      _filterFeedback();
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
                          items: filterOptions,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            _filterFeedback();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Rating",
                          items: ratingFilterOptions,
                          value: selectedRating,
                          onChanged: (value, label) {
                            selectedRating = value;
                            _filterFeedback();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.star, color: successColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${(feedbacks.map((f) => f["rating"] as int).reduce((a, b) => a + b) / feedbacks.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
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
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.pending_actions, color: warningColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${feedbacks.where((f) => f["status"] == "pending").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
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
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: dangerColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.priority_high, color: dangerColor, size: 32),
                        SizedBox(height: spSm),
                        Text(
                          "${feedbacks.where((f) => f["follow_up_required"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Follow Up",
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
            SizedBox(height: spMd),

            // Feedback List
            Text(
              "Customer Feedback (${filteredFeedbacks.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...filteredFeedbacks.map((feedback) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getStatusColor(feedback["status"]),
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
                              "${feedback["customer_name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${feedback["customer_email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Order: ${feedback["order_number"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor(feedback["status"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${feedback["status"]}".replaceAll('_', ' ').toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Row(
                            children: List.generate(5, (index) => Icon(
                              index < (feedback["rating"] as int) ? Icons.star : Icons.star_border,
                              color: _getRatingColor(feedback["rating"]),
                              size: 20,
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${feedback["comment"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${feedback["category"]}".replaceAll('_', ' ').toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${DateTime.parse(feedback["date"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (feedback["follow_up_required"] == true)
                        Container(
                          margin: EdgeInsets.only(left: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "FOLLOW UP",
                            style: TextStyle(
                              fontSize: 10,
                              color: dangerColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  if (feedback["restaurant_response"] != null) ...[
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.reply, color: successColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "Restaurant Response",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${DateTime.parse(feedback["response_date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${feedback["restaurant_response"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: feedback["restaurant_response"] == null ? "Respond" : "Update Response",
                          size: bs.sm,
                          onPressed: () => _showResponseDialog(feedback),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.flag,
                        size: bs.sm,
                        onPressed: () => _showStatusDialog(feedback),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () => _showFeedbackActions(feedback),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _showResponseDialog(Map<String, dynamic> feedback) {
    String response = feedback["restaurant_response"] ?? "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Respond to Feedback"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${feedback["comment"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Your Response",
              value: response,
              hint: "Type your response to the customer...",
              onChanged: (value) {
                response = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Send Response",
            onPressed: () {
              Navigator.pop(context);
              _respondToFeedback(feedback, response);
            },
          ),
        ],
      ),
    );
  }

  void _showStatusDialog(Map<String, dynamic> feedback) {
    String selectedStatus = feedback["status"];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Status"),
        content: QDropdownField(
          label: "Status",
          items: [
            {"label": "Pending", "value": "pending"},
            {"label": "In Progress", "value": "in_progress"},
            {"label": "Resolved", "value": "resolved"},
            {"label": "Escalated", "value": "escalated"},
          ],
          value: selectedStatus,
          onChanged: (value, label) {
            selectedStatus = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update Status",
            onPressed: () {
              Navigator.pop(context);
              _updateFeedbackStatus(feedback, selectedStatus);
            },
          ),
        ],
      ),
    );
  }

  void _showFeedbackActions(Map<String, dynamic> feedback) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.email, color: primaryColor),
              title: Text("Email Customer"),
              onTap: () {
                Navigator.pop(context);
                ss("Email sent to ${feedback["customer_name"]}");
              },
            ),
            ListTile(
              leading: Icon(Icons.phone, color: successColor),
              title: Text("Call Customer"),
              onTap: () {
                Navigator.pop(context);
                ss("Calling ${feedback["customer_name"]}...");
              },
            ),
            ListTile(
              leading: Icon(Icons.discount, color: warningColor),
              title: Text("Offer Compensation"),
              onTap: () {
                Navigator.pop(context);
                _showCompensationDialog(feedback);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Feedback"),
              onTap: () {
                Navigator.pop(context);
                _deleteFeedback(feedback);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCompensationDialog(Map<String, dynamic> feedback) {
    String compensationType = "discount";
    String compensationValue = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Offer Compensation"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Compensation Type",
              items: [
                {"label": "Discount Coupon", "value": "discount"},
                {"label": "Free Item", "value": "free_item"},
                {"label": "Refund", "value": "refund"},
              ],
              value: compensationType,
              onChanged: (value, label) {
                compensationType = value;
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Value/Description",
              value: compensationValue,
              hint: "Enter amount or description",
              onChanged: (value) {
                compensationValue = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Send Compensation",
            onPressed: () {
              Navigator.pop(context);
              ss("Compensation offer sent to ${feedback["customer_name"]}");
            },
          ),
        ],
      ),
    );
  }

  void _deleteFeedback(Map<String, dynamic> feedback) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this feedback?");
    if (isConfirmed) {
      feedbacks.remove(feedback);
      setState(() {});
      ss("Feedback deleted successfully");
    }
  }

  void _showFeedbackAnalytics() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Feedback Analytics"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Text(
                      "Rating Distribution",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...List.generate(5, (index) {
                      int rating = 5 - index;
                      int count = feedbacks.where((f) => f["rating"] == rating).length;
                      double percentage = count / feedbacks.length * 100;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Text("$rating ⭐"),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: percentage / 100,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _getRatingColor(rating),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text("$count (${percentage.toStringAsFixed(1)}%)"),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
