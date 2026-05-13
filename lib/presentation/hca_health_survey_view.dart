import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHealthSurveyView extends StatefulWidget {
  const HcaHealthSurveyView({super.key});

  @override
  State<HcaHealthSurveyView> createState() => _HcaHealthSurveyViewState();
}

class _HcaHealthSurveyViewState extends State<HcaHealthSurveyView> {
  int currentStep = 0;
  bool surveyCompleted = false;
  
  // Survey responses
  Map<String, dynamic> surveyData = {
    "personalInfo": {},
    "healthStatus": {},
    "lifestyle": {},
    "mentalHealth": {},
    "preferences": {},
  };

  List<Map<String, dynamic>> surveySteps = [
    {
      "title": "Personal Information",
      "subtitle": "Basic demographic information",
      "icon": Icons.person,
      "progress": 0.2,
    },
    {
      "title": "Health Status",
      "subtitle": "Current health conditions and medications",
      "icon": Icons.medical_services,
      "progress": 0.4,
    },
    {
      "title": "Lifestyle",
      "subtitle": "Diet, exercise, and daily habits",
      "icon": Icons.fitness_center,
      "progress": 0.6,
    },
    {
      "title": "Mental Health",
      "subtitle": "Stress levels and emotional wellbeing",
      "icon": Icons.psychology,
      "progress": 0.8,
    },
    {
      "title": "Preferences",
      "subtitle": "Health goals and communication preferences",
      "icon": Icons.settings,
      "progress": 1.0,
    },
  ];

  // Form fields
  String age = "";
  String gender = "";
  String height = "";
  String weight = "";
  String bloodType = "";
  String occupation = "";
  String education = "";
  String maritalStatus = "";
  
  List<String> selectedConditions = [];
  List<String> selectedMedications = [];
  String allergyInfo = "";
  String emergencyContact = "";
  
  String exerciseFrequency = "";
  String dietType = "";
  String sleepHours = "";
  String smokingStatus = "";
  String alcoholConsumption = "";
  String waterIntake = "";
  
  String stressLevel = "";
  String moodRating = "";
  String anxietyLevel = "";
  String socialSupport = "";
  
  List<String> healthGoals = [];
  String communicationPreference = "";
  String dataSharing = "";
  String reminderFrequency = "";

  List<Map<String, dynamic>> conditionOptions = [
    {"label": "Diabetes", "value": "diabetes"},
    {"label": "Hypertension", "value": "hypertension"},
    {"label": "Heart Disease", "value": "heart_disease"},
    {"label": "Asthma", "value": "asthma"},
    {"label": "Arthritis", "value": "arthritis"},
    {"label": "Depression", "value": "depression"},
    {"label": "Anxiety", "value": "anxiety"},
    {"label": "None", "value": "none"},
  ];

  List<Map<String, dynamic>> goalOptions = [
    {"label": "Weight Management", "value": "weight_management"},
    {"label": "Better Sleep", "value": "better_sleep"},
    {"label": "Stress Reduction", "value": "stress_reduction"},
    {"label": "Regular Exercise", "value": "regular_exercise"},
    {"label": "Healthy Eating", "value": "healthy_eating"},
    {"label": "Medication Adherence", "value": "medication_adherence"},
    {"label": "Preventive Care", "value": "preventive_care"},
  ];

