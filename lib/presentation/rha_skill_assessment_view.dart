import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaSkillAssessmentView extends StatefulWidget {
  const RhaSkillAssessmentView({super.key});

  @override
  State<RhaSkillAssessmentView> createState() => _RhaSkillAssessmentViewState();
}

class _RhaSkillAssessmentViewState extends State<RhaSkillAssessmentView> {
  String selectedCategory = "all";
  String selectedLevel = "all";
  String searchQuery = "";
  int currentQuestionIndex = 0;
  bool isAssessmentStarted = false;
  bool isAssessmentCompleted = false;
  
  Map<int, String> selectedAnswers = {};
  int timeRemaining = 3600; // 60 minutes in seconds

  // Assessment details
  Map<String, dynamic> assessmentInfo = {
    "title": "Frontend Developer Skills Assessment",
    "description": "Comprehensive evaluation of React, JavaScript, and web development skills",
    "duration": 60,
    "totalQuestions": 25,
    "passingScore": 70,
    "difficulty": "intermediate",
    "category": "technical",
    "instructions": [
      "Read each question carefully before selecting an answer",
      "You can navigate between questions using the navigation panel",
      "Make sure to answer all questions before submitting",
      "You cannot change answers after submission",
      "Time limit is strictly enforced"
    ]
  };

  List<Map<String, dynamic>> skillCategories = [
    {
      "id": "frontend",
      "name": "Frontend Development",
      "description": "React, JavaScript, CSS, HTML",
      "icon": Icons.web,
      "color": primaryColor,
      "assessments": 8,
      "averageScore": 78.5,
    },
    {
      "id": "backend",
      "name": "Backend Development", 
      "description": "Node.js, Databases, APIs",
      "icon": Icons.storage,
      "color": successColor,
      "assessments": 6,
      "averageScore": 82.3,
    },
    {
      "id": "mobile",
      "name": "Mobile Development",
      "description": "React Native, Flutter, iOS, Android",
      "icon": Icons.phone_android,
      "color": infoColor,
      "assessments": 4,
      "averageScore": 75.8,
    },
    {
      "id": "data-science",
      "name": "Data Science",
      "description": "Python, Machine Learning, Statistics",
      "icon": Icons.analytics,
      "color": warningColor,
      "assessments": 5,
      "averageScore": 80.2,
    },
    {
      "id": "devops",
      "name": "DevOps",
      "description": "AWS, Docker, CI/CD, Kubernetes",
      "icon": Icons.cloud,
      "color": dangerColor,
      "assessments": 3,
      "averageScore": 77.9,
    },
    {
      "id": "design",
      "name": "UI/UX Design",
      "description": "Figma, User Experience, Prototyping",
      "icon": Icons.design_services,
      "color": secondaryColor,
      "assessments": 4,
      "averageScore": 85.1,
    },
  ];

