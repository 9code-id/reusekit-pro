import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCertificateView extends StatefulWidget {
  const ElaCertificateView({super.key});

  @override
  State<ElaCertificateView> createState() => _ElaCertificateViewState();
}

class _ElaCertificateViewState extends State<ElaCertificateView> {
  List<Map<String, dynamic>> certificates = [
    {
      "id": 1,
      "title": "English Literature Proficiency",
      "description": "Awarded for demonstrating advanced understanding of literary analysis and interpretation",
      "issued_date": "2024-12-15",
      "level": "Advanced",
      "category": "Literature",
      "points_earned": 450,
      "points_required": 400,
      "issuer": "Westfield High School",
      "instructor": "Ms. Johnson",
      "skills": ["Literary Analysis", "Critical Thinking", "Essay Writing"],
      "status": "Earned",
      "certificate_url": "https://example.com/cert1.pdf",
      "badge_color": "#4CAF50"
    },
    {
      "id": 2,
      "title": "Creative Writing Excellence",
      "description": "Recognition for outstanding creative writing skills and original storytelling",
      "issued_date": "2024-11-28",
      "level": "Proficient",
      "category": "Creative Writing",
      "points_earned": 380,
      "points_required": 350,
      "issuer": "Westfield High School",
      "instructor": "Ms. Williams",
      "skills": ["Creative Writing", "Character Development", "Dialogue"],
      "status": "Earned",
      "certificate_url": "https://example.com/cert2.pdf",
      "badge_color": "#2196F3"
    },
    {
      "id": 3,
      "title": "Grammar Mastery",
      "description": "Certification for mastering advanced grammar concepts and mechanics",
      "issued_date": "",
      "level": "Intermediate",
      "category": "Grammar",
      "points_earned": 280,
      "points_required": 300,
      "issuer": "Westfield High School",
      "instructor": "Mr. Smith",
      "skills": ["Grammar Rules", "Sentence Structure", "Punctuation"],
      "status": "In Progress",
      "certificate_url": "",
      "badge_color": "#FF9800"
    },
    {
      "id": 4,
      "title": "Reading Comprehension Champion",
      "description": "Excellence in reading comprehension and analytical thinking",
      "issued_date": "2024-10-15",
      "level": "Advanced",
      "category": "Reading",
      "points_earned": 420,
      "points_required": 400,
      "issuer": "Westfield High School",
      "instructor": "Ms. Johnson",
      "skills": ["Reading Comprehension", "Text Analysis", "Inference"],
      "status": "Earned",
      "certificate_url": "https://example.com/cert4.pdf",
      "badge_color": "#9C27B0"
    },
    {
      "id": 5,
      "title": "Vocabulary Virtuoso",
      "description": "Recognition for extensive vocabulary knowledge and usage",
      "issued_date": "",
      "level": "Intermediate",
      "category": "Vocabulary",
      "points_earned": 180,
      "points_required": 250,
      "issuer": "Westfield High School",
      "instructor": "Mr. Smith",
      "skills": ["Academic Vocabulary", "Context Clues", "Etymology"],
      "status": "In Progress",
      "certificate_url": "",
      "badge_color": "#607D8B"
    }
  ];

  String selectedFilter = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> get filteredCertificates {
    List<Map<String, dynamic>> filtered = certificates;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((cert) => cert["category"] == selectedFilter).toList();
    }
    
    if (selectedStatus != "All") {
      filtered = filtered.where((cert) => cert["status"] == selectedStatus).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Earned":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Locked":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Advanced":
        return primaryColor;
      case "Proficient":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Beginner":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewCertificate(Map<String, dynamic> certificate) {
    if (certificate["status"] == "Earned") {
      // navigateTo(CertificateDetailView(certificate: certificate))
      ss("Opening certificate: ${certificate["title"]}");
    } else {
      si("Certificate not yet earned. Keep working to unlock it!");
    }
  }

  void _downloadCertificate(Map<String, dynamic> certificate) {
    if (certificate["status"] == "Earned") {
      ss("Downloading certificate: ${certificate["title"]}");
    } else {
      se("Certificate must be earned before downloading");
    }
  }

  void _shareCertificate(Map<String, dynamic> certificate) {
    if (certificate["status"] == "Earned") {
      ss("Certificate shared successfully!");
    } else {
      se("Can only share earned certificates");
    }
  }

  int get totalEarned => certificates.where((c) => c["status"] == "Earned").length;
  int get totalInProgress => certificates.where((c) => c["status"] == "In Progress").length;
  double get completionRate => (totalEarned / certificates.length) * 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Certificates"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Show certificate info
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Certificate Progress",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "$totalEarned",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Earned",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "$totalInProgress",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "In Progress",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${completionRate.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Complete",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Filter options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Category",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Literature", "value": "Literature"},
                      {"label": "Creative Writing", "value": "Creative Writing"},
                      {"label": "Grammar", "value": "Grammar"},
                      {"label": "Reading", "value": "Reading"},
                      {"label": "Vocabulary", "value": "Vocabulary"},
                    ],
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Earned", "value": "Earned"},
                      {"label": "In Progress", "value": "In Progress"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Quick stats
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achievement Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          "Advanced",
                          certificates.where((c) => c["level"] == "Advanced" && c["status"] == "Earned").length,
                          primaryColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          "Proficient",
                          certificates.where((c) => c["level"] == "Proficient" && c["status"] == "Earned").length,
                          successColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          "Intermediate",
                          certificates.where((c) => c["level"] == "Intermediate" && c["status"] == "Earned").length,
                          warningColor,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          "Total Points",
                          certificates.where((c) => c["status"] == "Earned").fold(0, (sum, c) => sum + (c["points_earned"] as int)),
                          infoColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Certificates list
            Text(
              "Certificates (${filteredCertificates.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...filteredCertificates.map((certificate) {
              final progress = (certificate["points_earned"] as int) / (certificate["points_required"] as int);
              final isEarned = certificate["status"] == "Earned";
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: Color(int.parse(certificate["badge_color"].substring(1), radix: 16) + 0xFF000000),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(int.parse(certificate["badge_color"].substring(1), radix: 16) + 0xFF000000).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isEarned ? Icons.emoji_events : Icons.lock,
                            color: Color(int.parse(certificate["badge_color"].substring(1), radix: 16) + 0xFF000000),
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${certificate["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${certificate["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(certificate["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${certificate["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(certificate["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Progress bar (for in-progress certificates)
                    if (!isEarned) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Progress: ${certificate["points_earned"]}/${certificate["points_required"]} points",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(progress * 100).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(int.parse(certificate["badge_color"].substring(1), radix: 16) + 0xFF000000),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                    ],
                    
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getLevelColor(certificate["level"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${certificate["level"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _getLevelColor(certificate["level"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${certificate["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        if (isEarned)
                          Text(
                            "Earned: ${DateTime.parse(certificate["issued_date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Skills
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (certificate["skills"] as List<String>).map((skill) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: isEarned ? "View Certificate" : "View Progress",
                            size: bs.sm,
                            onPressed: () => _viewCertificate(certificate),
                          ),
                        ),
                        if (isEarned) ...[
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () => _downloadCertificate(certificate),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.share,
                            size: bs.sm,
                            onPressed: () => _shareCertificate(certificate),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            if (filteredCertificates.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: disabledColor,
                      size: 60,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No certificates found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Complete assignments and achieve learning goals to earn certificates",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
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

  Widget _buildStatItem(String label, dynamic value, Color color) {
    return Column(
      children: [
        Text(
          "$value",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
