import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDeliveryFeedbackView extends StatefulWidget {
  const FdaDeliveryFeedbackView({super.key});

  @override
  State<FdaDeliveryFeedbackView> createState() => _FdaDeliveryFeedbackViewState();
}

class _FdaDeliveryFeedbackViewState extends State<FdaDeliveryFeedbackView> {
  int deliveryRating = 5;
  int foodQualityRating = 5;
  int driverRating = 5;
  String feedbackComment = "";
  bool recommendToFriends = true;
  List<String> selectedIssues = [];
  
  List<Map<String, dynamic>> issueOptions = [
    {"label": "Food was cold", "value": "cold_food"},
    {"label": "Late delivery", "value": "late_delivery"},
    {"label": "Wrong order", "value": "wrong_order"},
    {"label": "Missing items", "value": "missing_items"},
    {"label": "Poor packaging", "value": "poor_packaging"},
    {"label": "Driver behavior", "value": "driver_behavior"},
    {"label": "App issues", "value": "app_issues"},
    {"label": "Other", "value": "other"},
  ];

  Map<String, dynamic> orderData = {
    "orderId": "#FD2024001",
    "restaurant": "Burger Palace",
    "deliveryTime": "45 mins",
    "totalAmount": 35.50,
    "deliveredAt": "2024-01-15 19:30",
    "driverName": "John Smith",
    "driverPhoto": "https://picsum.photos/100/100?random=101",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Feedback"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildOrderSummary(),
            _buildDeliveryRating(),
            _buildFoodQualityRating(),
            _buildDriverRating(),
            _buildIssuesSection(),
            _buildFeedbackComment(),
            _buildRecommendationSection(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
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
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.receipt, color: disabledBoldColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Order ${orderData["orderId"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.restaurant, color: disabledBoldColor, size: 20),
              SizedBox(width: spXs),
              Text("${orderData["restaurant"]}"),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, color: disabledBoldColor, size: 20),
              SizedBox(width: spXs),
              Text("Delivered in ${orderData["deliveryTime"]}"),
            ],
          ),
          Row(
            children: [
              Icon(Icons.attach_money, color: disabledBoldColor, size: 20),
              SizedBox(width: spXs),
              Text("\$${(orderData["totalAmount"] as double).toStringAsFixed(2)}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryRating() {
    return Container(
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
          Text(
            "Delivery Experience",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "How was your delivery experience?",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  deliveryRating = index + 1;
                  setState(() {});
                },
                child: Icon(
                  index < deliveryRating ? Icons.star : Icons.star_border,
                  color: index < deliveryRating ? warningColor : disabledColor,
                  size: 40,
                ),
              );
            }),
          ),
          Center(
            child: Text(
              _getRatingText(deliveryRating),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodQualityRating() {
    return Container(
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
          Text(
            "Food Quality",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "How was the quality of your food?",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  foodQualityRating = index + 1;
                  setState(() {});
                },
                child: Icon(
                  index < foodQualityRating ? Icons.star : Icons.star_border,
                  color: index < foodQualityRating ? warningColor : disabledColor,
                  size: 40,
                ),
              );
            }),
          ),
          Center(
            child: Text(
              _getRatingText(foodQualityRating),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverRating() {
    return Container(
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
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${orderData["driverPhoto"]}"),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rate ${orderData["driverName"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Your delivery driver",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  driverRating = index + 1;
                  setState(() {});
                },
                child: Icon(
                  index < driverRating ? Icons.star : Icons.star_border,
                  color: index < driverRating ? warningColor : disabledColor,
                  size: 40,
                ),
              );
            }),
          ),
          Center(
            child: Text(
              _getRatingText(driverRating),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuesSection() {
    return Container(
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
          Text(
            "Any Issues?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Select any issues you experienced (optional)",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          ...List.generate(issueOptions.length, (index) {
            final issue = issueOptions[index];
            final isSelected = selectedIssues.contains(issue["value"]);
            
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  selectedIssues.remove(issue["value"]);
                } else {
                  selectedIssues.add(issue["value"]);
                }
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: isSelected ? primaryColor : disabledColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${issue["label"]}",
                      style: TextStyle(
                        color: isSelected ? primaryColor : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFeedbackComment() {
    return Container(
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
          Text(
            "Additional Comments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QMemoField(
            label: "Share your feedback",
            value: feedbackComment,
            hint: "Tell us more about your experience...",
            onChanged: (value) {
              feedbackComment = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationSection() {
    return Container(
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
          Text(
            "Recommendation",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Would you recommend this restaurant to friends?",
                "value": true,
                "checked": recommendToFriends,
              }
            ],
            value: [
              if (recommendToFriends)
                {
                  "label": "Would you recommend this restaurant to friends?",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              recommendToFriends = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Submit Feedback",
            size: bs.md,
            onPressed: () async {
              showLoading();
              
              // Simulate API call
              await Future.delayed(Duration(seconds: 2));
              
              hideLoading();
              ss("Thank you for your feedback!");
              back();
            },
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Skip for Now",
            size: bs.md,
            color: disabledBoldColor,
            onPressed: () {
              back();
            },
          ),
        ),
      ],
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1: return "Poor";
      case 2: return "Fair";
      case 3: return "Good";
      case 4: return "Very Good";
      case 5: return "Excellent";
      default: return "Good";
    }
  }
}
