import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsReviewRatingView extends StatefulWidget {
  const BrsReviewRatingView({super.key});

  @override
  State<BrsReviewRatingView> createState() => _BrsReviewRatingViewState();
}

class _BrsReviewRatingViewState extends State<BrsReviewRatingView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  int overallRating = 0;
  int serviceQuality = 0;
  int cleanliness = 0;
  int valueForMoney = 0;
  int punctuality = 0;
  int professionalisme = 0;
  
  String reviewText = "";
  String visitDate = DateTime.now().toString();
  bool recommendToFriends = false;
  
  List<String> selectedTags = [];
  
  List<String> reviewTags = [
    "Excellent Service",
    "Great Value",
    "Professional",
    "Clean Environment",
    "On Time",
    "Friendly Staff",
    "Skilled Barber",
    "Comfortable",
    "Quick Service",
    "Attention to Detail",
    "Good Communication",
    "Will Return",
  ];

  Map<String, dynamic> bookingDetails = {
    "id": "BK001",
    "barber_name": "Mike Johnson",
    "barber_image": "https://picsum.photos/120/120?random=101&keyword=barber",
    "shop_name": "Elite Barber Shop",
    "service": "Premium Haircut + Beard Trim",
    "date": "2024-12-15",
    "time": "14:00",
    "price": 35.0,
    "duration": "45 minutes",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate & Review"),
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildBookingDetailsCard(),
                  _buildOverallRatingSection(),
                  _buildDetailedRatingsSection(),
                  _buildReviewTextSection(),
                  _buildTagsSection(),
                  _buildRecommendationSection(),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildBookingDetailsCard() {
    return Container(
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
            "Your Recent Visit",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${bookingDetails["barber_image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${bookingDetails["barber_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${bookingDetails["shop_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${bookingDetails["service"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(bookingDetails["date"]).dMMMy} at ${bookingDetails["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${(bookingDetails["price"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
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

  Widget _buildOverallRatingSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Overall Experience",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "How would you rate your overall experience?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: spSm,
            children: List.generate(5, (index) {
              bool isSelected = index < overallRating;
              return GestureDetector(
                onTap: () {
                  overallRating = index + 1;
                  setState(() {});
                },
                child: Icon(
                  isSelected ? Icons.star : Icons.star_border,
                  color: isSelected ? Colors.amber : disabledBoldColor,
                  size: 40,
                ),
              );
            }),
          ),
          if (overallRating > 0)
            Text(
              _getRatingText(overallRating),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailedRatingsSection() {
    return Container(
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
            "Detailed Ratings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildRatingRow("Service Quality", serviceQuality, (rating) {
            serviceQuality = rating;
            setState(() {});
          }),
          _buildRatingRow("Cleanliness", cleanliness, (rating) {
            cleanliness = rating;
            setState(() {});
          }),
          _buildRatingRow("Value for Money", valueForMoney, (rating) {
            valueForMoney = rating;
            setState(() {});
          }),
          _buildRatingRow("Punctuality", punctuality, (rating) {
            punctuality = rating;
            setState(() {});
          }),
          _buildRatingRow("Professionalism", professionalisme, (rating) {
            professionalisme = rating;
            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String title, int rating, Function(int) onRatingChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
        Row(
          spacing: spXs,
          children: List.generate(5, (index) {
            bool isSelected = index < rating;
            return GestureDetector(
              onTap: () => onRatingChanged(index + 1),
              child: Icon(
                isSelected ? Icons.star : Icons.star_border,
                color: isSelected ? Colors.amber : disabledBoldColor,
                size: 20,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildReviewTextSection() {
    return Container(
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
            "Write Your Review",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Share your experience",
            value: reviewText,
            hint: "Tell others about your experience, what you liked, and any suggestions for improvement...",
            onChanged: (value) {
              reviewText = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection() {
    return Container(
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
            "Quick Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Select tags that describe your experience",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: reviewTags.map((tag) {
              bool isSelected = selectedTags.contains(tag);
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
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : primaryColor,
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

  Widget _buildRecommendationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Recommend to Friends?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Would you recommend this barber to your friends?",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: recommendToFriends,
            onChanged: (value) {
              recommendToFriends = value;
              setState(() {});
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Submit Review",
        size: bs.md,
        onPressed: _submitReview,
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return "Poor";
      case 2:
        return "Fair";
      case 3:
        return "Good";
      case 4:
        return "Very Good";
      case 5:
        return "Excellent";
      default:
        return "";
    }
  }

  void _submitReview() async {
    if (overallRating == 0) {
      se("Please provide an overall rating");
      return;
    }

    if (reviewText.trim().isEmpty) {
      se("Please write a review");
      return;
    }

    bool isConfirmed = await confirm("Submit your review? Once submitted, it cannot be changed.");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Review submitted successfully! Thank you for your feedback.");
    await Future.delayed(Duration(milliseconds: 500));
    back();
  }
}
