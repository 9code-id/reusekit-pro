import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSurveysView extends StatefulWidget {
  const NmaSurveysView({super.key});

  @override
  State<NmaSurveysView> createState() => _NmaSurveysViewState();
}

class _NmaSurveysViewState extends State<NmaSurveysView> {
  List<Map<String, dynamic>> surveys = [
    {
      "id": 1,
      "title": "Community Services Satisfaction Survey",
      "description": "Help us improve city services by sharing your experience with various departments",
      "category": "Community",
      "author": "City Administration",
      "date": "2025-06-16",
      "endDate": "2025-07-15",
      "estimatedTime": "5-8 minutes",
      "responses": 1240,
      "isActive": true,
      "hasCompleted": false,
      "progress": 0,
      "totalQuestions": 15,
      "incentive": "Entry into \$500 gift card drawing",
      "tags": ["services", "satisfaction", "improvement"],
      "difficulty": "Easy",
    },
    {
      "id": 2,
      "title": "Local Sports Program Assessment",
      "description": "Evaluate current sports programs and suggest improvements for youth athletics",
      "category": "Sports",
      "author": "Recreation Department",
      "date": "2025-06-15",
      "endDate": "2025-06-30",
      "estimatedTime": "8-12 minutes",
      "responses": 567,
      "isActive": true,
      "hasCompleted": true,
      "progress": 100,
      "totalQuestions": 22,
      "incentive": "Free community center day pass",
      "tags": ["sports", "youth", "programs", "athletics"],
      "difficulty": "Medium",
    },
    {
      "id": 3,
      "title": "Emergency Preparedness Survey",
      "description": "Assess community readiness for natural disasters and emergency situations",
      "category": "Community",
      "author": "Emergency Management",
      "date": "2025-06-14",
      "endDate": "2025-07-01",
      "estimatedTime": "10-15 minutes",
      "responses": 892,
      "isActive": true,
      "hasCompleted": false,
      "progress": 35,
      "totalQuestions": 28,
      "incentive": "Free emergency kit",
      "tags": ["emergency", "preparedness", "safety", "disaster"],
      "difficulty": "Medium",
    },
    {
      "id": 4,
      "title": "School District Feedback Survey",
      "description": "Parents and students share feedback on educational programs and facilities",
      "category": "Education",
      "author": "School Board",
      "date": "2025-06-13",
      "endDate": "2025-06-25",
      "estimatedTime": "12-18 minutes",
      "responses": 2156,
      "isActive": true,
      "hasCompleted": false,
      "progress": 0,
      "totalQuestions": 35,
      "incentive": "School supply donation in your name",
      "tags": ["education", "schools", "programs", "facilities"],
      "difficulty": "Medium",
    },
    {
      "id": 5,
      "title": "Public Transportation Usage Study",
      "description": "Share your commuting habits and preferences for future transit planning",
      "category": "Transportation",
      "author": "Transit Authority",
      "date": "2025-06-12",
      "endDate": "2025-06-20",
      "estimatedTime": "6-10 minutes",
      "responses": 789,
      "isActive": true,
      "hasCompleted": false,
      "progress": 0,
      "totalQuestions": 18,
      "incentive": "Free monthly bus pass",
      "tags": ["transportation", "commuting", "transit", "planning"],
      "difficulty": "Easy",
    },
    {
      "id": 6,
      "title": "Climate Action Community Survey",
      "description": "Help shape our city's environmental policies and sustainability initiatives",
      "category": "Environment",
      "author": "Environmental Department",
      "date": "2025-06-08",
      "endDate": "2025-06-15",
      "estimatedTime": "15-20 minutes",
      "responses": 456,
      "isActive": false,
      "hasCompleted": true,
      "progress": 100,
      "totalQuestions": 42,
      "incentive": "Tree planted in your honor",
      "tags": ["environment", "climate", "sustainability", "policy"],
      "difficulty": "Hard",
    },
  ];

  List<String> categories = ["All", "Community", "Sports", "Education", "Transportation", "Environment"];
  List<String> statusFilters = ["All", "Active", "Completed", "In Progress"];
  List<String> difficultyFilters = ["All Levels", "Easy", "Medium", "Hard"];
  
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedDifficulty = "All Levels";
  String searchQuery = "";
  String sortBy = "Newest";

