import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobRequirementsView extends StatefulWidget {
  const RhaJobRequirementsView({super.key});

  @override
  State<RhaJobRequirementsView> createState() => _RhaJobRequirementsViewState();
}

class _RhaJobRequirementsViewState extends State<RhaJobRequirementsView> {
  final formKey = GlobalKey<FormState>();
  
  String educationLevel = "Bachelor's Degree";
  String experienceYears = "3-5 years";
  String languageRequirement = "English (Fluent)";
  String certificationRequired = "";
  String technicalSkills = "";
  String softSkills = "";
  String additionalRequirements = "";
  bool requiresPortfolio = true;
  bool requiresCoverLetter = false;
  bool requiresReferences = true;
  bool willingToRelocate = false;
  bool availableForTravel = false;
  
  List<Map<String, dynamic>> educationItems = [
    {"label": "High School", "value": "High School"},
    {"label": "Associate Degree", "value": "Associate Degree"},
    {"label": "Bachelor's Degree", "value": "Bachelor's Degree"},
    {"label": "Master's Degree", "value": "Master's Degree"},
    {"label": "PhD", "value": "PhD"},
    {"label": "Professional Certification", "value": "Professional Certification"},
  ];
  
  List<Map<String, dynamic>> experienceItems = [
    {"label": "Entry Level (0-1 years)", "value": "0-1 years"},
    {"label": "Junior (1-3 years)", "value": "1-3 years"},
    {"label": "Mid-level (3-5 years)", "value": "3-5 years"},
    {"label": "Senior (5-8 years)", "value": "5-8 years"},
    {"label": "Expert (8+ years)", "value": "8+ years"},
  ];
  
  List<Map<String, dynamic>> languageItems = [
    {"label": "English (Fluent)", "value": "English (Fluent)"},
    {"label": "English (Conversational)", "value": "English (Conversational)"},
    {"label": "Spanish (Fluent)", "value": "Spanish (Fluent)"},
    {"label": "French (Fluent)", "value": "French (Fluent)"},
    {"label": "German (Fluent)", "value": "German (Fluent)"},
    {"label": "Mandarin (Fluent)", "value": "Mandarin (Fluent)"},
  ];

  List<Map<String, dynamic>> skillTemplates = [
    {
      "category": "Technical Skills",
      "skills": [
        "Flutter Development",
        "Dart Programming",
        "Firebase",
        "REST APIs",
        "Git Version Control",
        "Mobile App Development",
        "Cross-platform Development",
        "State Management (Bloc/Provider)",
      ]
    },
    {
      "category": "Soft Skills",
      "skills": [
        "Problem Solving",
        "Team Collaboration",
        "Communication",
        "Time Management",
        "Adaptability",
        "Critical Thinking",
        "Leadership",
        "Attention to Detail",
      ]
    },
    {
      "category": "Certifications",
      "skills": [
        "Google Flutter Certification",
        "AWS Certified Developer",
        "Project Management Professional (PMP)",
        "Scrum Master Certification",
        "Google Cloud Professional",
        "Microsoft Azure Fundamentals",
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Requirements"),
        actions: [
          IconButton(
            icon: Icon(Icons.description),
            onPressed: () {
              // Load requirement templates
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ss("Requirements saved successfully");
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              // Basic Requirements Section
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
                      "Basic Requirements",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Education Level",
                      items: educationItems,
                      value: educationLevel,
                      onChanged: (value, label) {
                        educationLevel = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Experience Required",
                      items: experienceItems,
                      value: experienceYears,
                      onChanged: (value, label) {
                        experienceYears = value;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Language Requirement",
                      items: languageItems,
                      value: languageRequirement,
                      onChanged: (value, label) {
                        languageRequirement = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Required Certifications",
                      value: certificationRequired,
                      hint: "e.g., PMP, AWS Certified Developer",
                      onChanged: (value) {
                        certificationRequired = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Skills Requirements Section
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Skills Requirements",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Use Template",
                          size: bs.sm,
                          onPressed: () {
                            _showSkillTemplateDialog();
                          },
                        ),
                      ],
                    ),
                    QMemoField(
                      label: "Technical Skills Required",
                      value: technicalSkills,
                      hint: "List required technical skills separated by commas or bullet points",
                      validator: Validator.required,
                      onChanged: (value) {
                        technicalSkills = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Soft Skills Required",
                      value: softSkills,
                      hint: "List desired soft skills and personal qualities",
                      onChanged: (value) {
                        softSkills = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Additional Requirements",
                      value: additionalRequirements,
                      hint: "Any other specific requirements or preferences",
                      onChanged: (value) {
                        additionalRequirements = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Application Requirements Section
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
                      "Application Requirements",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Portfolio/Work Samples Required",
                          "value": true,
                          "checked": requiresPortfolio,
                        }
                      ],
                      value: [
                        if (requiresPortfolio)
                          {
                            "label": "Portfolio/Work Samples Required",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        requiresPortfolio = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Cover Letter Required",
                          "value": true,
                          "checked": requiresCoverLetter,
                        }
                      ],
                      value: [
                        if (requiresCoverLetter)
                          {
                            "label": "Cover Letter Required",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        requiresCoverLetter = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "References Required",
                          "value": true,
                          "checked": requiresReferences,
                        }
                      ],
                      value: [
                        if (requiresReferences)
                          {
                            "label": "References Required",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        requiresReferences = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Additional Preferences Section
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
                      "Additional Preferences",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Willing to Relocate",
                          "value": true,
                          "checked": willingToRelocate,
                        }
                      ],
                      value: [
                        if (willingToRelocate)
                          {
                            "label": "Willing to Relocate",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        willingToRelocate = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Available for Business Travel",
                          "value": true,
                          "checked": availableForTravel,
                        }
                      ],
                      value: [
                        if (availableForTravel)
                          {
                            "label": "Available for Business Travel",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        availableForTravel = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Skill Templates Display
              ...skillTemplates.map((template) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "${template["category"]} Templates",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (template["skills"] as List).map((skill) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: infoColor.withAlpha(30)),
                            ),
                            child: Text(
                              "$skill",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),

              // Action Buttons
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save as Template",
                      size: bs.md,
                      onPressed: () {
                        ss("Requirement template saved");
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Apply Requirements",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ss("Requirements applied to job posting");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSkillTemplateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Skill Template"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: skillTemplates.length,
            itemBuilder: (context, index) {
              final template = skillTemplates[index];
              return ListTile(
                title: Text("${template["category"]}"),
                subtitle: Text("${(template["skills"] as List).length} skills"),
                onTap: () {
                  Navigator.pop(context);
                  _applySkillTemplate(template);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _applySkillTemplate(Map<String, dynamic> template) {
    String category = template["category"];
    List skills = template["skills"];
    String skillsText = skills.map((skill) => "• $skill").join("\n");

    if (category == "Technical Skills") {
      technicalSkills = skillsText;
    } else if (category == "Soft Skills") {
      softSkills = skillsText;
    } else if (category == "Certifications") {
      certificationRequired = skills.join(", ");
    }

    setState(() {});
    ss("$category template applied");
  }
}
