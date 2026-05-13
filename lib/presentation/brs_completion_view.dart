import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsCompletionView extends StatefulWidget {
  const BrsCompletionView({super.key});

  @override
  State<BrsCompletionView> createState() => _BrsCompletionViewState();
}

class _BrsCompletionViewState extends State<BrsCompletionView> {
  Map<String, dynamic> serviceData = {
    "booking_id": "BK001",
    "barber_name": "John Smith",
    "service": "Premium Haircut + Beard Trim",
    "start_time": "10:30 AM",
    "end_time": "11:15 AM",
    "total_duration": 45,
    "price": 35.0,
    "barber_image": "https://picsum.photos/80/80?random=1&keyword=barber",
    "before_photo": "https://picsum.photos/150/150?random=10&keyword=hair",
    "after_photo": "https://picsum.photos/150/150?random=11&keyword=hairstyle",
  };

  int rating = 0;
  String reviewText = "";
  double tipAmount = 0.0;
  bool showPhotoComparison = true;

  List<double> tipSuggestions = [5.0, 8.0, 10.0, 15.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Complete"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Completion Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 60,
                  ),
                  Text(
                    "Service Completed!",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Your appointment has been successfully completed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Service Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Service Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${serviceData["barber_image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${serviceData["barber_name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${serviceData["service"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${serviceData["start_time"]} - ${serviceData["end_time"]}",
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
                          Text(
                            "\$${(serviceData["price"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${serviceData["total_duration"]} minutes",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Before & After Photos
            if (showPhotoComparison) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Before & After",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${serviceData["before_photo"]}",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Before",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${serviceData["after_photo"]}",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "After",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Rating & Review
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rate Your Experience",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          rating = index + 1;
                          setState(() {});
                        },
                        child: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 40,
                        ),
                      );
                    }),
                  ),
                  QTextField(
                    label: "Share your experience",
                    value: reviewText,
                    hint: "Tell us about your experience...",
                    onChanged: (value) {
                      reviewText = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Tip Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Tip (Optional)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Show your appreciation for excellent service",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: tipSuggestions.map((amount) {
                      final isSelected = tipAmount == amount;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            tipAmount = amount;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: spXs),
                            padding: EdgeInsets.symmetric(vertical: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              "\$${amount.toStringAsFixed(0)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  QNumberField(
                    label: "Custom Tip Amount",
                    value: tipAmount == 0 || tipSuggestions.contains(tipAmount) 
                      ? "" 
                      : tipAmount.toString(),
                    onChanged: (value) {
                      tipAmount = double.tryParse(value) ?? 0.0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QButton(
                    label: "Submit Review & Complete",
                    size: bs.md,
                    onPressed: () async {
                      if (rating == 0) {
                        se("Please rate your experience");
                        return;
                      }
                      
                      // Submit review logic
                      ss("Thank you for your feedback!");
                      
                      // Navigate to home or booking history
                      await Future.delayed(Duration(seconds: 1));
                      back();
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Share Photos",
                          size: bs.sm,
                          onPressed: () {
                            // Share photos action
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Book Again",
                          size: bs.sm,
                          onPressed: () {
                            // Book again action
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Post-Service Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Post-Service Care Tips",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Avoid washing hair for 24 hours to let the style set",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "• Use recommended hair products for best results",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "• Schedule your next appointment in 4-6 weeks",
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
      ),
    );
  }
}
