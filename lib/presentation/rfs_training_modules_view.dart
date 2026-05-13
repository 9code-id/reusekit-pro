import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsTrainingModulesView extends StatefulWidget {
  const RfsTrainingModulesView({super.key});

  @override
  State<RfsTrainingModulesView> createState() => _RfsTrainingModulesViewState();
}

class _RfsTrainingModulesViewState extends State<RfsTrainingModulesView> {
  int currentTab = 0;
  String selectedCategory = "all";
  String selectedEmployee = "all";

  List<Map<String, dynamic>> trainingModules = [
    {
      "id": "MOD001",
      "title": "Food Safety & Hygiene",
      "description": "Essential food safety practices and hygiene standards for restaurant operations",
      "category": "safety",
      "duration": 45,
      "difficulty": "Beginner",
      "image": "https://picsum.photos/300/200?random=1&keyword=food",
      "progress": 100,
      "completedBy": 15,
      "totalEmployees": 18,
      "required": true,
      "certification": true,
      "lastUpdated": "2024-12-10",
      "instructor": "Sarah Wilson",
      "lessons": 8,
      "quiz": true,
    },
    {
      "id": "MOD002",
      "title": "Customer Service Excellence",
      "description": "Advanced customer service techniques and communication skills",
      "category": "service",
      "duration": 60,
      "difficulty": "Intermediate",
      "image": "https://picsum.photos/300/200?random=2&keyword=service",
      "progress": 85,
      "completedBy": 12,
      "totalEmployees": 15,
      "required": true,
      "certification": true,
      "lastUpdated": "2024-12-08",
      "instructor": "Mike Johnson",
      "lessons": 10,
      "quiz": true,
    },
    {
      "id": "MOD003",
      "title": "POS System Training",
      "description": "Complete guide to operating the restaurant POS system efficiently",
      "category": "technology",
      "duration": 30,
      "difficulty": "Beginner",
      "image": "https://picsum.photos/300/200?random=3&keyword=technology",
      "progress": 70,
      "completedBy": 8,
      "totalEmployees": 12,
      "required": false,
      "certification": false,
      "lastUpdated": "2024-12-05",
      "instructor": "Tech Support",
      "lessons": 6,
      "quiz": false,
    },
    {
      "id": "MOD004",
      "title": "Wine & Beverage Knowledge",
      "description": "Understanding wine varieties, food pairing, and beverage service",
      "category": "beverage",
      "duration": 90,
      "difficulty": "Advanced",
      "image": "https://picsum.photos/300/200?random=4&keyword=wine",
      "progress": 40,
      "completedBy": 4,
      "totalEmployees": 8,
      "required": false,
      "certification": true,
      "lastUpdated": "2024-12-01",
      "instructor": "David Chen",
      "lessons": 12,
      "quiz": true,
    },
    {
      "id": "MOD005",
      "title": "Kitchen Safety Protocols",
      "description": "Kitchen safety procedures and emergency response protocols",
      "category": "safety",
      "duration": 35,
      "difficulty": "Beginner",
      "image": "https://picsum.photos/300/200?random=5&keyword=kitchen",
      "progress": 95,
      "completedBy": 10,
      "totalEmployees": 11,
      "required": true,
      "certification": true,
      "lastUpdated": "2024-11-28",
      "instructor": "Chef Maria",
      "lessons": 7,
      "quiz": true,
    },
  ];

