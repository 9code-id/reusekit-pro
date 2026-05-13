import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmUserProfileView extends StatefulWidget {
  const TpmUserProfileView({super.key});

  @override
  State<TpmUserProfileView> createState() => _TpmUserProfileViewState();
}

class _TpmUserProfileViewState extends State<TpmUserProfileView> {
  // Profile Information
  String firstName = "John";
  String lastName = "Doe";
  String email = "john.doe@company.com";
  String phone = "+1 (555) 123-4567";
  String jobTitle = "Senior Full Stack Developer";
  String department = "Engineering";
  String location = "San Francisco, CA";
  String bio = "Passionate full-stack developer with 8+ years of experience building scalable web applications. Specialized in React, Node.js, and cloud technologies.";
  String profileImage = "https://picsum.photos/200/200?random=1&keyword=person";
  
  // Contact Information
  String linkedinUrl = "https://linkedin.com/in/johndoe";
  String githubUrl = "https://github.com/johndoe";
  String twitterUrl = "";
  String website = "https://johndoe.dev";
  
  // Work Information
  String employeeId = "EMP-001234";
  String manager = "Sarah Wilson";
  String startDate = "2020-03-15";
  String workingHours = "9:00 AM - 6:00 PM";
  String timezone = "Pacific Standard Time (PST)";
  
  // Skills and Expertise
  List<String> skills = [
    "JavaScript", "TypeScript", "React", "Node.js", "Python", "Flutter", 
    "AWS", "Docker", "GraphQL", "PostgreSQL", "MongoDB", "Git"
  ];
  
  List<String> languages = ["English (Native)", "Spanish (Conversational)", "French (Basic)"];
  
  // Statistics
  Map<String, dynamic> userStats = {
    "projects_completed": 47,
    "tasks_completed": 284,
    "hours_logged": 1567,
    "team_rating": 4.8,
    "on_time_delivery": 94,
    "code_reviews": 156
  };

  List<Map<String, dynamic>> achievements = [
    {
      "id": 1,
      "title": "Project Champion",
      "description": "Successfully delivered 5 major projects on time",
      "icon": Icons.star,
      "color": Colors.amber,
      "date": "2024-05-15"
    },
    {
      "id": 2,
      "title": "Code Quality Master",
      "description": "Maintained 95%+ code review approval rate",
      "icon": Icons.code,
      "color": Colors.blue,
      "date": "2024-04-20"
    },
    {
      "id": 3,
      "title": "Team Player",
      "description": "Helped 10+ team members with mentoring",
      "icon": Icons.group,
      "color": Colors.green,
      "date": "2024-03-10"
    },
    {
      "id": 4,
      "title": "Innovation Award",
      "description": "Implemented automated testing framework",
      "icon": Icons.lightbulb,
      "color": Colors.orange,
      "date": "2024-02-05"
    }
  ];

  List<Map<String, dynamic>> recentProjects = [
    {
      "id": 1,
      "name": "E-commerce Platform",
      "role": "Lead Developer",
      "status": "Completed",
      "completion": 100,
      "endDate": "2024-06-15"
    },
    {
      "id": 2,
      "name": "Mobile App Development",
      "role": "Full Stack Developer",
      "status": "In Progress",
      "completion": 75,
      "endDate": "2024-07-30"
    },
    {
      "id": 3,
      "name": "API Microservices",
      "role": "Backend Developer",
      "status": "Completed",
      "completion": 100,
      "endDate": "2024-05-20"
    }
  ];

