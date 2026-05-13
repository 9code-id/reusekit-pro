import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobListView extends StatefulWidget {
  const RhaJobListView({super.key});

  @override
  State<RhaJobListView> createState() => _RhaJobListViewState();
}

class _RhaJobListViewState extends State<RhaJobListView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedDepartment = "";
  String selectedJobType = "";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Draft", "value": "draft"},
    {"label": "Closed", "value": "closed"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Expired", "value": "expired"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": ""},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Sales", "value": "sales"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "HR", "value": "hr"},
    {"label": "Finance", "value": "finance"},
    {"label": "Operations", "value": "operations"},
    {"label": "Design", "value": "design"},
  ];

  List<Map<String, dynamic>> jobTypeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Full-time", "value": "full_time"},
    {"label": "Part-time", "value": "part_time"},
    {"label": "Contract", "value": "contract"},
    {"label": "Freelance", "value": "freelance"},
    {"label": "Internship", "value": "internship"},
  ];

  List<Map<String, dynamic>> jobs = [
    {
      "id": "1",
      "title": "Senior Frontend Developer",
      "department": "Engineering",
      "location": "Remote",
      "type": "Full-time",
      "status": "active",
      "applications": 45,
      "views": 234,
      "posted": "2024-03-15",
      "deadline": "2024-04-15",
      "salary": "80,000 - 120,000",
      "urgency": "high",
      "isRemote": true,
      "description": "We're looking for a talented Senior Frontend Developer to join our team...",
    },
    {
      "id": "2",
      "title": "Marketing Manager",
      "department": "Marketing",
      "location": "New York, NY",
      "type": "Full-time",
      "status": "active",
      "applications": 32,
      "views": 156,
      "posted": "2024-03-12",
      "deadline": "2024-04-12",
      "salary": "70,000 - 90,000",
      "urgency": "medium",
      "isRemote": false,
      "description": "Join our marketing team to drive growth and brand awareness...",
    },
    {
      "id": "3",
      "title": "Sales Representative",
      "department": "Sales",
      "location": "Chicago, IL",
      "type": "Full-time",
      "status": "active",
      "applications": 28,
      "views": 89,
      "posted": "2024-03-10",
      "deadline": "2024-04-10",
      "salary": "50,000 - 70,000",
      "urgency": "low",
      "isRemote": false,
      "description": "Expand our customer base and drive revenue growth...",
    },
    {
      "id": "4",
      "title": "UX/UI Designer",
      "department": "Design",
      "location": "San Francisco, CA",
      "type": "Contract",
      "status": "draft",
      "applications": 0,
      "views": 12,
      "posted": "2024-03-08",
      "deadline": "2024-04-08",
      "salary": "90,000 - 110,000",
      "urgency": "medium",
      "isRemote": true,
      "description": "Create intuitive and beautiful user experiences...",
    },
    {
      "id": "5",
      "title": "Data Analyst",
      "department": "Engineering",
      "location": "Boston, MA",
      "type": "Full-time",
      "status": "closed",
      "applications": 67,
      "views": 298,
      "posted": "2024-02-28",
      "deadline": "2024-03-28",
      "salary": "65,000 - 85,000",
      "urgency": "low",
      "isRemote": false,
      "description": "Analyze data to drive business insights and decisions...",
    },
    {
      "id": "6",
      "title": "HR Specialist",
      "department": "HR",
      "location": "Los Angeles, CA",
      "type": "Part-time",
      "status": "on_hold",
      "applications": 15,
      "views": 45,
      "posted": "2024-03-05",
      "deadline": "2024-04-05",
      "salary": "40,000 - 55,000",
      "urgency": "low",
      "isRemote": false,
      "description": "Support HR operations and employee relations...",
    },
  ];

  List<Map<String, dynamic>> get filteredJobs {
    return jobs.where((job) {
      bool matchesSearch = searchQuery.isEmpty ||
          job["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          job["department"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus.isEmpty || job["status"] == selectedStatus;
      bool matchesDepartment = selectedDepartment.isEmpty || job["department"].toString().toLowerCase() == selectedDepartment;
      bool matchesJobType = selectedJobType.isEmpty || job["type"].toString().toLowerCase().replaceAll('-', '_') == selectedJobType;
      
      return matchesSearch && matchesStatus && matchesDepartment && matchesJobType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Listings"),
        actions: [
          IconButton(
            onPressed: () {
              // Add new job
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              // More options
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search jobs",
                          value: searchQuery,
                          hint: "Job title, department, skills...",
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
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
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
                          items: departmentOptions,
                          value: selectedDepartment,
                          onChanged: (value, label) {
                            selectedDepartment = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Job Type",
                          items: jobTypeOptions,
                          value: selectedJobType,
                          onChanged: (value, label) {
                            selectedJobType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Results Summary
            Row(
              children: [
                Text(
                  "Jobs (${filteredJobs.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (searchQuery.isNotEmpty || selectedStatus.isNotEmpty || selectedDepartment.isNotEmpty || selectedJobType.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      selectedStatus = "";
                      selectedDepartment = "";
                      selectedJobType = "";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.clear,
                            size: 14,
                            color: dangerColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Clear Filters",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Job List
            if (filteredJobs.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.work_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Jobs Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search criteria or filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Create New Job",
                      size: bs.md,
                      onPressed: () {
                        // Navigate to job creation
                      },
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...filteredJobs.map((job) {
                Color statusColor = _getStatusColor(job["status"]);
                Color urgencyColor = _getUrgencyColor(job["urgency"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: statusColor.withAlpha(30),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${job["title"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    if (job["isRemote"] == true)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "REMOTE",
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: infoColor,
                                          ),
                                        ),
                                      ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: urgencyColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${job["urgency"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: urgencyColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${job["department"]} • ${job["location"]} • ${job["type"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${job["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Salary and Description
                      Text(
                        "Salary: \$${job["salary"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${job["description"]}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      // Statistics Row
                      Row(
                        children: [
                          _buildStat(Icons.visibility, "${job["views"]}", "views"),
                          SizedBox(width: spMd),
                          _buildStat(Icons.people, "${job["applications"]}", "applications"),
                          SizedBox(width: spMd),
                          _buildStat(Icons.calendar_today, "${job["posted"]}", "posted"),
                          Spacer(),
                          _buildStat(Icons.event, "${job["deadline"]}", "deadline"),
                        ],
                      ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              color: disabledBoldColor,
                              onPressed: () {
                                // View job details
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: job["status"] == "active" ? "Edit Job" : "Activate",
                              size: bs.sm,
                              onPressed: () {
                                // Edit or activate job
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            color: disabledBoldColor,
                            onPressed: () {
                              _showJobOptions(job);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: disabledBoldColor,
            ),
            SizedBox(width: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "draft":
        return warningColor;
      case "closed":
        return disabledBoldColor;
      case "on_hold":
        return infoColor;
      case "expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showJobOptions(Map<String, dynamic> job) {
    // Show bottom sheet with job options
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Job Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              // Job options would go here
              Text(
                "Options for ${job["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
