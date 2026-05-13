import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaCustomerRatingView extends StatefulWidget {
  const DlaCustomerRatingView({super.key});

  @override
  State<DlaCustomerRatingView> createState() => _DlaCustomerRatingViewState();
}

class _DlaCustomerRatingViewState extends State<DlaCustomerRatingView> {
  final formKey = GlobalKey<FormState>();
  double overallRating = 0.0;
  double deliverySpeedRating = 0.0;
  double driverCourtesyRating = 0.0;
  double packageHandlingRating = 0.0;
  double communicationRating = 0.0;
  String reviewText = "";
  List<String> selectedTags = [];
  bool anonymousReview = false;

  List<Map<String, dynamic>> ratingTags = [
    {"label": "Fast Delivery", "value": "fast", "icon": Icons.speed},
    {"label": "Friendly Driver", "value": "friendly", "icon": Icons.sentiment_satisfied},
    {"label": "Professional", "value": "professional", "icon": Icons.business_center},
    {"label": "Careful Handling", "value": "careful", "icon": Icons.handyman},
    {"label": "Good Communication", "value": "communication", "icon": Icons.chat},
    {"label": "On Time", "value": "punctual", "icon": Icons.schedule},
    {"label": "Package Secure", "value": "secure", "icon": Icons.security},
    {"label": "Polite", "value": "polite", "icon": Icons.thumb_up},
  ];

  Map<String, dynamic> deliveryDetails = {
    "order_id": "DL12345",
    "date": "2024-01-15",
    "time": "14:30",
    "driver": {
      "name": "Mike Johnson",
      "photo": "https://picsum.photos/100/100?random=1&keyword=person",
      "rating": 4.8,
      "total_deliveries": 1250
    },
    "package": {
      "type": "Electronics",
      "weight": "2.5 kg",
      "description": "Smartphone Package"
    },
    "delivery_address": "123 Main Street, Downtown",
    "delivery_time": "On Time",
    "status": "Delivered Successfully"
  };

  Widget _buildRatingCard(String title, String subtitle, double rating, Function(double) onRatingChanged, IconData icon) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
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
                    if (subtitle.isNotEmpty) ...[
                      SizedBox(height: spXs),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(
                rating > 0 ? "${rating.toStringAsFixed(1)}" : "Rate",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: rating > 0 ? warningColor : disabledColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => onRatingChanged((index + 1).toDouble()),
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  child: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating ? warningColor : disabledColor,
                    size: 32,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(Map<String, dynamic> tag) {
    final isSelected = selectedTags.contains(tag["value"]);
    
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          selectedTags.remove(tag["value"]);
        } else {
          selectedTags.add(tag["value"]);
        }
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm, bottom: spSm),
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
          boxShadow: isSelected ? [shadowSm] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              tag["icon"],
              size: 16,
              color: isSelected ? Colors.white : primaryColor,
            ),
            SizedBox(width: spXs),
            Text(
              "${tag["label"]}",
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double get averageRating {
    final ratings = [overallRating, deliverySpeedRating, driverCourtesyRating, packageHandlingRating, communicationRating];
    final validRatings = ratings.where((rating) => rating > 0).toList();
    if (validRatings.isEmpty) return 0.0;
    return validRatings.reduce((a, b) => a + b) / validRatings.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Your Delivery"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delivery Completed",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Order #${deliveryDetails["order_id"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${deliveryDetails["date"]} at ${deliveryDetails["time"]}",
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
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("${deliveryDetails["driver"]["photo"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${deliveryDetails["driver"]["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(deliveryDetails["driver"]["rating"] as double).toStringAsFixed(1)} • ${deliveryDetails["driver"]["total_deliveries"]} deliveries",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
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
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.inventory,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Package: ${deliveryDetails["package"]["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${deliveryDetails["delivery_address"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              if (averageRating > 0) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor.withAlpha(30)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Average Rating",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${averageRating.toStringAsFixed(1)} / 5.0",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spLg),
              ],
              
              Text(
                "Rate Different Aspects",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(height: spSm),
              
              _buildRatingCard(
                "Overall Experience",
                "How was your overall delivery experience?",
                overallRating,
                (rating) {
                  overallRating = rating;
                  setState(() {});
                },
                Icons.thumb_up
              ),
              
              _buildRatingCard(
                "Delivery Speed",
                "Was the package delivered on time?",
                deliverySpeedRating,
                (rating) {
                  deliverySpeedRating = rating;
                  setState(() {});
                },
                Icons.speed
              ),
              
              _buildRatingCard(
                "Driver Courtesy",
                "How courteous and professional was the driver?",
                driverCourtesyRating,
                (rating) {
                  driverCourtesyRating = rating;
                  setState(() {});
                },
                Icons.sentiment_satisfied
              ),
              
              _buildRatingCard(
                "Package Handling",
                "Was your package handled with care?",
                packageHandlingRating,
                (rating) {
                  packageHandlingRating = rating;
                  setState(() {});
                },
                Icons.handyman
              ),
              
              _buildRatingCard(
                "Communication",
                "How was the communication during delivery?",
                communicationRating,
                (rating) {
                  communicationRating = rating;
                  setState(() {});
                },
                Icons.chat
              ),
              
              SizedBox(height: spLg),
              
              Text(
                "What Went Well?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: spSm),
              
              Wrap(
                children: ratingTags.map((tag) => _buildTagChip(tag)).toList(),
              ),
              
              SizedBox(height: spLg),
              
              QMemoField(
                label: "Write a Review (Optional)",
                value: reviewText,
                hint: "Share your experience with other customers...",
                onChanged: (value) {
                  reviewText = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                label: "Post anonymously",
                items: [
                  {
                    "label": "Hide my name in this review",
                    "value": true,
                    "checked": anonymousReview,
                  }
                ],
                value: [
                  if (anonymousReview)
                    {
                      "label": "Hide my name in this review",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  anonymousReview = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spLg),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Rating",
                  onPressed: () {
                    if (overallRating > 0) {
                      ss("Thank you for your feedback!");
                      back();
                    } else {
                      se("Please provide at least an overall rating");
                    }
                  },
                ),
              ),
              
              SizedBox(height: spSm),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Skip for Now",
                  color: disabledBoldColor,
                  onPressed: () {
                    back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
