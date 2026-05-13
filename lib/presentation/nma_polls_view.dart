import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPollsView extends StatefulWidget {
  const NmaPollsView({super.key});

  @override
  State<NmaPollsView> createState() => _NmaPollsViewState();
}

class _NmaPollsViewState extends State<NmaPollsView> {
  List<Map<String, dynamic>> polls = [
    {
      "id": 1,
      "title": "Should the city increase funding for public transportation?",
      "description": "Vote on whether you support increased budget allocation for buses and trains",
      "category": "Politics",
      "author": "City Planning Department",
      "date": "2025-06-16",
      "endDate": "2025-06-23",
      "totalVotes": 2850,
      "isActive": true,
      "hasVoted": false,
      "userVote": null,
      "options": [
        {"id": 1, "text": "Yes, increase funding", "votes": 1620, "percentage": 56.8},
        {"id": 2, "text": "No, keep current budget", "votes": 854, "percentage": 30.0},
        {"id": 3, "text": "Reduce funding", "votes": 376, "percentage": 13.2},
      ],
      "allowMultiple": false,
      "showResults": true,
    },
    {
      "id": 2,
      "title": "Which sports should receive more coverage in local news?",
      "description": "Help us prioritize which sports stories matter most to our community",
      "category": "Sports",
      "author": "Sports News Team",
      "date": "2025-06-15",
      "endDate": "2025-06-20",
      "totalVotes": 1240,
      "isActive": true,
      "hasVoted": true,
      "userVote": [2],
      "options": [
        {"id": 1, "text": "High School Football", "votes": 456, "percentage": 36.8},
        {"id": 2, "text": "Basketball", "votes": 312, "percentage": 25.2},
        {"id": 3, "text": "Soccer", "votes": 234, "percentage": 18.9},
        {"id": 4, "text": "Baseball", "votes": 156, "percentage": 12.6},
        {"id": 5, "text": "Other sports", "votes": 82, "percentage": 6.6},
      ],
      "allowMultiple": false,
      "showResults": true,
    },
    {
      "id": 3,
      "title": "What weather information is most important to you?",
      "description": "Select all weather features you find most useful in our forecasts",
      "category": "Weather",
      "author": "Weather Team",
      "date": "2025-06-14",
      "endDate": "2025-06-21",
      "totalVotes": 890,
      "isActive": true,
      "hasVoted": false,
      "userVote": null,
      "options": [
        {"id": 1, "text": "7-day forecast", "votes": 567, "percentage": 63.7},
        {"id": 2, "text": "Hourly precipitation", "votes": 445, "percentage": 50.0},
        {"id": 3, "text": "Severe weather alerts", "votes": 623, "percentage": 70.0},
        {"id": 4, "text": "UV index", "votes": 234, "percentage": 26.3},
        {"id": 5, "text": "Air quality", "votes": 345, "percentage": 38.8},
      ],
      "allowMultiple": true,
      "showResults": false,
    },
    {
      "id": 4,
      "title": "Rate the city's response to recent storm damage",
      "description": "How would you rate the emergency response and cleanup efforts?",
      "category": "Community",
      "author": "Emergency Management",
      "date": "2025-06-13",
      "endDate": "2025-06-18",
      "totalVotes": 1567,
      "isActive": true,
      "hasVoted": true,
      "userVote": [2],
      "options": [
        {"id": 1, "text": "Excellent", "votes": 234, "percentage": 14.9},
        {"id": 2, "text": "Good", "votes": 567, "percentage": 36.2},
        {"id": 3, "text": "Fair", "votes": 456, "percentage": 29.1},
        {"id": 4, "text": "Poor", "votes": 310, "percentage": 19.8},
      ],
      "allowMultiple": false,
      "showResults": true,
    },
    {
      "id": 5,
      "title": "Best time for school board meetings",
      "description": "When would you prefer school board meetings to be scheduled?",
      "category": "Education",
      "author": "School Board",
      "date": "2025-06-10",
      "endDate": "2025-06-15",
      "totalVotes": 456,
      "isActive": false,
      "hasVoted": false,
      "userVote": null,
      "options": [
        {"id": 1, "text": "Weekday evenings", "votes": 234, "percentage": 51.3},
        {"id": 2, "text": "Weekend mornings", "votes": 123, "percentage": 27.0},
        {"id": 3, "text": "Weekend afternoons", "votes": 67, "percentage": 14.7},
        {"id": 4, "text": "Weekday afternoons", "votes": 32, "percentage": 7.0},
      ],
      "allowMultiple": false,
      "showResults": true,
    },
  ];

  List<String> categories = ["All", "Politics", "Sports", "Weather", "Community", "Education"];
  List<String> statusFilters = ["All", "Active", "Completed"];
  String selectedCategory = "All";
  String selectedStatus = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> get filteredPolls {
    List<Map<String, dynamic>> filtered = polls;

    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((poll) => poll["category"] == selectedCategory).toList();
    }

