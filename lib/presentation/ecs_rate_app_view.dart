import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsRateAppView extends StatefulWidget {
  const EcsRateAppView({super.key});

  @override
  State<EcsRateAppView> createState() => _EcsRateAppViewState();
}

class _EcsRateAppViewState extends State<EcsRateAppView> {
  int appRating = 0;
  int userExperienceRating = 0;
  int performanceRating = 0;
  int designRating = 0;
  int featuresRating = 0;
  
  String reviewTitle = "";
  String reviewText = "";
  String improvementSuggestion = "";
  String favoriteFeature = "";
  
  bool shareOnSocialMedia = false;
  bool recommendToFriends = false;
  bool participateInBeta = false;

  List<Map<String, dynamic>> quickFeedback = [
    {"label": "Easy to use", "selected": false},
    {"label": "Fast loading", "selected": false},
    {"label": "Great design", "selected": false},
    {"label": "Helpful features", "selected": false},
    {"label": "Good customer support", "selected": false},
    {"label": "Regular updates", "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Our App"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppHeader(),
            SizedBox(height: spLg),
            _buildOverallRating(),
            SizedBox(height: spLg),
            _buildDetailedRatings(),
            SizedBox(height: spLg),
            _buildQuickFeedback(),
            SizedBox(height: spLg),
            _buildWrittenReview(),
            SizedBox(height: spLg),
            _buildImprovementSuggestions(),
            SizedBox(height: spLg),
            _buildSharingOptions(),
            SizedBox(height: spXl),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(20), primaryColor.withAlpha(5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 40,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "ShopEasy",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "We'd love to hear your thoughts about our app. Your feedback helps us create a better shopping experience for everyone.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
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
              Icon(Icons.star, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Overall Rating",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "How would you rate our app overall?",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  appRating = index + 1;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: spSm),
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    children: [
                      Icon(
                        index < appRating ? Icons.star : Icons.star_border,
                        color: index < appRating ? warningColor : disabledColor,
                        size: 40,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 12,
                          color: index < appRating ? warningColor : disabledColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: spMd),
          if (appRating > 0) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: _getRatingColor(appRating).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getRatingIcon(appRating),
                    color: _getRatingColor(appRating),
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    _getRatingText(appRating),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _getRatingColor(appRating),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailedRatings() {
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
              Icon(Icons.rate_review, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Detailed Ratings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildRatingCategory("User Experience", userExperienceRating, Icons.person, (rating) {
            userExperienceRating = rating;
            setState(() {});
          }),
          SizedBox(height: spMd),
          _buildRatingCategory("Performance", performanceRating, Icons.speed, (rating) {
            performanceRating = rating;
            setState(() {});
          }),
          SizedBox(height: spMd),
          _buildRatingCategory("Design & Interface", designRating, Icons.design_services, (rating) {
            designRating = rating;
            setState(() {});
          }),
          SizedBox(height: spMd),
          _buildRatingCategory("Features", featuresRating, Icons.featured_play_list, (rating) {
            featuresRating = rating;
            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget _buildRatingCategory(String label, int rating, IconData icon, Function(int) onRatingChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: rating > 0 ? primaryColor.withAlpha(10) : null,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: rating > 0 ? primaryColor.withAlpha(30) : disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => onRatingChanged(index + 1),
                    child: Container(
                      margin: EdgeInsets.only(left: spXs),
                      padding: EdgeInsets.all(2),
                      child: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: index < rating ? warningColor : disabledColor,
                        size: 16,
                      ),
                    ),
                  );
                }),
              ),
            ],
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
          Row(
            children: [
              Icon(Icons.quick_contacts_dialer, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Quick Feedback",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "What do you like about our app? (Select all that apply)",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: quickFeedback.map((item) {
              bool isSelected = item["selected"] as bool;
              return GestureDetector(
                onTap: () {
                  item["selected"] = !isSelected;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                      ],
                      Text(
                        "${item["label"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWrittenReview() {
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
              Icon(Icons.edit, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Write a Review",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Review Title",
            value: reviewTitle,
            hint: "Summary of your experience",
            onChanged: (value) {
              reviewTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Your Review",
            value: reviewText,
            hint: "Tell us about your experience with the app",
            onChanged: (value) {
              reviewText = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Favorite Feature",
            value: favoriteFeature,
            hint: "What's your favorite feature?",
            onChanged: (value) {
              favoriteFeature = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImprovementSuggestions() {
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
              Icon(Icons.lightbulb, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Suggestions for Improvement",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "How can we improve?",
            value: improvementSuggestion,
            hint: "Share your ideas for making our app better",
            onChanged: (value) {
              improvementSuggestion = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSharingOptions() {
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
              Icon(Icons.share, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Sharing & Participation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QSwitch(
            items: [
              {
                "label": "Share my review on social media",
                "value": true,
                "checked": shareOnSocialMedia,
              }
            ],
            value: [if (shareOnSocialMedia) {"label": "Share my review on social media", "value": true, "checked": true}],
            onChanged: (values, ids) {
              shareOnSocialMedia = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Recommend this app to friends",
                "value": true,
                "checked": recommendToFriends,
              }
            ],
            value: [if (recommendToFriends) {"label": "Recommend this app to friends", "value": true, "checked": true}],
            onChanged: (values, ids) {
              recommendToFriends = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Participate in beta testing for new features",
                "value": true,
                "checked": participateInBeta,
              }
            ],
            value: [if (participateInBeta) {"label": "Participate in beta testing for new features", "value": true, "checked": true}],
            onChanged: (values, ids) {
              participateInBeta = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    bool canSubmit = appRating > 0;
    
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Submit Review",
            size: bs.md,
            onPressed: canSubmit ? _submitReview : null,
          ),
        ),
        SizedBox(height: spSm),
        if (appRating >= 4) ...[
          Container(
            width: double.infinity,
            child: QButton(
              label: "Rate on App Store",
              size: bs.md,
              onPressed: _rateOnAppStore,
            ),
          ),
          SizedBox(height: spSm),
        ],
        Container(
          width: double.infinity,
          child: QButton(
            label: "Maybe Later",
            size: bs.md,
            onPressed: () => back(),
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(Icons.security, color: infoColor, size: 16),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Your review is anonymous and helps improve our app",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return "Poor - Needs improvement";
      case 2:
        return "Fair - Below expectations";
      case 3:
        return "Good - Meets expectations";
      case 4:
        return "Very Good - Exceeds expectations";
      case 5:
        return "Excellent - Outstanding!";
      default:
        return "";
    }
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
      case 2:
        return dangerColor;
      case 3:
        return warningColor;
      case 4:
      case 5:
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getRatingIcon(int rating) {
    switch (rating) {
      case 1:
      case 2:
        return Icons.sentiment_dissatisfied;
      case 3:
        return Icons.sentiment_neutral;
      case 4:
      case 5:
        return Icons.sentiment_satisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  void _submitReview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Thank You!"),
        content: Text("Your review has been submitted successfully. We appreciate your feedback and will use it to improve our app."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              back();
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _rateOnAppStore() {
    ss("Redirecting to App Store for rating");
    back();
  }
}
