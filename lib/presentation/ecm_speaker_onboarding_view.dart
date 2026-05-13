import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSpeakerOnboardingView extends StatefulWidget {
  const EcmSpeakerOnboardingView({super.key});

  @override
  State<EcmSpeakerOnboardingView> createState() => _EcmSpeakerOnboardingViewState();
}

class _EcmSpeakerOnboardingViewState extends State<EcmSpeakerOnboardingView> {
  final formKey = GlobalKey<FormState>();
  
  // Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String profilePicture = "";
  String bio = "";
  
  // Professional Information
  String jobTitle = "";
  String company = "";
  String website = "";
  String linkedinUrl = "";
  String twitterUrl = "";
  
  // Speaking Experience
  String speakingExperience = "Beginner";
  List<String> expertiseAreas = [];
  List<String> preferredTopics = [];
  String previousSpeakingEvents = "";
  
  // Preferences
  String sessionFormat = "";
  String audienceSize = "";
  String speakingFee = "0";
  bool availableForMedia = false;
  bool willingToTravel = false;
  String travelRadius = "";
  
  // Requirements
  List<String> equipmentNeeds = [];
  String dietaryRestrictions = "";
  String accessibilityNeeds = "";
  String additionalRequirements = "";
  
  // Documents
  List<String> speakerReel = [];
  List<String> presentations = [];
  List<String> testimonials = [];
  String resumeCV = "";
  
  // Agreement
  bool agreedToTerms = false;
  bool agreedToCodeOfConduct = false;
  bool allowDataProcessing = false;
  
  int currentStep = 0;
  int totalSteps = 6;
  
  List<Map<String, dynamic>> experienceLevels = [
    {"label": "Beginner (0-2 years)", "value": "Beginner"},
    {"label": "Intermediate (3-5 years)", "value": "Intermediate"},
    {"label": "Advanced (5-10 years)", "value": "Advanced"},
    {"label": "Expert (10+ years)", "value": "Expert"},
  ];
  
  List<Map<String, dynamic>> sessionFormats = [
    {"label": "Keynote Presentation", "value": "keynote"},
    {"label": "Workshop", "value": "workshop"},
    {"label": "Panel Discussion", "value": "panel"},
    {"label": "Lightning Talk", "value": "lightning"},
    {"label": "Fireside Chat", "value": "fireside"},
    {"label": "Demo/Product Showcase", "value": "demo"},
  ];
  
  List<Map<String, dynamic>> audienceSizes = [
    {"label": "Small (1-50)", "value": "small"},
    {"label": "Medium (51-200)", "value": "medium"},
    {"label": "Large (201-500)", "value": "large"},
    {"label": "Very Large (500+)", "value": "xlarge"},
  ];
  
  List<Map<String, dynamic>> availableExpertise = [
    {"label": "Technology & Innovation", "value": "technology"},
    {"label": "Business & Strategy", "value": "business"},
    {"label": "Leadership & Management", "value": "leadership"},
    {"label": "Marketing & Sales", "value": "marketing"},
    {"label": "Design & User Experience", "value": "design"},
    {"label": "Data & Analytics", "value": "data"},
    {"label": "Healthcare & Medicine", "value": "healthcare"},
    {"label": "Education & Training", "value": "education"},
    {"label": "Finance & Investment", "value": "finance"},
    {"label": "Sustainability & Environment", "value": "sustainability"},
  ];
  
