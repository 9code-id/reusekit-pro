import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaApplicationReviewView extends StatefulWidget {
  const RhaApplicationReviewView({super.key});

  @override
  State<RhaApplicationReviewView> createState() => _RhaApplicationReviewViewState();
}

class _RhaApplicationReviewViewState extends State<RhaApplicationReviewView> {
  int currentTab = 0;
  String reviewStatus = "Pending";
  double overallScore = 0.0;
  String reviewNotes = "";
  String recommendation = "Pending";
  bool isReviewCompleted = false;
  
  // Review criteria scores
  Map<String, double> criteriaScores = {
    "Technical Skills": 0.0,
    "Experience": 0.0,
    "Communication": 0.0,
    "Cultural Fit": 0.0,
    "Problem Solving": 0.0,
    "Leadership": 0.0,
    "Education": 0.0,
    "Portfolio Quality": 0.0,
  };
  
  Map<String, String> criteriaComments = {
    "Technical Skills": "",
    "Experience": "",
    "Communication": "",
    "Cultural Fit": "",
    "Problem Solving": "",
    "Leadership": "",
    "Education": "",
    "Portfolio Quality": "",
  };

  final Map<String, dynamic> application = {
    "id": "APP001",
    "candidateName": "Sarah Johnson",
    "candidateEmail": "sarah.johnson@email.com",
    "candidatePhone": "+1-555-0123",
    "candidateAvatar": "https://picsum.photos/120/120?random=1&keyword=woman",
    "position": "Senior Flutter Developer",
    "department": "Engineering",
    "status": "Under Review",
    "priority": "High",
    "appliedDate": "2025-06-15",
    "experience": "5 years",
    "location": "New York, NY",
    "salary": 95000,
    "skills": ["Flutter", "Dart", "Firebase", "REST APIs", "Provider", "Riverpod", "Git", "Agile"],
    "matchPercentage": 92,
    "resumeUrl": "resume_sarah.pdf",
    "coverLetter": "I am excited to apply for the Senior Flutter Developer position...",
    "education": [
      {
        "degree": "Bachelor of Computer Science",
        "school": "Stanford University",
        "year": "2019",
        "gpa": "3.8"
      }
    ],
    "workHistory": [
      {
        "company": "TechCorp Inc.",
        "position": "Senior Mobile Developer",
        "duration": "2022 - Present",
        "description": "Lead mobile development team, architected scalable Flutter applications"
      },
      {
        "company": "StartupXYZ",
        "position": "Flutter Developer", 
        "duration": "2020 - 2022",
        "description": "Developed cross-platform mobile apps, implemented CI/CD pipelines"
      }
    ]
  };

  final List<Map<String, dynamic>> reviewers = [
    {
      "id": "REV001",
      "name": "John Smith",
      "role": "Senior Engineering Manager",
      "avatar": "https://picsum.photos/60/60?random=10&keyword=man",
      "status": "Completed",
      "score": 8.5,
      "reviewDate": "2025-06-18",
      "recommendation": "Hire",
      "notes": "Strong technical background and excellent communication skills. Candidate demonstrates deep understanding of Flutter framework and mobile development best practices.",
    },
    {
      "id": "REV002",
      "name": "Emily Davis",
      "role": "Technical Lead",
      "avatar": "https://picsum.photos/60/60?random=11&keyword=woman",
      "status": "Completed",
      "score": 8.2,
      "reviewDate": "2025-06-17",
      "recommendation": "Hire",
      "notes": "Impressive portfolio with real-world projects. Shows strong problem-solving abilities and attention to detail.",
    },
    {
      "id": "REV003",
      "name": "Mike Wilson", 
      "role": "HR Manager",
      "avatar": "https://picsum.photos/60/60?random=12&keyword=man",
      "status": "In Progress",
      "score": 0.0,
      "reviewDate": "",
      "recommendation": "Pending",
      "notes": "",
    },
    {
      "id": "REV004",
      "name": "Lisa Chen",
      "role": "Product Manager",
      "avatar": "https://picsum.photos/60/60?random=13&keyword=woman",
      "status": "Pending",
      "score": 0.0,
      "reviewDate": "",
      "recommendation": "Pending",
      "notes": "",
    }
  ];

