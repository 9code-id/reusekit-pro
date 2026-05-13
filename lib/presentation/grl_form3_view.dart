import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForm3View extends StatefulWidget {
  @override
  State<GrlForm3View> createState() => _GrlForm3ViewState();
}

class _GrlForm3ViewState extends State<GrlForm3View> {
  final formKey = GlobalKey<FormState>();
  
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String company = "";
  String jobTitle = "";
  String businessType = "";
  String experience = "";
  String preferredContact = "";
  bool agreeToTerms = false;
  bool subscribeNewsletter = false;

  List<Map<String, dynamic>> businessTypes = [
    {"label": "Technology", "value": "technology"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Finance", "value": "finance"},
    {"label": "Education", "value": "education"},
    {"label": "Retail", "value": "retail"},
    {"label": "Manufacturing", "value": "manufacturing"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> experienceOptions = [
    {"label": "Less than 1 year", "value": "less_than_1"},
    {"label": "1-3 years", "value": "1_3_years"},
    {"label": "3-5 years", "value": "3_5_years"},
    {"label": "5-10 years", "value": "5_10_years"},
    {"label": "More than 10 years", "value": "more_than_10"},
  ];

  List<Map<String, dynamic>> contactMethods = [
    {"label": "Email", "value": "email"},
    {"label": "Phone", "value": "phone"},
    {"label": "SMS", "value": "sms"},
    {"label": "WhatsApp", "value": "whatsapp"},
  ];

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        se("Please agree to the terms and conditions");
        return;
      }

      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      ss("Business registration submitted successfully!");
      // Navigate or perform action
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Registration"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.business,
                      size: 48,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Join Our Business Network",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Register your business to access premium features and exclusive partnerships",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information Section
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "First Name",
                      value: firstName,
                      validator: Validator.required,
                      onChanged: (value) {
                        firstName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Last Name",
                      value: lastName,
                      validator: Validator.required,
                      onChanged: (value) {
                        lastName = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              QTextField(
                label: "Email Address",
                value: email,
                validator: Validator.email,
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Phone Number",
                value: phoneNumber,
                validator: Validator.required,
                onChanged: (value) {
                  phoneNumber = value;
                  setState(() {});
                },
              ),

              // Business Information Section
              Text(
                "Business Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Company Name",
                value: company,
                validator: Validator.required,
                onChanged: (value) {
                  company = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Job Title",
                value: jobTitle,
                validator: Validator.required,
                onChanged: (value) {
                  jobTitle = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Business Type",
                items: businessTypes,
                value: businessType,
                validator: Validator.required,
                onChanged: (value, label) {
                  businessType = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Years of Experience",
                items: experienceOptions,
                value: experience,
                validator: Validator.required,
                onChanged: (value, label) {
                  experience = value;
                  setState(() {});
                },
              ),

              // Contact Preferences Section
              Text(
                "Contact Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Preferred Contact Method",
                items: contactMethods,
                value: preferredContact,
                validator: Validator.required,
                onChanged: (value, label) {
                  preferredContact = value;
                  setState(() {});
                },
              ),

              // Agreement Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledColor),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QSwitch(
                      items: [
                        {
                          "label": "I agree to the Terms and Conditions",
                          "value": true,
                          "checked": agreeToTerms,
                        }
                      ],
                      value: [
                        if (agreeToTerms)
                          {
                            "label": "I agree to the Terms and Conditions",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          agreeToTerms = values.isNotEmpty;
                        });
                      },
                    ),

                    QSwitch(
                      items: [
                        {
                          "label": "Subscribe to newsletter and updates",
                          "value": true,
                          "checked": subscribeNewsletter,
                        }
                      ],
                      value: [
                        if (subscribeNewsletter)
                          {
                            "label": "Subscribe to newsletter and updates",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          subscribeNewsletter = values.isNotEmpty;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Registration",
                  size: bs.md,
                  onPressed: _submitForm,
                ),
              ),

              // Help Text
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Your information will be reviewed within 2-3 business days. You'll receive a confirmation email once approved.",
                        style: TextStyle(
                          color: infoColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
