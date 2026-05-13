import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeedback6View extends StatefulWidget {
  @override
  State<GrlFeedback6View> createState() => _GrlFeedback6ViewState();
}

class _GrlFeedback6ViewState extends State<GrlFeedback6View> {
  String selectedProduct = "";
  List<String> selectedAspects = [];
  Map<String, int> aspectRatings = {};
  String additionalComments = "";
  bool wouldRecommend = false;
  String customerEmail = "";
  
  List<Map<String, dynamic>> products = [
    {
      "id": "prod_001",
      "name": "Premium Coffee Maker",
      "image": "https://picsum.photos/300/200?random=1&keyword=coffee",
      "category": "Kitchen Appliance",
      "price": 199.99,
    },
    {
      "id": "prod_002",
      "name": "Wireless Headphones",
      "image": "https://picsum.photos/300/200?random=2&keyword=headphones",
      "category": "Electronics",
      "price": 149.99,
    },
    {
      "id": "prod_003",
      "name": "Smart Watch",
      "image": "https://picsum.photos/300/200?random=3&keyword=watch",
      "category": "Wearable Tech",
      "price": 299.99,
    },
    {
      "id": "prod_004",
      "name": "Yoga Mat",
      "image": "https://picsum.photos/300/200?random=4&keyword=yoga",
      "category": "Fitness",
      "price": 49.99,
    },
  ];
  
