import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCandidateListView extends StatefulWidget {
  const RhaCandidateListView({super.key});

  @override
  State<RhaCandidateListView> createState() => _RhaCandidateListViewState();
}

class _RhaCandidateListViewState extends State<RhaCandidateListView> {
  List<Map<String, dynamic>> candidates = [
    {
      "id": "cand_001",
      "name": "John Smith",
      "email": "john.smith@email.com",
      "phone": "+1 (555) 123-4567",
      "position": "Senior Flutter Developer",
      "status": "Active",
      "stage": "Interview Scheduled",
      "experience": "5 years",
      "location": "San Francisco, CA",
      "match_score": 92,
      "applied_date": "2024-06-15",
      "last_activity": "2024-06-18",
      "salary_expectation": "\$130,000",
      "skills": ["Flutter", "Dart", "Firebase", "REST API", "Git"],
      "source": "LinkedIn",
      "resume_url": "https://example.com/resume1.pdf",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
    },
    {
      "id": "cand_002",
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "phone": "+1 (555) 987-6543",
      "position": "Flutter Developer",
      "status": "Active",
      "stage": "Technical Assessment",
      "experience": "3 years",
      "location": "Remote",
      "match_score": 87,
      "applied_date": "2024-06-16",
      "last_activity": "2024-06-19",
      "salary_expectation": "\$110,000",
      "skills": ["Flutter", "Dart", "GraphQL", "State Management"],
      "source": "Indeed",
      "resume_url": "https://example.com/resume2.pdf",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
    },
    {
      "id": "cand_003",
      "name": "Mike Chen",
      "email": "mike.chen@email.com",
      "phone": "+1 (555) 456-7890",
      "position": "Mobile Developer",
      "status": "Active",
      "stage": "HR Review",
      "experience": "4 years",
      "location": "Seattle, WA",
      "match_score": 78,
      "applied_date": "2024-06-14",
      "last_activity": "2024-06-17",
      "salary_expectation": "\$120,000",
      "skills": ["Flutter", "React Native", "iOS", "Android"],
      "source": "Company Website",
      "resume_url": "https://example.com/resume3.pdf",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=man",
    },
    {
      "id": "cand_004",
      "name": "Emily Davis",
      "email": "emily.davis@email.com",
      "phone": "+1 (555) 234-5678",
      "position": "Senior Flutter Developer",
      "status": "On Hold",
      "stage": "Reference Check",
      "experience": "6 years",
      "location": "New York, NY",
      "match_score": 95,
      "applied_date": "2024-06-12",
      "last_activity": "2024-06-16",
      "salary_expectation": "\$140,000",
      "skills": ["Flutter", "Dart", "Firebase", "AWS", "CI/CD"],
      "source": "Referral",
      "resume_url": "https://example.com/resume4.pdf",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=professional",
    },
    {
      "id": "cand_005",
      "name": "David Wilson",
      "email": "david.wilson@email.com",
      "phone": "+1 (555) 345-6789",
      "position": "Flutter Developer",
      "status": "Active",
      "stage": "Screening",
      "experience": "2 years",
      "location": "Austin, TX",
      "match_score": 72,
      "applied_date": "2024-06-18",
      "last_activity": "2024-06-19",
      "salary_expectation": "\$95,000",
      "skills": ["Flutter", "Dart", "JSON", "HTTP"],
      "source": "Glassdoor",
      "resume_url": "https://example.com/resume5.pdf",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=developer",
    },
    {
      "id": "cand_006",
      "name": "Lisa Anderson",
      "email": "lisa.anderson@email.com",
      "phone": "+1 (555) 567-8901",
      "position": "Senior Mobile Developer",
      "status": "Active",
      "stage": "Interview Completed",
      "experience": "7 years",
      "location": "Los Angeles, CA",
      "match_score": 89,
      "applied_date": "2024-06-10",
      "last_activity": "2024-06-18",
      "salary_expectation": "\$145,000",
      "skills": ["Flutter", "Dart", "Kotlin", "Swift", "Architecture"],
      "source": "Referral",
      "resume_url": "https://example.com/resume6.pdf",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=female",
    },
  ];

