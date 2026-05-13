import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRegister8View extends StatefulWidget {
  @override
  State<GrlRegister8View> createState() => _GrlRegister8ViewState();
}

class _GrlRegister8ViewState extends State<GrlRegister8View> {
  final formKey = GlobalKey<FormState>();
  
  String freelancerName = "";
  String freelancerEmail = "";
  String profession = "";
  String specialization = "";
  String experienceLevel = "";
  String hourlyRate = "";
  String bio = "";
  String portfolio = "";
  String profileImage = "";
  List<String> skills = [];
  List<String> certifications = [];
  List<String> portfolioImages = [];
  String availability = "";
  String timezone = "";
  String preferredProjectType = "";
  bool remoteWork = false;
  bool fullTimeAvailable = false;
  bool partTimeAvailable = false;
  bool isLoading = false;

  List<Map<String, dynamic>> professions = [
    {"label": "Web Developer", "value": "web_developer"},
    {"label": "Mobile App Developer", "value": "mobile_developer"},
    {"label": "UI/UX Designer", "value": "ui_designer"},
    {"label": "Graphic Designer", "value": "graphic_designer"},
    {"label": "Content Writer", "value": "content_writer"},
    {"label": "Digital Marketer", "value": "digital_marketer"},
    {"label": "Video Editor", "value": "video_editor"},
    {"label": "Photographer", "value": "photographer"},
    {"label": "Consultant", "value": "consultant"},
    {"label": "Virtual Assistant", "value": "virtual_assistant"},
    {"label": "Translator", "value": "translator"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Beginner (0-1 years)", "value": "beginner"},
    {"label": "Intermediate (2-4 years)", "value": "intermediate"},
    {"label": "Advanced (5-9 years)", "value": "advanced"},
    {"label": "Expert (10+ years)", "value": "expert"},
  ];

  List<Map<String, dynamic>> availabilityOptions = [
    {"label": "Full-time (40+ hours/week)", "value": "fulltime"},
    {"label": "Part-time (20-39 hours/week)", "value": "parttime"},
    {"label": "Project-based", "value": "project"},
    {"label": "As needed", "value": "as_needed"},
  ];

  List<Map<String, dynamic>> projectTypes = [
    {"label": "Short-term projects (1-4 weeks)", "value": "short_term"},
    {"label": "Medium-term projects (1-3 months)", "value": "medium_term"},
    {"label": "Long-term projects (3+ months)", "value": "long_term"},
    {"label": "Ongoing contracts", "value": "ongoing"},
  ];

  List<Map<String, dynamic>> skillCategories = [
    {"label": "JavaScript", "value": "javascript", "checked": false},
    {"label": "Python", "value": "python", "checked": false},
    {"label": "React", "value": "react", "checked": false},
    {"label": "Node.js", "value": "nodejs", "checked": false},
    {"label": "Adobe Photoshop", "value": "photoshop", "checked": false},
    {"label": "Adobe Illustrator", "value": "illustrator", "checked": false},
    {"label": "Figma", "value": "figma", "checked": false},
    {"label": "WordPress", "value": "wordpress", "checked": false},
    {"label": "SEO", "value": "seo", "checked": false},
    {"label": "Social Media Marketing", "value": "social_media", "checked": false},
    {"label": "Content Writing", "value": "content_writing", "checked": false},
    {"label": "Video Editing", "value": "video_editing", "checked": false},
  ];

  Future<void> _submitFreelancerRegistration() async {
    if (!formKey.currentState!.validate()) return;
    
    if (skills.isEmpty) {
      se("Please select at least one skill");
      return;
    }
    
    isLoading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    isLoading = false;
    setState(() {});
    
    ss("Freelancer profile created successfully! You can now start bidding on projects.");
    //navigateTo('GrlFreelancerDashboardView')
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: spMd),
              Text(
                "Creating your freelancer profile...",
                style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Setting up your professional profile",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Freelancer Registration"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.work_outline,
                      size: 64,
                      color: primaryColor,
                    ),
                    Text(
                      "Join as a Freelancer",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Create your professional freelancer profile and start connecting with clients worldwide. Showcase your skills and grow your business.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QImagePicker(
                      label: "Profile Picture",
                      value: profileImage,
                      hint: "Upload a professional profile photo",
                      validator: Validator.required,
                      onChanged: (value) {
                        profileImage = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Full Name",
                      value: freelancerName,
                      hint: "Enter your full name",
                      validator: Validator.required,
                      onChanged: (value) {
                        freelancerName = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Professional Email",
                      value: freelancerEmail,
                      hint: "Enter your professional email",
                      validator: Validator.email,
                      onChanged: (value) {
                        freelancerEmail = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Professional Information
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.work, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Professional Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Profession",
                            items: professions,
                            value: profession,
                            onChanged: (value, label) {
                              profession = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Experience Level",
                            items: experienceLevels,
                            value: experienceLevel,
                            onChanged: (value, label) {
                              experienceLevel = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Specialization",
                      value: specialization,
                      hint: "e.g., React Development, Logo Design, SEO Optimization",
                      validator: Validator.required,
                      onChanged: (value) {
                        specialization = value;
                        setState(() {});
                      },
                    ),
                    
                    QNumberField(
                      label: "Hourly Rate (USD)",
                      value: hourlyRate,
                      hint: "e.g., 25",
                      validator: Validator.required,
                      onChanged: (value) {
                        hourlyRate = value;
                        setState(() {});
                      },
                    ),
                    
                    QMemoField(
                      label: "Professional Bio",
                      value: bio,
                      hint: "Describe your experience, expertise, and what makes you unique...",
                      validator: Validator.required,
                      onChanged: (value) {
                        bio = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Skills and Expertise
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Skills and Expertise",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "Select your skills to help clients find you for relevant projects",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    QSwitch(
                      items: skillCategories,
                      value: skillCategories.where((item) => item["checked"] == true).toList(),
                      onChanged: (values, ids) {
                        skills = values.map((item) => item["value"].toString()).toList();
                        for (var skill in skillCategories) {
                          skill["checked"] = values.any((v) => v["value"] == skill["value"]);
                        }
                        setState(() {});
                      },
                    ),

                    if (skills.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(40)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 16),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Great! You've selected ${skills.length} skill${skills.length > 1 ? 's' : ''}. This will help clients find you for relevant projects.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Portfolio
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.folder, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Portfolio",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Portfolio Website (Optional)",
                      value: portfolio,
                      hint: "https://www.yourportfolio.com",
                      onChanged: (value) {
                        portfolio = value;
                        setState(() {});
                      },
                    ),
                    
                    QMultiImagePicker(
                      label: "Portfolio Images",
                      value: portfolioImages,
                      hint: "Upload your best work samples",
                      onChanged: (value) {
                        portfolioImages = value;
                        setState(() {});
                      },
                    ),
                    
                    QMultiImagePicker(
                      label: "Certifications",
                      value: certifications,
                      hint: "Upload any relevant certifications",
                      onChanged: (value) {
                        certifications = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Availability & Work Preferences
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, color: primaryColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "Availability & Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Availability",
                            items: availabilityOptions,
                            value: availability,
                            onChanged: (value, label) {
                              availability = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Preferred Project Type",
                            items: projectTypes,
                            value: preferredProjectType,
                            onChanged: (value, label) {
                              preferredProjectType = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QTextField(
                      label: "Timezone",
                      value: timezone,
                      hint: "e.g., PST, EST, GMT+7",
                      validator: Validator.required,
                      onChanged: (value) {
                        timezone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Work Preferences
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spMd,
                  children: [
                    QSwitch(
                      items: [
                        {
                          "label": "I'm available for remote work",
                          "value": true,
                          "checked": remoteWork,
                        }
                      ],
                      value: [if (remoteWork) {"label": "I'm available for remote work", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        remoteWork = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "I'm available for full-time projects",
                          "value": true,
                          "checked": fullTimeAvailable,
                        }
                      ],
                      value: [if (fullTimeAvailable) {"label": "I'm available for full-time projects", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        fullTimeAvailable = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    
                    QSwitch(
                      items: [
                        {
                          "label": "I'm available for part-time projects",
                          "value": true,
                          "checked": partTimeAvailable,
                        }
                      ],
                      value: [if (partTimeAvailable) {"label": "I'm available for part-time projects", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        partTimeAvailable = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Freelancer Benefits
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Freelancer Benefits",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Professional profile with verified badge",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Access to exclusive client projects",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Secure payment processing and protection",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Project management and collaboration tools",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Analytics and earnings tracking",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Profile Review Notice
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(40)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Profile Review",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your freelancer profile will be reviewed for quality and completeness. You can start applying to projects immediately after creation.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Freelancer Profile",
                  size: bs.md,
                  onPressed: _submitFreelancerRegistration,
                ),
              ),

              // Support Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(40)),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.support_agent, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Freelancer Support",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Need help setting up your profile or have questions about freelancing? Contact our freelancer support team at freelancers@company.com",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
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
