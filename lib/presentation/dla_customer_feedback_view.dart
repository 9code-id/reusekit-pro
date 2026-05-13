import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaCustomerFeedbackView extends StatefulWidget {
  const DlaCustomerFeedbackView({super.key});

  @override
  State<DlaCustomerFeedbackView> createState() => _DlaCustomerFeedbackViewState();
}

class _DlaCustomerFeedbackViewState extends State<DlaCustomerFeedbackView> {
  final formKey = GlobalKey<FormState>();
  String selectedCategory = "delivery";
  double overallRating = 4.0;
  double deliveryTimeRating = 4.0;
  double driverRating = 5.0;
  double packageConditionRating = 4.0;
  String feedbackText = "";
  String improvementSuggestion = "";
  bool recommendService = true;
  List<String> attachments = [];

  List<Map<String, dynamic>> feedbackCategories = [
    {"label": "Delivery Experience", "value": "delivery"},
    {"label": "Driver Service", "value": "driver"},
    {"label": "Package Condition", "value": "package"},
    {"label": "App Experience", "value": "app"},
    {"label": "Customer Support", "value": "support"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> recentDeliveries = [
    {
      "id": "DL001",
      "date": "2024-01-15",
      "driver": "Mike Johnson",
      "package": "Electronics Package",
      "status": "Delivered",
      "rating": 5.0,
      "feedback_given": true
    },
    {
      "id": "DL002",
      "date": "2024-01-12",
      "driver": "Sarah Wilson",
      "package": "Clothing Items",
      "status": "Delivered",
      "rating": 4.0,
      "feedback_given": false
    },
    {
      "id": "DL003",
      "date": "2024-01-10",
      "driver": "John Smith",
      "package": "Books Package",
      "status": "Delivered",
      "rating": 0.0,
      "feedback_given": false
    },
  ];

  Widget _buildRatingSection(String title, double rating, Function(double) onRatingChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () => onRatingChanged((index + 1).toDouble()),
                      child: Container(
                        margin: EdgeInsets.only(right: spXs),
                        child: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: index < rating ? warningColor : disabledColor,
                          size: 28,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Text(
                "${rating.toStringAsFixed(1)}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
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
                      "Order #${delivery["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${delivery["package"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${delivery["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: primaryColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Driver: ${delivery["driver"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${delivery["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              if ((delivery["rating"] as double) > 0) ...[
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < (delivery["rating"] as double) ? Icons.star : Icons.star_border,
                      color: index < (delivery["rating"] as double) ? warningColor : disabledColor,
                      size: 16,
                    );
                  }),
                ),
                SizedBox(width: spSm),
                Text(
                  "${(delivery["rating"] as double).toStringAsFixed(1)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ] else ...[
                Text(
                  "No rating given",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledColor,
                  ),
                ),
              ],
              
              Spacer(),
              
              if (!(delivery["feedback_given"] as bool)) ...[
                QButton(
                  label: "Give Feedback",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ] else ...[
                Text(
                  "Feedback Given",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Feedback"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Share Your Experience",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Text(
                "Your feedback helps us improve our delivery service",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
              
              SizedBox(height: spLg),
              
              Text(
                "Feedback Category",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Select Category",
                items: feedbackCategories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spLg),
              
              Text(
                "Rate Your Experience",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              _buildRatingSection("Overall Experience", overallRating, (rating) {
                overallRating = rating;
                setState(() {});
              }),
              
              SizedBox(height: spSm),
              
              _buildRatingSection("Delivery Time", deliveryTimeRating, (rating) {
                deliveryTimeRating = rating;
                setState(() {});
              }),
              
              SizedBox(height: spSm),
              
              _buildRatingSection("Driver Service", driverRating, (rating) {
                driverRating = rating;
                setState(() {});
              }),
              
              SizedBox(height: spSm),
              
              _buildRatingSection("Package Condition", packageConditionRating, (rating) {
                packageConditionRating = rating;
                setState(() {});
              }),
              
              SizedBox(height: spLg),
              
              QMemoField(
                label: "Your Feedback",
                value: feedbackText,
                hint: "Tell us about your delivery experience...",
                validator: Validator.required,
                onChanged: (value) {
                  feedbackText = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Suggestions for Improvement",
                value: improvementSuggestion,
                hint: "How can we improve our service?",
                onChanged: (value) {
                  improvementSuggestion = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QMultiImagePicker(
                label: "Attach Photos (Optional)",
                value: attachments,
                maxImages: 5,
                hint: "Add photos to support your feedback",
                onChanged: (value) {
                  attachments = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                label: "Would you recommend our service?",
                items: [
                  {
                    "label": "Yes, I would recommend",
                    "value": true,
                    "checked": recommendService,
                  }
                ],
                value: [
                  if (recommendService)
                    {
                      "label": "Yes, I would recommend",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  recommendService = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spLg),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Feedback",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Feedback submitted successfully!");
                    }
                  },
                ),
              ),
              
              SizedBox(height: spLg),
              
              Text(
                "Recent Deliveries",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: spSm),
              
              ...recentDeliveries.map((delivery) => _buildDeliveryCard(delivery)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
