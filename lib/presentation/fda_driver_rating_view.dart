import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDriverRatingView extends StatefulWidget {
  const FdaDriverRatingView({super.key});

  @override
  State<FdaDriverRatingView> createState() => _FdaDriverRatingViewState();
}

class _FdaDriverRatingViewState extends State<FdaDriverRatingView> {
  double overallRating = 0.0;
  double punctualityRating = 0.0;
  double courtesyRating = 0.0;
  double serviceRating = 0.0;
  String feedbackComment = "";
  bool anonymous = false;

  Map<String, dynamic> orderDetails = {
    "order_id": "#FD2024001",
    "restaurant": "Pizza Palace",
    "driver_name": "John Smith",
    "driver_photo": "https://picsum.photos/100/100?random=1&keyword=person",
    "delivery_time": "25 mins",
    "delivered_at": "Dec 15, 2024 at 7:32 PM",
  };

  List<String> quickFeedback = [
    "Great service!",
    "Very polite driver",
    "Fast delivery",
    "Followed instructions well",
    "Professional attitude",
    "Careful with food",
    "Friendly and helpful",
    "On time delivery",
  ];

  List<String> selectedQuickFeedback = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Your Driver"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Order Info
            Container(
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
                  Text(
                    "Order Delivered",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${orderDetails["order_id"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " from ${orderDetails["restaurant"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Delivered ${orderDetails["delivered_at"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Driver Profile
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      "${orderDetails["driver_photo"]}",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${orderDetails["driver_name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Delivery Partner",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Delivered in ${orderDetails["delivery_time"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Overall Rating
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
                    "Overall Rating",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "How was your delivery experience?",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: () {
                                overallRating = index + 1.0;
                                setState(() {});
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: spXs),
                                child: Icon(
                                  index < overallRating ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 40,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: spSm),
                        if (overallRating > 0)
                          Text(
                            _getRatingText(overallRating),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _getRatingColor(overallRating),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Detailed Ratings
            if (overallRating > 0)
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
                      "Rate Specific Aspects",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Punctuality
                    _buildRatingRow(
                      "Punctuality",
                      "On-time delivery",
                      Icons.access_time,
                      punctualityRating,
                      (rating) {
                        punctualityRating = rating;
                        setState(() {});
                      },
                    ),

                    // Courtesy
                    _buildRatingRow(
                      "Courtesy",
                      "Polite and respectful",
                      Icons.sentiment_satisfied,
                      courtesyRating,
                      (rating) {
                        courtesyRating = rating;
                        setState(() {});
                      },
                    ),

                    // Service Quality
                    _buildRatingRow(
                      "Service Quality",
                      "Following delivery instructions",
                      Icons.delivery_dining,
                      serviceRating,
                      (rating) {
                        serviceRating = rating;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

            // Quick Feedback Tags
            if (overallRating > 0)
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
                      "Quick Feedback",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Select what you liked (optional)",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: quickFeedback.map((feedback) {
                        bool isSelected = selectedQuickFeedback.contains(feedback);
                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              selectedQuickFeedback.remove(feedback);
                            } else {
                              selectedQuickFeedback.add(feedback);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(30) : Colors.grey.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : Colors.grey.withAlpha(60),
                              ),
                            ),
                            child: Text(
                              feedback,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

            // Written Feedback
            if (overallRating > 0)
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
                      "Additional Comments",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QMemoField(
                      label: "Share your experience (optional)",
                      value: feedbackComment,
                      hint: "Tell us more about your delivery experience...",
                      onChanged: (value) {
                        feedbackComment = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

            // Privacy Options
            if (overallRating > 0)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.privacy_tip,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Submit as anonymous",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Your name won't be shown to the driver",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: anonymous,
                      onChanged: (value) {
                        anonymous = value;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QButton(
              label: overallRating > 0 ? "Submit Rating" : "Skip Rating",
              onPressed: () {
                if (overallRating > 0) {
                  ss("Thank you for rating ${orderDetails["driver_name"]}!");
                } else {
                  si("Rating skipped");
                }
                back();
              },
            ),
            if (overallRating == 0)
              Text(
                "You can rate this driver later from your order history",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(String title, String subtitle, IconData icon, double currentRating, Function(double) onRatingChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
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
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                onRatingChanged(index + 1.0);
              },
              child: Padding(
                padding: EdgeInsets.only(right: spXs),
                child: Icon(
                  index < currentRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  String _getRatingText(double rating) {
    if (rating <= 1) return "Poor";
    if (rating <= 2) return "Fair";
    if (rating <= 3) return "Good";
    if (rating <= 4) return "Very Good";
    return "Excellent";
  }

  Color _getRatingColor(double rating) {
    if (rating <= 2) return dangerColor;
    if (rating <= 3) return warningColor;
    if (rating <= 4) return infoColor;
    return successColor;
  }
}