  List<String> selectedCandidates = [];
  String searchQuery = "";
  String filterStatus = "All";
  String filterStage = "All";
  String sortBy = "Applied Date";
  bool isDescending = true;
  bool isLoading = false;
  bool isGridView = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCandidates = _getFilteredCandidates();

    return Scaffold(
      appBar: AppBar(
        title: Text("Candidates (${filteredCandidates.length})"),
        actions: [
          QButton(
            icon: isGridView ? Icons.list : Icons.grid_view,
            size: bs.sm,
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () => _showFilterDialog(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          if (selectedCandidates.isNotEmpty) _buildBulkActionBar(),
          Expanded(
            child: isLoading
              ? Center(child: CircularProgressIndicator())
              : isGridView
                ? _buildGridView(filteredCandidates)
                : _buildListView(filteredCandidates),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search candidates",
                  value: searchQuery,
                  hint: "Name, email, skills...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.md,
                onPressed: () => _performSearch(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QCategoryPicker(
                  label: "Status",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Active", "value": "Active"},
                    {"label": "On Hold", "value": "On Hold"},
                    {"label": "Rejected", "value": "Rejected"},
                  ],
                  value: filterStatus,
                  onChanged: (index, label, value, item) {
                    filterStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Sort: $sortBy",
                size: bs.sm,
                icon: isDescending ? Icons.arrow_downward : Icons.arrow_upward,
                onPressed: () => _showSortDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActionBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: primaryColor.withAlpha(20),
      child: Row(
        children: [
          Text(
            "${selectedCandidates.length} selected",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Spacer(),
          QButton(
            label: "Message",
            size: bs.sm,
            icon: Icons.message,
            onPressed: () => _bulkMessage(),
          ),
          SizedBox(width: spSm),
          QButton(
            label: "Update Status",
            size: bs.sm,
            icon: Icons.update,
            onPressed: () => _bulkUpdateStatus(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.clear,
            size: bs.sm,
            onPressed: () {
              selectedCandidates.clear();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> candidates) {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: candidates.length,
      itemBuilder: (context, index) {
        final candidate = candidates[index];
        bool isSelected = selectedCandidates.contains(candidate["id"]);

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: GestureDetector(
            onTap: () {
              //navigateTo('RhaCandidateDetailView')
            },
            onLongPress: () => _toggleSelection(candidate["id"]),
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: isSelected 
                  ? Border.all(color: primaryColor, width: 2)
                  : null,
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _toggleSelection(candidate["id"]),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          child: isSelected
                            ? Icon(Icons.check, color: Colors.white, size: 14)
                            : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${candidate["avatar"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${candidate["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStageColor(candidate["stage"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${candidate["stage"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${candidate["position"]} • ${candidate["experience"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${candidate["location"]} • ${candidate["source"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: spXs,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getMatchScoreColor(candidate["match_score"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${candidate["match_score"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "${candidate["salary_expectation"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (candidate["skills"] as List).take(4).map((skill) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$skill",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Text(
                        "Applied ${DateTime.parse(candidate["applied_date"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Profile",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('RhaCandidateProfileView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.description,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo('RhaResumeViewerView')
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () => _sendMessage(candidate),
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () => _showCandidateActions(candidate),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<Map<String, dynamic>> candidates) {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: candidates.map((candidate) {
        bool isSelected = selectedCandidates.contains(candidate["id"]);

        return GestureDetector(
          onTap: () {
            //navigateTo('RhaCandidateDetailView')
          },
          onLongPress: () => _toggleSelection(candidate["id"]),
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: isSelected 
                ? Border.all(color: primaryColor, width: 2)
                : null,
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleSelection(candidate["id"]),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledBoldColor,
                          ),
                        ),
                        child: isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 14)
                          : null,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getMatchScoreColor(candidate["match_score"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${candidate["match_score"]}%",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${candidate["avatar"]}"),
                ),
                Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "${candidate["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${candidate["position"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStageColor(candidate["stage"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${candidate["stage"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${candidate["salary_expectation"]}",
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('RhaCandidateDetailView')
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  List<Map<String, dynamic>> _getFilteredCandidates() {
    List<Map<String, dynamic>> filtered = List.from(candidates);

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((candidate) {
        return candidate["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               candidate["email"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               (candidate["skills"] as List).any((skill) => 
                 skill.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    // Apply status filter
    if (filterStatus != "All") {
      filtered = filtered.where((candidate) => 
        candidate["status"] == filterStatus).toList();
    }

    // Apply stage filter
    if (filterStage != "All") {
      filtered = filtered.where((candidate) => 
        candidate["stage"] == filterStage).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      int comparison = 0;
      switch (sortBy) {
        case "Applied Date":
          comparison = DateTime.parse(a["applied_date"]).compareTo(DateTime.parse(b["applied_date"]));
          break;
        case "Match Score":
          comparison = (a["match_score"] as int).compareTo(b["match_score"] as int);
          break;
        case "Name":
          comparison = a["name"].compareTo(b["name"]);
          break;
        case "Experience":
          comparison = a["experience"].compareTo(b["experience"]);
          break;
      }
      return isDescending ? -comparison : comparison;
    });

    return filtered;
  }

  void _toggleSelection(String candidateId) {
    if (selectedCandidates.contains(candidateId)) {
      selectedCandidates.remove(candidateId);
    } else {
      selectedCandidates.add(candidateId);
    }
    setState(() {});
  }

  void _performSearch() {
    setState(() {});
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Filter Candidates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            QCategoryPicker(
              label: "Stage",
              items: [
                {"label": "All", "value": "All"},
                {"label": "Screening", "value": "Screening"},
                {"label": "HR Review", "value": "HR Review"},
                {"label": "Technical Assessment", "value": "Technical Assessment"},
                {"label": "Interview Scheduled", "value": "Interview Scheduled"},
                {"label": "Interview Completed", "value": "Interview Completed"},
                {"label": "Reference Check", "value": "Reference Check"},
              ],
              value: filterStage,
              onChanged: (index, label, value, item) {
                filterStage = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  back();
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Sort Candidates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                "Applied Date",
                "Match Score",
                "Name",
                "Experience",
              ].map((option) {
                return GestureDetector(
                  onTap: () {
                    sortBy = option;
                    setState(() {});
                    back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
                      children: [
                        Icon(
                          sortBy == option ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: sortBy == option ? primaryColor : disabledBoldColor,
                        ),
                        SizedBox(width: spSm),
                        Text(option),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Ascending",
                    size: bs.md,
                    icon: Icons.arrow_upward,
                    onPressed: () {
                      isDescending = false;
                      setState(() {});
                      back();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Descending",
                    size: bs.md,
                    icon: Icons.arrow_downward,
                    onPressed: () {
                      isDescending = true;
                      setState(() {});
                      back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStageColor(String stage) {
    switch (stage) {
      case "Screening":
        return infoColor;
      case "HR Review":
        return warningColor;
      case "Technical Assessment":
        return primaryColor;
      case "Interview Scheduled":
        return successColor;
      case "Interview Completed":
        return successColor;
      case "Reference Check":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getMatchScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 75) return warningColor;
    if (score >= 60) return infoColor;
    return dangerColor;
  }

  void _sendMessage(Map<String, dynamic> candidate) {
    si("Opening message for ${candidate["name"]}");
  }

  void _showCandidateActions(Map<String, dynamic> candidate) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${candidate["name"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.schedule, color: primaryColor),
                SizedBox(width: spSm),
                Text("Schedule Interview"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.update, color: warningColor),
                SizedBox(width: spSm),
                Text("Update Status"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.note_add, color: infoColor),
                SizedBox(width: spSm),
                Text("Add Note"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _bulkMessage() {
    si("Opening bulk message composer for ${selectedCandidates.length} candidates");
  }

  void _bulkUpdateStatus() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Update Status for ${selectedCandidates.length} candidates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            QCategoryPicker(
              label: "New Status",
              items: [
                {"label": "Active", "value": "Active"},
                {"label": "On Hold", "value": "On Hold"},
                {"label": "Rejected", "value": "Rejected"},
              ],
              value: "Active",
              onChanged: (index, label, value, item) {
                // Update status logic
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Update Status",
                size: bs.md,
                onPressed: () {
                  back();
                  selectedCandidates.clear();
                  setState(() {});
                  ss("Status updated for selected candidates");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
