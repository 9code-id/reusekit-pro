import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter9View extends StatefulWidget {
  @override
  State<GrlFilter9View> createState() => _GrlFilter9ViewState();
}

class _GrlFilter9ViewState extends State<GrlFilter9View> {
  String selectedCategory = "";
  String selectedSubject = "";
  String selectedLevel = "";
  String selectedLanguage = "";
  String selectedDuration = "";
  String selectedPriceRange = "";
  List<String> selectedSkills = [];
  List<String> selectedCertifications = [];
  String selectedFormat = "";
  bool freeOnly = false;
  bool withCertificate = false;
  bool beginnerFriendly = false;
  bool selfPaced = false;
  double maxPrice = 200;
  int minRating = 0;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": ""},
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Photography", "value": "photography"},
    {"label": "Music", "value": "music"},
    {"label": "Health & Fitness", "value": "health_fitness"},
    {"label": "Personal Development", "value": "personal_dev"},
  ];

  List<Map<String, dynamic>> subjectItems = [
    {"label": "All Subjects", "value": ""},
    {"label": "Programming", "value": "programming"},
    {"label": "Data Science", "value": "data_science"},
    {"label": "Web Development", "value": "web_dev"},
    {"label": "Mobile Development", "value": "mobile_dev"},
    {"label": "Graphic Design", "value": "graphic_design"},
    {"label": "Digital Marketing", "value": "digital_marketing"},
    {"label": "Project Management", "value": "project_management"},
    {"label": "Language Learning", "value": "language_learning"},
  ];

  List<Map<String, dynamic>> levelItems = [
    {"label": "All Levels", "value": ""},
    {"label": "Beginner", "value": "beginner"},
    {"label": "Intermediate", "value": "intermediate"},
    {"label": "Advanced", "value": "advanced"},
    {"label": "Expert", "value": "expert"},
  ];

  List<Map<String, dynamic>> languageItems = [
    {"label": "Any Language", "value": ""},
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Portuguese", "value": "portuguese"},
    {"label": "Italian", "value": "italian"},
    {"label": "Japanese", "value": "japanese"},
    {"label": "Korean", "value": "korean"},
  ];

  List<Map<String, dynamic>> durationItems = [
    {"label": "Any Duration", "value": ""},
    {"label": "Under 2 hours", "value": "under_2h"},
    {"label": "2-5 hours", "value": "2_5h"},
    {"label": "5-10 hours", "value": "5_10h"},
    {"label": "10-20 hours", "value": "10_20h"},
    {"label": "Over 20 hours", "value": "over_20h"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "Any Price", "value": ""},
    {"label": "Free", "value": "free"},
    {"label": "Under \$50", "value": "under_50"},
    {"label": "\$50 - \$100", "value": "50_100"},
    {"label": "\$100 - \$200", "value": "100_200"},
    {"label": "Over \$200", "value": "over_200"},
  ];

  List<Map<String, dynamic>> formatItems = [
    {"label": "Any Format", "value": ""},
    {"label": "Video Course", "value": "video"},
    {"label": "Live Class", "value": "live"},
    {"label": "Interactive", "value": "interactive"},
    {"label": "Text-based", "value": "text"},
    {"label": "Mixed Media", "value": "mixed"},
  ];

  List<String> skillsList = [
    "Python",
    "JavaScript",
    "React",
    "Node.js",
    "Machine Learning",
    "Data Analysis",
    "Photoshop",
    "Illustrator",
    "SEO",
    "Social Media Marketing",
    "Project Management",
    "Leadership",
    "Communication",
    "Problem Solving",
    "Critical Thinking",
  ];

  List<String> certificationsList = [
    "Google Analytics",
    "AWS Certified",
    "Microsoft Certified",
    "Adobe Certified",
    "PMP Certification",
    "Scrum Master",
    "Facebook Blueprint",
    "HubSpot Certified",
    "Salesforce Certified",
    "Cisco Certified",
    "CompTIA Certified",
    "Oracle Certified",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Filters"),
        actions: [
          GestureDetector(
            onTap: () {
              _resetFilters();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Center(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category and Subject
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Category",
                        items: categoryItems,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subject",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Subject",
                        items: subjectItems,
                        value: selectedSubject,
                        onChanged: (value, label) {
                          selectedSubject = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Level and Language
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Level",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Level",
                        items: levelItems,
                        value: selectedLevel,
                        onChanged: (value, label) {
                          selectedLevel = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Language",
                        items: languageItems,
                        value: selectedLanguage,
                        onChanged: (value, label) {
                          selectedLanguage = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Duration and Format
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Duration",
                        items: durationItems,
                        value: selectedDuration,
                        onChanged: (value, label) {
                          selectedDuration = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Format",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Format",
                        items: formatItems,
                        value: selectedFormat,
                        onChanged: (value, label) {
                          selectedFormat = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Price Range
            Text(
              "Price Range",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Price Range",
              items: priceRangeItems,
              value: selectedPriceRange,
              onChanged: (value, label) {
                selectedPriceRange = value;
                setState(() {});
              },
            ),

            // Custom Price Slider
            if (selectedPriceRange == "") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Max Price: \$${maxPrice.toInt()}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: maxPrice,
                      min: 0,
                      max: 500,
                      divisions: 50,
                      activeColor: primaryColor,
                      label: "\$${maxPrice.toInt()}",
                      onChanged: (value) {
                        maxPrice = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Rating Filter
            Text(
              "Minimum Rating",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "${minRating > 0 ? '$minRating+ Stars' : 'Any Rating'}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < minRating ? Icons.star : Icons.star_border,
                            color: warningColor,
                            size: 20,
                          );
                        }),
                      ),
                    ],
                  ),
                  Slider(
                    value: minRating.toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      minRating = value.toInt();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Course Features
            Text(
              "Course Features",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QSwitch(
                    items: [
                      {
                        "label": "Free Only",
                        "value": true,
                        "checked": freeOnly,
                      }
                    ],
                    value: [
                      if (freeOnly)
                        {"label": "Free Only", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      freeOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "With Certificate",
                        "value": true,
                        "checked": withCertificate,
                      }
                    ],
                    value: [
                      if (withCertificate)
                        {"label": "With Certificate", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      withCertificate = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Beginner Friendly",
                        "value": true,
                        "checked": beginnerFriendly,
                      }
                    ],
                    value: [
                      if (beginnerFriendly)
                        {"label": "Beginner Friendly", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      beginnerFriendly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Self-Paced",
                        "value": true,
                        "checked": selfPaced,
                      }
                    ],
                    value: [
                      if (selfPaced)
                        {"label": "Self-Paced", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      selfPaced = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Skills to Learn
            Text(
              "Skills to Learn",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select skills you want to learn:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: skillsList.map((skill) {
                      bool isSelected = selectedSkills.contains(skill);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedSkills.remove(skill);
                          } else {
                            selectedSkills.add(skill);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Certifications
            Text(
              "Certifications",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select certifications you're interested in:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: certificationsList.map((certification) {
                      bool isSelected = selectedCertifications.contains(certification);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedCertifications.remove(certification);
                          } else {
                            selectedCertifications.add(certification);
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? successColor : Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? successColor : Colors.grey.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            certification,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Apply Filter Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  _applyFilters();
                },
              ),
            ),

            SizedBox(height: spSm),

            // Clear Filters Button
            Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _resetFilters();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: spMd),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Center(
                    child: Text(
                      "Clear All Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    Map<String, dynamic> filters = {
      'category': selectedCategory,
      'subject': selectedSubject,
      'level': selectedLevel,
      'language': selectedLanguage,
      'duration': selectedDuration,
      'format': selectedFormat,
      'priceRange': selectedPriceRange,
      'maxPrice': maxPrice,
      'minRating': minRating,
      'skills': selectedSkills,
      'certifications': selectedCertifications,
      'freeOnly': freeOnly,
      'withCertificate': withCertificate,
      'beginnerFriendly': beginnerFriendly,
      'selfPaced': selfPaced,
    };

    ss("Course filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedCategory = "";
    selectedSubject = "";
    selectedLevel = "";
    selectedLanguage = "";
    selectedDuration = "";
    selectedFormat = "";
    selectedPriceRange = "";
    selectedSkills.clear();
    selectedCertifications.clear();
    freeOnly = false;
    withCertificate = false;
    beginnerFriendly = false;
    selfPaced = false;
    maxPrice = 200;
    minRating = 0;
    setState(() {});
  }
}
