import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsRatingFeedbackView extends StatefulWidget {
  const BrsRatingFeedbackView({super.key});

  @override
  State<BrsRatingFeedbackView> createState() => _BrsRatingFeedbackViewState();
}

class _BrsRatingFeedbackViewState extends State<BrsRatingFeedbackView> {
  double overallRating = 0.0;
  double serviceQualityRating = 0.0;
  double cleanlinessRating = 0.0;
  double staffBehaviorRating = 0.0;
  double valueForMoneyRating = 0.0;
  double ambientRating = 0.0;
  
  String feedbackText = "";
  bool wouldRecommend = false;
  bool isAnonymous = false;
  
  List<String> selectedTags = [];
  List<String> availableTags = [
    "Excellent Service",
    "Professional Staff",
    "Clean Environment",
    "Great Value",
    "Friendly Atmosphere",
    "Quick Service",
    "Skilled Barbers",
    "Modern Equipment",
    "Comfortable Seating",
    "Good Location",
    "Easy Booking",
    "Punctual",
  ];

  Map<String, dynamic> bookingDetails = {
    "id": "BRS2024001",
    "barber": "Marcus Thompson",
    "service": "Premium Haircut + Beard Trim",
    "date": "2024-03-15",
    "time": "14:30",
    "amount": 45.0,
    "barbershop": "Elite Cuts Barbershop",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate & Review"),
        actions: [
          if (feedbackText.isNotEmpty || overallRating > 0)
            TextButton(
              onPressed: () {
                // Save as draft
                ss("Feedback saved as draft");
              },
              child: Text(
                "Save Draft",
                style: TextStyle(color: primaryColor),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Details Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Booking #${bookingDetails["id"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          image: DecorationImage(
                            image: NetworkImage("https://picsum.photos/100/100?random=1&keyword=barber"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${bookingDetails["barber"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${bookingDetails["barbershop"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.cut, size: 16, color: disabledBoldColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${bookingDetails["service"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Text(
                              "\$${(bookingDetails["amount"] as double).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                            SizedBox(width: spSm),
                            Text(
                              "${bookingDetails["date"]} at ${bookingDetails["time"]}",
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
            ),

            SizedBox(height: spLg),

            // Overall Rating
            Text(
              "Overall Rating",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "How was your experience?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          overallRating = (index + 1).toDouble();
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: spXs),
                          child: Icon(
                            Icons.star,
                            size: 40,
                            color: index < overallRating ? warningColor : disabledColor,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: spSm),
                  if (overallRating > 0)
                    Text(
                      "${overallRating.toInt()} out of 5 stars",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Detailed Ratings
            Text(
              "Rate Specific Aspects",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  _buildRatingRow("Service Quality", serviceQualityRating, (rating) {
                    serviceQualityRating = rating;
                    setState(() {});
                  }),
                  _buildRatingRow("Cleanliness", cleanlinessRating, (rating) {
                    cleanlinessRating = rating;
                    setState(() {});
                  }),
                  _buildRatingRow("Staff Behavior", staffBehaviorRating, (rating) {
                    staffBehaviorRating = rating;
                    setState(() {});
                  }),
                  _buildRatingRow("Value for Money", valueForMoneyRating, (rating) {
                    valueForMoneyRating = rating;
                    setState(() {});
                  }),
                  _buildRatingRow("Ambience", ambientRating, (rating) {
                    ambientRating = rating;
                    setState(() {});
                  }),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Quick Tags
            Text(
              "What did you like? (Optional)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: availableTags.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedTags.remove(tag);
                    } else {
                      selectedTags.add(tag);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
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
                        if (isSelected) ...[
                          Icon(Icons.check, size: 16, color: Colors.white),
                          SizedBox(width: spXs),
                        ],
                        Text(
                          tag,
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Written Feedback
            Text(
              "Share Your Experience",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Write your review (Optional)",
              value: feedbackText,
              hint: "Tell others about your experience...",
              onChanged: (value) {
                feedbackText = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Additional Options
            Text(
              "Additional Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Would you recommend us to friends?",
                              "value": true,
                              "checked": wouldRecommend,
                            }
                          ],
                          value: wouldRecommend ? [{"label": "Would you recommend us to friends?", "value": true, "checked": true}] : [],
                          onChanged: (values, ids) {
                            wouldRecommend = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Submit feedback anonymously",
                              "value": true,
                              "checked": isAnonymous,
                            }
                          ],
                          value: isAnonymous ? [{"label": "Submit feedback anonymously", "value": true, "checked": true}] : [],
                          onChanged: (values, ids) {
                            isAnonymous = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Photo Upload
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.camera_alt, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Add Photos (Optional)",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Share photos of your haircut or the barbershop experience",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Take Photo",
                          icon: Icons.camera,
                          size: bs.sm,
                          onPressed: () {
                            // Open camera
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Choose from Gallery",
                          icon: Icons.photo_library,
                          size: bs.sm,
                          onPressed: () {
                            // Open gallery
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Submit Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Submit Review",
                    size: bs.md,
                    onPressed: overallRating > 0 ? () {
                      _submitReview();
                    } : null,
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.close,
                  size: bs.md,
                  onPressed: () {
                    back();
                  },
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Review Policy
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "Your review will help other customers make informed decisions. Reviews are subject to our community guidelines and may be moderated.",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(String title, double rating, Function(double) onRatingChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    onRatingChanged((index + 1).toDouble());
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(
                      Icons.star,
                      size: 24,
                      color: index < rating ? warningColor : disabledColor,
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(width: spSm),
          Container(
            width: 30,
            child: Text(
              rating > 0 ? "${rating.toInt()}" : "",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _submitReview() {
    if (overallRating == 0) {
      se("Please provide an overall rating");
      return;
    }

    // Simulate review submission
    ss("Thank you for your feedback!");
    
    // Navigate back or to confirmation screen
    back();
  }
}
