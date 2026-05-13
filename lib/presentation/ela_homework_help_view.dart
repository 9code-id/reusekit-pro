import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaHomeworkHelpView extends StatefulWidget {
  const ElaHomeworkHelpView({super.key});

  @override
  State<ElaHomeworkHelpView> createState() => _ElaHomeworkHelpViewState();
}

class _ElaHomeworkHelpViewState extends State<ElaHomeworkHelpView> {
  String selectedSubject = "Mathematics";
  String selectedGrade = "Grade 10";
  String questionText = "";
  List<String> attachments = [];
  int currentTab = 0;

  List<Map<String, dynamic>> subjects = [
    {"label": "Mathematics", "value": "Mathematics"},
    {"label": "Physics", "value": "Physics"},
    {"label": "Chemistry", "value": "Chemistry"},
    {"label": "Biology", "value": "Biology"},
    {"label": "English", "value": "English"},
    {"label": "History", "value": "History"},
  ];

  List<Map<String, dynamic>> grades = [
    {"label": "Grade 8", "value": "Grade 8"},
    {"label": "Grade 9", "value": "Grade 9"},
    {"label": "Grade 10", "value": "Grade 10"},
    {"label": "Grade 11", "value": "Grade 11"},
    {"label": "Grade 12", "value": "Grade 12"},
  ];

  List<Map<String, dynamic>> homeworkHelp = [
    {
      "id": 1,
      "subject": "Mathematics",
      "topic": "Quadratic Equations",
      "student": "Sarah Johnson",
      "grade": "Grade 10",
      "status": "In Progress",
      "urgency": "High",
      "timeRemaining": "2 hours",
      "tutor": "Dr. Smith",
      "avatarUrl": "https://picsum.photos/100/100?random=1",
      "description": "Need help solving complex quadratic equations with multiple variables",
      "submittedAt": DateTime.now().subtract(Duration(hours: 1)),
    },
    {
      "id": 2,
      "subject": "Physics",
      "topic": "Newton's Laws",
      "student": "Mike Chen",
      "grade": "Grade 11",
      "status": "Completed",
      "urgency": "Medium",
      "timeRemaining": "Completed",
      "tutor": "Prof. Wilson",
      "avatarUrl": "https://picsum.photos/100/100?random=2",
      "description": "Understanding the application of Newton's three laws in real-world scenarios",
      "submittedAt": DateTime.now().subtract(Duration(hours: 3)),
    },
    {
      "id": 3,
      "subject": "Chemistry",
      "topic": "Organic Compounds",
      "student": "Emma Davis",
      "grade": "Grade 12",
      "status": "Waiting",
      "urgency": "Low",
      "timeRemaining": "1 day",
      "tutor": "Unassigned",
      "avatarUrl": "https://picsum.photos/100/100?random=3",
      "description": "Help with naming organic compounds and understanding their structures",
      "submittedAt": DateTime.now().subtract(Duration(minutes: 30)),
    },
    {
      "id": 4,
      "subject": "Biology",
      "topic": "Cell Division",
      "student": "Alex Thompson",
      "grade": "Grade 9",
      "status": "In Progress",
      "urgency": "High",
      "timeRemaining": "4 hours",
      "tutor": "Dr. Brown",
      "avatarUrl": "https://picsum.photos/100/100?random=4",
      "description": "Need clarification on mitosis and meiosis processes",
      "submittedAt": DateTime.now().subtract(Duration(hours: 2)),
    },
  ];

  List<Map<String, dynamic>> availableTutors = [
    {
      "id": 1,
      "name": "Dr. Smith",
      "subject": "Mathematics",
      "rating": 4.9,
      "experience": "8 years",
      "status": "Online",
      "avatarUrl": "https://picsum.photos/100/100?random=5",
      "hourlyRate": 25,
      "specialization": "Algebra, Calculus",
    },
    {
      "id": 2,
      "name": "Prof. Wilson",
      "subject": "Physics",
      "rating": 4.8,
      "experience": "12 years",
      "status": "Busy",
      "avatarUrl": "https://picsum.photos/100/100?random=6",
      "hourlyRate": 30,
      "specialization": "Mechanics, Thermodynamics",
    },
    {
      "id": 3,
      "name": "Dr. Brown",
      "subject": "Biology",
      "rating": 4.9,
      "experience": "6 years",
      "status": "Online",
      "avatarUrl": "https://picsum.photos/100/100?random=7",
      "hourlyRate": 22,
      "specialization": "Cell Biology, Genetics",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return warningColor;
      case "Completed":
        return successColor;
      case "Waiting":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildHomeworkRequestCard(Map<String, dynamic> request) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${request["avatarUrl"]}"),
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
                      "${request["student"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${request["grade"]} • ${request["subject"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getUrgencyColor("${request["urgency"]}").withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${request["urgency"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getUrgencyColor("${request["urgency"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${request["topic"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${request["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "Time remaining: ${request["timeRemaining"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${request["status"]}").withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${request["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${request["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          if ("${request["tutor"]}" != "Unassigned") ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: primaryColor,
                ),
                SizedBox(width: 4),
                Text(
                  "Tutor: ${request["tutor"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.chat,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTutorCard(Map<String, dynamic> tutor) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${tutor["avatarUrl"]}"),
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
                      "${tutor["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${tutor["subject"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: warningColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${tutor["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "• ${tutor["experience"]}",
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
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: "${tutor["status"]}" == "Online" ? successColor : warningColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Specialization: ${tutor["specialization"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "\$${tutor["hourlyRate"]}/hour",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Request Help",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestHelpForm() {
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
          Text(
            "Request Homework Help",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Subject",
            items: subjects,
            value: selectedSubject,
            onChanged: (value, label) {
              selectedSubject = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Grade Level",
            items: grades,
            value: selectedGrade,
            onChanged: (value, label) {
              selectedGrade = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QMemoField(
            label: "Describe your question",
            value: questionText,
            hint: "Please provide details about what you need help with...",
            onChanged: (value) {
              questionText = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QAttachmentPicker(
            label: "Attach files (optional)",
            value: attachments,
            hint: "Attach homework images, documents, or notes",
            onChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Submit Request",
              onPressed: () {
                ss("Homework help request submitted successfully!");
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Homework Help",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Active Requests", icon: Icon(Icons.help_outline)),
        Tab(text: "Available Tutors", icon: Icon(Icons.person_search)),
        Tab(text: "Request Help", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        // Active Requests Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Track your homework help requests and connect with tutors",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              ...homeworkHelp.map((request) => _buildHomeworkRequestCard(request)),
            ],
          ),
        ),
        // Available Tutors Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "All tutors are verified experts in their subjects",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              ...availableTutors.map((tutor) => _buildTutorCard(tutor)),
            ],
          ),
        ),
        // Request Help Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildRequestHelpForm(),
        ),
      ],
    );
  }
}
