import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCandidateScoringView extends StatefulWidget {
  const RhaCandidateScoringView({super.key});

  @override
  State<RhaCandidateScoringView> createState() => _RhaCandidateScoringViewState();
}

class _RhaCandidateScoringViewState extends State<RhaCandidateScoringView> {
  String selectedCandidate = "";
  String selectedPosition = "";
  String selectedCriteria = "";
  int selectedTabIndex = 0;

  List<Map<String, dynamic>> candidates = [
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Chen", "value": "michael_chen"},
    {"label": "Emily Rodriguez", "value": "emily_rodriguez"},
    {"label": "David Kim", "value": "david_kim"},
  ];

  List<Map<String, dynamic>> positions = [
    {"label": "Senior Software Engineer", "value": "senior_swe"},
    {"label": "Product Manager", "value": "pm"},
    {"label": "UX Designer", "value": "ux_designer"},
    {"label": "Data Scientist", "value": "data_scientist"},
  ];

  List<Map<String, dynamic>> scoringCriteria = [
    {
      "id": "technical_skills",
      "name": "Technical Skills",
      "weight": 30,
      "maxScore": 100,
      "description": "Programming languages, frameworks, and technical expertise",
      "subCriteria": [
        {"name": "Programming Languages", "score": 85, "maxScore": 100},
        {"name": "Frameworks & Tools", "score": 90, "maxScore": 100},
        {"name": "System Design", "score": 75, "maxScore": 100},
        {"name": "Code Quality", "score": 88, "maxScore": 100},
      ],
    },
    {
      "id": "experience",
      "name": "Experience & Background",
      "weight": 25,
      "maxScore": 100,
      "description": "Relevant work experience and industry knowledge",
      "subCriteria": [
        {"name": "Years of Experience", "score": 92, "maxScore": 100},
        {"name": "Industry Knowledge", "score": 78, "maxScore": 100},
        {"name": "Leadership Experience", "score": 65, "maxScore": 100},
        {"name": "Project Complexity", "score": 85, "maxScore": 100},
      ],
    },
    {
      "id": "soft_skills",
      "name": "Soft Skills",
      "weight": 20,
      "maxScore": 100,
      "description": "Communication, teamwork, and interpersonal skills",
      "subCriteria": [
        {"name": "Communication", "score": 88, "maxScore": 100},
        {"name": "Teamwork", "score": 92, "maxScore": 100},
        {"name": "Problem Solving", "score": 85, "maxScore": 100},
        {"name": "Adaptability", "score": 80, "maxScore": 100},
      ],
    },
    {
      "id": "cultural_fit",
      "name": "Cultural Fit",
      "weight": 15,
      "maxScore": 100,
      "description": "Alignment with company values and culture",
      "subCriteria": [
        {"name": "Values Alignment", "score": 90, "maxScore": 100},
        {"name": "Work Style", "score": 85, "maxScore": 100},
        {"name": "Growth Mindset", "score": 88, "maxScore": 100},
        {"name": "Team Dynamics", "score": 87, "maxScore": 100},
      ],
    },
    {
      "id": "motivation",
      "name": "Motivation & Interest",
      "weight": 10,
      "maxScore": 100,
      "description": "Enthusiasm for the role and company",
      "subCriteria": [
        {"name": "Role Interest", "score": 95, "maxScore": 100},
        {"name": "Company Interest", "score": 88, "maxScore": 100},
        {"name": "Career Goals", "score": 85, "maxScore": 100},
        {"name": "Long-term Commitment", "score": 82, "maxScore": 100},
      ],
    },
  ];

