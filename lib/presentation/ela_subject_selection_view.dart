import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaSubjectSelectionView extends StatefulWidget {
  const ElaSubjectSelectionView({super.key});

  @override
  State<ElaSubjectSelectionView> createState() => _ElaSubjectSelectionViewState();
}

class _ElaSubjectSelectionViewState extends State<ElaSubjectSelectionView> {
  List<String> selectedSubjects = [];
  String gradeLevel = "9-12";
  String selectedCategory = "All";
  bool loading = false;

  final List<Map<String, dynamic>> gradeLevels = [
    {"label": "Elementary (K-5)", "value": "K-5"},
    {"label": "Middle School (6-8)", "value": "6-8"},
    {"label": "High School (9-12)", "value": "9-12"},
    {"label": "College Prep", "value": "College"},
  ];

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Language Arts", "value": "Language Arts"},
    {"label": "Literature", "value": "Literature"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Reading", "value": "Reading"},
    {"label": "Grammar", "value": "Grammar"},
  ];

  final List<Map<String, dynamic>> subjects = [
    {
      "id": "eng_comp_1",
      "name": "English Composition I",
      "category": "Writing",
      "grade": "9-12",
      "description": "Fundamental writing skills, essay structure, and academic writing",
      "icon": Icons.edit,
      "color": primaryColor,
      "duration": "Semester",
      "difficulty": "Beginner",
      "prerequisites": [],
      "topics": ["Essay Writing", "Grammar", "Research", "Citations"],
      "isPopular": true,
      "isRequired": true,
    },
    {
      "id": "eng_comp_2",
      "name": "English Composition II",
      "category": "Writing",
      "grade": "9-12",
      "description": "Advanced writing techniques, research papers, and literary analysis",
      "icon": Icons.article,
      "color": secondaryColor,
      "duration": "Semester",
      "difficulty": "Intermediate",
      "prerequisites": ["English Composition I"],
      "topics": ["Research Papers", "Literary Analysis", "Critical Thinking", "Advanced Grammar"],
      "isPopular": true,
      "isRequired": true,
    },
    {
      "id": "american_lit",
      "name": "American Literature",
      "category": "Literature",
      "grade": "9-12",
      "description": "Survey of American literary works from colonial times to present",
      "icon": Icons.flag,
      "color": Colors.red,
      "duration": "Full Year",
      "difficulty": "Intermediate",
      "prerequisites": ["English Composition I"],
      "topics": ["Colonial Literature", "Romanticism", "Realism", "Modern Literature"],
      "isPopular": true,
      "isRequired": false,
    },
    {
      "id": "british_lit",
      "name": "British Literature",
      "category": "Literature",
      "grade": "9-12",
      "description": "Exploration of British literary tradition from Anglo-Saxon to contemporary",
      "icon": Icons.castle,
      "color": Colors.blue,
      "duration": "Full Year",
      "difficulty": "Intermediate",
      "prerequisites": ["English Composition I"],
      "topics": ["Shakespeare", "Victorian Literature", "Romanticism", "Medieval Literature"],
      "isPopular": false,
      "isRequired": false,
    },
    {
      "id": "world_lit",
      "name": "World Literature",
      "category": "Literature",
      "grade": "9-12",
      "description": "Global perspective on literary works from diverse cultures and traditions",
      "icon": Icons.public,
      "color": Colors.green,
      "duration": "Full Year",
      "difficulty": "Advanced",
      "prerequisites": ["English Composition II"],
      "topics": ["Ancient Literature", "Eastern Literature", "European Literature", "Contemporary Global Works"],
      "isPopular": false,
      "isRequired": false,
    },
    {
      "id": "creative_writing",
      "name": "Creative Writing",
      "category": "Writing",
      "grade": "9-12",
      "description": "Develop skills in fiction, poetry, and creative nonfiction writing",
      "icon": Icons.create,
      "color": Colors.purple,
      "duration": "Semester",
      "difficulty": "Intermediate",
      "prerequisites": ["English Composition I"],
      "topics": ["Fiction Writing", "Poetry", "Creative Nonfiction", "Workshop Techniques"],
      "isPopular": true,
      "isRequired": false,
    },
    {
      "id": "speech_debate",
      "name": "Speech and Debate",
      "category": "Language Arts",
      "grade": "9-12",
      "description": "Public speaking, argumentation, and debate techniques",
      "icon": Icons.record_voice_over,
      "color": Colors.orange,
      "duration": "Semester",
      "difficulty": "Intermediate",
      "prerequisites": [],
      "topics": ["Public Speaking", "Argumentation", "Research", "Performance"],
      "isPopular": false,
      "isRequired": false,
    },
    {
      "id": "journalism",
      "name": "Journalism",
      "category": "Writing",
      "grade": "9-12",
      "description": "News writing, media literacy, and digital journalism skills",
      "icon": Icons.newspaper,
      "color": Colors.teal,
      "duration": "Semester",
      "difficulty": "Intermediate",
      "prerequisites": ["English Composition I"],
      "topics": ["News Writing", "Interviewing", "Media Ethics", "Digital Publishing"],
      "isPopular": false,
      "isRequired": false,
    },
    {
      "id": "ap_english_lang",
      "name": "AP English Language and Composition",
      "category": "Writing",
      "grade": "9-12",
      "description": "College-level analysis and composition, rhetorical strategies",
      "icon": Icons.school,
      "color": Colors.indigo,
      "duration": "Full Year",
      "difficulty": "Advanced",
      "prerequisites": ["English Composition II"],
      "topics": ["Rhetorical Analysis", "Synthesis Essays", "Argument Essays", "College Writing"],
      "isPopular": true,
      "isRequired": false,
    },
    {
      "id": "ap_english_lit",
      "name": "AP English Literature and Composition",
      "category": "Literature",
      "grade": "9-12",
      "description": "College-level literary analysis and critical writing",
      "icon": Icons.library_books,
      "color": Colors.deepPurple,
      "duration": "Full Year",
      "difficulty": "Advanced",
      "prerequisites": ["American Literature or British Literature"],
      "topics": ["Literary Analysis", "Poetry", "Drama", "Fiction", "Critical Essays"],
      "isPopular": true,
      "isRequired": false,
    },
    {
      "id": "reading_comprehension",
      "name": "Reading Comprehension",
      "category": "Reading",
      "grade": "6-8",
      "description": "Improve reading skills, vocabulary, and comprehension strategies",
      "icon": Icons.menu_book,
      "color": Colors.brown,
      "duration": "Semester",
      "difficulty": "Beginner",
      "prerequisites": [],
      "topics": ["Reading Strategies", "Vocabulary Building", "Text Analysis", "Critical Reading"],
      "isPopular": false,
      "isRequired": true,
    },
    {
      "id": "grammar_mechanics",
      "name": "Grammar and Mechanics",
      "category": "Grammar",
      "grade": "6-8",
      "description": "Essential grammar rules, punctuation, and writing mechanics",
      "icon": Icons.spellcheck,
      "color": Colors.cyan,
      "duration": "Semester",
      "difficulty": "Beginner",
      "prerequisites": [],
      "topics": ["Parts of Speech", "Sentence Structure", "Punctuation", "Usage Rules"],
      "isPopular": false,
      "isRequired": true,
    },
  ];

