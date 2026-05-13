import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCandidateFilterView extends StatefulWidget {
  const RhaCandidateFilterView({super.key});

  @override
  State<RhaCandidateFilterView> createState() => _RhaCandidateFilterViewState();
}

class _RhaCandidateFilterViewState extends State<RhaCandidateFilterView> {
  // Basic filters
  String selectedLocation = "";
  String selectedExperience = "";
  String selectedEducation = "";
  String selectedEmploymentType = "";
  List<String> selectedSkills = [];
  List<String> selectedIndustries = [];
  
  // Advanced filters
  Map<String, dynamic> salaryRange = {"min": 0, "max": 200000};
  String selectedAvailability = "";
  String selectedNoticeperiod = "";
  List<String> selectedLanguages = [];
  List<String> selectedCertifications = [];
  
  // Preference filters
  bool remoteWork = false;
  bool willingToRelocate = false;
  bool sponsorshipRequired = false;
  bool activelyLooking = false;
  String selectedWorkArrangement = "";
  
  // Search behavior filters
  String profileCompleteness = "";
  String lastActiveWithin = "";
  String responseRate = "";
  bool hasPortfolio = false;
  bool hasReferences = false;
  
  int totalMatches = 0;
  bool isLoading = false;

  // Mock filter options
  List<String> locations = [
    "All Locations", "San Francisco, CA", "New York, NY", "Seattle, WA",
    "Austin, TX", "Boston, MA", "Los Angeles, CA", "Chicago, IL", 
    "Miami, FL", "Denver, CO", "Remote", "Hybrid"
  ];

  List<String> experienceLevels = [
    "All Experience", "Entry Level (0-2 years)", "Mid Level (3-5 years)",
    "Senior Level (6-10 years)", "Lead Level (10+ years)", "Executive (15+ years)"
  ];

  List<String> educationLevels = [
    "All Education", "High School", "Associate Degree", "Bachelor's Degree",
    "Master's Degree", "PhD", "Bootcamp", "Self-taught"
  ];

  List<String> employmentTypes = [
    "All Types", "Full-time", "Part-time", "Contract", "Freelance", 
    "Internship", "Temporary"
  ];

  List<String> availableSkills = [
    "React", "Vue.js", "Angular", "Node.js", "Python", "Java", "C++", "C#",
    "TypeScript", "JavaScript", "AWS", "Azure", "GCP", "Docker", "Kubernetes",
    "GraphQL", "REST API", "MongoDB", "PostgreSQL", "MySQL", "Redis",
    "Machine Learning", "DevOps", "CI/CD", "Git", "Agile", "Scrum"
  ];

  List<String> industries = [
    "Technology", "Healthcare", "Finance", "E-commerce", "Education",
    "Gaming", "SaaS", "Fintech", "Biotech", "Automotive", "Real Estate",
    "Media", "Non-profit", "Government", "Consulting"
  ];

  List<String> availabilityOptions = [
    "All", "Immediately", "Within 2 weeks", "Within 1 month", 
    "Within 3 months", "Not actively looking"
  ];

  List<String> noticePeriods = [
    "All", "Immediate", "1 week", "2 weeks", "1 month", "2 months", "3+ months"
  ];

  List<String> languages = [
    "English", "Spanish", "Mandarin", "French", "German", "Japanese",
    "Korean", "Portuguese", "Russian", "Arabic", "Hindi"
  ];

  List<String> certifications = [
    "AWS Certified", "Google Cloud Certified", "Microsoft Certified",
    "Kubernetes Certified", "Scrum Master", "PMP", "CISSP", "CompTIA"
  ];

  List<String> workArrangements = [
    "All", "On-site", "Remote", "Hybrid", "Flexible"
  ];

  List<String> completenessOptions = [
    "All", "90-100%", "80-89%", "70-79%", "Below 70%"
  ];

  List<String> activeOptions = [
    "All", "24 hours", "3 days", "1 week", "2 weeks", "1 month"
  ];

  List<String> responseRateOptions = [
    "All", "90-100%", "75-89%", "50-74%", "Below 50%"
  ];

