import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobPostingView extends StatefulWidget {
  const RhaJobPostingView({super.key});

  @override
  State<RhaJobPostingView> createState() => _RhaJobPostingViewState();
}

class _RhaJobPostingViewState extends State<RhaJobPostingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedDepartment = "All";
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Paused", "value": "Paused"},
    {"label": "Closed", "value": "Closed"},
  ];
  
  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
  ];

  List<Map<String, dynamic>> jobPostings = [
    {
      "id": "1",
      "title": "Senior Flutter Developer",
      "department": "Engineering",
      "location": "New York, NY",
      "type": "Full-time",
      "status": "Active",
      "applications": 24,
      "views": 156,
      "posted": "2024-06-15",
      "deadline": "2024-08-15",
      "salary": "80000-120000",
      "featured": true,
    },
    {
      "id": "2",
      "title": "Marketing Manager",
      "department": "Marketing",
      "location": "San Francisco, CA",
      "type": "Full-time",
      "status": "Active",
      "applications": 18,
      "views": 89,
      "posted": "2024-06-12",
      "deadline": "2024-07-30",
      "salary": "70000-90000",
      "featured": false,
    },
    {
      "id": "3",
      "title": "Sales Representative",
      "department": "Sales",
      "location": "Remote",
      "type": "Full-time",
      "status": "Draft",
      "applications": 0,
      "views": 0,
      "posted": "2024-06-18",
      "deadline": "2024-08-01",
      "salary": "50000-70000",
      "featured": false,
    },
    {
      "id": "4",
      "title": "UX Designer",
      "department": "Engineering",
      "location": "Austin, TX",
      "type": "Contract",
      "status": "Paused",
      "applications": 12,
      "views": 67,
      "posted": "2024-06-08",
      "deadline": "2024-07-20",
      "salary": "60000-80000",
      "featured": false,
    },
    {
      "id": "5",
      "title": "HR Specialist",
      "department": "HR",
      "location": "Chicago, IL",
      "type": "Part-time",
      "status": "Closed",
      "applications": 35,
      "views": 198,
      "posted": "2024-05-20",
      "deadline": "2024-06-20",
      "salary": "40000-55000",
      "featured": false,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Draft":
        return warningColor;
      case "Paused":
        return infoColor;
      case "Closed":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Postings"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // View analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new job posting
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search job postings...",
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
                        items: statusItems,
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
                        items: departmentItems,
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Summary Cards
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "5",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Jobs",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "2",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "89",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Applications",
                          style: TextStyle(
                            color: warningColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Job Postings List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: jobPostings.length,
              itemBuilder: (context, index) {
                final job = jobPostings[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: (job["featured"] as bool)
                        ? Border.all(color: warningColor, width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          if (job["featured"] as bool)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "FEATURED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (job["featured"] as bool) SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${job["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${job["status"]}")
                                  .withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${job["status"]}",
                              style: TextStyle(
                                color: _getStatusColor("${job["status"]}"),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Job Details
                      Row(
                        children: [
                          Icon(
                            Icons.business,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${job["department"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${job["location"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.work,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${job["type"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.attach_money,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "\$${job["salary"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      // Statistics Row
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${job["applications"]} applications",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.visibility,
                                  size: 16,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${job["views"]} views",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  // Edit job posting
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // More actions
                                },
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Posted and Deadline Info
                      Row(
                        children: [
                          Text(
                            "Posted: ${job["posted"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Deadline: ${job["deadline"]}",
                            style: TextStyle(
                              color: dangerColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create new job posting
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
