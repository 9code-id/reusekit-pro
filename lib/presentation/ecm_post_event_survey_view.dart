import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmPostEventSurveyView extends StatefulWidget {
  const EcmPostEventSurveyView({super.key});

  @override
  State<EcmPostEventSurveyView> createState() => _EcmPostEventSurveyViewState();
}

class _EcmPostEventSurveyViewState extends State<EcmPostEventSurveyView> {
  final formKey = GlobalKey<FormState>();
  
  // Survey responses
  String overallRating = "5";
  String contentQuality = "5";
  String speakerRating = "5";
  String venueRating = "5";
  String organizationRating = "5";
  String mostValuableSession = "";
  String improvements = "";
  String additionalComments = "";
  String recommendationLikelihood = "10";
  bool wouldAttendAgain = true;
  bool interestedInFutureEvents = true;
  List<String> favoriteTopics = [];
  List<String> suggestedTopics = [];
  String networkingValue = "5";
  String learningObjectivesMet = "5";
  
  List<Map<String, dynamic>> ratingOptions = [
    {"label": "1 - Poor", "value": "1"},
    {"label": "2 - Fair", "value": "2"},
    {"label": "3 - Good", "value": "3"},
    {"label": "4 - Very Good", "value": "4"},
    {"label": "5 - Excellent", "value": "5"},
  ];
  
  List<Map<String, dynamic>> npsOptions = List.generate(11, (index) => {
    "label": "$index",
    "value": "$index",
  });
  
  List<Map<String, dynamic>> topicOptions = [
    {"label": "Technology & Innovation", "value": "technology"},
    {"label": "Business Strategy", "value": "business"},
    {"label": "Marketing & Sales", "value": "marketing"},
    {"label": "Leadership & Management", "value": "leadership"},
    {"label": "Digital Transformation", "value": "digital"},
    {"label": "Sustainability", "value": "sustainability"},
    {"label": "Data Analytics", "value": "analytics"},
    {"label": "Artificial Intelligence", "value": "ai"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post-Event Survey"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: _submitSurvey,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Digital Marketing Summit 2024",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "December 15-17, 2024 • Grand Ballroom",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Overall experience section
              Text(
                "Overall Experience",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QDropdownField(
                label: "Overall Event Rating",
                items: ratingOptions,
                value: overallRating,
                validator: Validator.required,
                onChanged: (value, label) {
                  overallRating = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Content Quality",
                      items: ratingOptions,
                      value: contentQuality,
                      onChanged: (value, label) {
                        contentQuality = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Speaker Quality",
                      items: ratingOptions,
                      value: speakerRating,
                      onChanged: (value, label) {
                        speakerRating = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Venue Rating",
                      items: ratingOptions,
                      value: venueRating,
                      onChanged: (value, label) {
                        venueRating = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Organization",
                      items: ratingOptions,
                      value: organizationRating,
                      onChanged: (value, label) {
                        organizationRating = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              // Net Promoter Score
              Text(
                "Recommendation",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QDropdownField(
                label: "How likely are you to recommend this event? (0-10)",
                items: npsOptions,
                value: recommendationLikelihood,
                validator: Validator.required,
                onChanged: (value, label) {
                  recommendationLikelihood = value;
                  setState(() {});
                },
              ),
              
              // Future attendance
              QSwitch(
                items: [
                  {
                    "label": "Would attend future events",
                    "value": true,
                    "checked": wouldAttendAgain,
                  }
                ],
                value: wouldAttendAgain ? [{"label": "Would attend future events", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  wouldAttendAgain = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              QSwitch(
                items: [
                  {
                    "label": "Interested in similar events",
                    "value": true,
                    "checked": interestedInFutureEvents,
                  }
                ],
                value: interestedInFutureEvents ? [{"label": "Interested in similar events", "value": true, "checked": true}] : [],
                onChanged: (values, ids) {
                  interestedInFutureEvents = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              // Content feedback
              Text(
                "Content & Learning",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QTextField(
                label: "Most Valuable Session",
                value: mostValuableSession,
                hint: "Which session provided the most value?",
                onChanged: (value) {
                  mostValuableSession = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Learning Objectives Met",
                      items: ratingOptions,
                      value: learningObjectivesMet,
                      onChanged: (value, label) {
                        learningObjectivesMet = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Networking Value",
                      items: ratingOptions,
                      value: networkingValue,
                      onChanged: (value, label) {
                        networkingValue = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              // Topics feedback
              Text(
                "Topics & Content",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QCategoryPicker(
                label: "Favorite Topics (Select Multiple)",
                items: topicOptions,
                value: favoriteTopics.isNotEmpty ? favoriteTopics[0] : "",
                onChanged: (index, label, value, item) {
                  if (favoriteTopics.contains(value)) {
                    favoriteTopics.remove(value);
                  } else {
                    favoriteTopics.add(value);
                  }
                  setState(() {});
                },
              ),
              
              // Open feedback
              Text(
                "Additional Feedback",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              QMemoField(
                label: "Suggestions for Improvement",
                value: improvements,
                hint: "What could we improve for future events?",
                onChanged: (value) {
                  improvements = value;
                  setState(() {});
                },
              ),
              
              QMemoField(
                label: "Additional Comments",
                value: additionalComments,
                hint: "Any other feedback or comments?",
                onChanged: (value) {
                  additionalComments = value;
                  setState(() {});
                },
              ),
              
              // Submit button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Survey",
                  icon: Icons.send,
                  size: bs.md,
                  onPressed: _submitSurvey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _submitSurvey() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Survey submitted successfully! Thank you for your feedback.");
      back();
    }
  }
}
