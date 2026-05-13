import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaTrainingModulesView extends StatefulWidget {
  const AmaTrainingModulesView({super.key});

  @override
  State<AmaTrainingModulesView> createState() => _AmaTrainingModulesViewState();
}

class _AmaTrainingModulesViewState extends State<AmaTrainingModulesView> {
  String selectedCategory = "All";
  String searchQuery = "";
  String selectedDifficulty = "All";
  String selectedProgress = "All";
  
  List<Map<String, dynamic>> trainingModules = [
    {
      "id": "tm001",
      "title": "Sustainable Agriculture Fundamentals",
      "description": "Learn the basics of sustainable farming practices and environmental conservation",
      "category": "Sustainability",
      "difficulty": "Beginner",
      "duration": "4 hours",
      "chapters": 8,
      "progress": 75,
      "status": "In Progress",
      "instructor": "Dr. Sarah Johnson",
      "rating": 4.8,
      "enrolled": 1247,
      "image": "https://picsum.photos/300/200?random=1&keyword=farm",
      "skills": ["Crop Rotation", "Soil Conservation", "Water Management"],
      "prerequisites": [],
      "completion_rate": 89,
      "last_accessed": "2024-01-15",
      "certificate": true,
    },
    {
      "id": "tm002", 
      "title": "Advanced Crop Management Techniques",
      "description": "Master advanced techniques for maximizing crop yields and quality",
      "category": "Crop Management",
      "difficulty": "Advanced",
      "duration": "6 hours",
      "chapters": 12,
      "progress": 45,
      "status": "In Progress",
      "instructor": "Prof. Michael Chen",
      "rating": 4.9,
      "enrolled": 892,
      "image": "https://picsum.photos/300/200?random=2&keyword=crops",
      "skills": ["Precision Agriculture", "IPM", "Yield Optimization"],
      "prerequisites": ["Basic Agriculture"],
      "completion_rate": 85,
      "last_accessed": "2024-01-14",
      "certificate": true,
    },
    {
      "id": "tm003",
      "title": "Livestock Health and Management",
      "description": "Comprehensive guide to maintaining healthy livestock and optimizing production",
      "category": "Livestock",
      "difficulty": "Intermediate",
      "duration": "5 hours",
      "chapters": 10,
      "progress": 100,
      "status": "Completed",
      "instructor": "Dr. Emily Watson",
      "rating": 4.7,
      "enrolled": 1156,
      "image": "https://picsum.photos/300/200?random=3&keyword=livestock",
      "skills": ["Animal Health", "Breeding", "Nutrition"],
      "prerequisites": ["Animal Husbandry Basics"],
      "completion_rate": 92,
      "last_accessed": "2024-01-12",
      "certificate": true,
    },
    {
      "id": "tm004",
      "title": "Modern Irrigation Systems",
      "description": "Design and implement efficient irrigation systems for optimal water usage",
      "category": "Water Management",
      "difficulty": "Intermediate",
      "duration": "3.5 hours",
      "chapters": 7,
      "progress": 25,
      "status": "Not Started",
      "instructor": "Mark Rodriguez",
      "rating": 4.6,
      "enrolled": 743,
      "image": "https://picsum.photos/300/200?random=4&keyword=irrigation",
      "skills": ["Drip Irrigation", "Smart Controllers", "Water Conservation"],
      "prerequisites": ["Basic Hydraulics"],
      "completion_rate": 78,
      "last_accessed": null,
      "certificate": true,
    },
    {
      "id": "tm005",
      "title": "Organic Farming Certification Process",
      "description": "Navigate the organic certification process and maintain compliance",
      "category": "Certification",
      "difficulty": "Beginner", 
      "duration": "2.5 hours",
      "chapters": 5,
      "progress": 60,
      "status": "In Progress",
      "instructor": "Lisa Thompson",
      "rating": 4.5,
      "enrolled": 634,
      "image": "https://picsum.photos/300/200?random=5&keyword=organic",
      "skills": ["Certification Standards", "Documentation", "Compliance"],
      "prerequisites": [],
      "completion_rate": 95,
      "last_accessed": "2024-01-13",
      "certificate": false,
    },
    {
      "id": "tm006",
      "title": "Agricultural Technology Integration",
      "description": "Implement modern technology solutions to enhance farming efficiency",
      "category": "Technology",
      "difficulty": "Advanced",
      "duration": "7 hours",
      "chapters": 15,
      "progress": 0,
      "status": "Not Started",
      "instructor": "Dr. James Park",
      "rating": 4.9,
      "enrolled": 567, 
      "image": "https://picsum.photos/300/200?random=6&keyword=technology",
      "skills": ["IoT Sensors", "Data Analytics", "Automation"],
      "prerequisites": ["Digital Literacy", "Basic Electronics"],
      "completion_rate": 71,
      "last_accessed": null,
      "certificate": true,
    },
  ];

