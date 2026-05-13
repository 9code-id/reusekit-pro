import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaQuizResultView extends StatefulWidget {
  const ElaQuizResultView({super.key});

  @override
  State<ElaQuizResultView> createState() => _ElaQuizResultViewState();
}

class _ElaQuizResultViewState extends State<ElaQuizResultView> {
  Map<String, dynamic> quizResult = {
    "quiz_title": "English Grammar & Literature Quiz",
    "total_questions": 15,
    "correct_answers": 12,
    "incorrect_answers": 3,
    "score_percentage": 80,
    "total_points": 120,
    "max_points": 150,
    "time_taken": "12:45",
    "completion_date": "2024-12-15",
    "grade": "B+",
    "passed": true,
    "feedback": "Good job! You have a solid understanding of English grammar and literature basics.",
    "strengths": [
      "Excellent grasp of past tense forms",
      "Strong metaphor identification skills",
      "Good comprehension of poetry themes"
    ],
    "areas_for_improvement": [
      "Sentence structure analysis",
      "Advanced vocabulary usage",
      "Complex literary devices"
    ]
  };

  List<Map<String, dynamic>> questionBreakdown = [
    {
      "question": "Which sentence uses correct past tense?",
      "your_answer": "She ran to the store yesterday.",
      "correct_answer": "She ran to the store yesterday.",
      "is_correct": true,
      "points_earned": 10,
      "max_points": 10,
      "category": "Grammar"
    },
    {
      "question": "Identify the metaphor in: 'Her voice was music to his ears.'",
      "your_answer": "was music",
      "correct_answer": "was music", 
      "is_correct": true,
      "points_earned": 15,
      "max_points": 15,
      "category": "Literary Devices"
    },
    {
      "question": "Main theme of 'The Road Not Taken'?",
      "your_answer": "The beauty of nature",
      "correct_answer": "Making difficult choices in life",
      "is_correct": false,
      "points_earned": 0,
      "max_points": 20,
      "category": "Literature"
    }
  ];

  void _retakeQuiz() {
    // navigateTo(ElaQuizQuestionView())
  }

  void _viewDetailedAnalysis() {
    // navigateTo(ElaQuizAnalysisView())
  }

  void _shareResults() {
    ss("Quiz results shared successfully!");
  }

  Color _getGradeColor() {
    final percentage = quizResult["score_percentage"] as int;
    if (percentage >= 90) return successColor;
    if (percentage >= 80) return infoColor;
    if (percentage >= 70) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    final percentage = quizResult["score_percentage"] as int;
    final passed = quizResult["passed"] as bool;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Results"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareResults(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _getGradeColor(),
                    _getGradeColor().withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    passed ? Icons.check_circle : Icons.cancel,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${quizResult["grade"]}",
                    style: TextStyle(
                      fontSize: fsH1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$percentage%",
                    style: TextStyle(
                      fontSize: fsH3,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    passed ? "Congratulations!" : "Keep Practicing!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${quizResult["feedback"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quiz statistics
            Container(
              width: double.infinity,
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
                    "Quiz Statistics",
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
                        child: _buildStatItem(
                          "Correct",
                          "${quizResult["correct_answers"]}",
                          successColor,
                          Icons.check_circle,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          "Incorrect", 
                          "${quizResult["incorrect_answers"]}",
                          dangerColor,
                          Icons.cancel,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          "Total",
                          "${quizResult["total_questions"]}",
                          primaryColor,
                          Icons.quiz,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          "Points",
                          "${quizResult["total_points"]}/${quizResult["max_points"]}",
                          infoColor,
                          Icons.star,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          "Time",
                          "${quizResult["time_taken"]}",
                          warningColor,
                          Icons.timer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Strengths
            Container(
              width: double.infinity,
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
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Strengths",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...(quizResult["strengths"] as List<String>).map((strength) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              strength,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Areas for improvement
            Container(
              width: double.infinity,
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
                      Icon(
                        Icons.trending_down,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Areas for Improvement",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...(quizResult["areas_for_improvement"] as List<String>).map((area) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              area,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Question breakdown
            Container(
              width: double.infinity,
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
                    "Question Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...questionBreakdown.map((question) {
                    final isCorrect = question["is_correct"] as bool;
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCorrect ? successColor.withAlpha(10) : dangerColor.withAlpha(10),
                        border: Border.all(
                          color: isCorrect ? successColor : dangerColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isCorrect ? Icons.check_circle : Icons.cancel,
                                color: isCorrect ? successColor : dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${question["question"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${question["points_earned"]}/${question["max_points"]} pts",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          if (!isCorrect) ...[
                            SizedBox(height: spXs),
                            Text(
                              "Your answer: ${question["your_answer"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Correct answer: ${question["correct_answer"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Action buttons
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Retake Quiz",
                    size: bs.md,
                    onPressed: () => _retakeQuiz(),
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Detailed Analysis",
                    size: bs.md,
                    onPressed: () => _viewDetailedAnalysis(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
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
}
