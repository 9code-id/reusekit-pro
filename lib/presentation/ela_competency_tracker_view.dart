import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCompetencyTrackerView extends StatefulWidget {
  const ElaCompetencyTrackerView({super.key});

  @override
  State<ElaCompetencyTrackerView> createState() => _ElaCompetencyTrackerViewState();
}

class _ElaCompetencyTrackerViewState extends State<ElaCompetencyTrackerView> {
  int selectedGrade = 0;
  String selectedStandard = "Reading";
  List<Map<String, dynamic>> grades = [
    {"label": "Grade K", "value": 0},
    {"label": "Grade 1", "value": 1},
    {"label": "Grade 2", "value": 2},
    {"label": "Grade 3", "value": 3},
    {"label": "Grade 4", "value": 4},
    {"label": "Grade 5", "value": 5},
  ];

  List<Map<String, dynamic>> standards = [
    {"label": "Reading", "value": "Reading"},
    {"label": "Writing", "value": "Writing"},
    {"label": "Speaking & Listening", "value": "Speaking"},
    {"label": "Language", "value": "Language"},
  ];

  List<Map<String, dynamic>> competencies = [
    {
      "id": "RF.K.1",
      "title": "Print Concepts",
      "description": "Demonstrate understanding of the organization and basic features of print",
      "standard": "Reading",
      "grade": 0,
      "mastery_level": "Proficient",
      "progress": 85,
      "last_assessed": "2025-06-10",
      "skills": [
        "Follow words from left to right, top to bottom",
        "Recognize that spoken words are represented in written language",
        "Understand that words are separated by spaces"
      ]
    },
    {
      "id": "RF.K.2",
      "title": "Phonological Awareness",
      "description": "Demonstrate understanding of spoken words, syllables, and sounds",
      "standard": "Reading",
      "grade": 0,
      "mastery_level": "Developing",
      "progress": 65,
      "last_assessed": "2025-06-12",
      "skills": [
        "Recognize and produce rhyming words",
        "Count, pronounce, blend, and segment syllables",
        "Isolate and pronounce initial sounds"
      ]
    },
    {
      "id": "W.1.1",
      "title": "Opinion Writing",
      "description": "Write opinion pieces introducing topic, stating opinion, and providing closure",
      "standard": "Writing",
      "grade": 1,
      "mastery_level": "Beginning",
      "progress": 45,
      "last_assessed": "2025-06-08",
      "skills": [
        "Introduce the topic being written about",
        "State an opinion",
        "Supply a reason for the opinion",
        "Provide some sense of closure"
      ]
    },
    {
      "id": "SL.2.1",
      "title": "Collaborative Discussion",
      "description": "Participate in collaborative conversations with diverse partners",
      "standard": "Speaking",
      "grade": 2,
      "mastery_level": "Proficient",
      "progress": 90,
      "last_assessed": "2025-06-11",
      "skills": [
        "Follow agreed-upon rules for discussions",
        "Build on others' talk in conversations",
        "Ask for clarification and further explanation"
      ]
    },
    {
      "id": "L.3.1",
      "title": "Grammar Conventions",
      "description": "Demonstrate command of conventions of standard English grammar",
      "standard": "Language",
      "grade": 3,
      "mastery_level": "Developing",
      "progress": 70,
      "last_assessed": "2025-06-09",
      "skills": [
        "Explain the function of nouns, pronouns, verbs",
        "Form and use regular and irregular plural nouns",
        "Use abstract nouns"
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredCompetencies {
    return competencies.where((comp) {
      bool gradeMatch = (comp["grade"] as int) == selectedGrade;
      bool standardMatch = (comp["standard"] as String) == selectedStandard;
      return gradeMatch && standardMatch;
    }).toList();
  }

  Color getMasteryColor(String level) {
    switch (level) {
      case "Proficient":
        return successColor;
      case "Developing":
        return warningColor;
      case "Beginning":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ELA Competency Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {
              //navigateTo('assessment_reports')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('tracker_settings')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Filter Competencies",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Grade Level",
                          items: grades,
                          value: selectedGrade,
                          onChanged: (value, label) {
                            selectedGrade = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Standard",
                          items: standards,
                          value: selectedStandard,
                          onChanged: (value, label) {
                            selectedStandard = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Overview Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredCompetencies.where((c) => c["mastery_level"] == "Proficient").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Proficient",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredCompetencies.where((c) => c["mastery_level"] == "Developing").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Developing",
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.school,
                          color: dangerColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${filteredCompetencies.where((c) => c["mastery_level"] == "Beginning").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Beginning",
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

            // Competencies List
            Text(
              "Competencies",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredCompetencies.map((competency) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: getMasteryColor("${competency["mastery_level"]}"),
                    ),
                  ),
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
                            children: [
                              Text(
                                "${competency["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${competency["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                            color: getMasteryColor("${competency["mastery_level"]}"),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${competency["mastery_level"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "${competency["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${competency["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: getMasteryColor("${competency["mastery_level"]}"),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (competency["progress"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: getMasteryColor("${competency["mastery_level"]}"),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Skills
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Key Skills:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        ...(competency["skills"] as List).map((skill) {
                          return Padding(
                            padding: EdgeInsets.only(left: spSm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "• ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "$skill",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),

                    // Last Assessed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Last assessed: ${competency["last_assessed"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            QButton(
                              label: "Assess",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('assess_competency')
                              },
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                //showCompetencyMenu()
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredCompetencies.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No competencies found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try changing the filter settings",
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('add_competency')
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
