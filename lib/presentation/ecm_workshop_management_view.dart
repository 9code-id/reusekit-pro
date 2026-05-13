import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmWorkshopManagementView extends StatefulWidget {
  const EcmWorkshopManagementView({super.key});

  @override
  State<EcmWorkshopManagementView> createState() => _EcmWorkshopManagementViewState();
}

class _EcmWorkshopManagementViewState extends State<EcmWorkshopManagementView> {
  List<Map<String, dynamic>> workshops = [
    {
      "id": 1,
      "title": "Advanced Data Analytics with Python",
      "instructor": "Dr. Emily Chen",
      "co_instructors": ["Prof. Mark Johnson", "Lisa Zhang"],
      "room": "Tech Lab A",
      "capacity": 40,
      "enrolled": 35,
      "waitlist": 8,
      "status": "Active",
      "start_date": DateTime.now().add(Duration(days: 2)),
      "end_date": DateTime.now().add(Duration(days: 4)),
      "duration": "3 days",
      "sessions_per_day": 3,
      "category": "Data Science",
      "level": "Advanced",
      "price": 599.0,
      "rating": 4.8,
      "materials": ["Python Notebooks", "Datasets", "Reference Guide"],
      "prerequisites": ["Basic Python", "Statistics Fundamentals"],
      "tools": ["Jupyter", "Pandas", "Scikit-learn"],
      "completion_rate": 92.5,
      "satisfaction": 4.7
    },
    {
      "id": 2,
      "title": "UI/UX Design Fundamentals",
      "instructor": "Sarah Rodriguez",
      "co_instructors": ["Alex Kim"],
      "room": "Design Studio B",
      "capacity": 25,
      "enrolled": 22,
      "waitlist": 5,
      "status": "Scheduled",
      "start_date": DateTime.now().add(Duration(days: 7)),
      "end_date": DateTime.now().add(Duration(days: 9)),
      "duration": "3 days",
      "sessions_per_day": 2,
      "category": "Design",
      "level": "Beginner",
      "price": 450.0,
      "rating": 4.6,
      "materials": ["Design Templates", "Color Palettes", "Wireframe Kit"],
      "prerequisites": ["Basic Computer Skills"],
      "tools": ["Figma", "Adobe XD", "Sketch"],
      "completion_rate": 88.3,
      "satisfaction": 4.5
    },
    {
      "id": 3,
      "title": "Blockchain Development Workshop",
      "instructor": "Michael Thompson",
      "co_instructors": ["Jennifer Wu", "David Lee"],
      "room": "Innovation Lab C",
      "capacity": 30,
      "enrolled": 18,
      "waitlist": 12,
      "status": "Active",
      "start_date": DateTime.now().subtract(Duration(days: 1)),
      "end_date": DateTime.now().add(Duration(days: 1)),
      "duration": "3 days",
      "sessions_per_day": 4,
      "category": "Blockchain",
      "level": "Intermediate",
      "price": 799.0,
      "rating": 4.9,
      "materials": ["Smart Contract Templates", "Development Guide", "Testing Framework"],
      "prerequisites": ["JavaScript", "Solidity Basics"],
      "tools": ["Truffle", "Ganache", "MetaMask"],
      "completion_rate": 85.7,
      "satisfaction": 4.8
    },
    {
      "id": 4,
      "title": "Digital Marketing Mastery",
      "instructor": "Amanda Foster",
      "co_instructors": ["Carlos Silva"],
      "room": "Marketing Hub D",
      "capacity": 50,
      "enrolled": 45,
      "waitlist": 15,
      "status": "Scheduled",
      "start_date": DateTime.now().add(Duration(days: 14)),
      "end_date": DateTime.now().add(Duration(days: 16)),
      "duration": "3 days",
      "sessions_per_day": 2,
      "category": "Marketing",
      "level": "Intermediate",
      "price": 399.0,
      "rating": 4.4,
      "materials": ["Campaign Templates", "Analytics Dashboard", "Content Calendar"],
      "prerequisites": ["Basic Marketing Knowledge"],
      "tools": ["Google Analytics", "Facebook Ads", "Hootsuite"],
      "completion_rate": 90.2,
      "satisfaction": 4.3
    },
    {
      "id": 5,
      "title": "Machine Learning in Healthcare",
      "instructor": "Dr. Robert Kim",
      "co_instructors": ["Dr. Maria Santos", "Dr. James Wilson"],
      "room": "Medical AI Lab E",
      "capacity": 20,
      "enrolled": 16,
      "waitlist": 6,
      "status": "Completed",
      "start_date": DateTime.now().subtract(Duration(days: 10)),
      "end_date": DateTime.now().subtract(Duration(days: 8)),
      "duration": "3 days",
      "sessions_per_day": 3,
      "category": "Healthcare AI",
      "level": "Expert",
      "price": 899.0,
      "rating": 4.9,
      "materials": ["Medical Datasets", "ML Models", "Ethics Guidelines"],
      "prerequisites": ["Machine Learning", "Healthcare Background"],
      "tools": ["TensorFlow", "Keras", "Medical APIs"],
      "completion_rate": 95.0,
      "satisfaction": 4.9
    }
  ];

  String selectedStatus = "All";
  String selectedCategory = "All";
  String selectedLevel = "All";
  String searchQuery = "";

  final List<String> statuses = ["All", "Active", "Scheduled", "Completed", "Cancelled", "Draft"];
  final List<String> categories = ["All", "Data Science", "Design", "Blockchain", "Marketing", "Healthcare AI"];
  final List<String> levels = ["All", "Beginner", "Intermediate", "Advanced", "Expert"];

