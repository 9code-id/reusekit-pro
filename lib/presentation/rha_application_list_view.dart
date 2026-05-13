import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaApplicationListView extends StatefulWidget {
  const RhaApplicationListView({super.key});

  @override
  State<RhaApplicationListView> createState() => _RhaApplicationListViewState();
}

class _RhaApplicationListViewState extends State<RhaApplicationListView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPosition = "All";
  String selectedDepartment = "All";
  String sortBy = "Date Applied";
  bool isGridView = false;
  bool showFilters = false;
  List<String> selectedApplications = [];

  final List<Map<String, dynamic>> applications = [
    {
      "id": "APP001",
      "candidateName": "Sarah Johnson",
      "candidateEmail": "sarah.johnson@email.com",
      "candidatePhone": "+1-555-0123",
      "candidateAvatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "position": "Senior Flutter Developer",
      "department": "Engineering",
      "status": "Under Review",
      "priority": "High",
      "appliedDate": "2025-06-15",
      "score": 8.5,
      "experience": "5 years",
      "location": "New York, NY",
      "salary": 95000,
      "resumeUrl": "resume_sarah.pdf",
      "coverLetter": "I am excited to apply for the Senior Flutter Developer position...",
      "source": "LinkedIn",
      "skills": ["Flutter", "Dart", "Firebase", "REST APIs"],
      "matchPercentage": 92,
      "lastActivity": "2025-06-18",
      "notes": 3,
      "interviews": 1,
    },
    {
      "id": "APP002", 
      "candidateName": "Michael Chen",
      "candidateEmail": "michael.chen@email.com",
      "candidatePhone": "+1-555-0124",
      "candidateAvatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "position": "UX Designer",
      "department": "Design",
      "status": "Interview Scheduled",
      "priority": "Medium",
      "appliedDate": "2025-06-14",
      "score": 7.8,
      "experience": "3 years",
      "location": "San Francisco, CA",
      "salary": 75000,
      "resumeUrl": "resume_michael.pdf",
      "coverLetter": "With my passion for user-centered design...",
      "source": "Company Website",
      "skills": ["Figma", "Adobe XD", "Prototyping", "User Research"],
      "matchPercentage": 87,
      "lastActivity": "2025-06-17",
      "notes": 2,
      "interviews": 2,
    },
    {
      "id": "APP003",
      "candidateName": "Emily Rodriguez",
      "candidateEmail": "emily.rodriguez@email.com", 
      "candidatePhone": "+1-555-0125",
      "candidateAvatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "position": "Product Manager",
      "department": "Product",
      "status": "Offer Extended",
      "priority": "High",
      "appliedDate": "2025-06-12",
      "score": 9.2,
      "experience": "7 years",
      "location": "Austin, TX",
      "salary": 120000,
      "resumeUrl": "resume_emily.pdf",
      "coverLetter": "I bring extensive product management experience...",
      "source": "Referral",
      "skills": ["Product Strategy", "Agile", "Analytics", "Leadership"],
      "matchPercentage": 95,
      "lastActivity": "2025-06-18",
      "notes": 5,
      "interviews": 3,
    },
    {
      "id": "APP004",
      "candidateName": "David Kim",
      "candidateEmail": "david.kim@email.com",
      "candidatePhone": "+1-555-0126",
      "candidateAvatar": "https://picsum.photos/80/80?random=4&keyword=man",
      "position": "Data Scientist",
      "department": "Analytics",
      "status": "Rejected",
      "priority": "Low",
      "appliedDate": "2025-06-10",
      "score": 6.5,
      "experience": "2 years",
      "location": "Seattle, WA",
      "salary": 85000,
      "resumeUrl": "resume_david.pdf",
      "coverLetter": "As a data science enthusiast...",
      "source": "Job Board",
      "skills": ["Python", "Machine Learning", "SQL", "Statistics"],
      "matchPercentage": 74,
      "lastActivity": "2025-06-16",
      "notes": 1,
      "interviews": 1,
    },
    {
      "id": "APP005",
      "candidateName": "Lisa Thompson",
      "candidateEmail": "lisa.thompson@email.com",
      "candidatePhone": "+1-555-0127",
      "candidateAvatar": "https://picsum.photos/80/80?random=5&keyword=woman",
      "position": "Marketing Manager",
      "department": "Marketing",
      "status": "Phone Screening",
      "priority": "Medium",
      "appliedDate": "2025-06-13",
      "score": 7.5,
      "experience": "4 years",
      "location": "Chicago, IL",
      "salary": 70000,
      "resumeUrl": "resume_lisa.pdf",
      "coverLetter": "I am passionate about digital marketing...",
      "source": "LinkedIn",
      "skills": ["Digital Marketing", "SEO", "Analytics", "Content Strategy"],
      "matchPercentage": 82,
      "lastActivity": "2025-06-17",
      "notes": 2,
      "interviews": 1,
    },
  ];

  List<Map<String, dynamic>> get filteredApplications {
    return applications.where((app) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${app["candidateName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${app["position"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${app["department"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || app["status"] == selectedStatus;
      bool matchesPosition = selectedPosition == "All" || app["position"] == selectedPosition;
      bool matchesDepartment = selectedDepartment == "All" || app["department"] == selectedDepartment;
      
      return matchesSearch && matchesStatus && matchesPosition && matchesDepartment;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Under Review":
        return warningColor;
      case "Interview Scheduled":
        return infoColor;
      case "Phone Screening":
        return primaryColor;
      case "Offer Extended":
        return successColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildApplicationCard(Map<String, dynamic> application) {
    bool isSelected = selectedApplications.contains(application["id"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        children: [
          // Header with selection and priority
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withAlpha(20) : null,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusSm),
                topRight: Radius.circular(radiusSm),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedApplications.remove(application["id"]);
                    } else {
                      selectedApplications.add(application["id"]);
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: isSelected
                        ? Icon(Icons.check, color: Colors.white, size: 14)
                        : null,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Application #${application["id"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(application["priority"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${application["priority"]} Priority",
                    style: TextStyle(
                      fontSize: 10,
                      color: _getPriorityColor(application["priority"]),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Main content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Candidate info
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${application["candidateAvatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${application["candidateName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${application["candidateEmail"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${application["experience"]} experience",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Match percentage
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${application["matchPercentage"]}% Match",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Position and department
                Row(
                  children: [
                    Icon(Icons.work, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${application["position"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.business, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${application["department"]} Department",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${application["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Status and score
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(application["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${application["status"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: _getStatusColor(application["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.star, size: 14, color: warningColor),
                    SizedBox(width: 2),
                    Text(
                      "${application["score"]}/10",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Application details
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Applied: ${application["appliedDate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${((application["salary"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(Icons.notes, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${application["notes"]} notes",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.video_call, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${application["interviews"]} interviews",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Source: ${application["source"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Skills
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (application["skills"] as List).take(3).map((skill) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Text(
                        "$skill",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                SizedBox(height: spSm),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to application detail
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.email,
                      size: bs.sm,
                      onPressed: () {
                        si("Email sent to candidate");
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showApplicationActions(application);
                      },
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

  void _showApplicationActions(Map<String, dynamic> application) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Application Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            _buildActionTile(Icons.schedule, "Schedule Interview", () {
              back();
              si("Interview scheduled");
            }),
            _buildActionTile(Icons.note_add, "Add Note", () {
              back();
              si("Note added");
            }),
            _buildActionTile(Icons.attach_file, "View Resume", () {
              back();
              si("Opening resume");
            }),
            _buildActionTile(Icons.phone, "Contact Candidate", () {
              back();
              si("Contacting candidate");
            }),
            _buildActionTile(Icons.move_down, "Move to Next Stage", () {
              back();
              ss("Application moved to next stage");
            }),
            _buildActionTile(Icons.close, "Reject Application", () {
              back();
              se("Application rejected");
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Applications"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showBulkActions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search applications...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    // Trigger search
                  },
                ),
              ],
            ),
          ),
          
          // Filters
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              color: primaryColor.withAlpha(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Under Review", "value": "Under Review"},
                            {"label": "Interview Scheduled", "value": "Interview Scheduled"},
                            {"label": "Phone Screening", "value": "Phone Screening"},
                            {"label": "Offer Extended", "value": "Offer Extended"},
                            {"label": "Rejected", "value": "Rejected"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: [
                            {"label": "All", "value": "All"},
                            {"label": "Engineering", "value": "Engineering"},
                            {"label": "Design", "value": "Design"},
                            {"label": "Product", "value": "Product"},
                            {"label": "Marketing", "value": "Marketing"},
                            {"label": "Analytics", "value": "Analytics"},
                          ],
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
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
                          label: "Sort By",
                          items: [
                            {"label": "Date Applied", "value": "Date Applied"},
                            {"label": "Name", "value": "Name"},
                            {"label": "Score", "value": "Score"},
                            {"label": "Match %", "value": "Match %"},
                            {"label": "Status", "value": "Status"},
                          ],
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Clear Filters",
                        size: bs.sm,
                        onPressed: () {
                          selectedStatus = "All";
                          selectedPosition = "All";
                          selectedDepartment = "All";
                          searchQuery = "";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          
          // Selection summary
          if (selectedApplications.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              color: primaryColor.withAlpha(20),
              child: Row(
                children: [
                  Text(
                    "${selectedApplications.length} selected",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Bulk Actions",
                    size: bs.sm,
                    onPressed: _showBulkActions,
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () {
                      selectedApplications.clear();
                      setState(() {});
                    },
                    child: Text(
                      "Clear",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          // Applications list
          Expanded(
            child: Container(
              color: disabledColor.withAlpha(30),
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: filteredApplications.length,
                itemBuilder: (context, index) {
                  final application = filteredApplications[index];
                  return _buildApplicationCard(application);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          si("Add new application");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showBulkActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Bulk Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            _buildActionTile(Icons.schedule, "Schedule Interviews", () {
              back();
              ss("${selectedApplications.length} interviews scheduled");
              selectedApplications.clear();
              setState(() {});
            }),
            _buildActionTile(Icons.email, "Send Bulk Email", () {
              back();
              ss("Emails sent to ${selectedApplications.length} candidates");
              selectedApplications.clear();
              setState(() {});
            }),
            _buildActionTile(Icons.move_down, "Move to Next Stage", () {
              back();
              ss("${selectedApplications.length} applications moved");
              selectedApplications.clear();
              setState(() {});
            }),
            _buildActionTile(Icons.close, "Reject Applications", () {
              back();
              se("${selectedApplications.length} applications rejected");
              selectedApplications.clear();
              setState(() {});
            }),
            _buildActionTile(Icons.download, "Export Data", () {
              back();
              si("Exporting ${selectedApplications.length} applications");
            }),
          ],
        ),
      ),
    );
  }
}