  Map<String, dynamic> candidateProfile = {
    "name": "Sarah Johnson",
    "position": "Senior Software Engineer",
    "avatar": "https://picsum.photos/120/120?random=1&person",
    "email": "sarah.johnson@email.com",
    "phone": "+1 (555) 123-4567",
    "location": "San Francisco, CA",
    "experience": "8 years",
    "currentCompany": "Google",
    "education": "MS Computer Science, Stanford",
    "overallScore": 86.4,
    "scoringDate": "2024-12-18",
    "scoredBy": "John Smith",
    "status": "Evaluated",
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Candidate Scoring",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Score Candidate", icon: Icon(Icons.score)),
        Tab(text: "Scoring Matrix", icon: Icon(Icons.table_chart)),
        Tab(text: "Comparisons", icon: Icon(Icons.compare)),
      ],
      tabChildren: [
        _buildScoringTab(),
        _buildMatrixTab(),
        _buildComparisonTab(),
      ],
    );
  }

  Widget _buildScoringTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCandidateSelection(),
          _buildCandidateProfile(),
          _buildScoringCriteria(),
          _buildScoringActions(),
        ],
      ),
    );
  }

  Widget _buildCandidateSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_search, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Select Candidate",
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
                  label: "Candidate",
                  items: candidates,
                  value: selectedCandidate,
                  onChanged: (value, label) {
                    selectedCandidate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Position",
                  items: positions,
                  value: selectedPosition,
                  onChanged: (value, label) {
                    selectedPosition = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateProfile() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Candidate Profile",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getScoreColor(candidateProfile["overallScore"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Overall: ${candidateProfile["overallScore"]}%",
                  style: TextStyle(
                    fontSize: 14,
                    color: _getScoreColor(candidateProfile["overallScore"]),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage("${candidateProfile["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${candidateProfile["name"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${candidateProfile["position"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(Icons.business, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${candidateProfile["currentCompany"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${candidateProfile["experience"]}",
                          style: TextStyle(
                            fontSize: 14,
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
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildProfileDetail("Email", candidateProfile["email"], Icons.email),
              _buildProfileDetail("Phone", candidateProfile["phone"], Icons.phone),
              _buildProfileDetail("Location", candidateProfile["location"], Icons.location_on),
              _buildProfileDetail("Education", candidateProfile["education"], Icons.school),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoringCriteria() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assessment, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Scoring Criteria",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Auto Score",
                size: bs.sm,
                onPressed: () => _autoScore(),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: scoringCriteria.map((criteria) {
              double avgScore = (criteria["subCriteria"] as List).fold(0.0, (sum, sub) => sum + (sub["score"] as int)) / (criteria["subCriteria"] as List).length;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${criteria["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${criteria["description"]}",
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
                              "${avgScore.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _getScoreColor(avgScore),
                              ),
                            ),
                            Text(
                              "Weight: ${criteria["weight"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: avgScore / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getScoreColor(avgScore),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      spacing: spXs,
                      children: (criteria["subCriteria"] as List).map<Widget>((subCriteria) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${subCriteria["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              child: QTextField(
                                label: "",
                                value: "${subCriteria["score"]}",
                                onChanged: (value) {
                                  subCriteria["score"] = int.tryParse(value) ?? 0;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "/ ${subCriteria["maxScore"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildScoringActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.save, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Actions",
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
                child: QButton(
                  label: "Save Score",
                  size: bs.md,
                  onPressed: () => _saveScore(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Reset Scores",
                  size: bs.md,
                  onPressed: () => _resetScores(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  size: bs.md,
                  onPressed: () => _generateReport(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add to Pipeline",
                  size: bs.md,
                  onPressed: () => _addToPipeline(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatrixTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScoringMatrix(),
        ],
      ),
    );
  }

  Widget _buildScoringMatrix() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.table_chart, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Scoring Matrix",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Export Matrix",
                size: bs.sm,
                onPressed: () => _exportMatrix(),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Criteria")),
                DataColumn(label: Text("Weight")),
                DataColumn(label: Text("Score")),
                DataColumn(label: Text("Weighted Score")),
                DataColumn(label: Text("Grade")),
              ],
              rows: scoringCriteria.map((criteria) {
                double avgScore = (criteria["subCriteria"] as List).fold(0.0, (sum, sub) => sum + (sub["score"] as int)) / (criteria["subCriteria"] as List).length;
                double weightedScore = avgScore * (criteria["weight"] as int) / 100;
                
                return DataRow(
                  cells: [
                    DataCell(Text("${criteria["name"]}")),
                    DataCell(Text("${criteria["weight"]}%")),
                    DataCell(Text("${avgScore.toStringAsFixed(1)}%")),
                    DataCell(Text("${weightedScore.toStringAsFixed(1)}")),
                    DataCell(
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getScoreColor(avgScore).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          _getGrade(avgScore),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getScoreColor(avgScore),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCandidateComparison(),
        ],
      ),
    );
  }

  Widget _buildCandidateComparison() {
    List<Map<String, dynamic>> comparisonCandidates = [
      {
        "name": "Sarah Johnson",
        "position": "Senior Software Engineer",
        "overallScore": 86.4,
        "technicalSkills": 84.5,
        "experience": 80.0,
        "softSkills": 86.25,
        "culturalFit": 87.5,
        "motivation": 87.5,
      },
      {
        "name": "Michael Chen",
        "position": "Product Manager",
        "overallScore": 83.2,
        "technicalSkills": 75.0,
        "experience": 85.0,
        "softSkills": 88.75,
        "culturalFit": 85.0,
        "motivation": 82.5,
      },
      {
        "name": "Emily Rodriguez",
        "position": "UX Designer",
        "overallScore": 88.1,
        "technicalSkills": 82.5,
        "experience": 78.75,
        "softSkills": 91.25,
        "culturalFit": 92.5,
        "motivation": 90.0,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.compare, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Candidate Comparison",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Candidate")),
                DataColumn(label: Text("Overall")),
                DataColumn(label: Text("Technical")),
                DataColumn(label: Text("Experience")),
                DataColumn(label: Text("Soft Skills")),
                DataColumn(label: Text("Cultural Fit")),
                DataColumn(label: Text("Motivation")),
              ],
              rows: comparisonCandidates.map((candidate) {
                return DataRow(
                  cells: [
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${candidate["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${candidate["position"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(_buildScoreCell(candidate["overallScore"])),
                    DataCell(_buildScoreCell(candidate["technicalSkills"])),
                    DataCell(_buildScoreCell(candidate["experience"])),
                    DataCell(_buildScoreCell(candidate["softSkills"])),
                    DataCell(_buildScoreCell(candidate["culturalFit"])),
                    DataCell(_buildScoreCell(candidate["motivation"])),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCell(double score) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: _getScoreColor(score).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Text(
        "${score.toStringAsFixed(1)}%",
        style: TextStyle(
          fontSize: 12,
          color: _getScoreColor(score),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 90) return successColor;
    if (score >= 80) return primaryColor;
    if (score >= 70) return warningColor;
    if (score >= 60) return infoColor;
    return dangerColor;
  }

  String _getGrade(double score) {
    if (score >= 90) return "A";
    if (score >= 80) return "B";
    if (score >= 70) return "C";
    if (score >= 60) return "D";
    return "F";
  }

  void _autoScore() {
    ss("Auto-scoring applied based on AI analysis");
  }

  void _saveScore() {
    ss("Candidate score saved successfully");
  }

  void _resetScores() {
    ss("All scores have been reset");
  }

  void _generateReport() {
    si("Generating detailed scoring report");
  }

  void _addToPipeline() {
    ss("Candidate added to hiring pipeline");
  }

  void _exportMatrix() {
    si("Exporting scoring matrix to Excel");
  }
}