  final List<Map<String, dynamic>> interviewFeedback = [
    {
      "id": "INT001",
      "type": "Phone Screening",
      "interviewer": "Emily Davis",
      "interviewerAvatar": "https://picsum.photos/50/50?random=11&keyword=woman",
      "date": "2025-06-17",
      "duration": "30 minutes",
      "status": "Completed",
      "score": 8.0,
      "feedback": "Candidate demonstrated strong technical knowledge and enthusiasm for the role. Good communication skills and asked thoughtful questions about the team and projects.",
      "strengths": ["Technical knowledge", "Communication", "Enthusiasm"],
      "concerns": ["None major"],
      "recommendation": "Proceed to technical interview",
    },
    {
      "id": "INT002",
      "type": "Technical Interview",
      "interviewer": "John Smith", 
      "interviewerAvatar": "https://picsum.photos/50/50?random=10&keyword=man",
      "date": "2025-06-18",
      "duration": "60 minutes", 
      "status": "Completed",
      "score": 8.5,
      "feedback": "Excellent technical performance. Candidate solved coding problems efficiently and explained their thought process clearly. Strong understanding of Flutter architecture and state management.",
      "strengths": ["Problem solving", "Code quality", "Architecture knowledge"],
      "concerns": ["Limited experience with testing"],
      "recommendation": "Strong hire",
    },
    {
      "id": "INT003",
      "type": "Behavioral Interview",
      "interviewer": "Mike Wilson",
      "interviewerAvatar": "https://picsum.photos/50/50?random=12&keyword=man",
      "date": "2025-06-19",
      "duration": "45 minutes",
      "status": "Scheduled",
      "score": 0.0,
      "feedback": "",
      "strengths": [],
      "concerns": [],
      "recommendation": "",
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Scheduled":
        return infoColor;
      case "Pending":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRecommendationColor(String recommendation) {
    switch (recommendation) {
      case "Hire":
      case "Strong hire":
        return successColor;
      case "No hire":
        return dangerColor;
      case "Proceed to technical interview":
        return infoColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  double get calculatedOverallScore {
    if (criteriaScores.values.every((score) => score == 0.0)) return 0.0;
    double total = criteriaScores.values.fold(0.0, (sum, score) => sum + score);
    return total / criteriaScores.length;
  }

  Widget _buildScoringTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall score summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Overall Assessment",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(reviewStatus).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        reviewStatus,
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(reviewStatus),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Score",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${calculatedOverallScore.toStringAsFixed(1)}/10",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: calculatedOverallScore >= 7.0 ? successColor : calculatedOverallScore >= 5.0 ? warningColor : dangerColor,
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
                            "Recommendation",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          QDropdownField(
                            label: "",
                            items: [
                              {"label": "Pending", "value": "Pending"},
                              {"label": "Strong Hire", "value": "Strong Hire"},
                              {"label": "Hire", "value": "Hire"},
                              {"label": "No Hire", "value": "No Hire"},
                              {"label": "Hold", "value": "Hold"},
                            ],
                            value: recommendation,
                            onChanged: (value, label) {
                              recommendation = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Scoring criteria
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Evaluation Criteria",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...criteriaScores.entries.map((entry) {
                  String criteria = entry.key;
                  double score = entry.value;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                criteria,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${score.toStringAsFixed(1)}/10",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: score >= 7.0 ? successColor : score >= 5.0 ? warningColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        // Score slider
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: primaryColor,
                            inactiveTrackColor: disabledColor,
                            thumbColor: primaryColor,
                            trackHeight: 4,
                          ),
                          child: Slider(
                            value: score,
                            min: 0.0,
                            max: 10.0,
                            divisions: 20,
                            onChanged: (value) {
                              criteriaScores[criteria] = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(height: spSm),
                        QMemoField(
                          label: "Comments for $criteria",
                          value: criteriaComments[criteria] ?? "",
                          onChanged: (value) {
                            criteriaComments[criteria] = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Overall review notes
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Review Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QMemoField(
                  label: "Overall review notes and summary",
                  value: reviewNotes,
                  onChanged: (value) {
                    reviewNotes = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save Review",
                        size: bs.sm,
                        onPressed: () {
                          reviewStatus = "Completed";
                          isReviewCompleted = true;
                          ss("Review saved successfully");
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Submit Final Review",
                        size: bs.sm,
                        onPressed: () {
                          if (calculatedOverallScore > 0 && recommendation != "Pending") {
                            _showSubmitConfirmation();
                          } else {
                            se("Please complete scoring and recommendation");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Review progress
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Review Progress",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Completed Reviews",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${reviewers.where((r) => r["status"] == "Completed").length}/${reviewers.length}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: successColor,
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
                            "Average Score",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${_calculateAverageScore().toStringAsFixed(1)}/10",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _calculateAverageScore() >= 7.0 ? successColor : _calculateAverageScore() >= 5.0 ? warningColor : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                // Progress bar
                LinearProgressIndicator(
                  value: reviewers.where((r) => r["status"] == "Completed").length / reviewers.length,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(successColor),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Reviewers list
          ...reviewers.map((reviewer) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
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
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${reviewer["avatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${reviewer["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${reviewer["role"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(reviewer["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${reviewer["status"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _getStatusColor(reviewer["status"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (reviewer["status"] == "Completed")
                                  Container(
                                    margin: EdgeInsets.only(left: spXs),
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getRecommendationColor(reviewer["recommendation"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${reviewer["recommendation"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: _getRecommendationColor(reviewer["recommendation"]),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (reviewer["status"] == "Completed")
                        Column(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            Text(
                              "${reviewer["score"]}/10",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  
                  if (reviewer["status"] == "Completed" && reviewer["notes"].toString().isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.notes, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Review Notes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${reviewer["reviewDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${reviewer["notes"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  if (reviewer["status"] == "Pending" || reviewer["status"] == "In Progress") ...[
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Send Reminder",
                            size: bs.sm,
                            onPressed: () {
                              si("Reminder sent to ${reviewer["name"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {
                            si("Message sent to ${reviewer["name"]}");
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInterviewsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Interview progress summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Interview Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: _buildInterviewStat(
                        "Completed",
                        "${interviewFeedback.where((i) => i["status"] == "Completed").length}",
                        successColor,
                      ),
                    ),
                    Expanded(
                      child: _buildInterviewStat(
                        "Scheduled",
                        "${interviewFeedback.where((i) => i["status"] == "Scheduled").length}",
                        infoColor,
                      ),
                    ),
                    Expanded(
                      child: _buildInterviewStat(
                        "Avg Score",
                        "${_calculateAverageInterviewScore().toStringAsFixed(1)}",
                        warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Interview feedback list
          ...interviewFeedback.map((interview) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${interview["interviewerAvatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${interview["type"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(interview["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${interview["status"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _getStatusColor(interview["status"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Interviewer: ${interview["interviewer"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${interview["date"]} • ${interview["duration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (interview["status"] == "Completed")
                                  Row(
                                    children: [
                                      SizedBox(width: spSm),
                                      Icon(Icons.star, size: 14, color: warningColor),
                                      SizedBox(width: 2),
                                      Text(
                                        "${interview["score"]}/10",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  if (interview["status"] == "Completed" && interview["feedback"].toString().isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Interview Feedback",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${interview["feedback"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: spSm),
                          
                          // Strengths and concerns
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Strengths",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    ...(interview["strengths"] as List).map((strength) {
                                      return Text(
                                        "• $strength",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Concerns",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    ...(interview["concerns"] as List).map((concern) {
                                      return Text(
                                        "• $concern",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          if (interview["recommendation"].toString().isNotEmpty) ...[
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getRecommendationColor(interview["recommendation"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Recommendation: ${interview["recommendation"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getRecommendationColor(interview["recommendation"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                  
                  if (interview["status"] == "Scheduled") ...[
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Add to Calendar",
                            size: bs.sm,
                            onPressed: () {
                              si("Interview added to calendar");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            si("Edit interview details");
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInterviewStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  double _calculateAverageScore() {
    var completedReviews = reviewers.where((r) => r["status"] == "Completed").toList();
    if (completedReviews.isEmpty) return 0.0;
    
    double total = completedReviews.fold(0.0, (sum, review) => sum + (review["score"] as num).toDouble());
    return total / completedReviews.length;
  }

  double _calculateAverageInterviewScore() {
    var completedInterviews = interviewFeedback.where((i) => i["status"] == "Completed").toList();
    if (completedInterviews.isEmpty) return 0.0;
    
    double total = completedInterviews.fold(0.0, (sum, interview) => sum + (interview["score"] as num).toDouble());
    return total / completedInterviews.length;
  }

  void _showSubmitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Submit Final Review"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Are you sure you want to submit your final review?"),
            SizedBox(height: spMd),
            Text(
              "Review Summary:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spXs),
            Text("Overall Score: ${calculatedOverallScore.toStringAsFixed(1)}/10"),
            Text("Recommendation: $recommendation"),
            SizedBox(height: spSm),
            Text(
              "This action cannot be undone.",
              style: TextStyle(
                fontSize: 12,
                color: warningColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              reviewStatus = "Submitted";
              isReviewCompleted = true;
              ss("Final review submitted successfully");
              setState(() {});
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Application Review",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Scoring", icon: Icon(Icons.assessment)),
        Tab(text: "Reviewers", icon: Icon(Icons.people)),
        Tab(text: "Interviews", icon: Icon(Icons.video_call)),
      ],
      tabChildren: [
        _buildScoringTab(),
        _buildReviewersTab(),
        _buildInterviewsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
