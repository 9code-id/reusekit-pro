import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaQAndAView extends StatefulWidget {
  const ElaQAndAView({super.key});

  @override
  State<ElaQAndAView> createState() => _ElaQAndAViewState();
}

class _ElaQAndAViewState extends State<ElaQAndAView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedSubject = "all";
  String selectedDifficulty = "all";

  List<Map<String, dynamic>> subjectItems = [
    {"label": "All Subjects", "value": "all"},
    {"label": "Mathematics", "value": "mathematics"},
    {"label": "Physics", "value": "physics"},
    {"label": "Chemistry", "value": "chemistry"},
    {"label": "Biology", "value": "biology"},
    {"label": "Computer Science", "value": "computer_science"},
  ];

  List<Map<String, dynamic>> difficultyItems = [
    {"label": "All Levels", "value": "all"},
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"},
  ];

  List<Map<String, dynamic>> questions = [
    {
      "id": 1,
      "title": "How to solve complex integration by parts?",
      "content": "I'm struggling with integration by parts when dealing with complex functions. Can someone provide a step-by-step approach?",
      "subject": "Mathematics",
      "difficulty": "Advanced",
      "author": "Sarah Johnson",
      "authorAvatar": "https://picsum.photos/40/40?random=1&keyword=student",
      "timestamp": "2024-01-15 10:30:00",
      "votes": 15,
      "answers": 3,
      "views": 89,
      "tags": ["Calculus", "Integration", "Advanced Math"],
      "isUpvoted": false,
      "isDownvoted": false,
      "hasAcceptedAnswer": true,
      "bounty": 0,
    },
    {
      "id": 2,
      "title": "What is wave-particle duality in quantum mechanics?",
      "content": "I need help understanding the concept of wave-particle duality. How can light behave as both a wave and a particle?",
      "subject": "Physics",
      "difficulty": "Intermediate",
      "author": "Mike Chen",
      "authorAvatar": "https://picsum.photos/40/40?random=2&keyword=student",
      "timestamp": "2024-01-15 09:15:00",
      "votes": 23,
      "answers": 5,
      "views": 156,
      "tags": ["Quantum Physics", "Light", "Fundamentals"],
      "isUpvoted": true,
      "isDownvoted": false,
      "hasAcceptedAnswer": true,
      "bounty": 50,
    },
    {
      "id": 3,
      "title": "Difference between SN1 and SN2 reactions?",
      "content": "Can someone explain the key differences between SN1 and SN2 reaction mechanisms in organic chemistry?",
      "subject": "Chemistry",
      "difficulty": "Intermediate",
      "author": "Emma Davis",
      "authorAvatar": "https://picsum.photos/40/40?random=3&keyword=student",
      "timestamp": "2024-01-15 08:45:00",
      "votes": 18,
      "answers": 4,
      "views": 73,
      "tags": ["Organic Chemistry", "Mechanisms", "Reactions"],
      "isUpvoted": false,
      "isDownvoted": false,
      "hasAcceptedAnswer": false,
      "bounty": 25,
    },
    {
      "id": 4,
      "title": "Best approach to learn data structures?",
      "content": "I'm new to computer science. What's the most effective way to understand and implement basic data structures?",
      "subject": "Computer Science",
      "difficulty": "Beginner",
      "author": "Alex Rodriguez",
      "authorAvatar": "https://picsum.photos/40/40?random=4&keyword=student",
      "timestamp": "2024-01-15 07:20:00",
      "votes": 31,
      "answers": 8,
      "views": 234,
      "tags": ["Data Structures", "Learning", "Beginner"],
      "isUpvoted": true,
      "isDownvoted": false,
      "hasAcceptedAnswer": true,
      "bounty": 0,
    },
    {
      "id": 5,
      "title": "Mitosis vs Meiosis - key differences?",
      "content": "I keep confusing mitosis and meiosis. What are the fundamental differences between these two processes?",
      "subject": "Biology",
      "difficulty": "Beginner",
      "author": "Lisa Thompson",
      "authorAvatar": "https://picsum.photos/40/40?random=5&keyword=student",
      "timestamp": "2024-01-14 16:30:00",
      "votes": 12,
      "answers": 6,
      "views": 98,
      "tags": ["Cell Biology", "Mitosis", "Meiosis"],
      "isUpvoted": false,
      "isDownvoted": false,
      "hasAcceptedAnswer": true,
      "bounty": 0,
    },
    {
      "id": 6,
      "title": "How to calculate limits approaching infinity?",
      "content": "Need help with calculating limits as x approaches infinity, especially with rational functions.",
      "subject": "Mathematics",
      "difficulty": "Intermediate",
      "author": "David Wilson",
      "authorAvatar": "https://picsum.photos/40/40?random=6&keyword=student",
      "timestamp": "2024-01-14 14:15:00",
      "votes": 9,
      "answers": 2,
      "views": 67,
      "tags": ["Calculus", "Limits", "Infinity"],
      "isUpvoted": false,
      "isDownvoted": false,
      "hasAcceptedAnswer": false,
      "bounty": 10,
    },
  ];

  List<Map<String, dynamic>> get filteredQuestions {
    return questions.where((question) {
      bool matchesSearch = question["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          question["content"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSubject = selectedSubject == "all" || 
          question["subject"].toString().toLowerCase().replaceAll(" ", "_") == selectedSubject;
      bool matchesDifficulty = selectedDifficulty == "all" || 
          question["difficulty"].toString().toLowerCase() == selectedDifficulty;
      return matchesSearch && matchesSubject && matchesDifficulty;
    }).toList();
  }

  List<Map<String, dynamic>> get sortedQuestions {
    List<Map<String, dynamic>> sorted = List.from(filteredQuestions);
    
    switch (currentTab) {
      case 0: // Newest
        sorted.sort((a, b) => DateTime.parse(b["timestamp"]).compareTo(DateTime.parse(a["timestamp"])));
        break;
      case 1: // Popular
        sorted.sort((a, b) => (b["votes"] as int).compareTo(a["votes"] as int));
        break;
      case 2: // Unanswered
        sorted = sorted.where((q) => q["answers"] == 0).toList();
        sorted.sort((a, b) => DateTime.parse(b["timestamp"]).compareTo(DateTime.parse(a["timestamp"])));
        break;
      case 3: // Bounty
        sorted = sorted.where((q) => (q["bounty"] as int) > 0).toList();
        sorted.sort((a, b) => (b["bounty"] as int).compareTo(a["bounty"] as int));
        break;
    }
    
    return sorted;
  }

  void _toggleVote(Map<String, dynamic> question, bool isUpvote) {
    setState(() {
      bool currentUpvoted = question["isUpvoted"] as bool;
      bool currentDownvoted = question["isDownvoted"] as bool;
      int currentVotes = question["votes"] as int;
      
      if (isUpvote) {
        if (currentUpvoted) {
          // Remove upvote
          question["isUpvoted"] = false;
          question["votes"] = currentVotes - 1;
        } else {
          // Add upvote, remove downvote if exists
          question["isUpvoted"] = true;
          question["isDownvoted"] = false;
          question["votes"] = currentVotes + 1 + (currentDownvoted ? 1 : 0);
        }
      } else {
        if (currentDownvoted) {
          // Remove downvote
          question["isDownvoted"] = false;
          question["votes"] = currentVotes + 1;
        } else {
          // Add downvote, remove upvote if exists
          question["isDownvoted"] = true;
          question["isUpvoted"] = false;
          question["votes"] = currentVotes - 1 - (currentUpvoted ? 1 : 0);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Q&A Forum",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Newest"),
        Tab(text: "Popular"),
        Tab(text: "Unanswered"),
        Tab(text: "Bounty"),
      ],
      tabChildren: [
        // Newest Tab
        _buildQuestionsList(),
        // Popular Tab  
        _buildQuestionsList(),
        // Unanswered Tab
        _buildQuestionsList(),
        // Bounty Tab
        _buildQuestionsList(),
      ],
      onInit: (tabController) {
        // Access to TabController if needed
      },
    );
  }

  Widget _buildQuestionsList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Column(
            spacing: spSm,
            children: [
              QTextField(
                label: "Search questions",
                value: searchQuery,
                hint: "Search by title or content",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Subject",
                      items: subjectItems,
                      value: selectedSubject,
                      onChanged: (value, label) {
                        selectedSubject = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Difficulty",
                      items: difficultyItems,
                      value: selectedDifficulty,
                      onChanged: (value, label) {
                        selectedDifficulty = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Ask Question Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Ask a Question",
              icon: Icons.help,
              size: bs.md,
              onPressed: () {
                // navigateTo('AskQuestionView')
              },
            ),
          ),

          // Questions Header
          Row(
            children: [
              Text(
                currentTab == 2 ? "Unanswered Questions" : 
                currentTab == 3 ? "Questions with Bounty" : "Questions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "${sortedQuestions.length} questions",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Questions List
          ...sortedQuestions.map((question) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: question["hasAcceptedAnswer"] as bool 
                    ? Border.all(color: successColor, width: 1)
                    : (question["bounty"] as int) > 0
                        ? Border.all(color: warningColor, width: 1)
                        : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  // Header with Author Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage("${question["authorAvatar"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${question["author"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(question["timestamp"]).dMMMy}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if ((question["bounty"] as int) > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.emoji_events,
                                size: 12,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${question["bounty"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  // Question Title
                  GestureDetector(
                    onTap: () {
                      // navigateTo('QuestionDetailView')
                    },
                    child: Text(
                      "${question["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Question Content Preview
                  Text(
                    "${question["content"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Subject and Difficulty Tags
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${question["subject"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: question["difficulty"] == "Beginner" ? successColor.withAlpha(20) :
                                 question["difficulty"] == "Intermediate" ? warningColor.withAlpha(20) :
                                 dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${question["difficulty"]}",
                          style: TextStyle(
                            color: question["difficulty"] == "Beginner" ? successColor :
                                   question["difficulty"] == "Intermediate" ? warningColor :
                                   dangerColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (question["hasAcceptedAnswer"] as bool) ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check,
                                size: 10,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "Solved",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Question Tags
                  Wrap(
                    spacing: spXs,
                    children: (question["tags"] as List).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Stats and Voting
                  Row(
                    children: [
                      // Voting
                      Container(
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => _toggleVote(question, true),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 20,
                                  color: question["isUpvoted"] as bool 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "${question["votes"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: question["isUpvoted"] as bool 
                                    ? primaryColor 
                                    : question["isDownvoted"] as bool 
                                        ? dangerColor 
                                        : Colors.black87,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _toggleVote(question, false),
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: question["isDownvoted"] as bool 
                                      ? dangerColor 
                                      : disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      // Stats
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${question["views"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              question["answers"] == 0 ? Icons.help_outline : Icons.question_answer,
                              size: 16,
                              color: question["answers"] == 0 ? warningColor : successColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${question["answers"]} answers",
                              style: TextStyle(
                                color: question["answers"] == 0 ? warningColor : successColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Answer Button
                      QButton(
                        label: "Answer",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('AnswerQuestionView')
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
