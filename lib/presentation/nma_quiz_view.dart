import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaQuizView extends StatefulWidget {
  const NmaQuizView({super.key});

  @override
  State<NmaQuizView> createState() => _NmaQuizViewState();
}

class _NmaQuizViewState extends State<NmaQuizView> {
  List<Map<String, dynamic>> quizzes = [
    {
      "id": "1",
      "title": "Current Affairs Quiz",
      "description": "Test your knowledge on recent news and events",
      "category": "Politics",
      "difficulty": "Medium",
      "questions": 15,
      "duration": 10,
      "participants": 2847,
      "image": "https://picsum.photos/300/200?random=1&keyword=politics",
      "tags": ["politics", "current affairs", "news"],
      "isActive": true,
      "startDate": "2024-01-15T09:00:00Z",
      "endDate": "2024-01-22T23:59:59Z",
      "prize": "News Subscription",
      "completed": false,
      "score": null,
    },
    {
      "id": "2",
      "title": "Sports Knowledge Challenge",
      "description": "How well do you know international sports?",
      "category": "Sports",
      "difficulty": "Easy",
      "questions": 20,
      "duration": 15,
      "participants": 1953,
      "image": "https://picsum.photos/300/200?random=2&keyword=sports",
      "tags": ["sports", "football", "olympics"],
      "isActive": true,
      "startDate": "2024-01-16T10:00:00Z",
      "endDate": "2024-01-25T23:59:59Z",
      "prize": "Sports Magazine",
      "completed": true,
      "score": 85,
    },
    {
      "id": "3",
      "title": "Science & Technology Quiz",
      "description": "Latest developments in science and tech",
      "category": "Technology",
      "difficulty": "Hard",
      "questions": 12,
      "duration": 12,
      "participants": 892,
      "image": "https://picsum.photos/300/200?random=3&keyword=technology",
      "tags": ["science", "technology", "innovation"],
      "isActive": true,
      "startDate": "2024-01-17T14:00:00Z",
      "endDate": "2024-01-30T23:59:59Z",
      "prize": "Tech Gadget",
      "completed": false,
      "score": null,
    },
    {
      "id": "4",
      "title": "History & Culture Quiz",
      "description": "Explore world history and cultural heritage",
      "category": "Culture",
      "difficulty": "Medium",
      "questions": 18,
      "duration": 20,
      "participants": 1456,
      "image": "https://picsum.photos/300/200?random=4&keyword=history",
      "tags": ["history", "culture", "heritage"],
      "isActive": false,
      "startDate": "2024-01-10T09:00:00Z",
      "endDate": "2024-01-14T23:59:59Z",
      "prize": "History Book Set",
      "completed": true,
      "score": 72,
    },
    {
      "id": "5",
      "title": "Entertainment Trivia",
      "description": "Movies, music, and celebrity knowledge",
      "category": "Entertainment",
      "difficulty": "Easy",
      "questions": 25,
      "duration": 18,
      "participants": 3421,
      "image": "https://picsum.photos/300/200?random=5&keyword=entertainment",
      "tags": ["movies", "music", "celebrities"],
      "isActive": true,
      "startDate": "2024-01-18T16:00:00Z",
      "endDate": "2024-02-01T23:59:59Z",
      "prize": "Movie Tickets",
      "completed": false,
      "score": null,
    },
    {
      "id": "6",
      "title": "Business & Economy Quiz",
      "description": "Test your business and economic knowledge",
      "category": "Business",
      "difficulty": "Hard",
      "questions": 14,
      "duration": 16,
      "participants": 687,
      "image": "https://picsum.photos/300/200?random=6&keyword=business",
      "tags": ["business", "economy", "finance"],
      "isActive": true,
      "startDate": "2024-01-19T11:00:00Z",
      "endDate": "2024-01-28T23:59:59Z",
      "prize": "Business Magazine",
      "completed": false,
      "score": null,
    },
  ];

  List<Map<String, dynamic>> filteredQuizzes = [];
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedDifficulty = "All";
  String selectedStatus = "All";
  String sortBy = "Recent";

  List<String> categories = [
    "All",
    "Politics",
    "Sports", 
    "Technology",
    "Culture",
    "Entertainment",
    "Business"
  ];

  List<String> difficulties = ["All", "Easy", "Medium", "Hard"];
  List<String> statuses = ["All", "Active", "Completed", "Upcoming"];
  List<String> sortOptions = ["Recent", "Popular", "Difficulty", "Duration"];

  @override
  void initState() {
    super.initState();
    _filterQuizzes();
  }

