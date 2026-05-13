import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaApplicationDetailView extends StatefulWidget {
  const RhaApplicationDetailView({super.key});

  @override
  State<RhaApplicationDetailView> createState() => _RhaApplicationDetailViewState();
}

class _RhaApplicationDetailViewState extends State<RhaApplicationDetailView> {
  int currentTab = 0;
  String newNote = "";
  String selectedScheduleType = "Phone";
  String scheduleDate = "";
  String scheduleTime = "";
  String interviewerEmail = "";
  String rejectReason = "";
  String offerAmount = "";
  String offerPosition = "";
  
  final Map<String, dynamic> application = {
    "id": "APP001",
    "candidateName": "Sarah Johnson",
    "candidateEmail": "sarah.johnson@email.com",
    "candidatePhone": "+1-555-0123",
    "candidateAvatar": "https://picsum.photos/120/120?random=1&keyword=woman",
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
    "coverLetter": "I am excited to apply for the Senior Flutter Developer position at your company. With over 5 years of experience in mobile app development using Flutter and Dart, I have successfully delivered numerous high-quality applications that have garnered millions of downloads.\n\nIn my current role at TechCorp, I have led a team of 4 developers in creating innovative mobile solutions for various industries including fintech, healthcare, and e-commerce. My expertise includes state management with Provider and Riverpod, integration with REST APIs and GraphQL, and implementing complex UI designs with custom animations.\n\nI am particularly drawn to your company's mission of creating user-centric digital experiences and would love to contribute to your team's success.",
    "source": "LinkedIn",
    "skills": ["Flutter", "Dart", "Firebase", "REST APIs", "Provider", "Riverpod", "Git", "Agile"],
    "matchPercentage": 92,
    "lastActivity": "2025-06-18",
    "yearsOfExperience": 5,
    "education": [
      {
        "degree": "Bachelor of Computer Science",
        "school": "Stanford University",
        "year": "2019",
        "gpa": "3.8"
      }
    ],
    "workHistory": [
      {
        "company": "TechCorp Inc.",
        "position": "Senior Mobile Developer",
        "duration": "2022 - Present",
        "description": "Lead mobile development team, architected scalable Flutter applications"
      },
      {
        "company": "StartupXYZ",
        "position": "Flutter Developer",
        "duration": "2020 - 2022",
        "description": "Developed cross-platform mobile apps, implemented CI/CD pipelines"
      }
    ],
    "socialLinks": {
      "linkedin": "https://linkedin.com/in/sarahjohnson",
      "github": "https://github.com/sarahjohnson",
      "portfolio": "https://sarahjohnson.dev"
    },
    "attachments": [
      {
        "name": "Resume_SarahJohnson.pdf",
        "size": "2.4 MB",
        "type": "PDF",
        "url": "resume_sarah.pdf"
      },
      {
        "name": "Portfolio_Projects.pdf", 
        "size": "5.1 MB",
        "type": "PDF",
        "url": "portfolio_sarah.pdf"
      }
    ]
  };

  final List<Map<String, dynamic>> notes = [
    {
      "id": "NOTE001",
      "author": "John Smith",
      "authorAvatar": "https://picsum.photos/40/40?random=10&keyword=man",
      "date": "2025-06-18",
      "time": "10:30 AM",
      "type": "General",
      "content": "Candidate has excellent technical skills and communication. Strong portfolio with real-world projects.",
      "isPrivate": false,
    },
    {
      "id": "NOTE002", 
      "author": "Emily Davis",
      "authorAvatar": "https://picsum.photos/40/40?random=11&keyword=woman",
      "date": "2025-06-17",
      "time": "3:45 PM",
      "type": "Interview",
      "content": "Phone screening completed. Candidate answered technical questions well. Recommended for next round.",
      "isPrivate": false,
    },
    {
      "id": "NOTE003",
      "author": "Mike Wilson",
      "authorAvatar": "https://picsum.photos/40/40?random=12&keyword=man", 
      "date": "2025-06-16",
      "time": "11:20 AM",
      "type": "Review",
      "content": "Resume review: Strong background in Flutter development. Good project variety.",
      "isPrivate": true,
    }
  ];

  final List<Map<String, dynamic>> timeline = [
    {
      "date": "2025-06-18",
      "time": "10:30 AM",
      "event": "Note Added",
      "description": "Technical evaluation completed",
      "icon": Icons.note_add,
      "color": "info",
    },
    {
      "date": "2025-06-17", 
      "time": "3:45 PM",
      "event": "Interview Completed",
      "description": "Phone screening with Emily Davis",
      "icon": Icons.phone,
      "color": "success",
    },
    {
      "date": "2025-06-16",
      "time": "2:15 PM",
      "event": "Status Updated",
      "description": "Moved to Under Review",
      "icon": Icons.update,
      "color": "warning",
    },
    {
      "date": "2025-06-15",
      "time": "9:30 AM",
      "event": "Application Received",
      "description": "Application submitted via LinkedIn",
      "icon": Icons.inbox,
      "color": "primary",
    }
  ];

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