  List<Map<String, dynamic>> assessmentQuestions = [
    {
      "id": 1,
      "question": "What is the purpose of React Hooks?",
      "type": "multiple-choice",
      "options": [
        "To add state and lifecycle methods to functional components",
        "To create class-based components",
        "To handle CSS styling in React",
        "To manage component routing"
      ],
      "correctAnswer": 0,
      "difficulty": "intermediate",
      "category": "React",
      "explanation": "React Hooks allow you to use state and other React features in functional components without writing a class."
    },
    {
      "id": 2,
      "question": "Which of the following is NOT a valid JavaScript data type?",
      "type": "multiple-choice",
      "options": [
        "String",
        "Boolean",
        "Float",
        "BigInt"
      ],
      "correctAnswer": 2,
      "difficulty": "beginner",
      "category": "JavaScript",
      "explanation": "JavaScript doesn't have a specific 'Float' data type. Numbers in JavaScript are all of type 'number'."
    },
    {
      "id": 3,
      "question": "What does CSS Grid provide that Flexbox doesn't?",
      "type": "multiple-choice",
      "options": [
        "One-dimensional layout control",
        "Two-dimensional layout control",
        "Better browser support",
        "Easier syntax"
      ],
      "correctAnswer": 1,
      "difficulty": "intermediate",
      "category": "CSS",
      "explanation": "CSS Grid provides two-dimensional layout control (rows and columns), while Flexbox is primarily one-dimensional."
    },
    {
      "id": 4,
      "question": "What is the difference between 'let' and 'const' in JavaScript?",
      "type": "multiple-choice",
      "options": [
        "let is block-scoped, const is function-scoped",
        "let can be reassigned, const cannot be reassigned",
        "let is hoisted, const is not hoisted",
        "There is no difference"
      ],
      "correctAnswer": 1,
      "difficulty": "beginner",
      "category": "JavaScript",
      "explanation": "Both let and const are block-scoped, but const cannot be reassigned after declaration while let can be."
    },
    {
      "id": 5,
      "question": "Which React Hook is used for side effects?",
      "type": "multiple-choice",
      "options": [
        "useState",
        "useEffect",
        "useContext",
        "useReducer"
      ],
      "correctAnswer": 1,
      "difficulty": "beginner",
      "category": "React",
      "explanation": "useEffect is the Hook used for performing side effects in functional components."
    },
  ];

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void startAssessment() {
    isAssessmentStarted = true;
    setState(() {});
    
    // Start timer
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining > 0 && !isAssessmentCompleted) {
        timeRemaining--;
        setState(() {});
      } else {
        timer.cancel();
        if (!isAssessmentCompleted) {
          completeAssessment();
        }
      }
    });
  }

  void completeAssessment() {
    isAssessmentCompleted = true;
    setState(() {});
    ss("Assessment completed successfully!");
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: (category["color"] as Color).withAlpha(51),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              category["icon"],
              color: category["color"],
              size: 28,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${category["name"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${category["description"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              height: 1.3,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "${category["assessments"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: category["color"],
                    ),
                  ),
                  Text(
                    "Tests",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${(category["averageScore"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: category["color"],
                    ),
                  ),
                  Text(
                    "Avg Score",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Assessment",
              size: bs.sm,
              onPressed: () {
                startAssessment();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentHeader() {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${assessmentInfo["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${assessmentInfo["description"]}",
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
                  color: timeRemaining > 600 ? successColor.withAlpha(51) : 
                        timeRemaining > 300 ? warningColor.withAlpha(51) : 
                        dangerColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 16,
                      color: timeRemaining > 600 ? successColor : 
                             timeRemaining > 300 ? warningColor : dangerColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      formatTime(timeRemaining),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: timeRemaining > 600 ? successColor : 
                               timeRemaining > 300 ? warningColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Question ${currentQuestionIndex + 1}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "of ${assessmentInfo["totalQuestions"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Answered",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${selectedAnswers.length}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Progress",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (currentQuestionIndex + 1) / (assessmentInfo["totalQuestions"] as int),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    if (currentQuestionIndex >= assessmentQuestions.length) return Container();
    
    final question = assessmentQuestions[currentQuestionIndex];
    
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
          // Question header
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${question["category"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: question["difficulty"] == "beginner" ? successColor.withAlpha(51) :
                        question["difficulty"] == "intermediate" ? warningColor.withAlpha(51) :
                        dangerColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${question["difficulty"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: question["difficulty"] == "beginner" ? successColor :
                          question["difficulty"] == "intermediate" ? warningColor :
                          dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Question text
          Text(
            "${question["question"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
              height: 1.3,
            ),
          ),
          SizedBox(height: spLg),
          
          // Answer options
          ...(question["options"] as List).asMap().entries.map((entry) {
            int index = entry.key;
            String option = entry.value;
            bool isSelected = selectedAnswers[question["id"]] == index.toString();
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedAnswers[question["id"]] = index.toString();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(51) : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledBoldColor,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNavigationControls() {
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
      child: Row(
        children: [
          QButton(
            label: "Previous",
            size: bs.sm,
            onPressed: currentQuestionIndex > 0 ? () {
              currentQuestionIndex--;
              setState(() {});
            } : null,
          ),
          Spacer(),
          QButton(
            label: currentQuestionIndex < assessmentQuestions.length - 1 ? "Next" : "Submit",
            size: bs.sm,
            onPressed: () {
              if (currentQuestionIndex < assessmentQuestions.length - 1) {
                currentQuestionIndex++;
                setState(() {});
              } else {
                completeAssessment();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentInfo() {
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
          Text(
            "${assessmentInfo["title"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${assessmentInfo["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${assessmentInfo["duration"]} min",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Duration",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${assessmentInfo["totalQuestions"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Questions",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${assessmentInfo["passingScore"]}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Pass Score",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Instructions:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...(assessmentInfo["instructions"] as List).map((instruction) =>
            Padding(
              padding: EdgeInsets.only(bottom: spXs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "$instruction",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Assessment",
              onPressed: () {
                startAssessment();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isAssessmentCompleted) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Assessment Completed"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 80,
                      color: successColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Assessment Completed!",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Your responses have been submitted successfully. Results will be available shortly.",
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
          ),
        ),
      );
    }

    if (isAssessmentStarted) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Skill Assessment"),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              _buildAssessmentHeader(),
              SizedBox(height: spSm),
              _buildQuestionCard(),
              SizedBox(height: spSm),
              _buildNavigationControls(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Skill Assessment"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assessment Info
            _buildAssessmentInfo(),
            SizedBox(height: spLg),
            
            // Skill Categories
            Text(
              "Skill Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: skillCategories.map((category) => _buildCategoryCard(category)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