  List<Map<String, dynamic>> get filteredModules {
    return trainingModules.where((module) {
      bool matchesCategory = selectedCategory == "All" || module["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
        module["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        module["description"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDifficulty = selectedDifficulty == "All" || module["difficulty"] == selectedDifficulty;
      bool matchesProgress = selectedProgress == "All" || module["status"] == selectedProgress;
      
      return matchesCategory && matchesSearch && matchesDifficulty && matchesProgress;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Training Modules"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.school, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Enrolled",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trainingModules.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Modules",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: successColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trainingModules.where((m) => m["status"] == "Completed").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Modules",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.schedule, color: warningColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "In Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trainingModules.where((m) => m["status"] == "In Progress").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Modules",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: disabledBoldColor, size: 20),
                        SizedBox(width: spXs),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: "Search training modules...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: disabledBoldColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Filter Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: selectedCategory == "All" ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: selectedCategory == "All" ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        selectedCategory = "All";
                        setState(() {});
                      },
                      child: Text(
                        "All Categories",
                        style: TextStyle(
                          color: selectedCategory == "All" ? Colors.white : disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ...["Sustainability", "Crop Management", "Livestock", "Water Management", "Technology", "Certification"]
                      .map((category) => Container(
                        margin: EdgeInsets.only(left: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: selectedCategory == category ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: selectedCategory == category ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            selectedCategory = category;
                            setState(() {});
                          },
                          child: Text(
                            category,
                            style: TextStyle(
                              color: selectedCategory == category ? Colors.white : disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Filter by Difficulty and Progress
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedDifficulty,
                        onChanged: (value) {
                          selectedDifficulty = value!;
                          setState(() {});
                        },
                        items: ["All", "Beginner", "Intermediate", "Advanced"]
                            .map((difficulty) => DropdownMenuItem(
                                  value: difficulty,
                                  child: Text(
                                    difficulty == "All" ? "All Levels" : difficulty,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],  
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedProgress,
                        onChanged: (value) {
                          selectedProgress = value!;
                          setState(() {});
                        },
                        items: ["All", "Not Started", "In Progress", "Completed"]
                            .map((progress) => DropdownMenuItem(
                                  value: progress,
                                  child: Text(
                                    progress == "All" ? "All Status" : progress,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Training Modules List
            Text(
              "Training Modules (${filteredModules.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredModules.length,
              itemBuilder: (context, index) {
                final module = filteredModules[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${module["image"]}",
                              width: 80,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${module["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getDifficultyColor(module["difficulty"]).withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        border: Border.all(
                                          color: _getDifficultyColor(module["difficulty"]).withAlpha(30),
                                        ),
                                      ),
                                      child: Text(
                                        "${module["difficulty"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getDifficultyColor(module["difficulty"]),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${module["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.person, color: disabledBoldColor, size: 12),
                                    SizedBox(width: 4),
                                    Text(
                                      "${module["instructor"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(Icons.access_time, color: disabledBoldColor, size: 12),
                                    SizedBox(width: 4),
                                    Text(
                                      "${module["duration"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Progress Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress: ${module["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(module["status"]).withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: _getStatusColor(module["status"]).withAlpha(30),
                                  ),
                                ),
                                child: Text(
                                  "${module["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getStatusColor(module["status"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (module["progress"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getStatusColor(module["status"]),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Module Details
                      Row(
                        children: [
                          Icon(Icons.menu_book, color: disabledBoldColor, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "${module["chapters"]} chapters",
                            style: TextStyle(fontSize: 11, color: disabledBoldColor),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.star, color: warningColor, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "${module["rating"]}",
                            style: TextStyle(fontSize: 11, color: disabledBoldColor),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.people, color: disabledBoldColor, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "${module["enrolled"]}",
                            style: TextStyle(fontSize: 11, color: disabledBoldColor),
                          ),
                          if (module["certificate"] == true) ...[
                            SizedBox(width: spSm),
                            Icon(Icons.verified, color: successColor, size: 14),
                            SizedBox(width: 4),
                            Text(
                              "Certificate",
                              style: TextStyle(fontSize: 11, color: successColor),
                            ),
                          ],
                        ],
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Skills Tags
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (module["skills"] as List).map<Widget>((skill) => Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: primaryColor.withAlpha(20)),
                          ),
                          child: Text(
                            "$skill",
                            style: TextStyle(
                              fontSize: 9,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )).toList(),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: module["status"] == "Completed" ? "Review" : 
                                     module["status"] == "In Progress" ? "Continue" : "Start",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.info_outline,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.bookmark_border,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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
        return disabledBoldColor;
    }
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Not Started":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }
}
