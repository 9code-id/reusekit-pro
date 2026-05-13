import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobDetailView extends StatefulWidget {
  const RhaJobDetailView({super.key});

  @override
  State<RhaJobDetailView> createState() => _RhaJobDetailViewState();
}

class _RhaJobDetailViewState extends State<RhaJobDetailView> {
  Map<String, dynamic> jobData = {
    "id": "job_001",
    "title": "Senior Flutter Developer",
    "company": "TechCorp Solutions",
    "location": "San Francisco, CA",
    "department": "Engineering",
    "type": "Full-time",
    "experience": "3-5 years",
    "salary": "\$120,000 - \$150,000",
    "posted_date": "2024-06-15",
    "deadline": "2024-07-15",
    "status": "Active",
    "applications": 45,
    "views": 234,
    "description": "We are looking for a Senior Flutter Developer to join our growing team. You will be responsible for developing cross-platform mobile applications using Flutter framework.",
    "requirements": [
      "3+ years of Flutter development experience",
      "Strong knowledge of Dart programming language",
      "Experience with RESTful APIs and JSON",
      "Familiarity with Git version control",
      "Understanding of mobile app architecture"
    ],
    "benefits": [
      "Competitive salary package",
      "Health and dental insurance",
      "Flexible working hours",
      "Remote work options",
      "Professional development budget"
    ],
    "skills": ["Flutter", "Dart", "Firebase", "REST API", "Git"]
  };

  List<Map<String, dynamic>> recentApplications = [
    {
      "id": "app_001",
      "name": "John Smith",
      "email": "john.smith@email.com",
      "applied_date": "2024-06-18",
      "status": "Under Review",
      "experience": "4 years",
      "location": "San Francisco, CA",
      "match_score": 85
    },
    {
      "id": "app_002", 
      "name": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "applied_date": "2024-06-17",
      "status": "Shortlisted",
      "experience": "5 years",
      "location": "Remote",
      "match_score": 92
    },
    {
      "id": "app_003",
      "name": "Mike Chen",
      "email": "mike.chen@email.com", 
      "applied_date": "2024-06-16",
      "status": "Interview Scheduled",
      "experience": "3 years",
      "location": "San Jose, CA",
      "match_score": 78
    }
  ];

  bool isLoading = false;
  String selectedAction = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Details"),
        actions: [
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              //navigateTo('RhaCreateJobView')
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () => _showJobActions(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: isLoading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                _buildJobHeader(),
                _buildJobStats(),
                _buildJobDescription(),
                _buildRequirements(),
                _buildBenefits(),
                _buildSkillTags(),
                _buildRecentApplications(),
                _buildActionButtons(),
              ],
            ),
          ),
    );
  }

  Widget _buildJobHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${jobData["title"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${jobData["company"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: jobData["status"] == "Active" ? successColor : warningColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${jobData["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${jobData["location"]}",
                style: TextStyle(color: disabledBoldColor),
              ),
              SizedBox(width: spMd),
              Icon(Icons.work, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${jobData["type"]}",
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${jobData["salary"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "${jobData["applications"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Applications",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "${jobData["views"]}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Views",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "15",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Days Left",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobDescription() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Job Description",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${jobData["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirements() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Requirements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: (jobData["requirements"] as List).map((requirement) {
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$requirement",
                        style: TextStyle(
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
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

  Widget _buildBenefits() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Benefits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            children: (jobData["benefits"] as List).map((benefit) {
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: successColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$benefit",
                        style: TextStyle(
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
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

  Widget _buildSkillTags() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Required Skills",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: (jobData["skills"] as List).map((skill) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(40)),
                ),
                child: Text(
                  "$skill",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentApplications() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recent Applications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  //navigateTo('RhaCandidateListView')
                },
              ),
            ],
          ),
          Column(
            children: recentApplications.map((application) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: primaryColor,
                      child: Text(
                        "${application["name"]}".substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${application["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${application["experience"]} • ${application["location"]}",
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
                            color: _getStatusColor(application["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${application["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "${application["match_score"]}% match",
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
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "View All Applications",
            size: bs.md,
            onPressed: () {
              //navigateTo('RhaCandidateListView')
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Share Job",
                size: bs.md,
                icon: Icons.share,
                onPressed: () => _shareJob(),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Post External",
                size: bs.md,
                icon: Icons.public,
                onPressed: () {
                  //navigateTo('RhaExternalPostingView')
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Under Review":
        return warningColor;
      case "Shortlisted":
        return infoColor;
      case "Interview Scheduled":
        return successColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showJobActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            Text(
              "Job Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.edit, color: primaryColor),
                SizedBox(width: spSm),
                Text("Edit Job"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.copy, color: primaryColor),
                SizedBox(width: spSm),
                Text("Duplicate Job"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.pause, color: warningColor),
                SizedBox(width: spSm),
                Text("Pause Job"),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(Icons.delete, color: dangerColor),
                SizedBox(width: spSm),
                Text("Delete Job"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shareJob() {
    ss("Job link copied to clipboard");
  }
}