  List<Map<String, dynamic>> employeeProgress = [
    {
      "employee": "Alice Johnson",
      "role": "Server",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=person",
      "completedModules": 4,
      "totalModules": 5,
      "certificationsEarned": 3,
      "totalHours": 185,
      "lastActivity": "2024-12-15",
      "currentModule": "Wine & Beverage Knowledge",
      "progress": 65,
      "skillLevel": "Intermediate",
    },
    {
      "employee": "Bob Wilson",
      "role": "Chef",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=person",
      "completedModules": 3,
      "totalModules": 4,
      "certificationsEarned": 2,
      "totalHours": 140,
      "lastActivity": "2024-12-14",
      "currentModule": "Kitchen Safety Protocols",
      "progress": 95,
      "skillLevel": "Advanced",
    },
    {
      "employee": "Carol Smith",
      "role": "Manager",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=person",
      "completedModules": 5,
      "totalModules": 5,
      "certificationsEarned": 4,
      "totalHours": 225,
      "lastActivity": "2024-12-15",
      "currentModule": "Completed All",
      "progress": 100,
      "skillLevel": "Expert",
    },
    {
      "employee": "David Brown",
      "role": "Bartender",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=person",
      "completedModules": 3,
      "totalModules": 4,
      "certificationsEarned": 2,
      "totalHours": 165,
      "lastActivity": "2024-12-13",
      "currentModule": "Customer Service Excellence",
      "progress": 85,
      "skillLevel": "Intermediate",
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Safety", "value": "safety"},
    {"label": "Service", "value": "service"},
    {"label": "Technology", "value": "technology"},
    {"label": "Beverage", "value": "beverage"},
  ];

  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "all"},
    {"label": "Alice Johnson", "value": "alice"},
    {"label": "Bob Wilson", "value": "bob"},
    {"label": "Carol Smith", "value": "carol"},
    {"label": "David Brown", "value": "david"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Training Modules",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Modules", icon: Icon(Icons.school)),
        Tab(text: "Progress", icon: Icon(Icons.analytics)),
        Tab(text: "Certificates", icon: Icon(Icons.verified)),
      ],
      tabChildren: [
        _buildModulesTab(),
        _buildProgressTab(),
        _buildCertificatesTab(),
      ],
    );
  }

  Widget _buildModulesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTrainingOverview(),
          _buildFilters(),
          _buildModulesList(),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildProgressOverview(),
          _buildEmployeeFilters(),
          _buildEmployeeProgressList(),
        ],
      ),
    );
  }

  Widget _buildCertificatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCertificationOverview(),
          _buildCertificatesList(),
          _buildUpcomingCertifications(),
        ],
      ),
    );
  }

  Widget _buildTrainingOverview() {
    int totalModules = trainingModules.length;
    int completedModules = trainingModules.where((m) => (m["progress"] as int) == 100).length;
    int totalHours = trainingModules.fold(0, (sum, m) => sum + (m["duration"] as int));
    int avgProgress = trainingModules.fold(0, (sum, m) => sum + (m["progress"] as int)) ~/ totalModules;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Total Modules", "$totalModules", Icons.school, primaryColor),
        _buildOverviewCard("Completed", "$completedModules", Icons.check_circle, successColor),
        _buildOverviewCard("Total Hours", "${totalHours}h", Icons.schedule, infoColor),
        _buildOverviewCard("Avg Progress", "$avgProgress%", Icons.trending_up, warningColor),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.filter_list, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Filters",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Add Module",
                  size: bs.sm,
                  onPressed: () {
                    ss("Adding new training module");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulesList() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: trainingModules.map((module) => _buildModuleCard(module)).toList(),
    );
  }

  Widget _buildModuleCard(Map<String, dynamic> module) {
    Color progressColor = _getProgressColor(module["progress"] as int);
    Color difficultyColor = _getDifficultyColor(module["difficulty"] as String);
    
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${module["image"]}",
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                if (module["required"] == true) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "REQUIRED",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                ],
                if (module["certification"] == true) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "CERT",
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: difficultyColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${module["difficulty"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: difficultyColor,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${module["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${module["description"]}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${module["duration"]}min",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Icon(Icons.video_library, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${module["lessons"]} lessons",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${module["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${module["completedBy"]}/${module["totalEmployees"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (module["progress"] as int) / 100,
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      ss("Viewing ${module["title"]} details");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.play_arrow,
                  size: bs.sm,
                  onPressed: () {
                    ss("Starting ${module["title"]} training");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressOverview() {
    int totalEmployees = employeeProgress.length;
    int completedAll = employeeProgress.where((e) => (e["completedModules"] as int) == (e["totalModules"] as int)).length;
    int totalCertifications = employeeProgress.fold(0, (sum, e) => sum + (e["certificationsEarned"] as int));
    int avgHours = employeeProgress.fold(0, (sum, e) => sum + (e["totalHours"] as int)) ~/ totalEmployees;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildProgressCard("Total Employees", "$totalEmployees", Icons.people, primaryColor),
        _buildProgressCard("Completed All", "$completedAll", Icons.check_circle, successColor),
        _buildProgressCard("Certificates", "$totalCertifications", Icons.verified, warningColor),
        _buildProgressCard("Avg Hours", "${avgHours}h", Icons.schedule, infoColor),
      ],
    );
  }

  Widget _buildProgressCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeFilters() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Row(
          children: [
            Icon(Icons.filter_list, color: primaryColor),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Select Employee",
                items: employeeOptions,
                value: selectedEmployee,
                onChanged: (value, label) {
                  selectedEmployee = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.refresh,
              size: bs.sm,
              onPressed: () {
                ss("Progress data refreshed");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeProgressList() {
    return Column(
      spacing: spSm,
      children: employeeProgress.map((employee) => _buildEmployeeProgressCard(employee)).toList(),
    );
  }

  Widget _buildEmployeeProgressCard(Map<String, dynamic> employee) {
    double completionRate = (employee["completedModules"] as int) / (employee["totalModules"] as int);
    Color skillColor = _getSkillLevelColor(employee["skillLevel"] as String);
    
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("${employee["avatar"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${employee["employee"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: skillColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${employee["skillLevel"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: skillColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${employee["role"]} • Last active: ${DateTime.parse(employee["lastActivity"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getProgressColor((completionRate * 100).round()).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${(completionRate * 100).round()}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getProgressColor((completionRate * 100).round()),
                    ),
                  ),
                ),
              ],
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildProgressDetailCard("Modules", "${employee["completedModules"]}/${employee["totalModules"]}", Icons.school),
                _buildProgressDetailCard("Certificates", "${employee["certificationsEarned"]}", Icons.verified),
                _buildProgressDetailCard("Hours", "${employee["totalHours"]}h", Icons.schedule),
                _buildProgressDetailCard("Current", "${employee["currentModule"]}", Icons.play_circle),
              ],
            ),
            if (employee["currentModule"] != "Completed All") ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Current Module Progress: ${employee["progress"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (employee["progress"] as int) / 100,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor(employee["progress"] as int)),
                  ),
                ],
              ),
            ],
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Progress",
                    size: bs.sm,
                    onPressed: () {
                      ss("Viewing ${employee["employee"]} training progress");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.assignment,
                  size: bs.sm,
                  onPressed: () {
                    ss("Assigning new module to ${employee["employee"]}");
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  onPressed: () {
                    ss("Message sent to ${employee["employee"]}");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressDetailCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 18),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationOverview() {
    int totalCertifications = trainingModules.where((m) => m["certification"] == true).length;
    int earnedCertifications = employeeProgress.fold(0, (sum, e) => sum + (e["certificationsEarned"] as int));
    int pendingCertifications = (totalCertifications * employeeProgress.length) - earnedCertifications;
    
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildCertCard("Available", "$totalCertifications", Icons.school, primaryColor),
        _buildCertCard("Earned", "$earnedCertifications", Icons.verified, successColor),
        _buildCertCard("Pending", "$pendingCertifications", Icons.pending, warningColor),
        _buildCertCard("Completion Rate", "${((earnedCertifications / (totalCertifications * employeeProgress.length)) * 100).round()}%", Icons.trending_up, infoColor),
      ],
    );
  }

  Widget _buildCertCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificatesList() {
    var certificationModules = trainingModules.where((m) => m["certification"] == true).toList();
    
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.verified, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Available Certifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ...certificationModules.map((module) => _buildCertificationItem(module)),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificationItem(Map<String, dynamic> module) {
    int completionRate = ((module["completedBy"] as int) / (module["totalEmployees"] as int) * 100).round();
    Color rateColor = _getProgressColor(completionRate);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: rateColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${module["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Instructor: ${module["instructor"]} • ${module["duration"]}min",
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
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: rateColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$completionRate%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: rateColor,
                  ),
                ),
              ),
              Text(
                "${module["completedBy"]}/${module["totalEmployees"]} certified",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingCertifications() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(Icons.upcoming, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Upcoming Certification Deadlines",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              spacing: spSm,
              children: [
                _buildUpcomingItem("Food Safety & Hygiene", "3 employees pending", "Dec 20, 2024", warningColor),
                _buildUpcomingItem("Customer Service Excellence", "6 employees pending", "Dec 25, 2024", infoColor),
                _buildUpcomingItem("Kitchen Safety Protocols", "1 employee pending", "Dec 30, 2024", successColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingItem(String certification, String pending, String deadline, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  certification,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  pending,
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
            children: [
              Text(
                "Deadline",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                deadline,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(int progress) {
    if (progress >= 90) return successColor;
    if (progress >= 70) return warningColor;
    if (progress >= 50) return infoColor;
    return dangerColor;
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getSkillLevelColor(String skillLevel) {
    switch (skillLevel) {
      case "Beginner":
        return infoColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return primaryColor;
      case "Expert":
        return successColor;
      default:
        return disabledColor;
    }
  }
}