  @override
  Widget build(BuildContext context) {
    if (surveyCompleted) {
      return _buildCompletionView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Health Survey"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDraft,
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      surveySteps[currentStep]["icon"],
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${surveySteps[currentStep]["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${surveySteps[currentStep]["subtitle"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Step ${currentStep + 1} of ${surveySteps.length}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Progress Bar
                LinearProgressIndicator(
                  value: surveySteps[currentStep]["progress"],
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),
          
          // Survey Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildCurrentStep(),
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
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentStep > 0)
                  SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: currentStep == surveySteps.length - 1 ? "Complete Survey" : "Next",
                    size: bs.md,
                    onPressed: _nextStep,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildHealthStatusStep();
      case 2:
        return _buildLifestyleStep();
      case 3:
        return _buildMentalHealthStep();
      case 4:
        return _buildPreferencesStep();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "This information helps us provide personalized health recommendations. All data is kept confidential and secure.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
        
        QNumberField(
          label: "Age",
          value: age,
          onChanged: (value) {
            age = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Gender",
          items: [
            {"label": "Male", "value": "male"},
            {"label": "Female", "value": "female"},
            {"label": "Non-binary", "value": "non_binary"},
            {"label": "Prefer not to say", "value": "prefer_not_to_say"},
          ],
          value: gender,
          onChanged: (value, label) {
            gender = value;
            setState(() {});
          },
        ),
        
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Height (cm)",
                value: height,
                onChanged: (value) {
                  height = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QNumberField(
                label: "Weight (kg)",
                value: weight,
                onChanged: (value) {
                  weight = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        QDropdownField(
          label: "Blood Type",
          items: [
            {"label": "A+", "value": "a_positive"},
            {"label": "A-", "value": "a_negative"},
            {"label": "B+", "value": "b_positive"},
            {"label": "B-", "value": "b_negative"},
            {"label": "AB+", "value": "ab_positive"},
            {"label": "AB-", "value": "ab_negative"},
            {"label": "O+", "value": "o_positive"},
            {"label": "O-", "value": "o_negative"},
            {"label": "Unknown", "value": "unknown"},
          ],
          value: bloodType,
          onChanged: (value, label) {
            bloodType = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Occupation",
          value: occupation,
          onChanged: (value) {
            occupation = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Education Level",
          items: [
            {"label": "High School", "value": "high_school"},
            {"label": "Some College", "value": "some_college"},
            {"label": "Bachelor's Degree", "value": "bachelors"},
            {"label": "Master's Degree", "value": "masters"},
            {"label": "Doctorate", "value": "doctorate"},
            {"label": "Other", "value": "other"},
          ],
          value: education,
          onChanged: (value, label) {
            education = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Marital Status",
          items: [
            {"label": "Single", "value": "single"},
            {"label": "Married", "value": "married"},
            {"label": "Divorced", "value": "divorced"},
            {"label": "Widowed", "value": "widowed"},
            {"label": "Prefer not to say", "value": "prefer_not_to_say"},
          ],
          value: maritalStatus,
          onChanged: (value, label) {
            maritalStatus = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildHealthStatusStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Health Status",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Please share information about your current health conditions and medications.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
        
        Text(
          "Current Health Conditions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QSwitch(
          items: conditionOptions,
          value: selectedConditions.map((condition) => {
            "label": conditionOptions.firstWhere((opt) => opt["value"] == condition)["label"],
            "value": condition,
            "checked": true,
          }).toList(),
          onChanged: (values, ids) {
            selectedConditions = values.map((v) => v["value"] as String).toList();
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Current Medications",
          value: selectedMedications.join(", "),
          hint: "List all medications you are currently taking",
          onChanged: (value) {
            selectedMedications = value.split(",").map((s) => s.trim()).toList();
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Allergies & Intolerances",
          value: allergyInfo,
          hint: "Food allergies, drug allergies, environmental allergies",
          onChanged: (value) {
            allergyInfo = value;
            setState(() {});
          },
        ),
        
        QTextField(
          label: "Emergency Contact",
          value: emergencyContact,
          hint: "Name and phone number",
          onChanged: (value) {
            emergencyContact = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildLifestyleStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Lifestyle",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Your daily habits and lifestyle choices help us provide better health recommendations.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
        
        QDropdownField(
          label: "Exercise Frequency",
          items: [
            {"label": "Never", "value": "never"},
            {"label": "1-2 times per week", "value": "1_2_times"},
            {"label": "3-4 times per week", "value": "3_4_times"},
            {"label": "5+ times per week", "value": "5_plus_times"},
            {"label": "Daily", "value": "daily"},
          ],
          value: exerciseFrequency,
          onChanged: (value, label) {
            exerciseFrequency = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Diet Type",
          items: [
            {"label": "Omnivore", "value": "omnivore"},
            {"label": "Vegetarian", "value": "vegetarian"},
            {"label": "Vegan", "value": "vegan"},
            {"label": "Keto", "value": "keto"},
            {"label": "Mediterranean", "value": "mediterranean"},
            {"label": "Other", "value": "other"},
          ],
          value: dietType,
          onChanged: (value, label) {
            dietType = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Average Sleep Hours",
          items: [
            {"label": "Less than 5 hours", "value": "less_5"},
            {"label": "5-6 hours", "value": "5_6"},
            {"label": "7-8 hours", "value": "7_8"},
            {"label": "9+ hours", "value": "9_plus"},
          ],
          value: sleepHours,
          onChanged: (value, label) {
            sleepHours = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Smoking Status",
          items: [
            {"label": "Never smoked", "value": "never"},
            {"label": "Former smoker", "value": "former"},
            {"label": "Current smoker", "value": "current"},
            {"label": "Occasional smoker", "value": "occasional"},
          ],
          value: smokingStatus,
          onChanged: (value, label) {
            smokingStatus = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Alcohol Consumption",
          items: [
            {"label": "Never", "value": "never"},
            {"label": "Rarely", "value": "rarely"},
            {"label": "1-2 drinks per week", "value": "1_2_weekly"},
            {"label": "3-5 drinks per week", "value": "3_5_weekly"},
            {"label": "Daily", "value": "daily"},
          ],
          value: alcoholConsumption,
          onChanged: (value, label) {
            alcoholConsumption = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Daily Water Intake",
          items: [
            {"label": "Less than 4 glasses", "value": "less_4"},
            {"label": "4-6 glasses", "value": "4_6"},
            {"label": "7-8 glasses", "value": "7_8"},
            {"label": "More than 8 glasses", "value": "more_8"},
          ],
          value: waterIntake,
          onChanged: (value, label) {
            waterIntake = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildMentalHealthStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Mental Health & Wellbeing",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Understanding your mental health helps us provide comprehensive care recommendations.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
        
        QDropdownField(
          label: "Current Stress Level",
          items: [
            {"label": "Very Low", "value": "very_low"},
            {"label": "Low", "value": "low"},
            {"label": "Moderate", "value": "moderate"},
            {"label": "High", "value": "high"},
            {"label": "Very High", "value": "very_high"},
          ],
          value: stressLevel,
          onChanged: (value, label) {
            stressLevel = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Overall Mood (Past 2 Weeks)",
          items: [
            {"label": "Excellent", "value": "excellent"},
            {"label": "Good", "value": "good"},
            {"label": "Fair", "value": "fair"},
            {"label": "Poor", "value": "poor"},
            {"label": "Very Poor", "value": "very_poor"},
          ],
          value: moodRating,
          onChanged: (value, label) {
            moodRating = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Anxiety Level",
          items: [
            {"label": "Never anxious", "value": "never"},
            {"label": "Occasionally anxious", "value": "occasionally"},
            {"label": "Sometimes anxious", "value": "sometimes"},
            {"label": "Often anxious", "value": "often"},
            {"label": "Always anxious", "value": "always"},
          ],
          value: anxietyLevel,
          onChanged: (value, label) {
            anxietyLevel = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Social Support",
          items: [
            {"label": "Strong support network", "value": "strong"},
            {"label": "Moderate support", "value": "moderate"},
            {"label": "Limited support", "value": "limited"},
            {"label": "No support", "value": "none"},
          ],
          value: socialSupport,
          onChanged: (value, label) {
            socialSupport = value;
            setState(() {});
          },
        ),
        
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "If you're experiencing severe mental health symptoms, please contact a healthcare professional immediately.",
                  style: TextStyle(
                    fontSize: 13,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
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
          "Health Goals & Preferences",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        Text(
          "Let us know your health goals and how you'd like to receive health information and reminders.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.4,
          ),
        ),
        
        Text(
          "Health Goals (Select all that apply)",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QSwitch(
          items: goalOptions,
          value: healthGoals.map((goal) => {
            "label": goalOptions.firstWhere((opt) => opt["value"] == goal)["label"],
            "value": goal,
            "checked": true,
          }).toList(),
          onChanged: (values, ids) {
            healthGoals = values.map((v) => v["value"] as String).toList();
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Preferred Communication Method",
          items: [
            {"label": "In-app notifications", "value": "app_notifications"},
            {"label": "Email", "value": "email"},
            {"label": "SMS", "value": "sms"},
            {"label": "Phone calls", "value": "phone"},
            {"label": "No communication", "value": "none"},
          ],
          value: communicationPreference,
          onChanged: (value, label) {
            communicationPreference = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Health Data Sharing",
          items: [
            {"label": "Share with healthcare providers", "value": "healthcare_providers"},
            {"label": "Share for research purposes", "value": "research"},
            {"label": "Share with family/caregivers", "value": "family"},
            {"label": "Keep private", "value": "private"},
          ],
          value: dataSharing,
          onChanged: (value, label) {
            dataSharing = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Reminder Frequency",
          items: [
            {"label": "Daily", "value": "daily"},
            {"label": "Weekly", "value": "weekly"},
            {"label": "Monthly", "value": "monthly"},
            {"label": "As needed", "value": "as_needed"},
            {"label": "No reminders", "value": "none"},
          ],
          value: reminderFrequency,
          onChanged: (value, label) {
            reminderFrequency = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildCompletionView() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(spXl),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 80,
                color: successColor,
              ),
            ),
            
            SizedBox(height: spXl),
            
            Text(
              "Survey Completed!",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Text(
              "Thank you for completing your health survey. Your responses will help us provide personalized health recommendations and improve our services.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            
            SizedBox(height: spXl),
            
            Container(
              width: double.infinity,
              child: QButton(
                label: "View My Health Profile",
                size: bs.md,
                onPressed: () {
                  // Navigate to health profile
                },
              ),
            ),
            
            SizedBox(height: spMd),
            
            Container(
              width: double.infinity,
              child: QButton(
                label: "Back to Dashboard",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  // Navigate to dashboard
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextStep() {
    if (currentStep < surveySteps.length - 1) {
      _saveCurrentStep();
      currentStep++;
      setState(() {});
    } else {
      _completeSurvey();
    }
  }

  void _saveCurrentStep() {
    // Save current step data
    switch (currentStep) {
      case 0:
        surveyData["personalInfo"] = {
          "age": age,
          "gender": gender,
          "height": height,
          "weight": weight,
          "bloodType": bloodType,
          "occupation": occupation,
          "education": education,
          "maritalStatus": maritalStatus,
        };
        break;
      case 1:
        surveyData["healthStatus"] = {
          "conditions": selectedConditions,
          "medications": selectedMedications,
          "allergies": allergyInfo,
          "emergencyContact": emergencyContact,
        };
        break;
      case 2:
        surveyData["lifestyle"] = {
          "exerciseFrequency": exerciseFrequency,
          "dietType": dietType,
          "sleepHours": sleepHours,
          "smokingStatus": smokingStatus,
          "alcoholConsumption": alcoholConsumption,
          "waterIntake": waterIntake,
        };
        break;
      case 3:
        surveyData["mentalHealth"] = {
          "stressLevel": stressLevel,
          "moodRating": moodRating,
          "anxietyLevel": anxietyLevel,
          "socialSupport": socialSupport,
        };
        break;
      case 4:
        surveyData["preferences"] = {
          "healthGoals": healthGoals,
          "communicationPreference": communicationPreference,
          "dataSharing": dataSharing,
          "reminderFrequency": reminderFrequency,
        };
        break;
    }
  }

  void _completeSurvey() {
    _saveCurrentStep();
    surveyCompleted = true;
    setState(() {});
    ss("Health survey completed successfully!");
  }

  void _saveDraft() {
    _saveCurrentStep();
    ss("Survey draft saved!");
  }
}
