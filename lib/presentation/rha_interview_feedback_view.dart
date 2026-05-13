import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaInterviewFeedbackView extends StatefulWidget {
  const RhaInterviewFeedbackView({super.key});

  @override
  State<RhaInterviewFeedbackView> createState() => _RhaInterviewFeedbackViewState();
}

class _RhaInterviewFeedbackViewState extends State<RhaInterviewFeedbackView> {
  String selectedRound = "all";
  String selectedRating = "all";
  String searchQuery = "";
  int currentTab = 0;

  List<Map<String, dynamic>> feedbackList = [
    {
      "id": "FB001",
      "candidateName": "Sarah Wilson",
      "candidateImage": "https://picsum.photos/60/60?random=1&keyword=woman",
      "position": "Senior Software Engineer",
      "round": "Technical Round 1",
      "interviewer": "John Smith",
      "interviewerImage": "https://picsum.photos/40/40?random=11&keyword=man",
      "date": "2024-06-19",
      "duration": 60,
      "overallRating": 4.5,
      "technicalSkills": 4,
      "communication": 5,
      "problemSolving": 4,
      "cultureFit": 5,
      "experience": 4,
      "feedback": "Excellent technical knowledge and communication skills. Solved complex problems efficiently and showed great teamwork potential.",
      "strengths": [
        "Strong JavaScript and React expertise",
        "Excellent problem-solving approach",
        "Clear communication",
        "Good system design thinking"
      ],
      "improvements": [
        "Could improve knowledge of backend technologies",
        "Need more experience with microservices"
      ],
      "recommendation": "proceed",
      "notes": "Would be a great addition to the frontend team"
    },
    {
      "id": "FB002",
      "candidateName": "Michael Chen",
      "candidateImage": "https://picsum.photos/60/60?random=2&keyword=man",
      "position": "Product Manager",
      "round": "Panel Interview",
      "interviewer": "Lisa Garcia",
      "interviewerImage": "https://picsum.photos/40/40?random=12&keyword=woman",
      "date": "2024-06-19",
      "duration": 90,
      "overallRating": 4.8,
      "technicalSkills": 4,
      "communication": 5,
      "problemSolving": 5,
      "cultureFit": 5,
      "experience": 5,
      "feedback": "Outstanding candidate with exceptional strategic thinking and leadership qualities. Demonstrated deep understanding of product management principles.",
      "strengths": [
        "Strategic product vision",
        "Strong analytical skills",
        "Excellent stakeholder management",
        "Data-driven decision making"
      ],
      "improvements": [
        "Could benefit from more technical depth",
        "Need experience with agile methodologies"
      ],
      "recommendation": "hire",
      "notes": "Perfect fit for senior PM role"
    },
    {
      "id": "FB003",
      "candidateName": "Emily Johnson",
      "candidateImage": "https://picsum.photos/60/60?random=3&keyword=woman",
      "position": "UX Designer",
      "round": "Design Challenge",
      "interviewer": "David Park",
      "interviewerImage": "https://picsum.photos/40/40?random=13&keyword=man",
      "date": "2024-06-18",
      "duration": 120,
      "overallRating": 3.8,
      "technicalSkills": 4,
      "communication": 4,
      "problemSolving": 4,
      "cultureFit": 3,
      "experience": 4,
      "feedback": "Good design skills and creative thinking. Portfolio shows strong visual design capabilities but needs improvement in user research methodology.",
      "strengths": [
        "Creative design solutions",
        "Strong visual design skills",
        "Good understanding of design systems",
        "Collaborative approach"
      ],
      "improvements": [
        "Need more user research experience",
        "Should improve prototyping skills",
        "Requires better understanding of accessibility"
      ],
      "recommendation": "proceed",
      "notes": "Has potential but needs mentoring"
    },
    {
      "id": "FB004",
      "candidateName": "Alex Rodriguez",
      "candidateImage": "https://picsum.photos/60/60?random=4&keyword=person",
      "position": "Data Scientist",
      "round": "Technical Assessment",
      "interviewer": "Dr. Maria Santos",
      "interviewerImage": "https://picsum.photos/40/40?random=14&keyword=woman",
      "date": "2024-06-17",
      "duration": 75,
      "overallRating": 2.8,
      "technicalSkills": 3,
      "communication": 2,
      "problemSolving": 3,
      "cultureFit": 3,
      "experience": 2,
      "feedback": "Basic understanding of data science concepts but lacks practical experience. Struggled with advanced statistical concepts and machine learning algorithms.",
      "strengths": [
        "Eager to learn",
        "Basic Python knowledge",
        "Understanding of statistics"
      ],
      "improvements": [
        "Need more hands-on ML experience",
        "Should improve coding skills",
        "Requires deeper statistical knowledge",
        "Need better presentation skills"
      ],
      "recommendation": "reject",
      "notes": "Not ready for senior role, might consider for junior position"
    },
    {
      "id": "FB005",
      "candidateName": "James Thompson",
      "candidateImage": "https://picsum.photos/60/60?random=5&keyword=man",
      "position": "DevOps Engineer",
      "round": "Practical Test",
      "interviewer": "Tom Wilson",
      "interviewerImage": "https://picsum.photos/40/40?random=15&keyword=man",
      "date": "2024-06-16",
      "duration": 90,
      "overallRating": 4.2,
      "technicalSkills": 5,
      "communication": 3,
      "problemSolving": 4,
      "cultureFit": 4,
      "experience": 5,
      "feedback": "Strong technical skills with extensive DevOps experience. Excellent knowledge of cloud platforms and automation tools. Communication could be improved.",
      "strengths": [
        "Expert in AWS and Azure",
        "Strong automation skills",
        "Excellent troubleshooting",
        "Deep infrastructure knowledge"
      ],
      "improvements": [
        "Should improve communication skills",
        "Need better documentation practices",
        "Could work on presentation skills"
      ],
      "recommendation": "proceed",
      "notes": "Technical skills are outstanding"
    }
  ];