  List<Map<String, dynamic>> get filteredSubjects {
    return subjects.where((subject) {
      bool matchesGrade = subject["grade"] == gradeLevel || 
                         (gradeLevel == "K-5" && subject["grade"] == "K-5") ||
                         (gradeLevel == "6-8" && (subject["grade"] == "6-8" || subject["grade"] == "9-12")) ||
                         (gradeLevel == "9-12" && subject["grade"] == "9-12") ||
                         (gradeLevel == "College" && subject["grade"] == "9-12");
      
      bool matchesCategory = selectedCategory == "All" || subject["category"] == selectedCategory;
      
      return matchesGrade && matchesCategory;
    }).toList();
  }

  List<Map<String, dynamic>> get requiredSubjects {
    return filteredSubjects.where((subject) => subject["isRequired"] == true).toList();
  }

  List<Map<String, dynamic>> get electiveSubjects {
    return filteredSubjects.where((subject) => subject["isRequired"] == false).toList();
  }

  void _toggleSubjectSelection(String subjectId) {
    if (selectedSubjects.contains(subjectId)) {
      selectedSubjects.remove(subjectId);
    } else {
      selectedSubjects.add(subjectId);
    }
    setState(() {});
  }

  void _saveSelection() async {
    if (selectedSubjects.isEmpty) {
      se("Please select at least one subject");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Subject selection saved successfully!");
    
    // Show confirmation dialog with selected subjects
    _showSelectionSummary();
  }

  void _selectAllRequired() {
    selectedSubjects.clear();
    for (var subject in requiredSubjects) {
      selectedSubjects.add(subject["id"]);
    }
    setState(() {});
    ss("All required subjects selected");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select ELA Subjects"),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showSubjectGuide();
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Selection Header
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: QDropdownField(
                              label: "Grade Level",
                              items: gradeLevels,
                              value: gradeLevel,
                              onChanged: (value, label) {
                                gradeLevel = value;
                                selectedSubjects.clear();
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QDropdownField(
                              label: "Category",
                              items: categories,
                              value: selectedCategory,
                              onChanged: (value, label) {
                                selectedCategory = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),

                      // Selection Summary
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: primaryColor.withAlpha(50)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.checklist, color: primaryColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${selectedSubjects.length} subjects selected • ${filteredSubjects.length} available",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            if (requiredSubjects.isNotEmpty)
                              QButton(
                                label: "Select Required",
                                size: bs.sm,
                                onPressed: _selectAllRequired,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Subjects List
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      spacing: spMd,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Required Subjects
                        if (requiredSubjects.isNotEmpty) ...[
                          Text(
                            "Required Subjects",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          ...requiredSubjects.map((subject) {
                            return _buildSubjectCard(subject, isRequired: true);
                          }).toList(),
                        ],

                        // Elective Subjects
                        if (electiveSubjects.isNotEmpty) ...[
                          Text(
                            "Elective Subjects",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          ...electiveSubjects.map((subject) {
                            return _buildSubjectCard(subject, isRequired: false);
                          }).toList(),
                        ],

                        if (filteredSubjects.isEmpty)
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 50),
                                Icon(
                                  Icons.school,
                                  size: 64,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(height: spMd),
                                Text(
                                  "No subjects available",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Try selecting a different grade level or category",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Save Button
                if (selectedSubjects.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [shadowSm],
                    ),
                    child: QButton(
                      label: "Save Selection (${selectedSubjects.length} subjects)",
                      size: bs.md,
                      onPressed: _saveSelection,
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject, {bool isRequired = false}) {
    bool isSelected = selectedSubjects.contains(subject["id"]);
    Color statusColor = isRequired ? successColor : infoColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isSelected 
            ? Border.all(color: primaryColor, width: 2)
            : isRequired
                ? Border.all(color: statusColor.withAlpha(100))
                : null,
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isSelected 
                  ? primaryColor.withAlpha(10) 
                  : (subject["color"] as Color).withAlpha(10),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (subject["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        subject["icon"],
                        color: subject["color"],
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${subject["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              if (isRequired)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Required",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              if (isRequired) SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${subject["category"]}",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              if (subject["isPopular"])
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
                                    "Popular",
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _toggleSubjectSelection(subject["id"]),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Icon(
                          isSelected ? Icons.check : Icons.add,
                          color: isSelected ? Colors.white : disabledBoldColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${subject["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spSm),
                
                // Subject Details
                Row(
                  children: [
                    _buildDetailChip("Duration", "${subject["duration"]}", infoColor),
                    SizedBox(width: spXs),
                    _buildDetailChip("Level", "${subject["difficulty"]}", 
                        subject["difficulty"] == "Beginner" ? successColor :
                        subject["difficulty"] == "Intermediate" ? warningColor : dangerColor),
                  ],
                ),
                
                if ((subject["prerequisites"] as List).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text(
                    "Prerequisites:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: 4,
                    children: (subject["prerequisites"] as List).map((prereq) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$prereq",
                          style: TextStyle(
                            fontSize: 10,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                
                SizedBox(height: spSm),
                Text(
                  "Topics Covered:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: 4,
                  children: (subject["topics"] as List).map((topic) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: (subject["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$topic",
                        style: TextStyle(
                          fontSize: 10,
                          color: subject["color"],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spXs,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showSelectionSummary() {
    List<Map<String, dynamic>> selectedSubjectObjects = subjects
        .where((subject) => selectedSubjects.contains(subject["id"]))
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Selected Subjects",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "You have selected ${selectedSubjectObjects.length} subjects for $gradeLevel",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              Expanded(
                child: ListView.builder(
                  itemCount: selectedSubjectObjects.length,
                  itemBuilder: (context, index) {
                    final subject = selectedSubjectObjects[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (subject["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              subject["icon"],
                              color: subject["color"],
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${subject["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${subject["category"]} • ${subject["duration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (subject["isRequired"])
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Required",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Modify Selection",
                      size: bs.sm,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Continue",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to next step
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSubjectGuide() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Subject Selection Guide",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGuideSection(
                        "Required vs Elective",
                        "Required subjects are mandatory for graduation. Elective subjects allow you to explore interests and specialize.",
                        Icons.checklist,
                        primaryColor,
                      ),
                      
                      _buildGuideSection(
                        "Prerequisites",
                        "Some advanced courses require completion of prerequisite subjects. Check requirements before selecting.",
                        Icons.stairs,
                        warningColor,
                      ),
                      
                      _buildGuideSection(
                        "Difficulty Levels",
                        "Beginner: Foundation level\nIntermediate: Standard level\nAdvanced: College-level or AP courses",
                        Icons.trending_up,
                        infoColor,
                      ),
                      
                      _buildGuideSection(
                        "Popular Subjects",
                        "Marked subjects are highly recommended by students and teachers for college preparation.",
                        Icons.star,
                        warningColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGuideSection(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
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
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
