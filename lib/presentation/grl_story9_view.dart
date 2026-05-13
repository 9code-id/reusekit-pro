import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStory9View extends StatefulWidget {
  @override
  State<GrlStory9View> createState() => _GrlStory9ViewState();
}

class _GrlStory9ViewState extends State<GrlStory9View> {
  String selectedQuizOption = "";
  bool hasAnswered = false;
  bool isCorrectAnswer = false;
  int currentQuestion = 1;
  int totalQuestions = 5;
  int score = 0;

  Map<String, dynamic> quizQuestion = {
    "question": "Which planet is known as the 'Red Planet'?",
    "options": [
      {"text": "Venus", "isCorrect": false},
      {"text": "Mars", "isCorrect": true},
      {"text": "Jupiter", "isCorrect": false},
      {"text": "Saturn", "isCorrect": false},
    ],
    "explanation": "Mars is called the Red Planet because of iron oxide (rust) on its surface, which gives it a reddish appearance.",
    "category": "Astronomy",
    "difficulty": "Easy"
  };

  List<Map<String, dynamic>> participants = [
    {
      "username": "space_lover",
      "avatar": "https://picsum.photos/50/50?random=70&keyword=astronaut",
      "score": 4,
      "answered": true
    },
    {
      "username": "quiz_master",
      "avatar": "https://picsum.photos/50/50?random=71&keyword=scientist",
      "score": 5,
      "answered": true
    },
    {
      "username": "learning_enthusiast",
      "avatar": "https://picsum.photos/50/50?random=72&keyword=student",
      "score": 3,
      "answered": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background with Quiz Theme
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo.withAlpha(100),
                  Colors.purple.withAlpha(100),
                  Colors.black,
                ],
              ),
            ),
          ),

          // Header
          Positioned(
            top: 50,
            left: spMd,
            right: spMd,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://picsum.photos/80/80?random=10&keyword=teacher"
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "quiz_champion",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.quiz,
                            color: primaryColor,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Live Quiz Challenge",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "QUIZ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () => back(),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Quiz Progress
          Positioned(
            top: 120,
            left: spMd,
            right: spMd,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question $currentQuestion of $totalQuestions",
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Score: $score",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: currentQuestion / totalQuestions,
                  backgroundColor: Colors.white.withAlpha(50),
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ],
            ),
          ),

          // Quiz Content
          Positioned(
            top: 180,
            left: spMd,
            right: spMd,
            bottom: 160,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question Category and Difficulty
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${quizQuestion["category"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${quizQuestion["difficulty"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Question
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowMd],
                    ),
                    child: Text(
                      "${quizQuestion["question"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Answer Options
                  ...(quizQuestion["options"] as List).map((option) {
                    bool isSelected = selectedQuizOption == option["text"];
                    bool isCorrect = option["isCorrect"] as bool;
                    
                    Color getOptionColor() {
                      if (!hasAnswered) {
                        return isSelected ? primaryColor.withAlpha(100) : Colors.black.withAlpha(100);
                      }
                      if (isCorrect) {
                        return Colors.green.withAlpha(150);
                      }
                      if (isSelected && !isCorrect) {
                        return Colors.red.withAlpha(150);
                      }
                      return Colors.black.withAlpha(100);
                    }
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: GestureDetector(
                        onTap: hasAnswered ? null : () {
                          setState(() {
                            selectedQuizOption = option["text"];
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: getOptionColor(),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: hasAnswered && isCorrect 
                                  ? Colors.green 
                                  : (hasAnswered && isSelected && !isCorrect)
                                      ? Colors.red
                                      : isSelected 
                                          ? primaryColor 
                                          : Colors.white.withAlpha(50),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: hasAnswered && isCorrect 
                                      ? Colors.green 
                                      : (hasAnswered && isSelected && !isCorrect)
                                          ? Colors.red
                                          : isSelected 
                                              ? primaryColor 
                                              : Colors.white.withAlpha(50),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + (quizQuestion["options"] as List).indexOf(option)),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Text(
                                  "${option["text"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (hasAnswered && isCorrect)
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 24,
                                ),
                              if (hasAnswered && isSelected && !isCorrect)
                                Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  
                  // Answer Button
                  if (!hasAnswered && selectedQuizOption.isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Submit Answer",
                        size: bs.md,
                        onPressed: () {
                          setState(() {
                            hasAnswered = true;
                            bool correctAnswer = (quizQuestion["options"] as List)
                                .firstWhere((option) => option["text"] == selectedQuizOption)["isCorrect"];
                            
                            if (correctAnswer) {
                              score++;
                              ss("Correct! Well done! 🎉");
                            } else {
                              se("Incorrect. Better luck next time! 💪");
                            }
                          });
                        },
                      ),
                    ),
                  ],
                  
                  // Explanation
                  if (hasAnswered) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(100),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Explanation",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${quizQuestion["explanation"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Participants and Stats
          Positioned(
            bottom: 40,
            left: spMd,
            right: spMd,
            child: Column(
              children: [
                // Participants
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Live Participants",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${participants.length + 47} playing",
                            style: TextStyle(
                              color: Colors.white.withAlpha(150),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          ...participants.take(3).map((participant) {
                            return Container(
                              margin: EdgeInsets.only(right: spSm),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                          "${participant["avatar"]}"
                                        ),
                                      ),
                                      if (participant["answered"] as bool)
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 8,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "${participant["score"]}/5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          Text(
                            "+44 more",
                            style: TextStyle(
                              color: Colors.white.withAlpha(150),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                if (hasAnswered) ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Next Question",
                      size: bs.md,
                      onPressed: () {
                        ss("Loading next question...");
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
