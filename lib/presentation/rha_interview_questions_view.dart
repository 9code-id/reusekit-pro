import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaInterviewQuestionsView extends StatefulWidget {
  const RhaInterviewQuestionsView({super.key});

  @override
  State<RhaInterviewQuestionsView> createState() => _RhaInterviewQuestionsViewState();
}

class _RhaInterviewQuestionsViewState extends State<RhaInterviewQuestionsView> {
  String selectedCategory = "all";
  String selectedDifficulty = "all";
  String searchQuery = "";
  bool showAnswers = false;

  List<Map<String, dynamic>> interviewQuestions = [
    {
      "id": "Q001",
      "question": "Tell me about yourself and your professional background.",
      "category": "behavioral",
      "difficulty": "beginner",
      "type": "open-ended",
      "tags": ["Introduction", "Background", "Experience"],
      "sampleAnswer": "I'm a software engineer with 5+ years of experience in full-stack development. I specialize in React and Node.js, and I'm passionate about creating user-friendly applications that solve real-world problems. In my current role at XYZ Company, I've led a team of 4 developers and successfully delivered 3 major projects.",
      "tips": [
        "Keep it concise - aim for 2-3 minutes",
        "Focus on professional achievements",
        "Connect your background to the role you're applying for",
        "Practice this answer until it flows naturally"
      ],
      "keywords": ["Experience", "Skills", "Achievements", "Goals"],
      "lastUsed": "2024-06-15",
      "frequency": 95,
      "rating": 4.8,
    },
    {
      "id": "Q002",
      "question": "What is the difference between var, let, and const in JavaScript?",
      "category": "technical",
      "difficulty": "intermediate",
      "type": "knowledge",
      "tags": ["JavaScript", "Variables", "ES6"],
      "sampleAnswer": "var is function-scoped and can be redeclared and updated. let is block-scoped and can be updated but not redeclared. const is block-scoped and cannot be updated or redeclared. var is hoisted and initialized with undefined, while let and const are hoisted but not initialized.",
      "tips": [
        "Explain scope differences clearly",
        "Mention hoisting behavior",
        "Provide practical examples",
        "Discuss when to use each one"
      ],
      "keywords": ["Scope", "Hoisting", "ES6", "Variables"],
      "lastUsed": "2024-06-14",
      "frequency": 78,
      "rating": 4.6,
    },
    {
      "id": "Q003",
      "question": "Describe a challenging project you worked on and how you overcame obstacles.",
      "category": "behavioral",
      "difficulty": "intermediate",
      "type": "situational",
      "tags": ["Problem Solving", "Challenges", "Leadership"],
      "sampleAnswer": "I led a project to migrate our legacy system to a modern microservices architecture. The main challenge was maintaining system uptime during migration. I created a phased migration plan, implemented feature flags, and set up comprehensive monitoring. We successfully migrated with zero downtime.",
      "tips": [
        "Use the STAR method (Situation, Task, Action, Result)",
        "Choose a relevant example",
        "Focus on your specific contributions",
        "Quantify the results when possible"
      ],
      "keywords": ["Leadership", "Problem Solving", "Results", "Teamwork"],
      "lastUsed": "2024-06-13",
      "frequency": 89,
      "rating": 4.7,
    },
    {
      "id": "Q004",
      "question": "Design a URL shortening service like bit.ly. How would you handle millions of requests?",
      "category": "technical",
      "difficulty": "advanced",
      "type": "system-design",
      "tags": ["System Design", "Scalability", "Databases"],
      "sampleAnswer": "I would use a distributed system with load balancers, multiple application servers, and a NoSQL database like Cassandra for horizontal scaling. Implement caching with Redis, use a CDN for global distribution, and consider database sharding. For URL encoding, use base62 encoding with a distributed counter or UUID approach.",
      "tips": [
        "Start with high-level architecture",
        "Discuss scalability considerations",
        "Consider trade-offs between consistency and availability",
        "Think about caching strategies"
      ],
      "keywords": ["Scalability", "Caching", "Load Balancing", "Databases"],
      "lastUsed": "2024-06-12",
      "frequency": 45,
      "rating": 4.9,
    },
    {
      "id": "Q005",
      "question": "Why do you want to work for our company?",
      "category": "company",
      "difficulty": "beginner",
      "type": "motivational",
      "tags": ["Company Culture", "Motivation", "Research"],
      "sampleAnswer": "I'm impressed by your company's commitment to innovation and sustainable technology solutions. Your recent project on AI-powered healthcare applications aligns perfectly with my passion for using technology to make a positive impact. I also value your collaborative culture and emphasis on continuous learning.",
      "tips": [
        "Research the company thoroughly",
        "Mention specific projects or values",
        "Connect your goals with company mission",
        "Show genuine enthusiasm"
      ],
      "keywords": ["Company Research", "Values Alignment", "Passion", "Growth"],
      "lastUsed": "2024-06-11",
      "frequency": 92,
      "rating": 4.5,
    },
    {
      "id": "Q006",
      "question": "How do you handle conflicts within your team?",
      "category": "behavioral",
      "difficulty": "intermediate",
      "type": "situational",
      "tags": ["Conflict Resolution", "Team Management", "Communication"],
      "sampleAnswer": "I believe in addressing conflicts early and directly. I start by listening to all parties involved to understand different perspectives. Then I facilitate a discussion focused on the project goals and finding common ground. In one instance, I mediated between two developers with different technical approaches and helped them find a hybrid solution.",
      "tips": [
        "Show your communication skills",
        "Demonstrate leadership qualities",
        "Provide a specific example",
        "Focus on positive outcomes"
      ],
      "keywords": ["Communication", "Leadership", "Mediation", "Resolution"],
      "lastUsed": "2024-06-10",
      "frequency": 67,
      "rating": 4.4,
    },
    {
      "id": "Q007",
      "question": "Explain the concept of React Hooks and their benefits.",
      "category": "technical",
      "difficulty": "intermediate",
      "type": "knowledge",
      "tags": ["React", "Hooks", "Frontend"],
      "sampleAnswer": "React Hooks are functions that allow you to use state and lifecycle features in functional components. Benefits include: simpler code without classes, better code reuse through custom hooks, easier testing, and better performance optimization. Common hooks include useState, useEffect, useContext, and useMemo.",
      "tips": [
        "Explain the 'why' behind hooks",
        "Mention specific hook examples",
        "Discuss performance benefits",
        "Compare with class components"
      ],
      "keywords": ["React", "State Management", "Lifecycle", "Performance"],
      "lastUsed": "2024-06-09",
      "frequency": 71,
      "rating": 4.7,
    },
    {
      "id": "Q008",
      "question": "Where do you see yourself in 5 years?",
      "category": "behavioral",
      "difficulty": "beginner",
      "type": "career",
      "tags": ["Career Goals", "Ambition", "Growth"],
      "sampleAnswer": "In 5 years, I see myself in a senior technical leadership role, mentoring other developers and contributing to architectural decisions. I'd like to have deep expertise in emerging technologies like AI/ML integration in web applications. I also want to contribute to open-source projects and possibly speak at tech conferences.",
      "tips": [
        "Be realistic and specific",
        "Align with potential career paths at the company",
        "Show ambition but also loyalty",
        "Mention both technical and leadership growth"
      ],
      "keywords": ["Career Growth", "Leadership", "Goals", "Ambition"],
      "lastUsed": "2024-06-08",
      "frequency": 88,
      "rating": 4.3,
    },
  ];

