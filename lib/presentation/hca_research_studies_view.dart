import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaResearchStudiesView extends StatefulWidget {
  const HcaResearchStudiesView({super.key});

  @override
  State<HcaResearchStudiesView> createState() => _HcaResearchStudiesViewState();
}

class _HcaResearchStudiesViewState extends State<HcaResearchStudiesView> {
  String selectedFilter = "All";
  String searchQuery = "";
  bool showEligibleOnly = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Studies", "value": "All"},
    {"label": "Recruiting", "value": "Recruiting"},
    {"label": "Active", "value": "Active"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Upcoming", "value": "Upcoming"},
  ];

  List<Map<String, dynamic>> researchStudies = [
    {
      "id": 1,
      "title": "Digital Health Monitoring for Diabetes Management",
      "institution": "Johns Hopkins University",
      "principalInvestigator": "Dr. Jennifer Martinez",
      "status": "Recruiting",
      "studyType": "Clinical Trial",
      "phase": "Phase III",
      "participants": {"current": 145, "target": 200},
      "duration": "12 months",
      "compensation": "\$500",
      "location": "Baltimore, MD",
      "remote": true,
      "startDate": "2024-02-01",
      "endDate": "2025-02-01",
      "description": "This study evaluates the effectiveness of a digital health platform in improving diabetes management through continuous glucose monitoring and AI-powered insights.",
      "eligibilityCriteria": [
        "Adults aged 18-65 with Type 2 diabetes",
        "HbA1c levels between 7-10%",
        "Smartphone access required",
        "No severe complications"
      ],
      "primaryOutcome": "HbA1c reduction after 6 months",
      "secondaryOutcomes": [
        "Time in range improvement",
        "Quality of life scores",
        "Healthcare utilization"
      ],
      "isEligible": true,
      "hasApplied": false,
      "category": "Endocrinology",
      "fundingSource": "NIH",
      "contactEmail": "diabetes.study@jhu.edu",
      "contactPhone": "(410) 555-0123"
    },
    {
      "id": 2,
      "title": "Mindfulness-Based Stress Reduction for Heart Disease",
      "institution": "Mayo Clinic",
      "principalInvestigator": "Dr. Sarah Thompson",
      "status": "Active",
      "studyType": "Interventional Study",
      "phase": "N/A",
      "participants": {"current": 89, "target": 120},
      "duration": "8 weeks",
      "compensation": "\$200",
      "location": "Rochester, MN",
      "remote": false,
      "startDate": "2024-01-15",
      "endDate": "2024-12-15",
      "description": "Investigating the impact of structured mindfulness training on cardiovascular health outcomes in patients with coronary artery disease.",
      "eligibilityCriteria": [
        "Diagnosed coronary artery disease",
        "Ages 40-75",
        "Stable condition",
        "No prior mindfulness training"
      ],
      "primaryOutcome": "Blood pressure reduction",
      "secondaryOutcomes": [
        "Stress hormone levels",
        "Sleep quality improvement",
        "Anxiety reduction"
      ],
      "isEligible": false,
      "hasApplied": false,
      "category": "Cardiology",
      "fundingSource": "American Heart Association",
      "contactEmail": "heart.study@mayo.edu",
      "contactPhone": "(507) 555-0456"
    },
    {
      "id": 3,
      "title": "Personalized Cancer Treatment Using Genetic Profiling",
      "institution": "MD Anderson Cancer Center",
      "principalInvestigator": "Dr. Michael Rodriguez",
      "status": "Recruiting",
      "studyType": "Observational Study",
      "phase": "N/A",
      "participants": {"current": 67, "target": 150},
      "duration": "24 months",
      "compensation": "\$1000",
      "location": "Houston, TX",
      "remote": true,
      "startDate": "2024-03-01",
      "endDate": "2026-03-01",
      "description": "Long-term study tracking treatment outcomes based on genetic tumor profiling to develop personalized therapy recommendations.",
      "eligibilityCriteria": [
        "Recently diagnosed cancer",
        "Ages 18 and above",
        "Willing to provide tissue samples",
        "No previous genetic testing"
      ],
      "primaryOutcome": "Treatment response rates",
      "secondaryOutcomes": [
        "Survival rates",
        "Quality of life",
        "Treatment toxicity"
      ],
      "isEligible": true,
      "hasApplied": true,
      "category": "Oncology",
      "fundingSource": "National Cancer Institute",
      "contactEmail": "genetics.study@mdanderson.org",
      "contactPhone": "(713) 555-0789"
    },
    {
      "id": 4,
      "title": "Exercise Intervention for Alzheimer's Prevention",
      "institution": "Stanford University",
      "principalInvestigator": "Dr. Lisa Chen",
      "status": "Upcoming",
      "studyType": "Randomized Controlled Trial",
      "phase": "N/A",
      "participants": {"current": 0, "target": 300},
      "duration": "18 months",
      "compensation": "\$750",
      "location": "Palo Alto, CA",
      "remote": false,
      "startDate": "2024-04-01",
      "endDate": "2025-10-01",
      "description": "Multi-center trial examining whether structured exercise programs can delay cognitive decline in individuals at risk for Alzheimer's disease.",
      "eligibilityCriteria": [
        "Ages 55-75",
        "Family history of Alzheimer's",
        "No current cognitive impairment",
        "Able to participate in exercise"
      ],
      "primaryOutcome": "Cognitive function scores",
      "secondaryOutcomes": [
        "Brain imaging changes",
        "Biomarker levels",
        "Physical fitness metrics"
      ],
      "isEligible": true,
      "hasApplied": false,
      "category": "Neurology",
      "fundingSource": "Alzheimer's Association",
      "contactEmail": "brain.study@stanford.edu",
      "contactPhone": "(650) 555-0234"
    },
    {
      "id": 5,
      "title": "Telehealth Mental Health Services Effectiveness",
      "institution": "University of California, San Francisco",
      "principalInvestigator": "Dr. Amanda Foster",
      "status": "Completed",
      "studyType": "Comparative Study",
      "phase": "N/A",
      "participants": {"current": 250, "target": 250},
      "duration": "6 months",
      "compensation": "\$300",
      "location": "San Francisco, CA",
      "remote": true,
      "startDate": "2023-06-01",
      "endDate": "2023-12-01",
      "description": "Comparison study evaluating the effectiveness of telehealth versus in-person mental health services for anxiety and depression treatment.",
      "eligibilityCriteria": [
        "Adults with anxiety or depression",
        "Internet access required",
        "No severe mental illness",
        "First-time therapy seekers"
      ],
      "primaryOutcome": "Depression and anxiety scale scores",
      "secondaryOutcomes": [
        "Treatment adherence",
        "Patient satisfaction",
        "Cost-effectiveness"
      ],
      "isEligible": false,
      "hasApplied": false,
      "category": "Psychiatry",
      "fundingSource": "NIMH",
      "contactEmail": "telehealth.study@ucsf.edu",
      "contactPhone": "(415) 555-0567"
    }
  ];

