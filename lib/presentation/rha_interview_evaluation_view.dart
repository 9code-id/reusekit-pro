import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaInterviewEvaluationView extends StatefulWidget {
  const RhaInterviewEvaluationView({super.key});

  @override
  State<RhaInterviewEvaluationView> createState() => _RhaInterviewEvaluationViewState();
}

class _RhaInterviewEvaluationViewState extends State<RhaInterviewEvaluationView> {
  final formKey = GlobalKey<FormState>();
  
  // Candidate Information
  String candidateName = "Sarah Wilson";
  String candidateEmail = "sarah.wilson@email.com";
  String position = "Senior Software Engineer";
  String interviewRound = "Technical Round 1";
  String interviewDate = "2024-06-20";
  String interviewer = "John Smith";
  
  // Evaluation Scores
  double technicalSkills = 4.0;
  double communication = 4.5;
  double problemSolving = 4.0;
  double cultureFit = 5.0;
  double experience = 4.0;
  double leadership = 3.5;
  
  // Feedback
  String overallFeedback = "";
  String strengths = "";
  String improvements = "";
  String recommendation = "proceed";
  String additionalNotes = "";
  
  bool isSubmitting = false;

  double get overallRating {
    return (technicalSkills + communication + problemSolving + cultureFit + experience + leadership) / 6;
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return successColor;
    if (rating >= 3.5) return primaryColor;
    if (rating >= 2.5) return warningColor;
    return dangerColor;
  }

  Widget _buildRatingSlider(
    String label,
    String description,
    double value,
    Function(double) onChanged,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getRatingColor(value).withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${value.toStringAsFixed(1)}/5.0",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getRatingColor(value),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: disabledColor.withAlpha(51),
              thumbColor: color,
              overlayColor: color.withAlpha(51),
              valueIndicatorColor: color,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Slider(
              value: value,
              min: 1,
              max: 5,
              divisions: 8,
              label: value.toStringAsFixed(1),
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Poor",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Average",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Excellent",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRatingCard() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Overall Rating",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getRatingColor(overallRating).withAlpha(51),
              border: Border.all(
                color: _getRatingColor(overallRating),
                width: 4,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${overallRating.toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: _getRatingColor(overallRating),
                    ),
                  ),
                  Text(
                    "out of 5.0",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            overallRating >= 4.5 ? "Excellent" :
            overallRating >= 3.5 ? "Good" :
            overallRating >= 2.5 ? "Average" : "Below Average",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _getRatingColor(overallRating),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateInfoCard() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/120/120?random=1&keyword=woman"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidateName,
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      candidateEmail,
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      position,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Divider(color: disabledOutlineBorderColor),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Interview Round",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      interviewRound,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Interview Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      interviewDate,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Interviewer",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                interviewer,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> recommendationOptions = [
    {"label": "Hire", "value": "hire"},
    {"label": "Proceed to Next Round", "value": "proceed"},
    {"label": "Reject", "value": "reject"},
    {"label": "Under Review", "value": "review"},
  ];

  void _submitEvaluation() async {
    if (!formKey.currentState!.validate()) return;
    
    isSubmitting = true;
    setState(() {});
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    isSubmitting = false;
    setState(() {});
    
    ss("Evaluation submitted successfully");
    // Navigate back or to next screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interview Evaluation"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_alt),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Candidate Information
              _buildCandidateInfoCard(),
              SizedBox(height: spLg),
              
              // Overall Rating Summary
              _buildOverallRatingCard(),
              SizedBox(height: spLg),
              
              // Individual Ratings
              Text(
                "Evaluation Criteria",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              _buildRatingSlider(
                "Technical Skills",
                "Knowledge of required technologies and ability to apply them",
                technicalSkills,
                (value) {
                  technicalSkills = value;
                  setState(() {});
                },
                primaryColor,
              ),
              SizedBox(height: spSm),
              
              _buildRatingSlider(
                "Communication",
                "Ability to express ideas clearly and listen effectively",
                communication,
                (value) {
                  communication = value;
                  setState(() {});
                },
                infoColor,
              ),
              SizedBox(height: spSm),
              
              _buildRatingSlider(
                "Problem Solving",
                "Analytical thinking and ability to solve complex problems",
                problemSolving,
                (value) {
                  problemSolving = value;
                  setState(() {});
                },
                successColor,
              ),
              SizedBox(height: spSm),
              
              _buildRatingSlider(
                "Culture Fit",
                "Alignment with company values and team dynamics",
                cultureFit,
                (value) {
                  cultureFit = value;
                  setState(() {});
                },
                warningColor,
              ),
              SizedBox(height: spSm),
              
              _buildRatingSlider(
                "Experience",
                "Relevant work experience and industry knowledge",
                experience,
                (value) {
                  experience = value;
                  setState(() {});
                },
                dangerColor,
              ),
              SizedBox(height: spSm),
              
              _buildRatingSlider(
                "Leadership",
                "Leadership potential and ability to guide others",
                leadership,
                (value) {
                  leadership = value;
                  setState(() {});
                },
                secondaryColor,
              ),
              SizedBox(height: spLg),
              
              // Detailed Feedback
              Text(
                "Detailed Feedback",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Overall Feedback",
                value: overallFeedback,
                hint: "Provide comprehensive feedback about the candidate's performance",
                validator: Validator.required,
                onChanged: (value) {
                  overallFeedback = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Key Strengths",
                value: strengths,
                hint: "List the candidate's main strengths and positive qualities",
                validator: Validator.required,
                onChanged: (value) {
                  strengths = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Areas for Improvement",
                value: improvements,
                hint: "Identify areas where the candidate could improve",
                onChanged: (value) {
                  improvements = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Recommendation",
                items: recommendationOptions,
                value: recommendation,
                validator: Validator.required,
                onChanged: (value, label) {
                  recommendation = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QMemoField(
                label: "Additional Notes",
                value: additionalNotes,
                hint: "Any additional observations or comments",
                onChanged: (value) {
                  additionalNotes = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),
              
              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: isSubmitting ? "Submitting..." : "Submit Evaluation",
                  onPressed: isSubmitting ? null : _submitEvaluation,
                ),
              ),
              SizedBox(height: spSm),
              
              // Draft Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save as Draft",
                  onPressed: () {
                    ss("Evaluation saved as draft");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