  List<Map<String, dynamic>> get filteredWorkshops {
    return workshops.where((workshop) {
      final matchesStatus = selectedStatus == "All" || workshop["status"] == selectedStatus;
      final matchesCategory = selectedCategory == "All" || workshop["category"] == selectedCategory;
      final matchesLevel = selectedLevel == "All" || workshop["level"] == selectedLevel;
      final matchesSearch = searchQuery.isEmpty || 
          "${workshop["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${workshop["instructor"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesCategory && matchesLevel && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Scheduled":
        return infoColor;
      case "Completed":
        return primaryColor;
      case "Cancelled":
        return dangerColor;
      case "Draft":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return infoColor;
      case "Advanced":
        return warningColor;
      case "Expert":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _createWorkshop() {
    // Navigate to create workshop
    // navigateTo(EcmCreateWorkshopView());
  }

  void _editWorkshop(Map<String, dynamic> workshop) {
    // Navigate to edit workshop
    // navigateTo(EcmEditWorkshopView(workshop: workshop));
  }

  void _viewWorkshopDetails(Map<String, dynamic> workshop) {
    // Navigate to workshop details
    // navigateTo(EcmWorkshopDetailsView(workshop: workshop));
  }

  void _manageEnrollments(Map<String, dynamic> workshop) {
    // Navigate to enrollment management
    // navigateTo(EcmWorkshopEnrollmentView(workshop: workshop));
  }

  void _duplicateWorkshop(Map<String, dynamic> workshop) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    
    final newWorkshop = Map<String, dynamic>.from(workshop);
    newWorkshop["id"] = workshops.length + 1;
    newWorkshop["title"] = "${workshop["title"]} (Copy)";
    newWorkshop["status"] = "Draft";
    newWorkshop["enrolled"] = 0;
    newWorkshop["waitlist"] = 0;
    newWorkshop["start_date"] = DateTime.now().add(Duration(days: 30));
    newWorkshop["end_date"] = DateTime.now().add(Duration(days: 32));
    
    workshops.add(newWorkshop);
    hideLoading();
    setState(() {});
    ss("Workshop duplicated successfully");
  }

  void _deleteWorkshop(Map<String, dynamic> workshop) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this workshop?");
    if (isConfirmed) {
      workshops.removeWhere((w) => w["id"] == workshop["id"]);
      setState(() {});
      ss("Workshop deleted successfully");
    }
  }

  Widget _buildStatsCard() {
    final totalWorkshops = workshops.length;
    final activeWorkshops = workshops.where((w) => w["status"] == "Active").length;
    final totalEnrolled = workshops.fold(0, (sum, w) => sum + (w["enrolled"] as int));
    final totalRevenue = workshops.fold(0.0, (sum, w) => sum + ((w["price"] as double) * (w["enrolled"] as int)));

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Workshop Management Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Total Workshops", totalWorkshops.toString(), Icons.build, primaryColor),
              ),
              Expanded(
                child: _buildStatItem("Active", activeWorkshops.toString(), Icons.play_circle, successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Total Enrolled", totalEnrolled.toString(), Icons.people, infoColor),
              ),
              Expanded(
                child: _buildStatItem("Revenue", "\$${(totalRevenue / 1000).toStringAsFixed(1)}K", Icons.attach_money, warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
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

  Widget _buildWorkshopCard(Map<String, dynamic> workshop) {
    final enrollmentRate = ((workshop["enrolled"] as int) / (workshop["capacity"] as int)) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.build,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${workshop["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "by ${workshop["instructor"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${workshop["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${workshop["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor("${workshop["status"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.room, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${workshop["room"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${workshop["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(Icons.attach_money, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "\$${workshop["price"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getLevelColor("${workshop["level"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${workshop["level"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getLevelColor("${workshop["level"]}"),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${workshop["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "${workshop["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Date: ${(workshop["start_date"] as DateTime).dMMMy} - ${(workshop["end_date"] as DateTime).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enrollment (${workshop["enrolled"]}/${workshop["capacity"]})",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: enrollmentRate / 100,
                            backgroundColor: Colors.grey.withAlpha(50),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              enrollmentRate > 80 ? successColor :
                              enrollmentRate > 60 ? warningColor : infoColor,
                            ),
                          ),
                          if ((workshop["waitlist"] as int) > 0) ...[
                            SizedBox(height: spXs),
                            Text(
                              "Waitlist: ${workshop["waitlist"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Performance",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Completion: ${workshop["completion_rate"]}%",
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Satisfaction: ${workshop["satisfaction"]}⭐",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Co-instructors: ${(workshop["co_instructors"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Tools: ${(workshop["tools"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                QButton(
                  label: "Details",
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () => _viewWorkshopDetails(workshop),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Enrollments",
                  icon: Icons.people,
                  size: bs.sm,
                  onPressed: () => _manageEnrollments(workshop),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _editWorkshop(workshop),
                  child: Icon(
                    Icons.edit,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () => _duplicateWorkshop(workshop),
                  child: Icon(
                    Icons.copy,
                    color: infoColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () => _deleteWorkshop(workshop),
                  child: Icon(
                    Icons.delete,
                    color: dangerColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workshop Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createWorkshop,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search workshops...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
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
                    label: "Status",
                    items: statuses.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
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
                    label: "Level",
                    items: levels.map((level) => {
                      "label": level,
                      "value": level,
                    }).toList(),
                    value: selectedLevel,
                    onChanged: (value, label) {
                      selectedLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Category",
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            if (filteredWorkshops.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.build,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No workshops found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or create a new workshop",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredWorkshops.map((workshop) {
                  return _buildWorkshopCard(workshop);
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createWorkshop,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