  List<Map<String, dynamic>> equipmentOptions = [
    {"label": "Microphone", "value": "microphone"},
    {"label": "Projector/Screen", "value": "projector"},
    {"label": "Laptop/Computer", "value": "laptop"},
    {"label": "Clicker/Remote", "value": "clicker"},
    {"label": "Flip Chart", "value": "flipchart"},
    {"label": "Whiteboard", "value": "whiteboard"},
    {"label": "Audio System", "value": "audio"},
    {"label": "Recording Equipment", "value": "recording"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speaker Onboarding"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Center(
              child: Text(
                "Step ${currentStep + 1}/$totalSteps",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Progress Indicator
            Container(
              padding: EdgeInsets.all(spMd),
              child: LinearProgressIndicator(
                value: (currentStep + 1) / totalSteps,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
            
            // Step Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: _buildStepContent(),
              ),
            ),
            
            // Navigation Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: QButton(
                        label: "Previous",
                        size: bs.md,
                        color: disabledBoldColor,
                        onPressed: _previousStep,
                      ),
                    ),
                  if (currentStep > 0) SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: currentStep == totalSteps - 1 ? "Complete Onboarding" : "Next",
                      size: bs.md,
                      onPressed: _nextStep,
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
  
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInformationStep();
      case 1:
        return _buildProfessionalInformationStep();
      case 2:
        return _buildSpeakingExperienceStep();
      case 3:
        return _buildPreferencesStep();
      case 4:
        return _buildRequirementsStep();
      case 5:
        return _buildDocumentsAndAgreementStep();
      default:
        return Container();
    }
  }
  
  Widget _buildPersonalInformationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Let's start with your basic information to create your speaker profile.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        
        QImagePicker(
          label: "Profile Picture",
          value: profilePicture,
          hint: "Upload your professional headshot",
          onChanged: (value) {
            profilePicture = value;
            setState(() {});
          },
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
            SizedBox(width: spMd),
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
          value: phone,
          validator: Validator.required,
          onChanged: (value) {
            phone = value;
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Bio",
          value: bio,
          hint: "Write a brief professional bio (2-3 sentences)",
          validator: Validator.required,
          onChanged: (value) {
            bio = value;
            setState(() {});
          },
        ),
      ],
    );
  }
  
  Widget _buildProfessionalInformationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Professional Information",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Tell us about your professional background and online presence.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
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
        
        QTextField(
          label: "Company/Organization",
          value: company,
          validator: Validator.required,
          onChanged: (value) {
            company = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Website URL",
          value: website,
          hint: "https://yourwebsite.com",
          onChanged: (value) {
            website = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "LinkedIn Profile",
          value: linkedinUrl,
          hint: "https://linkedin.com/in/yourprofile",
          onChanged: (value) {
            linkedinUrl = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Twitter Handle",
          value: twitterUrl,
          hint: "@yourusername",
          onChanged: (value) {
            twitterUrl = value;
            setState(() {});
          },
        ),
      ],
    );
  }
  
  Widget _buildSpeakingExperienceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Speaking Experience",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Help us understand your speaking background and areas of expertise.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        
        QDropdownField(
          label: "Speaking Experience Level",
          items: experienceLevels,
          value: speakingExperience,
          onChanged: (value, label) {
            speakingExperience = value;
            setState(() {});
          },
        ),
        
        QCategoryPicker(
          label: "Areas of Expertise",
          items: availableExpertise,
          value: expertiseAreas.isNotEmpty ? expertiseAreas[0] : "",
          onChanged: (index, label, value, item) {
            if (!expertiseAreas.contains(value)) {
              expertiseAreas.add(value);
              setState(() {});
            }
          },
        ),
        
        if (expertiseAreas.isNotEmpty)
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selected Expertise Areas:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: expertiseAreas.map((area) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            availableExpertise.firstWhere((item) => item["value"] == area)["label"],
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              expertiseAreas.remove(area);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        
        QMemoField(
          label: "Previous Speaking Events",
          value: previousSpeakingEvents,
          hint: "List notable conferences, events, or presentations you've given",
          onChanged: (value) {
            previousSpeakingEvents = value;
            setState(() {});
          },
        ),
      ],
    );
  }
  
  Widget _buildPreferencesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Speaking Preferences",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Let us know your preferred speaking formats and requirements.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        
        QDropdownField(
          label: "Preferred Session Format",
          items: sessionFormats,
          value: sessionFormat,
          onChanged: (value, label) {
            sessionFormat = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Preferred Audience Size",
          items: audienceSizes,
          value: audienceSize,
          onChanged: (value, label) {
            audienceSize = value;
            setState(() {});
          },
        ),
        
        QNumberField(
          label: "Speaking Fee (USD)",
          value: speakingFee,
          hint: "Enter 0 for pro-bono speaking",
          onChanged: (value) {
            speakingFee = value;
            setState(() {});
          },
        ),
        
        QSwitch(
          label: "Available for Media Interviews",
          items: [
            {
              "label": "Available for interviews and media requests",
              "value": true,
              "checked": availableForMedia,
            }
          ],
          value: [if (availableForMedia) {"label": "Available for interviews and media requests", "value": true, "checked": true}],
          onChanged: (values, ids) {
            availableForMedia = values.isNotEmpty;
            setState(() {});
          },
        ),
        
        QSwitch(
          label: "Travel Preferences",
          items: [
            {
              "label": "Willing to travel for speaking engagements",
              "value": true,
              "checked": willingToTravel,
            }
          ],
          value: [if (willingToTravel) {"label": "Willing to travel for speaking engagements", "value": true, "checked": true}],
          onChanged: (values, ids) {
            willingToTravel = values.isNotEmpty;
            setState(() {});
          },
        ),
        
        if (willingToTravel)
          QTextField(
            label: "Travel Radius",
            value: travelRadius,
            hint: "e.g., Global, North America, Within 500 miles",
            onChanged: (value) {
              travelRadius = value;
              setState(() {});
            },
          ),
      ],
    );
  }
  
  Widget _buildRequirementsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Requirements & Accommodations",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Help us prepare for your speaking engagement by specifying your needs.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        
        Text(
          "Equipment Needs:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: fsH6,
          ),
        ),
        
        ...equipmentOptions.map((equipment) {
          bool isSelected = equipmentNeeds.contains(equipment["value"]);
          return GestureDetector(
            onTap: () {
              if (isSelected) {
                equipmentNeeds.remove(equipment["value"]);
              } else {
                equipmentNeeds.add(equipment["value"]);
              }
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                    color: isSelected ? primaryColor : disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${equipment["label"]}",
                    style: TextStyle(
                      color: isSelected ? primaryColor : Colors.black,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        
        QMemoField(
          label: "Dietary Restrictions",
          value: dietaryRestrictions,
          hint: "Any food allergies or dietary requirements",
          onChanged: (value) {
            dietaryRestrictions = value;
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Accessibility Needs",
          value: accessibilityNeeds,
          hint: "Any accessibility accommodations needed",
          onChanged: (value) {
            accessibilityNeeds = value;
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Additional Requirements",
          value: additionalRequirements,
          hint: "Any other special requirements or requests",
          onChanged: (value) {
            additionalRequirements = value;
            setState(() {});
          },
        ),
      ],
    );
  }
  
  Widget _buildDocumentsAndAgreementStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Documents & Agreement",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Upload supporting documents and agree to our terms to complete your onboarding.",
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 16,
          ),
        ),
        
        QMultiImagePicker(
          label: "Speaker Reel/Portfolio",
          value: speakerReel,
          hint: "Upload videos, photos, or presentation slides",
          onChanged: (value) {
            speakerReel = value;
            setState(() {});
          },
        ),
        
        QAttachmentPicker(
          label: "Sample Presentations",
          value: presentations,
          hint: "Upload sample slides or presentation materials",
          onChanged: (value) {
            presentations = value;
            setState(() {});
          },
        ),
        
        QAttachmentPicker(
          label: "Testimonials",
          value: testimonials,
          hint: "Letters of recommendation or testimonials",
          onChanged: (value) {
            testimonials = value;
            setState(() {});
          },
        ),
        
        QImagePicker(
          label: "Resume/CV",
          value: resumeCV,
          hint: "Upload your current resume or CV",
          onChanged: (value) {
            resumeCV = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Legal Agreements",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fsH6,
                ),
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "I agree to the Terms and Conditions",
                    "value": true,
                    "checked": agreedToTerms,
                  }
                ],
                value: [if (agreedToTerms) {"label": "I agree to the Terms and Conditions", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  agreedToTerms = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "I agree to the Speaker Code of Conduct",
                    "value": true,
                    "checked": agreedToCodeOfConduct,
                  }
                ],
                value: [if (agreedToCodeOfConduct) {"label": "I agree to the Speaker Code of Conduct", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  agreedToCodeOfConduct = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "I consent to data processing for speaker management",
                    "value": true,
                    "checked": allowDataProcessing,
                  }
                ],
                value: [if (allowDataProcessing) {"label": "I consent to data processing for speaker management", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  allowDataProcessing = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        if (!agreedToTerms || !agreedToCodeOfConduct || !allowDataProcessing)
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Please agree to all terms to complete your onboarding.",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
  
  void _nextStep() {
    if (currentStep < totalSteps - 1) {
      if (_validateCurrentStep()) {
        currentStep++;
        setState(() {});
      }
    } else {
      _completeOnboarding();
    }
  }
  
  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }
  
  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && bio.isNotEmpty;
      case 1:
        return jobTitle.isNotEmpty && company.isNotEmpty;
      case 2:
        return speakingExperience.isNotEmpty && expertiseAreas.isNotEmpty;
      case 3:
        return sessionFormat.isNotEmpty && audienceSize.isNotEmpty;
      case 4:
        return true; // Requirements are optional
      case 5:
        return agreedToTerms && agreedToCodeOfConduct && allowDataProcessing;
      default:
        return true;
    }
  }
  
  void _completeOnboarding() {
    if (!_validateCurrentStep()) {
      se("Please complete all required fields and agreements");
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Onboarding Complete!",
          style: TextStyle(
            color: successColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Congratulations! Your speaker profile has been created successfully."),
            SizedBox(height: spSm),
            Text(
              "What happens next:",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: spXs),
            Text("• Your profile will be reviewed by our team"),
            Text("• You'll receive a confirmation email within 24 hours"),
            Text("• Event organizers can now discover and book you"),
            Text("• You'll get access to the speaker dashboard"),
          ],
        ),
        actions: [
          QButton(
            label: "Continue to Dashboard",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              ss("Welcome to the speaker community!");
              // Navigate to speaker dashboard
            },
          ),
        ],
      ),
    );
  }
}
