import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaRateOrderView extends StatefulWidget {
  const FdaRateOrderView({super.key});

  @override
  State<FdaRateOrderView> createState() => _FdaRateOrderViewState();
}

class _FdaRateOrderViewState extends State<FdaRateOrderView> {
  double restaurantRating = 0;
  double deliveryRating = 0;
  String orderFeedback = "";
  List<Map<String, dynamic>> itemRatings = [];
  bool isSubmitting = false;
  
  Map<String, dynamic> orderDetails = {
    "orderId": "ORD-2024-001234",
    "restaurant": {
      "name": "Bella Italia",
      "image": "https://placehold.co/60x60?text=BI",
    },
    "deliveryTime": "35 minutes",
    "deliveryPerson": "John Smith",
    "deliveryPhoto": "https://placehold.co/40x40?text=JS",
    "orderDate": "2024-06-15",
    "total": 42.50,
    "items": [
      {
        "id": 1,
        "name": "Spaghetti Carbonara",
        "image": "https://placehold.co/60x60?text=SC",
        "price": 18.99,
        "quantity": 1,
        "rating": 0.0,
        "comment": ""
      },
      {
        "id": 2,
        "name": "Caesar Salad",
        "image": "https://placehold.co/60x60?text=CS",
        "price": 12.99,
        "quantity": 1,
        "rating": 0.0,
        "comment": ""
      },
      {
        "id": 3,
        "name": "Tiramisu",
        "image": "https://placehold.co/60x60?text=T",
        "price": 8.99,
        "quantity": 1,
        "rating": 0.0,
        "comment": ""
      }
    ]
  };

  List<Map<String, dynamic>> quickFeedbackOptions = [
    {"label": "Great food quality", "selected": false},
    {"label": "Fast delivery", "selected": false},
    {"label": "Hot and fresh", "selected": false},
    {"label": "Correct order", "selected": false},
    {"label": "Polite delivery person", "selected": false},
    {"label": "Good packaging", "selected": false},
    {"label": "Value for money", "selected": false},
    {"label": "Would order again", "selected": false},
  ];

  @override
  void initState() {
    super.initState();
    itemRatings = (orderDetails["items"] as List).map((item) => {
      "id": item["id"],
      "rating": 0.0,
      "comment": ""
    }).toList();
  }

  Widget _buildRatingStars(double rating, Function(double) onRatingChanged, {double size = 32}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRatingChanged((index + 1).toDouble()),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Icon(
              index < rating.floor() ? Icons.star : Icons.star_border,
              color: warningColor,
              size: size,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${orderDetails["restaurant"]["image"]}"),
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
                      "${orderDetails["restaurant"]["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Order #${orderDetails["orderId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Delivered in ${orderDetails["deliveryTime"]} • \$${(orderDetails["total"] as double).toStringAsFixed(2)}",
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
        ],
      ),
    );
  }

  Widget _buildRestaurantRating() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rate Restaurant",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Center(
            child: Column(
              children: [
                _buildRatingStars(restaurantRating, (rating) {
                  restaurantRating = rating;
                  setState(() {});
                }),
                SizedBox(height: spSm),
                Text(
                  _getRatingText(restaurantRating),
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryRating() {
    return Container(
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
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${orderDetails["deliveryPhoto"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rate Delivery",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Delivered by ${orderDetails["deliveryPerson"]}",
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
          Center(
            child: Column(
              children: [
                _buildRatingStars(deliveryRating, (rating) {
                  deliveryRating = rating;
                  setState(() {});
                }),
                SizedBox(height: spSm),
                Text(
                  _getRatingText(deliveryRating),
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRatings() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rate Individual Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: (orderDetails["items"] as List).asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("${item["image"]}"),
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
                                "${item["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$${(item["price"] as double).toStringAsFixed(2)} × ${item["quantity"]}",
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
                    _buildRatingStars(
                      itemRatings[index]["rating"],
                      (rating) {
                        itemRatings[index]["rating"] = rating;
                        setState(() {});
                      },
                      size: 24,
                    ),
                    if (itemRatings[index]["rating"] > 0) ...[
                      SizedBox(height: spSm),
                      QTextField(
                        label: "Comment (optional)",
                        value: itemRatings[index]["comment"],
                        hint: "Tell us what you thought about this item",
                        onChanged: (value) {
                          itemRatings[index]["comment"] = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFeedback() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Feedback",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: quickFeedbackOptions.map((option) {
              return GestureDetector(
                onTap: () {
                  option["selected"] = !option["selected"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: option["selected"] 
                        ? primaryColor.withAlpha(20)
                        : disabledColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: option["selected"] ? primaryColor : disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "${option["label"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: option["selected"] ? primaryColor : disabledBoldColor,
                      fontWeight: option["selected"] ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalFeedback() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Feedback",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Share your experience",
            value: orderFeedback,
            hint: "Tell us more about your order experience...",
            onChanged: (value) {
              orderFeedback = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  String _getRatingText(double rating) {
    if (rating == 0) return "Tap to rate";
    if (rating == 1) return "Poor";
    if (rating == 2) return "Fair";
    if (rating == 3) return "Good";
    if (rating == 4) return "Very Good";
    if (rating == 5) return "Excellent";
    return "";
  }

  bool get _canSubmit {
    return restaurantRating > 0 || deliveryRating > 0 || itemRatings.any((item) => item["rating"] > 0);
  }

  void _submitRating() async {
    if (!_canSubmit) {
      se("Please provide at least one rating");
      return;
    }

    isSubmitting = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    isSubmitting = false;
    setState(() {});

    ss("Thank you for your feedback!");
    //navigateTo(FdaOrderHistoryView())
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Your Order"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildOrderSummary(),
            SizedBox(height: spMd),
            _buildRestaurantRating(),
            SizedBox(height: spMd),
            _buildDeliveryRating(),
            SizedBox(height: spMd),
            _buildItemRatings(),
            SizedBox(height: spMd),
            _buildQuickFeedback(),
            SizedBox(height: spMd),
            _buildAdditionalFeedback(),
            SizedBox(height: spLg),
            Container(
              width: double.infinity,
              child: QButton(
                label: isSubmitting ? "Submitting..." : "Submit Rating",
                size: bs.md,
                onPressed: _canSubmit && !isSubmitting ? _submitRating : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