  void _filterQuizzes() {
    filteredQuizzes = quizzes.where((quiz) {
      bool matchesSearch = searchQuery.isEmpty ||
          ("${quiz["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
           "${quiz["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
           (quiz["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase())));

      bool matchesCategory = selectedCategory == "All" || quiz["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "All" || quiz["difficulty"] == selectedDifficulty;
      
      bool matchesStatus = selectedStatus == "All" ||
          (selectedStatus == "Active" && quiz["isActive"] == true) ||
          (selectedStatus == "Completed" && quiz["completed"] == true) ||
          (selectedStatus == "Upcoming" && quiz["isActive"] == false && quiz["completed"] == false);

      return matchesSearch && matchesCategory && matchesDifficulty && matchesStatus;
    }).toList();

    // Apply sorting
    switch (sortBy) {
      case "Popular":
        filteredQuizzes.sort((a, b) => (b["participants"] as int).compareTo(a["participants"] as int));
        break;
      case "Difficulty":
        filteredQuizzes.sort((a, b) {
          Map<String, int> difficultyOrder = {"Easy": 1, "Medium": 2, "Hard": 3};
          return (difficultyOrder[a["difficulty"]] ?? 0).compareTo(difficultyOrder[b["difficulty"]] ?? 0);
        });
        break;
      case "Duration":
        filteredQuizzes.sort((a, b) => (a["duration"] as int).compareTo(b["duration"] as int));
        break;
      default: // Recent
        filteredQuizzes.sort((a, b) => DateTime.parse("${b["startDate"]}").compareTo(DateTime.parse("${a["startDate"]}")));
    }

    setState(() {});
  }

  void _startQuiz(Map<String, dynamic> quiz) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Start Quiz"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${quiz["title"]}"),
            SizedBox(height: spSm),
            Text("Questions: ${quiz["questions"]}"),
            Text("Duration: ${quiz["duration"]} minutes"),
            Text("Difficulty: ${quiz["difficulty"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Start Quiz",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Quiz started! Good luck!");
            },
          ),
        ],
      ),
    );
  }

  void _viewResults(Map<String, dynamic> quiz) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quiz Results"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${quiz["title"]}"),
            SizedBox(height: spSm),
            Text(
              "Your Score: ${quiz["score"]}%",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: (quiz["score"] as int) >= 70 ? successColor : dangerColor,
              ),
            ),
            SizedBox(height: spSm),
            Text("Questions: ${quiz["questions"]}"),
            Text("Participants: ${quiz["participants"]}"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(Map<String, dynamic> quiz) {
    bool isCompleted = quiz["completed"] == true;
    bool isActive = quiz["isActive"] == true;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quiz Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            child: Stack(
              children: [
                Image.network(
                  "${quiz["image"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: isCompleted ? successColor : isActive ? primaryColor : disabledColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      isCompleted ? "Completed" : isActive ? "Active" : "Ended",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (quiz["score"] != null)
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${quiz["score"]}%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Quiz Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${quiz["category"]}",
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
                        color: quiz["difficulty"] == "Easy" ? successColor.withAlpha(20) :
                               quiz["difficulty"] == "Medium" ? warningColor.withAlpha(20) :
                               dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${quiz["difficulty"]}",
                        style: TextStyle(
                          color: quiz["difficulty"] == "Easy" ? successColor :
                                 quiz["difficulty"] == "Medium" ? warningColor :
                                 dangerColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${quiz["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${quiz["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(Icons.quiz, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${quiz["questions"]} questions",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.timer, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${quiz["duration"]} min",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.people, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${quiz["participants"]}",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: isCompleted 
                        ? QButton(
                            label: "View Results",
                            size: bs.sm,
                            onPressed: () => _viewResults(quiz),
                          )
                        : isActive
                          ? QButton(
                              label: "Start Quiz",
                              size: bs.sm,
                              onPressed: () => _startQuiz(quiz),
                            )
                          : QButton(
                              label: "Quiz Ended",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        si("Quiz shared successfully!");
                      },
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.share,
                          color: disabledBoldColor,
                          size: 18,
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.leaderboard),
            onPressed: () {
              si("Leaderboard coming soon!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search quizzes...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                _filterQuizzes();
              },
            ),
            
            SizedBox(height: spSm),
            
            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      _filterQuizzes();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Difficulty",
                    items: difficulties.map((difficulty) => {
                      "label": difficulty,
                      "value": difficulty,
                    }).toList(),
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      _filterQuizzes();
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statuses.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      _filterQuizzes();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      _filterQuizzes();
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${quizzes.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Quizzes",
                          style: TextStyle(
                            fontSize: 12,
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${quizzes.where((q) => q["completed"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${quizzes.where((q) => q["isActive"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Showing ${filteredQuizzes.length} quiz${filteredQuizzes.length != 1 ? 'es' : ''}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    searchQuery = "";
                    selectedCategory = "All";
                    selectedDifficulty = "All";
                    selectedStatus = "All";
                    sortBy = "Recent";
                    _filterQuizzes();
                  },
                  child: Text(
                    "Clear Filters",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Quizzes List
            if (filteredQuizzes.isEmpty)
              Container(
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No quizzes found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredQuizzes.map((quiz) => _buildQuizCard(quiz)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