  List<Map<String, dynamic>> get filteredFeedback {
    return feedbackList.where((feedback) {
      bool matchesRound = selectedRound == "all" || feedback["round"] == selectedRound;
      bool matchesRating = selectedRating == "all" || 
          (selectedRating == "excellent" && feedback["overallRating"] >= 4.5) ||
          (selectedRating == "good" && feedback["overallRating"] >= 3.5 && feedback["overallRating"] < 4.5) ||
          (selectedRating == "average" && feedback["overallRating"] < 3.5);
      bool matchesSearch = searchQuery.isEmpty ||
          (feedback["candidateName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (feedback["position"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return matchesRound && matchesRating && matchesSearch;
    }).toList();
  }

  Color _getRecommendationColor(String recommendation) {
    switch (recommendation) {
      case "hire":
        return successColor;
      case "proceed":
        return infoColor;
      case "reject":
        return dangerColor;
      default:
        return warningColor;
    }
  }

  String _getRecommendationLabel(String recommendation) {
    switch (recommendation) {
      case "hire":
        return "Hire";
      case "proceed":
        return "Next Round";
      case "reject":
        return "Reject";
      default:
        return "Under Review";
    }
  }

  Widget _buildRatingBar(String label, double rating, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "${rating.toStringAsFixed(1)}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(51),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: rating / 5,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackCard(Map<String, dynamic> feedback) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
          // Header
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${feedback["candidateImage"]}"),
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
                      "${feedback["candidateName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${feedback["position"]} • ${feedback["round"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getRecommendationColor(feedback["recommendation"]).withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getRecommendationLabel(feedback["recommendation"]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getRecommendationColor(feedback["recommendation"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Interviewer and Date
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${feedback["interviewerImage"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Interviewed by ${feedback["interviewer"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "${feedback["date"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Overall Rating
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Overall Rating:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${(feedback["overallRating"] as double).toStringAsFixed(1)}/5.0",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          
          // Individual Ratings
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar("Technical", (feedback["technicalSkills"] as int).toDouble(), primaryColor),
                    SizedBox(height: spSm),
                    _buildRatingBar("Communication", (feedback["communication"] as int).toDouble(), infoColor),
                    SizedBox(height: spSm),
                    _buildRatingBar("Problem Solving", (feedback["problemSolving"] as int).toDouble(), successColor),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar("Culture Fit", (feedback["cultureFit"] as int).toDouble(), warningColor),
                    SizedBox(height: spSm),
                    _buildRatingBar("Experience", (feedback["experience"] as int).toDouble(), dangerColor),
                    SizedBox(height: spSm),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Feedback Text
          Text(
            "Feedback:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${feedback["feedback"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          
          // Strengths
          Text(
            "Strengths:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: successColor,
            ),
          ),
          SizedBox(height: spXs),
          ...(feedback["strengths"] as List).map((strength) => 
            Padding(
              padding: EdgeInsets.only(bottom: spXs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: successColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "$strength",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
          SizedBox(height: spSm),
          
          // Areas for Improvement
          Text(
            "Areas for Improvement:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: warningColor,
            ),
          ),
          SizedBox(height: spXs),
          ...(feedback["improvements"] as List).map((improvement) => 
            Padding(
              padding: EdgeInsets.only(bottom: spXs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb,
                    size: 16,
                    color: warningColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "$improvement",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
          
          if (feedback["notes"].isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Additional Notes:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${feedback["notes"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Full Report",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.share,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, Color color) {
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
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interview Feedback"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.analytics),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.file_download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Overview
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 80,
              children: [
                _buildStatsCard("Average Rating", "4.2", primaryColor),
                _buildStatsCard("Hired", "8", successColor),
                _buildStatsCard("Proceeding", "12", infoColor),
                _buildStatsCard("Rejected", "4", dangerColor),
              ],
            ),
            SizedBox(height: spLg),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search feedback",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // Rating Filter
            QCategoryPicker(
              items: [
                {"label": "All Ratings", "value": "all"},
                {"label": "Excellent (4.5+)", "value": "excellent"},
                {"label": "Good (3.5-4.4)", "value": "good"},
                {"label": "Average (<3.5)", "value": "average"},
              ],
              value: selectedRating,
              onChanged: (index, label, value, item) {
                selectedRating = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Feedback List
            Text(
              "Feedback Reports (${filteredFeedback.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...filteredFeedback.map((feedback) => _buildFeedbackCard(feedback)).toList(),
            
            if (filteredFeedback.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.feedback,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No feedback found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