    // Filter by status
    if (selectedStatus != "All") {
      if (selectedStatus == "Active") {
        filtered = filtered.where((poll) => poll["isActive"] as bool).toList();
      } else if (selectedStatus == "Completed") {
        filtered = filtered.where((poll) => !(poll["isActive"] as bool)).toList();
      }
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((poll) {
        final title = (poll["title"] as String).toLowerCase();
        final description = (poll["description"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    }

    return filtered..sort((a, b) => b["date"].compareTo(a["date"]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polls & Voting"),
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

          // Polls List
          Expanded(
            child: filteredPolls.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.poll,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No polls found",
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
                    itemCount: filteredPolls.length,
                    separatorBuilder: (context, index) => SizedBox(height: spSm),
                    itemBuilder: (context, index) {
                      final poll = filteredPolls[index];
                      return _buildPollCard(poll);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPollCard(Map<String, dynamic> poll) {
    final isActive = poll["isActive"] as bool;
    final hasVoted = poll["hasVoted"] as bool;
    final allowMultiple = poll["allowMultiple"] as bool;
    final showResults = poll["showResults"] as bool;
    final userVote = poll["userVote"] as List?;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isActive ? primaryColor.withAlpha(100) : disabledOutlineBorderColor,
          width: isActive ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poll Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      "${poll["description"]}",
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
                  color: isActive ? successColor : disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  isActive ? "ACTIVE" : "ENDED",
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

          // Poll Info
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${poll["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Icon(Icons.person, size: 14, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${poll["author"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Ends: ${DateTime.parse(poll["endDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Poll Options
          Column(
            children: (poll["options"] as List).map<Widget>((option) {
              return _buildPollOption(poll, option, hasVoted, showResults, userVote);
            }).toList(),
          ),

          SizedBox(height: spSm),

          // Poll Stats and Actions
          Row(
            children: [
              Icon(Icons.how_to_vote, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${(poll["totalVotes"] as int).toString()} votes",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (allowMultiple) ...[
                SizedBox(width: spSm),
                Icon(Icons.check_box, size: 16, color: infoColor),
                SizedBox(width: 4),
                Text(
                  "Multiple choice",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                  ),
                ),
              ],
              Spacer(),
              if (hasVoted)
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
                        "Voted",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              if (!hasVoted && isActive) ...[
                SizedBox(width: spSm),
                QButton(
                  label: "Vote Now",
                  icon: Icons.how_to_vote,
                  size: bs.sm,
                  onPressed: () => _showVoteDialog(poll),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPollOption(Map<String, dynamic> poll, Map<String, dynamic> option, bool hasVoted, bool showResults, List? userVote) {
    final percentage = option["percentage"] as double;
    final votes = option["votes"] as int;
    final isUserChoice = userVote?.contains(option["id"]) ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${option["text"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isUserChoice ? FontWeight.w600 : FontWeight.normal,
                    color: isUserChoice ? primaryColor : Colors.black87,
                  ),
                ),
              ),
              if (showResults && hasVoted) ...[
                Text(
                  "${percentage.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "($votes)",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
              if (isUserChoice)
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: primaryColor,
                ),
            ],
          ),
          if (showResults && hasVoted) ...[
            SizedBox(height: spXs),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: isUserChoice ? primaryColor : primaryColor.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showSearchDialog() {
    String tempSearch = searchQuery;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Polls"),
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
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Polls",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showVoteDialog(Map<String, dynamic> poll) {
    final allowMultiple = poll["allowMultiple"] as bool;
    List<int> selectedOptions = [];
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Cast Your Vote"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${poll["title"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              if (allowMultiple)
                Text(
                  "You can select multiple options",
                  style: TextStyle(
                    fontSize: 13,
                    color: infoColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              SizedBox(height: spSm),
              
              ...(poll["options"] as List).map<Widget>((option) {
                final isSelected = selectedOptions.contains(option["id"]);
                
                return GestureDetector(
                  onTap: () {
                    if (allowMultiple) {
                      if (isSelected) {
                        selectedOptions.remove(option["id"]);
                      } else {
                        selectedOptions.add(option["id"]);
                      }
                    } else {
                      selectedOptions = [option["id"]];
                    }
                    setDialogState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          allowMultiple 
                              ? (isSelected ? Icons.check_box : Icons.check_box_outline_blank)
                              : (isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${option["text"]}",
                            style: TextStyle(
                              color: isSelected ? primaryColor : Colors.black87,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Submit Vote",
              size: bs.sm,
              onPressed: selectedOptions.isEmpty ? null : () {
                _submitVote(poll, selectedOptions);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitVote(Map<String, dynamic> poll, List<int> selectedOptions) {
    // Update poll data
    poll["hasVoted"] = true;
    poll["userVote"] = selectedOptions;
    poll["totalVotes"] = (poll["totalVotes"] as int) + 1;
    
    // Update vote counts for selected options
    for (var option in poll["options"] as List) {
      if (selectedOptions.contains(option["id"])) {
        option["votes"] = (option["votes"] as int) + 1;
      }
    }
    
    // Recalculate percentages
    final totalVotes = poll["totalVotes"] as int;
    for (var option in poll["options"] as List) {
      option["percentage"] = ((option["votes"] as int) / totalVotes) * 100;
    }
    
    setState(() {});
    ss("Vote submitted successfully!");
  }
}
