import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaWriteReviewView extends StatefulWidget {
  const SpaWriteReviewView({Key? key}) : super(key: key);

  @override
  State<SpaWriteReviewView> createState() => _SpaWriteReviewViewState();
}

class _SpaWriteReviewViewState extends State<SpaWriteReviewView> {
  final formKey = GlobalKey<FormState>();
  
  int selectedRating = 0;
  String reviewTitle = "";
  String reviewText = "";
  String selectedTreatment = "";
  String selectedSpa = "";
  List<String> reviewPhotos = [];
  bool recommendToFriends = true;
  bool allowContact = false;
  String visitDate = "";
  String experienceLevel = "";

  List<Map<String, dynamic>> treatmentOptions = [
    {"label": "Hydrating Facial Treatment", "value": "hydrating_facial"},
    {"label": "Anti-Aging Facial", "value": "anti_aging_facial"},
    {"label": "Organic Skin Renewal", "value": "organic_renewal"},
    {"label": "Diamond Microdermabrasion", "value": "diamond_micro"},
    {"label": "Deep Cleansing Facial", "value": "deep_cleansing"},
    {"label": "Acne Treatment", "value": "acne_treatment"},
  ];

  List<Map<String, dynamic>> spaOptions = [
    {"label": "Luxury Spa & Wellness", "value": "luxury_spa"},
    {"label": "Elite Beauty Center", "value": "elite_beauty"},
    {"label": "Natural Spa Retreat", "value": "natural_spa"},
    {"label": "Premium Skin Clinic", "value": "premium_skin"},
    {"label": "Urban Wellness Hub", "value": "urban_wellness"},
  ];

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "First time at this spa", "value": "first_time"},
    {"label": "Occasional visitor", "value": "occasional"},
    {"label": "Regular customer", "value": "regular"},
    {"label": "VIP member", "value": "vip"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Review"),
        actions: [
          QButton(
            label: "Save Draft",
            size: bs.sm,
            color: secondaryColor,
            onPressed: () {
              _saveDraft();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Treatment & Spa Selection
                    _buildSection(
                      title: "Treatment Information",
                      icon: Icons.spa,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QDropdownField(
                            label: "Select Treatment",
                            items: treatmentOptions,
                            value: selectedTreatment,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedTreatment = value;
                              setState(() {});
                            },
                          ),
                          QDropdownField(
                            label: "Select Spa",
                            items: spaOptions,
                            value: selectedSpa,
                            validator: Validator.required,
                            onChanged: (value, label) {
                              selectedSpa = value;
                              setState(() {});
                            },
                          ),
                          QDatePicker(
                            label: "Visit Date",
                            value: visitDate.isNotEmpty ? DateTime.parse(visitDate) : DateTime.now(),
                            onChanged: (value) {
                              visitDate = value.toIso8601String();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Rating Section
                    _buildSection(
                      title: "Overall Rating",
                      icon: Icons.star,
                      child: Column(
                        children: [
                          Text(
                            "How would you rate your experience?",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  selectedRating = index + 1;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: spXs),
                                  child: Icon(
                                    selectedRating > index
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: warningColor,
                                    size: 40,
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: spSm),
                          if (selectedRating > 0)
                            Text(
                              _getRatingText(selectedRating),
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: _getRatingColor(selectedRating),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Review Content
                    _buildSection(
                      title: "Your Review",
                      icon: Icons.edit,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QTextField(
                            label: "Review Title",
                            value: reviewTitle,
                            hint: "Summarize your experience in a few words",
                            validator: Validator.required,
                            onChanged: (value) {
                              reviewTitle = value;
                              setState(() {});
                            },
                          ),
                          QMemoField(
                            label: "Detailed Review",
                            value: reviewText,
                            hint: "Share your detailed experience, what you liked, and any suggestions for improvement...",
                            validator: Validator.required,
                            onChanged: (value) {
                              reviewText = value;
                              setState(() {});
                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Review Guidelines:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                _buildGuideline("Be honest and constructive"),
                                _buildGuideline("Focus on your experience"),
                                _buildGuideline("Avoid personal attacks"),
                                _buildGuideline("Include specific details"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Photos
                    _buildSection(
                      title: "Add Photos",
                      icon: Icons.camera_alt,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Photos help other customers understand your experience better",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          QMultiImagePicker(
                            label: "Review Photos",
                            value: reviewPhotos,
                            maxImages: 5,
                            hint: "Add up to 5 photos",
                            onChanged: (value) {
                              reviewPhotos = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Additional Information
                    _buildSection(
                      title: "Additional Information",
                      icon: Icons.info,
                      child: Column(
                        spacing: spSm,
                        children: [
                          QDropdownField(
                            label: "Your Experience Level",
                            items: experienceOptions,
                            value: experienceLevel,
                            onChanged: (value, label) {
                              experienceLevel = value;
                              setState(() {});
                            },
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "I would recommend this to friends",
                                "value": "recommend",
                                "checked": recommendToFriends,
                              }
                            ],
                            value: recommendToFriends
                                ? [
                                    {
                                      "label": "I would recommend this to friends",
                                      "value": "recommend",
                                      "checked": true,
                                    }
                                  ]
                                : [],
                            onChanged: (values, ids) {
                              recommendToFriends = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                          QSwitch(
                            items: [
                              {
                                "label": "Allow spa to contact me about this review",
                                "value": "contact",
                                "checked": allowContact,
                              }
                            ],
                            value: allowContact
                                ? [
                                    {
                                      "label": "Allow spa to contact me about this review",
                                      "value": "contact",
                                      "checked": true,
                                    }
                                  ]
                                : [],
                            onChanged: (values, ids) {
                              allowContact = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),

                    // Review Preview
                    if (selectedRating > 0 && reviewTitle.isNotEmpty)
                      _buildSection(
                        title: "Review Preview",
                        icon: Icons.preview,
                        child: _buildReviewPreview(),
                      ),

                    // Terms and Conditions
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: infoColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: infoColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Review Terms",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "By submitting this review, you agree to our review guidelines and confirm that this review reflects your genuine experience.",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.md,
                      color: secondaryColor,
                      onPressed: () {
                        _showCancelDialog();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Submit Review",
                      size: bs.md,
                      onPressed: () {
                        _submitReview();
                      },
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

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildGuideline(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: successColor,
            size: 14,
          ),
          SizedBox(width: spXs),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewPreview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: primaryColor,
                child: Text(
                  "ME",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Review",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < selectedRating ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 14,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            reviewTitle,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (reviewText.isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              reviewText,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (reviewPhotos.isNotEmpty) ...[
            SizedBox(height: spSm),
            Text(
              "${reviewPhotos.length} phoss('Next page') attached",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
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

  void _saveDraft() {
    si("Draft saved successfully");
  }

  void _showCancelDialog() async {
    bool isConfirmed = await confirm("Are you sure you want to cancel? Your progress will be lost.");
    if (isConfirmed) {
      back();
    }
  }

  void _submitReview() {
    if (selectedRating == 0) {
      se("Please select a rating");
      return;
    }

    if (formKey.currentState!.validate()) {
      // Submit review logic
      ss("Review submitted successfully!");
      back();
    }
  }
}