  List<Map<String, dynamic>> get filteredStudies {
    var studies = researchStudies;
    
    if (selectedFilter != "All") {
      studies = studies.where((study) => study["status"] == selectedFilter).toList();
    }
    
    if (showEligibleOnly) {
      studies = studies.where((study) => study["isEligible"] == true).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      studies = studies.where((study) => 
        "${study["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${study["category"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${study["institution"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return studies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Studies"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Show application history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search studies...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filter Options and Quick Stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatCard("Total Studies", "${researchStudies.length}", Icons.science),
                      _buildStatCard("Recruiting", "${researchStudies.where((s) => s["status"] == "Recruiting").length}", Icons.person_add),
                      _buildStatCard("Eligible", "${researchStudies.where((s) => s["isEligible"] == true).length}", Icons.check_circle),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Filter Toggle
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show only eligible studies",
                              "value": true,
                              "checked": showEligibleOnly,
                            }
                          ],
                          value: [
                            if (showEligibleOnly)
                              {
                                "label": "Show only eligible studies",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showEligibleOnly = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Status Filter
            QCategoryPicker(
              label: "Filter by Status",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Studies Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredStudies.length} Studies Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                if (selectedFilter != "All" || showEligibleOnly || searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      selectedFilter = "All";
                      showEligibleOnly = false;
                      searchQuery = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear All Filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Research Studies List
            ...List.generate(filteredStudies.length, (index) {
              final study = filteredStudies[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: study["isEligible"] 
                    ? Border.all(color: successColor.withAlpha(100), width: 2)
                    : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Status and Eligibility
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor(study["status"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${study["status"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (study["isEligible"])
                            Container(
                              margin: EdgeInsets.only(left: spSm),
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Eligible",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Spacer(),
                          if (study["hasApplied"])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: infoColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Applied",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Study Title
                      Text(
                        "${study["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Institution and PI
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${study["institution"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "PI: ${study["principalInvestigator"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Description
                      Text(
                        "${study["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Key Details Grid
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDetailItem("Duration", "${study["duration"]}", Icons.schedule),
                                ),
                                Expanded(
                                  child: _buildDetailItem("Compensation", "${study["compensation"]}", Icons.monetization_on),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDetailItem("Participants", "${study["participants"]["current"]}/${study["participants"]["target"]}", Icons.people),
                                ),
                                Expanded(
                                  child: _buildDetailItem("Location", study["remote"] ? "Remote" : "${study["location"]}", study["remote"] ? Icons.computer : Icons.location_on),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Primary Outcome
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Primary Outcome",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${study["primaryOutcome"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {
                                _showStudyDetails(study);
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (study["status"] == "Recruiting" && !study["hasApplied"])
                            Expanded(
                              child: QButton(
                                label: study["isEligible"] ? "Apply Now" : "Check Eligibility", 
                                color: study["isEligible"] ? successColor : warningColor,
                                size: bs.sm,
                                onPressed: () {
                                  if (study["isEligible"]) {
                                    _applyToStudy(study);
                                  } else {
                                    _checkEligibility(study);
                                  }
                                },
                              ),
                            ),
                          if (study["hasApplied"])
                            Expanded(
                              child: QButton(
                                label: "View Application",
                                color: infoColor,
                                size: bs.sm,
                                onPressed: () {
                                  // View application status
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            
            if (filteredStudies.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.science_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Studies Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or search criteria",
                      textAlign: TextAlign.center,
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
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: primaryColor,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH5,
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
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Recruiting":
        return successColor;
      case "Active":
        return infoColor;
      case "Completed":
        return disabledBoldColor;
      case "Upcoming":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    // Show filter dialog
  }

  void _showStudyDetails(Map<String, dynamic> study) {
    // Show detailed study information
  }

  void _applyToStudy(Map<String, dynamic> study) {
    study["hasApplied"] = true;
    setState(() {});
    ss("Application submitted successfully!");
  }

  void _checkEligibility(Map<String, dynamic> study) {
    // Check eligibility criteria
  }
}