  List<Map<String, dynamic>> get filteredQuestions {
    return interviewQuestions.where((question) {
      bool matchesCategory = selectedCategory == "all" || question["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "all" || question["difficulty"] == selectedDifficulty;
      bool matchesSearch = searchQuery.isEmpty ||
          (question["question"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (question["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesDifficulty && matchesSearch;
    }).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "beginner":
        return successColor;
      case "intermediate":
        return warningColor;
      case "advanced":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "technical":
        return primaryColor;
      case "behavioral":
        return infoColor;
      case "company":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "technical":
        return Icons.code;
      case "behavioral":
        return Icons.psychology;
      case "company":
        return Icons.business;
      default:
        return Icons.help;
    }
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getCategoryColor(question["category"]).withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getCategoryIcon(question["category"]),
                  color: _getCategoryColor(question["category"]),
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(question["category"]).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${question["category"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getCategoryColor(question["category"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(question["difficulty"]).withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${question["difficulty"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getDifficultyColor(question["difficulty"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${question["frequency"]}% frequency",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.star,
                          size: 14,
                          color: warningColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(question["rating"] as double).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.bookmark_border,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Question
          Text(
            "${question["question"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
              height: 1.3,
            ),
          ),
          SizedBox(height: spSm),
          
          // Tags
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (question["tags"] as List).map((tag) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ).toList(),
          ),
          
          if (showAnswers) ...[
            SizedBox(height: spSm),
            Divider(color: disabledOutlineBorderColor),
            SizedBox(height: spSm),
            
            // Sample Answer
            Text(
              "Sample Answer:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: successColor,
              ),
            ),
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${question["sampleAnswer"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: spSm),
            
            // Tips
            Text(
              "Tips:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: infoColor,
              ),
            ),
            SizedBox(height: spXs),
            ...(question["tips"] as List).map((tip) => 
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
                        color: infoColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$tip",
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
            
            // Keywords
            Text(
              "Key Topics:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: warningColor,
              ),
            ),
            SizedBox(height: spXs),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (question["keywords"] as List).map((keyword) => 
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$keyword",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ],
          
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Practice",
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
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, Color color, IconData icon) {
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
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
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
        title: Text("Interview Questions"),
        actions: [
          IconButton(
            onPressed: () {
              showAnswers = !showAnswers;
              setState(() {});
            },
            icon: Icon(showAnswers ? Icons.visibility_off : Icons.visibility),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.quiz),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildStatsCard("Total Questions", "${interviewQuestions.length}", primaryColor, Icons.quiz),
                _buildStatsCard("Technical", "${interviewQuestions.where((q) => q["category"] == "technical").length}", primaryColor, Icons.code),
                _buildStatsCard("Behavioral", "${interviewQuestions.where((q) => q["category"] == "behavioral").length}", infoColor, Icons.psychology),
                _buildStatsCard("Company", "${interviewQuestions.where((q) => q["category"] == "company").length}", successColor, Icons.business),
              ],
            ),
            SizedBox(height: spLg),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search questions or tags",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.shuffle,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            // Category Filter
            QCategoryPicker(
              items: [
                {"label": "All Categories", "value": "all"},
                {"label": "Technical", "value": "technical"},
                {"label": "Behavioral", "value": "behavioral"},
                {"label": "Company", "value": "company"},
              ],
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            
            // Difficulty Filter
            QCategoryPicker(
              items: [
                {"label": "All Levels", "value": "all"},
                {"label": "Beginner", "value": "beginner"},
                {"label": "Intermediate", "value": "intermediate"},
                {"label": "Advanced", "value": "advanced"},
              ],
              value: selectedDifficulty,
              onChanged: (index, label, value, item) {
                selectedDifficulty = value;
                setState(() {});
              },
            ),
            SizedBox(height: spLg),
            
            // Questions List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Questions (${filteredQuestions.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: showAnswers ? successColor.withAlpha(51) : disabledColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    showAnswers ? "Answers Shown" : "Questions Only",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: showAnswers ? successColor : disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            ...filteredQuestions.map((question) => _buildQuestionCard(question)).toList(),
            
            if (filteredQuestions.isEmpty) ...[
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
                      Icons.quiz,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No questions found",
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