  List<Map<String, dynamic>> reviewAspects = [
    {
      "id": "quality",
      "name": "Product Quality",
      "icon": Icons.star,
      "description": "Overall build quality and materials"
    },
    {
      "id": "value",
      "name": "Value for Money",
      "icon": Icons.attach_money,
      "description": "Price vs. quality ratio"
    },
    {
      "id": "design",
      "name": "Design & Appearance",
      "icon": Icons.palette,
      "description": "Look, feel, and aesthetic appeal"
    },
    {
      "id": "usability",
      "name": "Ease of Use",
      "icon": Icons.touch_app,
      "description": "User-friendliness and intuitive design"
    },
    {
      "id": "performance",
      "name": "Performance",
      "icon": Icons.speed,
      "description": "How well it performs its intended function"
    },
    {
      "id": "durability",
      "name": "Durability",
      "icon": Icons.security,
      "description": "Long-term reliability and sturdiness"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Review"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // navigateTo(ReviewHistoryView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Share Your Product Experience",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Help other customers make informed decisions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Product Selection
            Text(
              "Which product would you like to review?",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...products.map((product) => GestureDetector(
              onTap: () {
                selectedProduct = product["id"];
                setState(() {});
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                  border: Border.all(
                    color: selectedProduct == product["id"] 
                        ? primaryColor 
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: Row(
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(radiusLg),
                      ),
                      child: Image.network(
                        "${product["image"]}",
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    // Product Info
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${product["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "\$${(product["price"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Selection Indicator
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: selectedProduct == product["id"] 
                              ? primaryColor 
                              : Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          selectedProduct == product["id"] 
                              ? Icons.check 
                              : Icons.add,
                          color: selectedProduct == product["id"] 
                              ? Colors.white 
                              : Colors.grey.shade400,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
            
            if (selectedProduct.isNotEmpty) ...[
              SizedBox(height: spMd),
              
              // Rating Aspects
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
                      "Rate Different Aspects",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Select the aspects you'd like to rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Aspect Selection
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: reviewAspects.map((aspect) => GestureDetector(
                        onTap: () {
                          if (selectedAspects.contains(aspect["id"])) {
                            selectedAspects.remove(aspect["id"]);
                            aspectRatings.remove(aspect["id"]);
                          } else {
                            selectedAspects.add(aspect["id"]);
                            aspectRatings[aspect["id"]] = 0;
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: selectedAspects.contains(aspect["id"])
                                ? primaryColor.withAlpha(20)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: selectedAspects.contains(aspect["id"])
                                  ? primaryColor
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                aspect["icon"] as IconData,
                                size: 16,
                                color: selectedAspects.contains(aspect["id"])
                                    ? primaryColor
                                    : disabledBoldColor,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                aspect["name"],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: selectedAspects.contains(aspect["id"])
                                      ? primaryColor
                                      : disabledBoldColor,
                                ),
                              ),
                              if (selectedAspects.contains(aspect["id"])) ...[
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.check,
                                  size: 16,
                                  color: primaryColor,
                                ),
                              ],
                            ],
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
              
              if (selectedAspects.isNotEmpty) ...[
                SizedBox(height: spMd),
                
                // Rating Cards
                ...selectedAspects.map((aspectId) {
                  final aspect = reviewAspects.firstWhere((a) => a["id"] == aspectId);
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              aspect["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    aspect["name"],
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    aspect["description"],
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
                        SizedBox(height: spMd),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            int rating = index + 1;
                            return GestureDetector(
                              onTap: () {
                                aspectRatings[aspectId] = rating;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (aspectRatings[aspectId] ?? 0) >= rating
                                      ? warningColor
                                      : Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: (aspectRatings[aspectId] ?? 0) >= rating
                                      ? Colors.white
                                      : Colors.grey.shade400,
                                  size: 24,
                                ),
                              ),
                            );
                          }),
                        ),
                        if ((aspectRatings[aspectId] ?? 0) > 0) ...[
                          SizedBox(height: spSm),
                          Text(
                            _getRatingText(aspectRatings[aspectId] ?? 0),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getRatingColor(aspectRatings[aspectId] ?? 0),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ],
              
              SizedBox(height: spMd),
              
              // Additional Comments
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
                      "Additional Comments",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QMemoField(
                      label: "Your Review",
                      value: additionalComments,
                      hint: "Share your detailed experience with this product...",
                      onChanged: (value) {
                        additionalComments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Recommendation and Contact
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
                      "Final Thoughts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QSwitch(
                      items: [
                        {
                          "label": "I would recommend this product to others",
                          "value": true,
                          "checked": wouldRecommend,
                        }
                      ],
                      value: [if (wouldRecommend) {"label": "I would recommend this product to others", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        wouldRecommend = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spMd),
                    QTextField(
                      label: "Email (optional)",
                      value: customerEmail,
                      hint: "For follow-up questions about your review",
                      onChanged: (value) {
                        customerEmail = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Review Summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: successColor.withAlpha(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.summarize,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Review Summary",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    if (aspectRatings.isNotEmpty) ...[
                      Text(
                        "Average Rating: ${(aspectRatings.values.reduce((a, b) => a + b) / aspectRatings.length).toStringAsFixed(1)}/5",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Aspects Rated: ${selectedAspects.length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                    if (wouldRecommend)
                      Text(
                        "Would recommend to others",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
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
                  onPressed: selectedAspects.isNotEmpty && aspectRatings.values.any((rating) => rating > 0)
                      ? () {
                          _submitReview();
                        }
                      : null,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1: return "Poor";
      case 2: return "Fair";
      case 3: return "Good";
      case 4: return "Very Good";
      case 5: return "Excellent";
      default: return "";
    }
  }

  Color _getRatingColor(int rating) {
    if (rating <= 2) return dangerColor;
    if (rating == 3) return warningColor;
    return successColor;
  }

  void _submitReview() {
    if (selectedProduct.isEmpty) {
      se("Please select a product to review");
      return;
    }
    
    if (selectedAspects.isEmpty) {
      se("Please select at least one aspect to rate");
      return;
    }
    
    if (!aspectRatings.values.any((rating) => rating > 0)) {
      se("Please provide ratings for selected aspects");
      return;
    }
    
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Thank you for your detailed product review!");
      
      // Reset form
      selectedProduct = "";
      selectedAspects = [];
      aspectRatings = {};
      additionalComments = "";
      wouldRecommend = false;
      customerEmail = "";
      setState(() {});
    });
  }
}