  List<Map<String, dynamic>> get filteredSurveys {
    List<Map<String, dynamic>> filtered = surveys;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((survey) => survey["category"] == selectedCategory).toList();
    }

    // Filter by status
    if (selectedStatus != "All") {
      switch (selectedStatus) {
        case "Active":
          filtered = filtered.where((survey) => survey["isActive"] as bool).toList();
          break;
        case "Completed":
          filtered = filtered.where((survey) => survey["hasCompleted"] as bool).toList();
          break;
        case "In Progress":
          filtered = filtered.where((survey) => 
            (survey["progress"] as int) > 0 && !(survey["hasCompleted"] as bool)).toList();
          break;
      }
    }

    // Filter by difficulty
    if (selectedDifficulty != "All Levels") {
      filtered = filtered.where((survey) => survey["difficulty"] == selectedDifficulty).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((survey) {
        final title = (survey["title"] as String).toLowerCase();
        final description = (survey["description"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    }

    // Sort
    switch (sortBy) {
      case "Most Responses":
        filtered.sort((a, b) => (b["responses"] as int).compareTo(a["responses"] as int));
        break;
      case "Shortest First":
        filtered.sort((a, b) => a["totalQuestions"].compareTo(b["totalQuestions"]));
        break;
      case "Ending Soon":
        filtered.sort((a, b) => a["endDate"].compareTo(b["endDate"]));
        break;
      case "Oldest":
        filtered.sort((a, b) => a["date"].compareTo(b["date"]));
        break;
      default: // Newest
        filtered.sort((a, b) => b["date"].compareTo(a["date"]));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surveys"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            padding: EdgeInsets.all(spSm),
            child: QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          // Active Filters Info
          if (selectedStatus != "All" || selectedDifficulty != "All Levels" || searchQuery.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Wrap(
                spacing: spXs,
                children: [
                  if (selectedStatus != "All")
                    Chip(
                      label: Text(selectedStatus),
                      deleteIcon: Icon(Icons.close, size: 16),
                      onDeleted: () {
                        selectedStatus = "All";
                        setState(() {});
                      },
                    ),
                  if (selectedDifficulty != "All Levels")
                    Chip(
                      label: Text(selectedDifficulty),
                      deleteIcon: Icon(Icons.close, size: 16),
                      onDeleted: () {
                        selectedDifficulty = "All Levels";
                        setState(() {});
                      },
                    ),
                  if (searchQuery.isNotEmpty)
                    Chip(
                      label: Text("\"$searchQuery\""),
                      deleteIcon: Icon(Icons.close, size: 16),
                      onDeleted: () {
                        searchQuery = "";
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),

          // Surveys List
          Expanded(
            child: filteredSurveys.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No surveys found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Try adjusting your filters",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(spSm),
                    itemCount: filteredSurveys.length,
                    separatorBuilder: (context, index) => SizedBox(height: spSm),
                    itemBuilder: (context, index) {
                      final survey = filteredSurveys[index];
                      return _buildSurveyCard(survey);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurveyCard(Map<String, dynamic> survey) {
    final isActive = survey["isActive"] as bool;
    final hasCompleted = survey["hasCompleted"] as bool;
    final progress = survey["progress"] as int;
    final isInProgress = progress > 0 && !hasCompleted;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: hasCompleted 
              ? successColor.withAlpha(100)
              : isInProgress 
                  ? warningColor.withAlpha(100)
                  : isActive 
                      ? primaryColor.withAlpha(100) 
                      : disabledOutlineBorderColor,
          width: (hasCompleted || isInProgress || isActive) ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Survey Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${survey["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${survey["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: hasCompleted
                      ? successColor
                      : isInProgress
                          ? warningColor
                          : isActive
                              ? infoColor
                              : disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  hasCompleted
                      ? "COMPLETED"
                      : isInProgress
                          ? "IN PROGRESS"
                          : isActive
                              ? "ACTIVE"
                              : "ENDED",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Progress Bar (if started)
          if (isInProgress) ...[
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: disabledColor.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${progress}% complete",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
          ],

          // Survey Info
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${survey["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(survey["difficulty"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${survey["difficulty"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getDifficultyColor(survey["difficulty"]),
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.schedule, size: 14, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${survey["estimatedTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),

          // Questions and Author
          Row(
            children: [
              Icon(Icons.quiz, size: 14, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${survey["totalQuestions"]} questions",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.person, size: 14, color: disabledBoldColor),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "${survey["author"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),

          // End Date
          Row(
            children: [
              Icon(Icons.event, size: 14, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "Ends: ${DateTime.parse(survey["endDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Incentive
          if (survey["incentive"] != null && (survey["incentive"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.card_giftcard, size: 16, color: successColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Incentive: ${survey["incentive"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: spSm),

          // Stats and Action
          Row(
            children: [
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${(survey["responses"] as int).toString()} responses",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (hasCompleted)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 12, color: successColor),
                      SizedBox(width: 4),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              if (!hasCompleted && isActive) ...[
                if (isInProgress)
                  QButton(
                    label: "Continue",
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () => _takeSurvey(survey, true),
                  )
                else
                  QButton(
                    label: "Take Survey",
                    icon: Icons.assignment,
                    size: bs.sm,
                    onPressed: () => _takeSurvey(survey, false),
                  ),
              ],
              if (!isActive)
                Text(
                  "Survey Ended",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showSearchDialog() {
    String tempSearch = searchQuery;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Surveys"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Search term",
              value: tempSearch,
              hint: "Enter title, description, or keyword",
              onChanged: (value) {
                tempSearch = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              searchQuery = tempSearch;
              setState(() {});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Filters & Sort",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Filter
                    QDropdownField(
                      label: "Status",
                      items: statusFilters.map((status) => {
                        "label": status,
                        "value": status,
                      }).toList(),
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),

                    // Difficulty Filter
                    QDropdownField(
                      label: "Difficulty Level",
                      items: difficultyFilters.map((difficulty) => {
                        "label": difficulty,
                        "value": difficulty,
                      }).toList(),
                      value: selectedDifficulty,
                      onChanged: (value, label) {
                        selectedDifficulty = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),

                    // Sort Options
                    QDropdownField(
                      label: "Sort by",
                      items: [
                        {"label": "Newest", "value": "Newest"},
                        {"label": "Oldest", "value": "Oldest"},
                        {"label": "Most Responses", "value": "Most Responses"},
                        {"label": "Shortest First", "value": "Shortest First"},
                        {"label": "Ending Soon", "value": "Ending Soon"},
                      ],
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spLg),

                    // Clear Filters
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear All Filters",
                        icon: Icons.clear_all,
                        size: bs.sm,
                        onPressed: () {
                          selectedStatus = "All";
                          selectedDifficulty = "All Levels";
                          selectedCategory = "All";
                          searchQuery = "";
                          sortBy = "Newest";
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _takeSurvey(Map<String, dynamic> survey, bool isContinuing) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isContinuing ? "Continue Survey" : "Start Survey"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${survey["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Text("${survey["description"]}"),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text("${survey["estimatedTime"]}"),
              ],
            ),
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.quiz, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text("${survey["totalQuestions"]} questions"),
              ],
            ),
            if (survey["incentive"] != null && (survey["incentive"] as String).isNotEmpty) ...[
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.card_giftcard, size: 16, color: successColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${survey["incentive"]}",
                      style: TextStyle(color: successColor),
                    ),
                  ),
                ],
              ),
            ],
            if (isContinuing) ...[
              SizedBox(height: spSm),
              LinearProgressIndicator(
                value: (survey["progress"] as int) / 100,
                backgroundColor: disabledColor.withAlpha(50),
                valueColor: AlwaysStoppedAnimation<Color>(warningColor),
              ),
              SizedBox(height: spXs),
              Text(
                "${survey["progress"]}% completed",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: isContinuing ? "Continue" : "Start Survey",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              if (!isContinuing) {
                survey["progress"] = 25; // Simulate starting progress
                setState(() {});
              }
              ss(isContinuing ? "Continuing survey..." : "Starting survey...");
            },
          ),
        ],
      ),
    );
  }
}
