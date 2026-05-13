import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsFeedbackView extends StatefulWidget {
  const EcsFeedbackView({super.key});

  @override
  State<EcsFeedbackView> createState() => _EcsFeedbackViewState();
}

class _EcsFeedbackViewState extends State<EcsFeedbackView> {
  final formKey = GlobalKey<FormState>();
  
  String feedbackType = "";
  List<Map<String, dynamic>> feedbackTypes = [
    {"label": "Product Quality", "value": "product_quality"},
    {"label": "Shipping & Delivery", "value": "shipping"},
    {"label": "Customer Service", "value": "customer_service"},
    {"label": "Website/App Experience", "value": "website"},
    {"label": "Payment Issues", "value": "payment"},
    {"label": "Return/Exchange", "value": "return"},
    {"label": "Suggestion", "value": "suggestion"},
    {"label": "Other", "value": "other"}
  ];

  int overallRating = 0;
  int productQualityRating = 0;
  int shippingRating = 0;
  int serviceRating = 0;
  
  String subject = "";
  String message = "";
  String email = "";
  String name = "";
  
  List<String> attachments = [];
  bool allowFollowUp = true;
  bool subscribeNewsletter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFeedbackHeader(),
              SizedBox(height: spLg),
              _buildOverallRating(),
              SizedBox(height: spLg),
              _buildDetailedRatings(),
              SizedBox(height: spLg),
              _buildFeedbackDetails(),
              SizedBox(height: spLg),
              _buildContactInfo(),
              SizedBox(height: spLg),
              _buildAttachments(),
              SizedBox(height: spLg),
              _buildPreferences(),
              SizedBox(height: spXl),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackHeader() {
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
          Icon(
            Icons.feedback,
            size: 48,
            color: primaryColor,
          ),
          SizedBox(height: spMd),
          Text(
            "We Value Your Feedback",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Help us improve by sharing your experience with our products and services",
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
                "Overall Experience",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "How would you rate your overall experience?",
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
                  overallRating = index + 1;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: spXs),
                  padding: EdgeInsets.all(spXs),
                  child: Icon(
                    index < overallRating ? Icons.star : Icons.star_border,
                    color: index < overallRating ? warningColor : disabledColor,
                    size: 32,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: spSm),
          Text(
            _getRatingText(overallRating),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: _getRatingColor(overallRating),
            ),
          ),
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
          _buildRatingRow("Product Quality", productQualityRating, (rating) {
            productQualityRating = rating;
            setState(() {});
          }),
          SizedBox(height: spMd),
          _buildRatingRow("Shipping & Delivery", shippingRating, (rating) {
            shippingRating = rating;
            setState(() {});
          }),
          SizedBox(height: spMd),
          _buildRatingRow("Customer Service", serviceRating, (rating) {
            serviceRating = rating;
            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String label, int rating, Function(int) onRatingChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(height: spXs),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => onRatingChanged(index + 1),
              child: Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.all(2),
                child: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: index < rating ? warningColor : disabledColor,
                  size: 20,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFeedbackDetails() {
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
              Icon(Icons.message, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Feedback Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Feedback Category",
            items: feedbackTypes,
            value: feedbackType,
            validator: Validator.required,
            onChanged: (value, label) {
              feedbackType = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QTextField(
            label: "Subject",
            value: subject,
            hint: "Brief description of your feedback",
            validator: Validator.required,
            onChanged: (value) {
              subject = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Your Message",
            value: message,
            hint: "Please provide detailed feedback about your experience",
            validator: Validator.required,
            onChanged: (value) {
              message = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
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
              Icon(Icons.contact_mail, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Full Name",
                  value: name,
                  validator: Validator.required,
                  onChanged: (value) {
                    name = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Email Address",
                  value: email,
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttachments() {
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
              Icon(Icons.attach_file, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Attachments (Optional)",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QAttachmentPicker(
            label: "Upload Files",
            value: attachments,
            hint: "Add screenshots, photos, or documents",
            maxAttachments: 5,
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferences() {
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
              Icon(Icons.settings, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Communication Preferences",
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
                "label": "Allow follow-up contact about this feedback",
                "value": true,
                "checked": allowFollowUp,
              }
            ],
            value: [if (allowFollowUp) {"label": "Allow follow-up contact about this feedback", "value": true, "checked": true}],
            onChanged: (values, ids) {
              allowFollowUp = values.isNotEmpty;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Subscribe to newsletter for updates",
                "value": true,
                "checked": subscribeNewsletter,
              }
            ],
            value: [if (subscribeNewsletter) {"label": "Subscribe to newsletter for updates", "value": true, "checked": true}],
            onChanged: (values, ids) {
              subscribeNewsletter = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Submit Feedback",
            size: bs.md,
            onPressed: _submitFeedback,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save as Draft",
            size: bs.md,
            onPressed: _saveDraft,
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
              Icon(Icons.privacy_tip, color: infoColor, size: 16),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Your feedback is confidential and helps us improve our services",
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
        return "Select a rating";
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

  void _submitFeedback() {
    if (formKey.currentState!.validate()) {
      if (overallRating == 0) {
        se("Please provide an overall rating");
        return;
      }
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Submit Feedback"),
          content: Text("Thank you for taking the time to provide feedback. Your input helps us improve our services."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _confirmSubmission();
              },
              child: Text("Submit"),
            ),
          ],
        ),
      );
    }
  }

  void _saveDraft() {
    ss("Feedback saved as draft");
  }

  void _confirmSubmission() {
    ss("Thank you! Your feedback has been submitted successfully");
    back();
  }
}
