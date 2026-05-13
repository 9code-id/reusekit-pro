import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaCustomerFeedbackView extends StatefulWidget {
  const LtaCustomerFeedbackView({super.key});

  @override
  State<LtaCustomerFeedbackView> createState() => _LtaCustomerFeedbackViewState();
}

class _LtaCustomerFeedbackViewState extends State<LtaCustomerFeedbackView> {
  String searchQuery = "";
  String selectedRating = "All";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> ratingOptions = [
    {"label": "All", "value": "All"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "New", "value": "New"},
    {"label": "Reviewed", "value": "Reviewed"},
    {"label": "Responded", "value": "Responded"},
    {"label": "Resolved", "value": "Resolved"}
  ];

  List<Map<String, dynamic>> feedbacks = [
    {
      "feedbackId": "FB001",
      "orderId": "ORD001",
      "customerName": "Ahmad Wijaya",
      "customerEmail": "ahmad.wijaya@email.com",
      "customerPhone": "+62 812-3456-7890",
      "driverName": "Budi Santoso",
      "vehicleNumber": "B 1234 XYZ",
      "serviceDate": "2024-12-15",
      "rating": 5,
      "title": "Excellent Service!",
      "comment": "Driver was very professional and courteous. Delivery was on time and package was handled with care. Highly recommend!",
      "feedbackDate": "2024-12-15 18:30",
      "status": "Responded",
      "adminResponse": "Thank you for your positive feedback! We're glad to hear about your excellent experience with our service.",
      "responseDate": "2024-12-15 20:15",
      "category": "Service Quality",
      "images": [
        "https://picsum.photos/300/200?random=1&keyword=delivery",
        "https://picsum.photos/300/200?random=2&keyword=package"
      ]
    },
    {
      "feedbackId": "FB002",
      "orderId": "ORD002",
      "customerName": "Siti Nurhaliza",
      "customerEmail": "siti.nurhaliza@company.com",
      "customerPhone": "+62 813-9876-5432",
      "driverName": "Eko Prasetyo",
      "vehicleNumber": "B 5678 ABC",
      "serviceDate": "2024-12-14",
      "rating": 2,
      "title": "Poor Communication",
      "comment": "Driver arrived 2 hours late without prior notice. When contacted, customer service was not helpful. Package was delivered but customer experience was disappointing.",
      "feedbackDate": "2024-12-14 16:45",
      "status": "Reviewed",
      "adminResponse": null,
      "responseDate": null,
      "category": "Communication",
      "images": []
    },
    {
      "feedbackId": "FB003",
      "orderId": "ORD003",
      "customerName": "Muhammad Rizki",
      "customerEmail": "m.rizki@business.co.id",
      "customerPhone": "+62 814-1111-2222",
      "driverName": "Sari Wulandari",
      "vehicleNumber": "B 9012 DEF",
      "serviceDate": "2024-12-13",
      "rating": 4,
      "title": "Good Service, Minor Issues",
      "comment": "Overall good experience. Driver was friendly and delivery was careful. Only issue was slight delay due to traffic, but driver kept us informed throughout the journey.",
      "feedbackDate": "2024-12-13 14:20",
      "status": "Resolved",
      "adminResponse": "Thank you for your feedback. We're working on improving our route planning to minimize traffic delays.",
      "responseDate": "2024-12-13 16:00",
      "category": "Delivery Time",
      "images": [
        "https://picsum.photos/300/200?random=3&keyword=truck"
      ]
    },
    {
      "feedbackId": "FB004",
      "orderId": "ORD004",
      "customerName": "Diana Putri",
      "customerEmail": "diana.putri@logistics.com",
      "customerPhone": "+62 815-3333-4444",
      "driverName": "Agus Wijaya",
      "vehicleNumber": "B 3456 GHI",
      "serviceDate": "2024-12-12",
      "rating": 3,
      "title": "Average Experience",
      "comment": "Service was okay, nothing special. Delivery completed as expected but driver seemed inexperienced with the route.",
      "feedbackDate": "2024-12-12 11:30",
      "status": "New",
      "adminResponse": null,
      "responseDate": null,
      "category": "Driver Performance",
      "images": []
    },
    {
      "feedbackId": "FB005",
      "orderId": "ORD005",
      "customerName": "Bambang Sutrisno",
      "customerEmail": "bambang@transport.id",
      "customerPhone": "+62 816-5555-6666",
      "driverName": "Indra Kusuma",
      "vehicleNumber": "B 7890 JKL",
      "serviceDate": "2024-12-11",
      "rating": 5,
      "title": "Outstanding Performance!",
      "comment": "Exceptional service from start to finish. Professional driver, timely delivery, and excellent communication throughout. Will definitely use this service again!",
      "feedbackDate": "2024-12-11 17:45",
      "status": "Responded",
      "adminResponse": "We appreciate your wonderful feedback! Your satisfaction is our top priority.",
      "responseDate": "2024-12-11 19:20",
      "category": "Overall Experience",
      "images": [
        "https://picsum.photos/300/200?random=4&keyword=service",
        "https://picsum.photos/300/200?random=5&keyword=professional"
      ]
    },
    {
      "feedbackId": "FB006",
      "orderId": "ORD006",
      "customerName": "Lestari Indah",
      "customerEmail": "lestari@shop.com",
      "customerPhone": "+62 817-7777-8888",
      "driverName": "Yoga Pratama",
      "vehicleNumber": "B 2468 MNO",
      "serviceDate": "2024-12-10",
      "rating": 1,
      "title": "Terrible Experience",
      "comment": "Package was damaged during transport. Driver was rude and unprofessional. Customer service was unhelpful when we complained. Very disappointed with the service.",
      "feedbackDate": "2024-12-10 20:15",
      "status": "New",
      "adminResponse": null,
      "responseDate": null,
      "category": "Package Handling",
      "images": [
        "https://picsum.photos/300/200?random=6&keyword=damage"
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredFeedbacks {
    return feedbacks.where((feedback) {
      bool matchesSearch = searchQuery.isEmpty || 
          (feedback["feedbackId"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (feedback["customerName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (feedback["orderId"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesRating = selectedRating == "All" || feedback["rating"].toString() == selectedRating;
      bool matchesStatus = selectedStatus == "All" || feedback["status"] == selectedStatus;
      
      return matchesSearch && matchesRating && matchesStatus;
    }).toList();
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return successColor;
    if (rating == 3) return warningColor;
    return dangerColor;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "New":
        return warningColor;
      case "Reviewed":
        return infoColor;
      case "Responded":
        return primaryColor;
      case "Resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : disabledBoldColor,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Feedback"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to feedback analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search feedback...",
                    value: searchQuery,
                    hint: "Search by ID, customer, or order",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Rating",
                    items: ratingOptions,
                    value: selectedRating,
                    onChanged: (value, label) {
                      selectedRating = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
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
              ],
            ),

            // Feedback Statistics
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "${(feedbacks.map((f) => f["rating"] as int).reduce((a, b) => a + b) / feedbacks.length).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Average Rating",
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
                        Icon(Icons.feedback, color: infoColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${feedbacks.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
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
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.pending_actions, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${feedbacks.where((f) => f["status"] == "New" || f["status"] == "Reviewed").length}",
                          style: TextStyle(
                            fontSize: fsH5,
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
              ],
            ),

            // Feedback List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "Customer Feedback",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredFeedbacks.length} feedback",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredFeedbacks.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final feedback = filteredFeedbacks[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getRatingColor(feedback["rating"] as int).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${feedback["rating"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _getRatingColor(feedback["rating"] as int),
                                      ),
                                    ),
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
                                            "${feedback["title"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(feedback["status"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${feedback["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getStatusColor(feedback["status"] as String),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          _buildStars(feedback["rating"] as int),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${feedback["customerName"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${feedback["comment"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      height: 1.4,
                                    ),
                                  ),
                                  if ((feedback["images"] as List).isNotEmpty) ...[
                                    SizedBox(height: spSm),
                                    QHorizontalScroll(
                                      children: (feedback["images"] as List).map((imageUrl) {
                                        return Container(
                                          width: 80,
                                          height: 60,
                                          margin: EdgeInsets.only(right: spXs),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radiusSm),
                                            image: DecorationImage(
                                              image: NetworkImage(imageUrl as String),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Text(
                                        "Order: ${feedback["orderId"]} • Driver: ${feedback["driverName"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 2),
                                      Text(
                                        "${feedback["feedbackDate"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (feedback["adminResponse"] != null) ...[
                              SizedBox(height: spSm),
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: primaryColor.withAlpha(30)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.support_agent, size: 14, color: primaryColor),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Admin Response",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${feedback["adminResponse"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Responded on ${feedback["responseDate"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "${feedback["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                if (feedback["status"] == "New" || feedback["status"] == "Reviewed") ...[
                                  QButton(
                                    label: "Respond",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to respond to feedback
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                ],
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to feedback details
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
          ],
        ),
      ),
    );
  }
}