  @override
  void initState() {
    super.initState();
    _calculateMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Filters"),
        actions: [
          TextButton(
            onPressed: () => _resetAllFilters(),
            child: Text(
              "Reset",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Results counter
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              border: Border(bottom: BorderSide(color: primaryColor.withAlpha(50))),
            ),
            child: Row(
              children: [
                Icon(Icons.people, color: primaryColor),
                SizedBox(width: spSm),
                if (isLoading)
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: spSm),
                      Text("Calculating matches..."),
                    ],
                  )
                else
                  Text(
                    "$totalMatches candidates match your criteria",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                Spacer(),
                QButton(
                  label: "Apply",
                  size: bs.sm,
                  onPressed: () => _applyFilters(),
                ),
              ],
            ),
          ),
          
          // Filter sections
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicFiltersSection(),
                  SizedBox(height: spMd),
                  _buildAdvancedFiltersSection(),
                  SizedBox(height: spMd),
                  _buildPreferenceFiltersSection(),
                  SizedBox(height: spMd),
                  _buildBehaviorFiltersSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicFiltersSection() {
    return _buildFilterSection(
      "Basic Filters",
      Icons.filter_list,
      [
        // Location and Experience
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Location",
                items: locations.map((loc) => {"label": loc, "value": loc}).toList(),
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                  _calculateMatches();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Experience Level",
                items: experienceLevels.map((exp) => {"label": exp, "value": exp}).toList(),
                value: selectedExperience,
                onChanged: (value, label) {
                  selectedExperience = value;
                  setState(() {});
                  _calculateMatches();
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        // Education and Employment Type
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Education Level",
                items: educationLevels.map((edu) => {"label": edu, "value": edu}).toList(),
                value: selectedEducation,
                onChanged: (value, label) {
                  selectedEducation = value;
                  setState(() {});
                  _calculateMatches();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Employment Type",
                items: employmentTypes.map((type) => {"label": type, "value": type}).toList(),
                value: selectedEmploymentType,
                onChanged: (value, label) {
                  selectedEmploymentType = value;
                  setState(() {});
                  _calculateMatches();
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        // Skills
        _buildMultiSelectFilter(
          "Required Skills",
          availableSkills,
          selectedSkills,
          (skills) {
            selectedSkills = skills;
            setState(() {});
            _calculateMatches();
          },
        ),
        
        SizedBox(height: spSm),
        
        // Industries
        _buildMultiSelectFilter(
          "Industry Experience",
          industries,
          selectedIndustries,
          (industries) {
            selectedIndustries = industries;
            setState(() {});
            _calculateMatches();
          },
        ),
      ],
    );
  }

  Widget _buildAdvancedFiltersSection() {
    return _buildFilterSection(
      "Advanced Filters",
      Icons.tune,
      [
        // Salary Range
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Salary Range: \$${(salaryRange["min"] as int).currency} - \$${(salaryRange["max"] as int).currency}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Min Salary",
                    value: (salaryRange["min"] as int).toString(),
                    onChanged: (value) {
                      salaryRange["min"] = int.tryParse(value) ?? 0;
                      setState(() {});
                      _calculateMatches();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QNumberField(
                    label: "Max Salary",
                    value: (salaryRange["max"] as int).toString(),
                    onChanged: (value) {
                      salaryRange["max"] = int.tryParse(value) ?? 200000;
                      setState(() {});
                      _calculateMatches();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        // Availability and Notice Period
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Availability",
                items: availabilityOptions.map((av) => {"label": av, "value": av}).toList(),
                value: selectedAvailability,
                onChanged: (value, label) {
                  selectedAvailability = value;
                  setState(() {});
                  _calculateMatches();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Notice Period",
                items: noticePeriods.map((np) => {"label": np, "value": np}).toList(),
                value: selectedNoticeperiod,
                onChanged: (value, label) {
                  selectedNoticeperiod = value;
                  setState(() {});
                  _calculateMatches();
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        // Languages
        _buildMultiSelectFilter(
          "Languages",
          languages,
          selectedLanguages,
          (langs) {
            selectedLanguages = langs;
            setState(() {});
            _calculateMatches();
          },
        ),
        
        SizedBox(height: spSm),
        
        // Certifications
        _buildMultiSelectFilter(
          "Certifications",
          certifications,
          selectedCertifications,
          (certs) {
            selectedCertifications = certs;
            setState(() {});
            _calculateMatches();
          },
        ),
      ],
    );
  }

  Widget _buildPreferenceFiltersSection() {
    return _buildFilterSection(
      "Work Preferences",
      Icons.work,
      [
        // Work arrangement
        QDropdownField(
          label: "Work Arrangement",
          items: workArrangements.map((wa) => {"label": wa, "value": wa}).toList(),
          value: selectedWorkArrangement,
          onChanged: (value, label) {
            selectedWorkArrangement = value;
            setState(() {});
            _calculateMatches();
          },
        ),
        
        SizedBox(height: spSm),
        
        // Boolean preferences
        _buildSwitchFilter("Open to Remote Work", remoteWork, (value) {
          remoteWork = value;
          setState(() {});
          _calculateMatches();
        }),
        
        _buildSwitchFilter("Willing to Relocate", willingToRelocate, (value) {
          willingToRelocate = value;
          setState(() {});
          _calculateMatches();
        }),
        
        _buildSwitchFilter("Requires Visa Sponsorship", sponsorshipRequired, (value) {
          sponsorshipRequired = value;
          setState(() {});
          _calculateMatches();
        }),
        
        _buildSwitchFilter("Actively Looking for Jobs", activelyLooking, (value) {
          activelyLooking = value;
          setState(() {});
          _calculateMatches();
        }),
      ],
    );
  }

  Widget _buildBehaviorFiltersSection() {
    return _buildFilterSection(
      "Profile & Activity",
      Icons.person,
      [
        // Profile completeness and activity
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Profile Completeness",
                items: completenessOptions.map((pc) => {"label": pc, "value": pc}).toList(),
                value: profileCompleteness,
                onChanged: (value, label) {
                  profileCompleteness = value;
                  setState(() {});
                  _calculateMatches();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Last Active Within",
                items: activeOptions.map((ao) => {"label": ao, "value": ao}).toList(),
                value: lastActiveWithin,
                onChanged: (value, label) {
                  lastActiveWithin = value;
                  setState(() {});
                  _calculateMatches();
                },
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        QDropdownField(
          label: "Response Rate",
          items: responseRateOptions.map((rr) => {"label": rr, "value": rr}).toList(),
          value: responseRate,
          onChanged: (value, label) {
            responseRate = value;
            setState(() {});
            _calculateMatches();
          },
        ),
        
        SizedBox(height: spSm),
        
        // Portfolio and references
        _buildSwitchFilter("Has Portfolio/Projects", hasPortfolio, (value) {
          hasPortfolio = value;
          setState(() {});
          _calculateMatches();
        }),
        
        _buildSwitchFilter("Has References", hasReferences, (value) {
          hasReferences = value;
          setState(() {});
          _calculateMatches();
        }),
      ],
    );
  }

  Widget _buildFilterSection(String title, IconData icon, List<Widget> children) {
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
              Icon(icon, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...children,
        ],
      ),
    );
  }

  Widget _buildMultiSelectFilter(
    String title,
    List<String> options,
    List<String> selectedValues,
    Function(List<String>) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$title (${selectedValues.length} selected):",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            if (selectedValues.isNotEmpty)
              GestureDetector(
                onTap: () {
                  onChanged([]);
                },
                child: Text(
                  "Clear",
                  style: TextStyle(fontSize: 12, color: dangerColor),
                ),
              ),
          ],
        ),
        SizedBox(height: spSm),
        Wrap(
          spacing: spXs,
          runSpacing: spXs,
          children: options.map((option) {
            bool isSelected = selectedValues.contains(option);
            return GestureDetector(
              onTap: () {
                List<String> newSelected = List.from(selectedValues);
                if (isSelected) {
                  newSelected.remove(option);
                } else {
                  newSelected.add(option);
                }
                onChanged(newSelected);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.white : disabledBoldColor,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSwitchFilter(String title, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Expanded(
            child: QSwitch(
              items: [
                {
                  "label": title,
                  "value": true,
                  "checked": value,
                }
              ],
              value: value ? [{"label": title, "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                onChanged(values.isNotEmpty);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _calculateMatches() {
    isLoading = true;
    setState(() {});
    
    // Simulate calculation delay
    Future.delayed(Duration(milliseconds: 500), () {
      // Mock calculation based on filters
      int baseMatches = 1250;
      int reductionFactor = 0;
      
      if (selectedLocation.isNotEmpty && selectedLocation != "All Locations") reductionFactor += 200;
      if (selectedExperience.isNotEmpty && selectedExperience != "All Experience") reductionFactor += 150;
      if (selectedEducation.isNotEmpty && selectedEducation != "All Education") reductionFactor += 100;
      if (selectedEmploymentType.isNotEmpty && selectedEmploymentType != "All Types") reductionFactor += 80;
      
      reductionFactor += selectedSkills.length * 50;
      reductionFactor += selectedIndustries.length * 30;
      reductionFactor += selectedLanguages.length * 20;
      reductionFactor += selectedCertifications.length * 40;
      
      if (remoteWork) reductionFactor += 100;
      if (willingToRelocate) reductionFactor -= 50; // Actually increases matches
      if (sponsorshipRequired) reductionFactor += 300;
      if (activelyLooking) reductionFactor -= 100; // Increases matches
      if (hasPortfolio) reductionFactor += 200;
      if (hasReferences) reductionFactor += 150;
      
      totalMatches = (baseMatches - reductionFactor).clamp(0, baseMatches);
      isLoading = false;
      setState(() {});
    });
  }

  void _resetAllFilters() {
    selectedLocation = "";
    selectedExperience = "";
    selectedEducation = "";
    selectedEmploymentType = "";
    selectedSkills.clear();
    selectedIndustries.clear();
    salaryRange = {"min": 0, "max": 200000};
    selectedAvailability = "";
    selectedNoticeperiod = "";
    selectedLanguages.clear();
    selectedCertifications.clear();
    remoteWork = false;
    willingToRelocate = false;
    sponsorshipRequired = false;
    activelyLooking = false;
    selectedWorkArrangement = "";
    profileCompleteness = "";
    lastActiveWithin = "";
    responseRate = "";
    hasPortfolio = false;
    hasReferences = false;
    
    setState(() {});
    _calculateMatches();
    ss("All filters reset");
  }

  void _applyFilters() {
    // Collect all active filters
    Map<String, dynamic> appliedFilters = {
      "location": selectedLocation,
      "experience": selectedExperience,
      "education": selectedEducation,
      "employmentType": selectedEmploymentType,
      "skills": selectedSkills,
      "industries": selectedIndustries,
      "salaryRange": salaryRange,
      "availability": selectedAvailability,
      "noticePeriod": selectedNoticeperiod,
      "languages": selectedLanguages,
      "certifications": selectedCertifications,
      "remoteWork": remoteWork,
      "willingToRelocate": willingToRelocate,
      "sponsorshipRequired": sponsorshipRequired,
      "activelyLooking": activelyLooking,
      "workArrangement": selectedWorkArrangement,
      "profileCompleteness": profileCompleteness,
      "lastActiveWithin": lastActiveWithin,
      "responseRate": responseRate,
      "hasPortfolio": hasPortfolio,
      "hasReferences": hasReferences,
    };
    
    // Count active filters
    int activeFilterCount = 0;
    appliedFilters.forEach((key, value) {
      if (value is String && value.isNotEmpty) activeFilterCount++;
      else if (value is List && value.isNotEmpty) activeFilterCount++;
      else if (value is bool && value) activeFilterCount++;
      else if (value is Map && key == "salaryRange") {
        if ((value["min"] as int) > 0 || (value["max"] as int) < 200000) activeFilterCount++;
      }
    });
    
    Navigator.pop(context, {
      "filters": appliedFilters,
      "totalMatches": totalMatches,
      "activeFilterCount": activeFilterCount,
    });
    
    ss("$activeFilterCount filters applied - $totalMatches candidates found");
  }
}
