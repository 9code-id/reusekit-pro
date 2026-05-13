import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaPollView extends StatefulWidget {
  const EmaPollView({super.key});

  @override
  State<EmaPollView> createState() => _EmaPollViewState();
}

class _EmaPollViewState extends State<EmaPollView> {
  String selectedFilter = "All";
  bool showCreatePoll = false;
  String newPollQuestion = "";
  List<String> newPollOptions = ["", ""];
  String pollTitle = "";
  String selectedCategory = "General";

  List<Map<String, dynamic>> polls = [
    {
      "id": 1,
      "title": "Daily Mood Check",
      "question": "How would you rate your overall mood today?",
      "category": "Mood",
      "options": ["Excellent", "Good", "Fair", "Poor"],
      "responses": [45, 32, 18, 5],
      "totalResponses": 100,
      "createdBy": "Dr. Smith",
      "createdAt": "2024-12-15",
      "status": "Active",
      "endDate": "2024-12-30",
    },
    {
      "id": 2,
      "title": "Sleep Quality Assessment",
      "question": "How would you rate your sleep quality last night?",
      "category": "Sleep",
      "options": ["Very Good", "Good", "Average", "Poor", "Very Poor"],
      "responses": [22, 35, 28, 12, 3],
      "totalResponses": 100,
      "createdBy": "Dr. Johnson",
      "createdAt": "2024-12-14",
      "status": "Active",
      "endDate": "2024-12-31",
    },
    {
      "id": 3,
      "title": "Exercise Frequency",
      "question": "How often did you exercise this week?",
      "category": "Health",
      "options": ["Daily", "4-6 times", "2-3 times", "Once", "Never"],
      "responses": [15, 25, 30, 20, 10],
      "totalResponses": 100,
      "createdBy": "Dr. Wilson",
      "createdAt": "2024-12-13",
      "status": "Completed",
      "endDate": "2024-12-20",
    },
  ];

  List<String> categories = ["All", "General", "Mood", "Sleep", "Health", "Stress", "Social"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMA Polls"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                showCreatePoll = true;
              });
            },
          ),
        ],
      ),
      body: showCreatePoll ? _buildCreatePollForm() : _buildPollsList(),
    );
  }

  Widget _buildPollsList() {
    final filteredPolls = selectedFilter == "All" 
        ? polls 
        : polls.where((poll) => poll["category"] == selectedFilter).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats overview
          Row(
            children: [
              _buildStatCard("Total Polls", "${polls.length}", Icons.poll, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Active", "${polls.where((p) => p["status"] == "Active").length}", Icons.play_circle, successColor),
            ],
          ),
          SizedBox(height: spMd),

          // Category filter
          QCategoryPicker(
            label: "Filter by Category",
            items: categories.map((cat) => {
              "label": cat,
              "value": cat,
            }).toList(),
            value: selectedFilter,
            onChanged: (index, label, value, item) {
              setState(() {
                selectedFilter = value;
              });
            },
          ),
          SizedBox(height: spMd),

          // Polls list
          Text(
            "Poll Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...filteredPolls.map((poll) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            child: _buildPollCard(poll),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Column(
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollCard(Map<String, dynamic> poll) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poll header
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: poll["status"] == "Active" ? successColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${poll["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${poll["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Poll title and question
          Text(
            "${poll["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${poll["question"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),

          // Poll options and results
          ...(poll["options"] as List<String>).asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final responses = (poll["responses"] as List<int>)[index];
            final totalResponses = poll["totalResponses"] as int;
            final percentage = totalResponses > 0 ? (responses / totalResponses * 100) : 0;

            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "$responses (${percentage.toInt()}%)",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            );
          }).toList(),
          SizedBox(height: spMd),

          // Poll footer
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "${poll["createdBy"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${poll["totalResponses"]} responses",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Ends: ${poll["endDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreatePollForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form header
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showCreatePoll = false;
                    _resetForm();
                  });
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Create New Poll",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Poll form
          QTextField(
            label: "Poll Title",
            value: pollTitle,
            hint: "Enter a descriptive title for your poll",
            onChanged: (value) {
              pollTitle = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),

          QTextField(
            label: "Poll Question",
            value: newPollQuestion,
            hint: "What question would you like to ask?",
            onChanged: (value) {
              newPollQuestion = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),

          QDropdownField(
            label: "Category",
            items: categories.skip(1).map((cat) => {
              "label": cat,
              "value": cat,
            }).toList(),
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),

          // Poll options
          Text(
            "Poll Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),

          ...newPollOptions.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;

            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Option ${index + 1}",
                      value: option,
                      hint: "Enter poll option",
                      onChanged: (value) {
                        newPollOptions[index] = value;
                        setState(() {});
                      },
                    ),
                  ),
                  if (newPollOptions.length > 2)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          newPollOptions.removeAt(index);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: spSm),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          Icons.delete,
                          color: dangerColor,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),

          // Add option button
          if (newPollOptions.length < 6)
            GestureDetector(
              onTap: () {
                setState(() {
                  newPollOptions.add("");
                });
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Add Option",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: spLg),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    setState(() {
                      showCreatePoll = false;
                      _resetForm();
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Poll",
                  size: bs.md,
                  onPressed: _createPoll,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    pollTitle = "";
    newPollQuestion = "";
    newPollOptions = ["", ""];
    selectedCategory = "General";
  }

  void _createPoll() {
    if (pollTitle.isEmpty || newPollQuestion.isEmpty) {
      se("Please fill in the poll title and question");
      return;
    }

    final validOptions = newPollOptions.where((option) => option.isNotEmpty).toList();
    if (validOptions.length < 2) {
      se("Please provide at least 2 poll options");
      return;
    }

    setState(() {
      polls.insert(0, {
        "id": polls.length + 1,
        "title": pollTitle,
        "question": newPollQuestion,
        "category": selectedCategory,
        "options": validOptions,
        "responses": List.filled(validOptions.length, 0),
        "totalResponses": 0,
        "createdBy": "You",
        "createdAt": DateTime.now().toString().substring(0, 10),
        "status": "Active",
        "endDate": DateTime.now().add(Duration(days: 14)).toString().substring(0, 10),
      });
      showCreatePoll = false;
      _resetForm();
    });

    ss("Poll created successfully!");
  }
}