  Color _getTimelineColor(String colorType) {
    switch (colorType) {
      case "primary":
        return primaryColor;
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "danger":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Candidate header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${application["candidateAvatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${application["candidateName"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${application["position"]}",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Text(
                                "${application["score"]}/10",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${application["matchPercentage"]}% Match",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(application["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${application["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(application["status"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Contact info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.email, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${application["candidateEmail"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${application["candidatePhone"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
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
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Applied",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${application["appliedDate"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Salary Expectation",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${((application["salary"] as int).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Quick actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Schedule Interview",
                        size: bs.sm,
                        onPressed: () {
                          _showScheduleDialog();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Send Message",
                        size: bs.sm,
                        onPressed: () {
                          si("Message sent");
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Move to Next Stage",
                        size: bs.sm,
                        onPressed: () {
                          ss("Moved to next stage");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reject",
                        size: bs.sm,
                        onPressed: () {
                          _showRejectDialog();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Skills
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Skills & Technologies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: (application["skills"] as List).map((skill) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Text(
                        "$skill",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Cover Letter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cover Letter",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "${application["coverLetter"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Attachments
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Attachments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...(application["attachments"] as List).map((attachment) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: disabledColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.picture_as_pdf, color: dangerColor, size: 24),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${attachment["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${attachment["size"]} • ${attachment["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            si("Downloading ${attachment["name"]}");
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () {
                            si("Opening ${attachment["name"]}");
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Education
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Education",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...(application["education"] as List).map((edu) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${edu["degree"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${edu["school"]} • ${edu["year"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "GPA: ${edu["gpa"]}",
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
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Work History
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Work Experience",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...(application["workHistory"] as List).map((work) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border(left: BorderSide(width: 4, color: primaryColor)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${work["position"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${work["company"]} • ${work["duration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${work["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Social Links
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Social Links",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          si("Opening LinkedIn profile");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: infoColor.withAlpha(30)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.business, color: infoColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "LinkedIn",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          si("Opening GitHub profile");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: primaryColor.withAlpha(30)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.code, color: primaryColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "GitHub",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          si("Opening portfolio website");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: successColor.withAlpha(30)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.web, color: successColor, size: 20),
                              SizedBox(width: spXs),
                              Text(
                                "Portfolio",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
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

  Widget _buildNotesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Add note
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Note",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QMemoField(
                  label: "Note content",
                  value: newNote,
                  onChanged: (value) {
                    newNote = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add Note",
                        size: bs.sm,
                        onPressed: () {
                          if (newNote.isNotEmpty) {
                            ss("Note added successfully");
                            newNote = "";
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Notes list
          ...notes.map((note) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("${note["authorAvatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${note["author"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${note["type"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (note["isPrivate"] as bool)
                                  Container(
                                    margin: EdgeInsets.only(left: spXs),
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Private",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${note["date"]} at ${note["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("Note options");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${note["content"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: timeline.map((event) {
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getTimelineColor(event["color"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    event["icon"] as IconData,
                    color: _getTimelineColor(event["color"]),
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${event["event"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${event["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${event["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${event["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Schedule Interview"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Interview Type",
              items: [
                {"label": "Phone", "value": "Phone"},
                {"label": "Video Call", "value": "Video Call"},
                {"label": "In-Person", "value": "In-Person"},
              ],
              value: selectedScheduleType,
              onChanged: (value, label) {
                selectedScheduleType = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QDatePicker(
              label: "Interview Date",
              value: DateTime.now(),
              onChanged: (value) {
                scheduleDate = value.toString();
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTimePicker(
              label: "Interview Time",
              value: TimeOfDay.now(),
              onChanged: (value) {
                scheduleTime = value!.kkmm;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Interviewer Email",
              value: interviewerEmail,
              onChanged: (value) {
                interviewerEmail = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Interview scheduled successfully");
            },
            child: Text("Schedule"),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reject Application"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to reject this application?",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: spMd),
            QMemoField(
              label: "Rejection reason (optional)",
              value: rejectReason,
              onChanged: (value) {
                rejectReason = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              se("Application rejected");
            },
            child: Text("Reject"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Application Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Resume", icon: Icon(Icons.description)),
        Tab(text: "Notes", icon: Icon(Icons.note)),
        Tab(text: "Timeline", icon: Icon(Icons.timeline)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildResumeTab(),
        _buildNotesTab(),
        _buildTimelineTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }
}