  int selectedTab = 0;
  bool loading = false;
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(editMode ? Icons.save : Icons.edit),
            onPressed: editMode ? _saveProfile : _toggleEditMode,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTab,
              tabs: [
                Tab(text: "Profile", icon: Icon(Icons.person)),
                Tab(text: "Work", icon: Icon(Icons.work)),
                Tab(text: "Stats", icon: Icon(Icons.analytics)),
              ],
              tabChildren: [
                _buildProfileTab(),
                _buildWorkTab(),
                _buildStatsTab(),
              ],
            ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          SizedBox(height: spMd),
          _buildBasicInformation(),
          SizedBox(height: spMd),
          _buildContactInformation(),
          SizedBox(height: spMd),
          _buildSkillsSection(),
          if (editMode) ...[
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Changes",
                size: bs.md,
                onPressed: _saveProfile,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWorkTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWorkInformation(),
          SizedBox(height: spMd),
          _buildRecentProjects(),
          SizedBox(height: spMd),
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPerformanceStats(),
          SizedBox(height: spMd),
          _buildActivityChart(),
          SizedBox(height: spMd),
          _buildSkillsChart(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: editMode ? _changeProfileImage : null,
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(profileImage),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                    ),
                    if (editMode)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(spXxs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (editMode) ...[
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "First Name",
                              value: firstName,
                              onChanged: (value) {
                                firstName = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTextField(
                              label: "Last Name",
                              value: lastName,
                              onChanged: (value) {
                                lastName = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        "$firstName $lastName",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        jobTitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        department,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (!editMode) ...[
            SizedBox(height: spMd),
            Text(
              bio,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBasicInformation() {
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
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          if (editMode) ...[
            QTextField(
              label: "Job Title",
              value: jobTitle,
              onChanged: (value) {
                jobTitle = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Department",
              value: department,
              onChanged: (value) {
                department = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Location",
              value: location,
              onChanged: (value) {
                location = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Bio",
              value: bio,
              onChanged: (value) {
                bio = value;
                setState(() {});
              },
            ),
          ] else ...[
            _buildInfoRow("Email", email, Icons.email),
            _buildInfoRow("Phone", phone, Icons.phone),
            _buildInfoRow("Location", location, Icons.location_on),
            _buildInfoRow("Employee ID", employeeId, Icons.badge),
          ],
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
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
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          if (editMode) ...[
            QTextField(
              label: "Email",
              value: email,
              onChanged: (value) {
                email = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Phone",
              value: phone,
              onChanged: (value) {
                phone = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "LinkedIn URL",
              value: linkedinUrl,
              onChanged: (value) {
                linkedinUrl = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "GitHub URL",
              value: githubUrl,
              onChanged: (value) {
                githubUrl = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Website",
              value: website,
              onChanged: (value) {
                website = value;
                setState(() {});
              },
            ),
          ] else ...[
            if (linkedinUrl.isNotEmpty) _buildLinkRow("LinkedIn", linkedinUrl, Icons.business),
            if (githubUrl.isNotEmpty) _buildLinkRow("GitHub", githubUrl, Icons.code),
            if (website.isNotEmpty) _buildLinkRow("Website", website, Icons.web),
          ],
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
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
          Row(
            children: [
              Text(
                "Skills & Expertise",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (editMode) ...[
                Spacer(),
                QButton(
                  label: "Add Skill",
                  size: bs.sm,
                  onPressed: _addSkill,
                ),
              ],
            ],
          ),
          SizedBox(height: spMd),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: skills.map((skill) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      skill,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (editMode) ...[
                      SizedBox(width: spXs),
                      GestureDetector(
                        onTap: () => _removeSkill(skill),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ).toList(),
          ),
          SizedBox(height: spMd),
          Text(
            "Languages",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...languages.map((language) => 
            Container(
              margin: EdgeInsets.only(bottom: spXs),
              child: Row(
                children: [
                  Icon(Icons.language, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    language,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildWorkInformation() {
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
            "Work Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoRow("Manager", manager, Icons.person),
          _buildInfoRow("Start Date", startDate, Icons.calendar_today),
          _buildInfoRow("Working Hours", workingHours, Icons.schedule),
          _buildInfoRow("Timezone", timezone, Icons.access_time),
        ],
      ),
    );
  }

  Widget _buildRecentProjects() {
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
            "Recent Projects",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...recentProjects.map((project) => _buildProjectCard(project)).toList(),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    Color statusColor = project["status"] == "Completed" ? successColor : infoColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${project["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${project["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "Role: ${project["role"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: (project["completion"] as int) / 100,
                  backgroundColor: Colors.grey.withAlpha(30),
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${project["completion"]}%",
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
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
            "Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...achievements.map((achievement) => _buildAchievementCard(achievement)).toList(),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (achievement["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (achievement["color"] as Color).withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: achievement["color"] as Color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              achievement["icon"] as IconData,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${achievement["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${achievement["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${DateTime.parse(achievement["date"]).dMMMy}",
            style: TextStyle(
              color: disabledColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceStats() {
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
            "Performance Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Projects Completed", "${userStats["projects_completed"]}", Icons.folder, successColor),
              _buildStatCard("Tasks Completed", "${userStats["tasks_completed"]}", Icons.task, infoColor),
              _buildStatCard("Hours Logged", "${userStats["hours_logged"]}", Icons.schedule, warningColor),
              _buildStatCard("Team Rating", "${userStats["team_rating"]}/5", Icons.star, Colors.amber),
              _buildStatCard("On-time Delivery", "${userStats["on_time_delivery"]}%", Icons.check_circle, successColor),
              _buildStatCard("Code Reviews", "${userStats["code_reviews"]}", Icons.code, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityChart() {
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
            "Activity Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Center(
              child: Text(
                "Activity Chart\n(Chart implementation would go here)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsChart() {
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
            "Skills Proficiency",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Center(
              child: Text(
                "Skills Radar Chart\n(Chart implementation would go here)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(width: spSm),
          Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkRow(String label, String url, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(width: spSm),
          Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: GestureDetector(
              onTap: () => ss("Opening $url"),
              child: Text(
                url,
                style: TextStyle(
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleEditMode() {
    editMode = !editMode;
    setState(() {});
  }

  void _saveProfile() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    editMode = false;
    loading = false;
    setState(() {});
    
    ss("Profile updated successfully");
  }

  void _changeProfileImage() {
    ss("Profile image change functionality - coming soon");
  }

  void _addSkill() {
    skills.add("New Skill");
    setState(() {});
  }

  void _removeSkill(String skill) {
    skills.remove(skill);
    setState(() {});
  }
}
