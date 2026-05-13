import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCandidateNotesView extends StatefulWidget {
  const RhaCandidateNotesView({super.key});

  @override
  State<RhaCandidateNotesView> createState() => _RhaCandidateNotesViewState();
}

class _RhaCandidateNotesViewState extends State<RhaCandidateNotesView> {
  String selectedCandidate = "";
  String selectedCategory = "";
  String selectedPriority = "";
  String newNoteContent = "";
  String newNoteCategory = "";
  String newNotePriority = "";
  bool isPrivateNote = false;

  List<Map<String, dynamic>> candidates = [
    {"label": "All Candidates", "value": ""},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Chen", "value": "michael_chen"},
    {"label": "Emily Rodriguez", "value": "emily_rodriguez"},
    {"label": "David Kim", "value": "david_kim"},
  ];

  List<Map<String, dynamic>> noteCategories = [
    {"label": "All Categories", "value": ""},
    {"label": "Interview Feedback", "value": "interview"},
    {"label": "Skills Assessment", "value": "skills"},
    {"label": "Cultural Fit", "value": "culture"},
    {"label": "Reference Check", "value": "reference"},
    {"label": "Follow-up", "value": "followup"},
    {"label": "General", "value": "general"},
  ];

  List<Map<String, dynamic>> priorities = [
    {"label": "All Priorities", "value": ""},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> candidateNotes = [
    {
      "id": "N001",
      "candidateName": "Sarah Johnson",
      "candidateAvatar": "https://picsum.photos/40/40?random=1&person",
      "content": "Excellent technical interview performance. Demonstrated strong problem-solving skills and deep understanding of system architecture. Particularly impressed with her approach to handling scalability challenges.",
      "category": "interview",
      "categoryLabel": "Interview Feedback",
      "priority": "high",
      "authorName": "John Smith",
      "authorRole": "Senior Engineer",
      "authorAvatar": "https://picsum.photos/40/40?random=11&person",
      "createdAt": "2024-12-18T14:30:00",
      "isPrivate": false,
      "tags": ["technical", "problem-solving", "architecture"],
      "attachments": ["interview_notes.pdf"],
    },
    {
      "id": "N002",
      "candidateName": "Sarah Johnson",
      "candidateAvatar": "https://picsum.photos/40/40?random=1&person",
      "content": "Reference check completed with previous manager at Google. Highly recommended for leadership potential and ability to mentor junior developers. Consistent performer with strong work ethic.",
      "category": "reference",
      "categoryLabel": "Reference Check",
      "priority": "medium",
      "authorName": "Lisa Davis",
      "authorRole": "HR Manager",
      "authorAvatar": "https://picsum.photos/40/40?random=12&person",
      "createdAt": "2024-12-17T11:15:00",
      "isPrivate": true,
      "tags": ["reference", "leadership", "mentoring"],
      "attachments": [],
    },
    {
      "id": "N003",
      "candidateName": "Michael Chen",
      "candidateAvatar": "https://picsum.photos/40/40?random=2&person",
      "content": "Great cultural fit assessment. Shows strong alignment with our values of innovation and collaboration. Demonstrated excellent communication skills during the panel interview.",
      "category": "culture",
      "categoryLabel": "Cultural Fit",
      "priority": "high",
      "authorName": "Emma Wilson",
      "authorRole": "Team Lead",
      "authorAvatar": "https://picsum.photos/40/40?random=13&person",
      "createdAt": "2024-12-17T09:45:00",
      "isPrivate": false,
      "tags": ["culture", "communication", "collaboration"],
      "attachments": [],
    },
    {
      "id": "N004",
      "candidateName": "Emily Rodriguez",
      "candidateAvatar": "https://picsum.photos/40/40?random=3&person",
      "content": "Portfolio review shows exceptional design thinking and user-centered approach. Her redesign case study for the mobile app demonstrates both creativity and analytical skills.",
      "category": "skills",
      "categoryLabel": "Skills Assessment",
      "priority": "high",
      "authorName": "David Park",
      "authorRole": "Design Director",
      "authorAvatar": "https://picsum.photos/40/40?random=14&person",
      "createdAt": "2024-12-16T16:20:00",
      "isPrivate": false,
      "tags": ["design", "portfolio", "user-experience"],
      "attachments": ["portfolio_review.pdf", "design_samples.zip"],
    },
    {
      "id": "N005",
      "candidateName": "David Kim",
      "candidateAvatar": "https://picsum.photos/40/40?random=4&person",
      "content": "Follow-up needed on salary expectations and start date availability. Candidate expressed interest but mentioned current project commitment through February.",
      "category": "followup",
      "categoryLabel": "Follow-up",
      "priority": "medium",
      "authorName": "Sarah Thompson",
      "authorRole": "Recruiter",
      "authorAvatar": "https://picsum.photos/40/40?random=15&person",
      "createdAt": "2024-12-15T13:30:00",
      "isPrivate": false,
      "tags": ["salary", "availability", "timeline"],
      "attachments": [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotes = candidateNotes.where((note) {
      bool matchesCandidate = selectedCandidate.isEmpty || note["candidateName"].toString().toLowerCase().contains(selectedCandidate.toLowerCase());
      bool matchesCategory = selectedCategory.isEmpty || note["category"] == selectedCategory;
      bool matchesPriority = selectedPriority.isEmpty || note["priority"] == selectedPriority;
      return matchesCandidate && matchesCategory && matchesPriority;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Candidate Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddNoteDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotesOverview(),
            _buildFiltersSection(),
            _buildNotesSection(filteredNotes),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesOverview() {
    Map<String, int> categoryStats = {};
    Map<String, int> priorityStats = {};
    
    for (var note in candidateNotes) {
      String category = note["categoryLabel"];
      String priority = note["priority"];
      
      categoryStats[category] = (categoryStats[category] ?? 0) + 1;
      priorityStats[priority] = (priorityStats[priority] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Notes Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildOverviewCard("Total Notes", candidateNotes.length, Icons.note, primaryColor),
              _buildOverviewCard("High Priority", priorityStats["high"] ?? 0, Icons.priority_high, dangerColor),
              _buildOverviewCard("Private Notes", candidateNotes.where((n) => n["isPrivate"] == true).length, Icons.lock, warningColor),
              _buildOverviewCard("This Week", candidateNotes.where((n) => _isThisWeek(n["createdAt"])).length, Icons.schedule, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, int value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                "$value",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.filter_list, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Filter Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _clearFilters(),
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QDropdownField(
                label: "Candidate",
                items: candidates,
                value: selectedCandidate,
                onChanged: (value, label) {
                  selectedCandidate = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Category",
                items: noteCategories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Priority",
                items: priorities,
                value: selectedPriority,
                onChanged: (value, label) {
                  selectedPriority = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(List<Map<String, dynamic>> notes) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.note, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${notes.length} notes",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (notes.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.note_add,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No notes found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Add your first note or adjust the filters",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          if (notes.isNotEmpty)
            Column(
              spacing: spSm,
              children: notes.map((note) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage("${note["candidateAvatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${note["candidateName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getCategoryColor(note["category"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${note["categoryLabel"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getCategoryColor(note["category"]),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(note["priority"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${note["priority"].toString().toUpperCase()}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getPriorityColor(note["priority"]),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if (note["isPrivate"] == true) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.lock,
                                        size: 12,
                                        color: warningColor,
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () => _showNoteOptions(note),
                          ),
                        ],
                      ),
                      Text(
                        "${note["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.5,
                        ),
                      ),
                      if ((note["tags"] as List).isNotEmpty)
                        QHorizontalScroll(
                          children: (note["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      if ((note["attachments"] as List).isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Attachments:",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            QHorizontalScroll(
                              children: (note["attachments"] as List).map((attachment) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(color: successColor.withAlpha(50)),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.attach_file,
                                        size: 14,
                                        color: successColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "$attachment",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage("${note["authorAvatar"]}"),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${note["authorName"]} • ${note["authorRole"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            _formatDateTime(note["createdAt"]),
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
              }).toList(),
            ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "interview":
        return primaryColor;
      case "skills":
        return successColor;
      case "culture":
        return infoColor;
      case "reference":
        return warningColor;
      case "followup":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _isThisWeek(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return date.isAfter(startOfWeek);
  }

  String _formatDateTime(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  void _clearFilters() {
    setState(() {
      selectedCandidate = "";
      selectedCategory = "";
      selectedPriority = "";
    });
    ss("Filters cleared");
  }

  void _showSearchDialog() {
    si("Search notes functionality");
  }

  void _showFilterDialog() {
    si("Advanced filter options");
  }

  void _showAddNoteDialog() {
    si("Add new note dialog");
  }

  void _showNoteOptions(Map<String, dynamic> note) {
    si("Show options for note ${note["id"]}");
  }
}
