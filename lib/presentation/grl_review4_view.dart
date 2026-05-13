import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReview4View extends StatefulWidget {
  @override
  State<GrlReview4View> createState() => _GrlReview4ViewState();
}

class _GrlReview4ViewState extends State<GrlReview4View> {
  Map<String, int> criteriaRatings = {
    "Food Quality": 0,
    "Service": 0,
    "Atmosphere": 0,
    "Value for Money": 0,
    "Cleanliness": 0,
  };
  
  String reviewTitle = "";
  String reviewContent = "";
  List<String> selectedPhotos = [];
  bool wouldRecommend = false;
  String visitType = "dine_in";
  String priceRange = "";
  
  List<Map<String, dynamic>> menuHighlights = [
    {"name": "Grilled Salmon", "liked": false},
    {"name": "Caesar Salad", "liked": false},
    {"name": "Ribeye Steak", "liked": false},
    {"name": "Chocolate Dessert", "liked": false},
    {"name": "House Wine", "liked": false},
    {"name": "Garlic Bread", "liked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Restaurant"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "https://picsum.photos/100/100?random=1&keyword=restaurant",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bella Vista Restaurant",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Italian Cuisine • \$\$\$",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "123 Gourmet Street, Downtown",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) => Icon(
                                index < 4 ? Icons.star : Icons.star_border,
                                size: 14,
                                color: warningColor,
                              )),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "4.2 (248 reviews)",
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
            
            SizedBox(height: spMd),
            
            // Visit Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Visit Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Visit Type",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: QDropdownField(
                          label: "Select type",
                          items: [
                            {"label": "Dine In", "value": "dine_in"},
                            {"label": "Takeout", "value": "takeout"},
                            {"label": "Delivery", "value": "delivery"},
                          ],
                          value: visitType,
                          onChanged: (value, label) {
                            visitType = value;
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
                        child: Text(
                          "Price Range",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: QDropdownField(
                          label: "Select range",
                          items: [
                            {"label": "Under \$20", "value": "under_20"},
                            {"label": "\$20-\$40", "value": "20_40"},
                            {"label": "\$40-\$60", "value": "40_60"},
                            {"label": "Over \$60", "value": "over_60"},
                          ],
                          value: priceRange,
                          onChanged: (value, label) {
                            priceRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Rating Criteria
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rate Your Experience",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...criteriaRatings.entries.map((entry) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: List.generate(5, (index) => GestureDetector(
                            onTap: () {
                              criteriaRatings[entry.key] = index + 1;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: spSm),
                              child: Icon(
                                entry.value > index ? Icons.star : Icons.star_border,
                                size: 28,
                                color: entry.value > index ? warningColor : disabledColor,
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Menu Highlights
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What did you try?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Select items you tried (optional)",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: menuHighlights.map((item) => GestureDetector(
                      onTap: () {
                        item["liked"] = !item["liked"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: item["liked"] ? successColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: item["liked"] ? successColor : disabledColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (item["liked"])
                              Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              ),
                            if (item["liked"]) SizedBox(width: spXs),
                            Text(
                              item["name"],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: item["liked"] ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Review Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Write Your Review",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Review Title",
                    value: reviewTitle,
                    hint: "Summarize your experience",
                    onChanged: (value) {
                      reviewTitle = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QMemoField(
                    label: "Your Review",
                    value: reviewContent,
                    hint: "Tell others about your dining experience. What was great? What could be improved?",
                    onChanged: (value) {
                      reviewContent = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Photos
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Photos (Optional)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Photos help other diners see what to expect",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QMultiImagePicker(
                    label: "Restaurant Photos",
                    value: selectedPhotos,
                    maxImages: 5,
                    hint: "Add photos of food, ambiance, etc.",
                    onChanged: (value) {
                      selectedPhotos = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Recommendation
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Would you recommend this restaurant?",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Yes, I would recommend this restaurant",
                              "value": true,
                              "checked": wouldRecommend,
                            }
                          ],
                          value: [
                            if (wouldRecommend)
                              {
                                "label": "Yes, I would recommend this restaurant",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            wouldRecommend = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Review",
                size: bs.md,
                onPressed: _canSubmitReview()
                    ? () {
                        ss("Restaurant review submitted successfully!");
                      }
                    : () {},
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Review Tips
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        size: 20,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Review Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Be specific about your experience\n• Mention standout dishes or service\n• Include helpful details for other diners\n• Be honest and constructive",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.5,
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

  bool _canSubmitReview() {
    bool hasRatings = criteriaRatings.values.any((rating) => rating > 0);
    return hasRatings && reviewTitle.isNotEmpty && reviewContent.isNotEmpty;
  }
}
