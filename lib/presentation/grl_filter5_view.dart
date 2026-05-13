import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFilter5View extends StatefulWidget {
  @override
  State<GrlFilter5View> createState() => _GrlFilter5ViewState();
}

class _GrlFilter5ViewState extends State<GrlFilter5View> {
  String selectedJobType = "";
  String selectedSalaryRange = "";
  String selectedExperience = "";
  String selectedLocation = "";
  String selectedCompanySize = "";
  List<String> selectedSkills = [];
  List<String> selectedBenefits = [];
  String selectedRemoteWork = "all";
  DateTime? postedAfter;
  bool fullTime = false;
  bool partTime = false;
  bool contract = false;
  bool internship = false;

  List<Map<String, dynamic>> jobTypeItems = [
    {"label": "All Job Types", "value": ""},
    {"label": "Software Engineer", "value": "software_engineer"},
    {"label": "Product Manager", "value": "product_manager"},
    {"label": "Data Scientist", "value": "data_scientist"},
    {"label": "UX Designer", "value": "ux_designer"},
    {"label": "Marketing Manager", "value": "marketing_manager"},
    {"label": "Sales Representative", "value": "sales_rep"},
    {"label": "Business Analyst", "value": "business_analyst"},
    {"label": "DevOps Engineer", "value": "devops_engineer"},
  ];

  List<Map<String, dynamic>> salaryRangeItems = [
    {"label": "Any Salary", "value": ""},
    {"label": "Under \$50k", "value": "under_50k"},
    {"label": "\$50k - \$75k", "value": "50k_75k"},
    {"label": "\$75k - \$100k", "value": "75k_100k"},
    {"label": "\$100k - \$150k", "value": "100k_150k"},
    {"label": "\$150k - \$200k", "value": "150k_200k"},
    {"label": "Over \$200k", "value": "over_200k"},
  ];

  List<Map<String, dynamic>> experienceItems = [
    {"label": "Any Experience", "value": ""},
    {"label": "Entry Level (0-2 years)", "value": "entry"},
    {"label": "Mid Level (3-5 years)", "value": "mid"},
    {"label": "Senior Level (6-10 years)", "value": "senior"},
    {"label": "Executive (10+ years)", "value": "executive"},
  ];

  List<Map<String, dynamic>> locationItems = [
    {"label": "Any Location", "value": ""},
    {"label": "New York, NY", "value": "new_york"},
    {"label": "San Francisco, CA", "value": "san_francisco"},
    {"label": "Los Angeles, CA", "value": "los_angeles"},
    {"label": "Chicago, IL", "value": "chicago"},
    {"label": "Boston, MA", "value": "boston"},
    {"label": "Seattle, WA", "value": "seattle"},
    {"label": "Austin, TX", "value": "austin"},
  ];

  List<Map<String, dynamic>> companySizeItems = [
    {"label": "Any Company Size", "value": ""},
    {"label": "Startup (1-50)", "value": "startup"},
    {"label": "Medium (51-500)", "value": "medium"},
    {"label": "Large (501-5000)", "value": "large"},
    {"label": "Enterprise (5000+)", "value": "enterprise"},
  ];

  List<String> skillsList = [
    "Python",
    "JavaScript",
    "React",
    "Node.js",
    "SQL",
    "AWS",
    "Docker",
    "Kubernetes",
    "Machine Learning",
    "Data Analysis",
    "Project Management",
    "Agile",
    "Scrum",
    "Git",
    "CI/CD",
  ];

  List<String> benefitsList = [
    "Health Insurance",
    "Dental Insurance",
    "Vision Insurance",
    "401(k) Matching",
    "Flexible Schedule",
    "Remote Work",
    "Unlimited PTO",
    "Stock Options",
    "Bonus Eligible",
    "Professional Development",
    "Gym Membership",
    "Commuter Benefits",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Filters"),
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
            // Job Type
            Text(
              "Job Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDropdownField(
              label: "Select Job Type",
              items: jobTypeItems,
              value: selectedJobType,
              onChanged: (value, label) {
                selectedJobType = value;
                setState(() {});
              },
            ),

            // Salary Range and Experience
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Salary Range",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Salary",
                        items: salaryRangeItems,
                        value: selectedSalaryRange,
                        onChanged: (value, label) {
                          selectedSalaryRange = value;
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
                        "Experience",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Experience",
                        items: experienceItems,
                        value: selectedExperience,
                        onChanged: (value, label) {
                          selectedExperience = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Location and Company Size
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Location",
                        items: locationItems,
                        value: selectedLocation,
                        onChanged: (value, label) {
                          selectedLocation = value;
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
                        "Company Size",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QDropdownField(
                        label: "Company Size",
                        items: companySizeItems,
                        value: selectedCompanySize,
                        onChanged: (value, label) {
                          selectedCompanySize = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Remote Work Options
            Text(
              "Remote Work",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QCategoryPicker(
              items: [
                {"label": "All", "value": "all"},
                {"label": "Remote Only", "value": "remote"},
                {"label": "Hybrid", "value": "hybrid"},
                {"label": "On-site", "value": "onsite"},
              ],
              value: selectedRemoteWork,
              onChanged: (index, label, value, item) {
                selectedRemoteWork = value;
                setState(() {});
              },
            ),

            // Employment Type
            Text(
              "Employment Type",
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
                        "label": "Full-time",
                        "value": true,
                        "checked": fullTime,
                      }
                    ],
                    value: [
                      if (fullTime)
                        {"label": "Full-time", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      fullTime = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Part-time",
                        "value": true,
                        "checked": partTime,
                      }
                    ],
                    value: [
                      if (partTime)
                        {"label": "Part-time", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      partTime = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Contract",
                        "value": true,
                        "checked": contract,
                      }
                    ],
                    value: [
                      if (contract)
                        {"label": "Contract", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      contract = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Internship",
                        "value": true,
                        "checked": internship,
                      }
                    ],
                    value: [
                      if (internship)
                        {"label": "Internship", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      internship = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Posted Date
            Text(
              "Posted Date",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            QDatePicker(
              label: "Posted After",
              value: postedAfter ?? DateTime.now().subtract(Duration(days: 30)),
              onChanged: (value) {
                postedAfter = value;
                setState(() {});
              },
            ),

            // Required Skills
            Text(
              "Required Skills",
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
                    "Select skills you have:",
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

            // Benefits
            Text(
              "Benefits",
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
                    "Select desired benefits:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: benefitsList.map((benefit) {
                      bool isSelected = selectedBenefits.contains(benefit);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            selectedBenefits.remove(benefit);
                          } else {
                            selectedBenefits.add(benefit);
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
                            benefit,
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
      'jobType': selectedJobType,
      'salaryRange': selectedSalaryRange,
      'experience': selectedExperience,
      'location': selectedLocation,
      'companySize': selectedCompanySize,
      'skills': selectedSkills,
      'benefits': selectedBenefits,
      'remoteWork': selectedRemoteWork,
      'postedAfter': postedAfter?.toIso8601String(),
      'fullTime': fullTime,
      'partTime': partTime,
      'contract': contract,
      'internship': internship,
    };

    ss("Job filters applied successfully!");
    back();
  }

  void _resetFilters() {
    selectedJobType = "";
    selectedSalaryRange = "";
    selectedExperience = "";
    selectedLocation = "";
    selectedCompanySize = "";
    selectedSkills.clear();
    selectedBenefits.clear();
    selectedRemoteWork = "all";
    postedAfter = null;
    fullTime = false;
    partTime = false;
    contract = false;
    internship = false;
    setState(() {});
  }
}
