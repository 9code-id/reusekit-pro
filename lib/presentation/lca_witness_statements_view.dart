import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaWitnessStatementsView extends StatefulWidget {
  const LcaWitnessStatementsView({super.key});

  @override
  State<LcaWitnessStatementsView> createState() => _LcaWitnessStatementsViewState();
}

class _LcaWitnessStatementsViewState extends State<LcaWitnessStatementsView> {
  String searchQuery = "";
  String selectedType = "All";
  String selectedStatus = "All";
  String selectedCase = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Eyewitness", "value": "eyewitness"},
    {"label": "Expert", "value": "expert"},
    {"label": "Character", "value": "character"},
    {"label": "Victim", "value": "victim"},
    {"label": "Police Officer", "value": "police"},
    {"label": "Medical", "value": "medical"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Completed", "value": "completed"},
    {"label": "Transcribed", "value": "transcribed"},
    {"label": "Reviewed", "value": "reviewed"},
    {"label": "Approved", "value": "approved"},
    {"label": "Subpoenaed", "value": "subpoenaed"},
  ];

  List<Map<String, dynamic>> caseOptions = [
    {"label": "All", "value": "All"},
    {"label": "Johnson vs. Acme", "value": "CV-2024-001"},
    {"label": "State vs. Williams", "value": "CR-2024-002"},
    {"label": "Martinez Custody", "value": "FL-2024-003"},
    {"label": "Property Dispute", "value": "RE-2024-004"},
  ];

  List<Map<String, dynamic>> witnessStatements = [
    {
      "id": 1,
      "statementNumber": "WS-2024-001",
      "witnessName": "Maria Rodriguez",
      "type": "eyewitness",
      "status": "transcribed",
      "caseNumber": "CV-2024-001",
      "caseName": "Johnson vs. Acme Corporation",
      "dateRecorded": "2024-01-12",
      "duration": "01:35:20",
      "location": "Law Office Conference Room",
      "interviewer": "Sarah Mitchell, Attorney",
      "witnessContact": {
        "phone": "(555) 123-4567",
        "email": "maria.rodriguez@email.com",
        "address": "123 Main St, City, State 12345"
      },
      "credibility": "High",
      "favorability": "Favorable",
      "keyPoints": [
        "Witnessed the slip and fall incident firsthand",
        "Observed wet floor without warning signs",
        "Saw plaintiff fall and immediately assisted",
        "No prior relationship with plaintiff or defendant"
      ],
      "summary": "Eyewitness account of workplace accident clearly establishing negligent maintenance and lack of proper safety warnings",
      "concerns": "None identified - consistent and credible testimony",
      "followUpNeeded": false,
      "confidential": false,
      "availability": "Available for trial, prefers morning sessions",
      "backgroundCheck": "Completed - No issues",
      "expertiseArea": null,
      "compensation": "Standard witness fee",
      "documents": ["witness_statement.pdf", "transcript.docx", "audio_recording.mp3"],
    },
    {
      "id": 2,
      "statementNumber": "WS-2024-002",
      "witnessName": "Dr. Robert Chen",
      "type": "expert",
      "status": "approved",
      "caseNumber": "CV-2024-001",
      "caseName": "Johnson vs. Acme Corporation",
      "dateRecorded": "2024-01-14",
      "duration": "02:15:45",
      "location": "Medical Office",
      "interviewer": "Michael Rodriguez, Attorney",
      "witnessContact": {
        "phone": "(555) 987-6543",
        "email": "dr.chen@orthopedics.com",
        "address": "456 Medical Drive, City, State 12345"
      },
      "credibility": "Very High",
      "favorability": "Favorable",
      "keyPoints": [
        "25 years experience in orthopedic surgery",
        "Reviewed all medical records and imaging",
        "Confirms injury consistent with fall mechanism",
        "Long-term prognosis requires ongoing treatment"
      ],
      "summary": "Expert medical testimony establishing causation and extent of injuries resulting from workplace accident",
      "concerns": "None - well-qualified expert with solid opinions",
      "followUpNeeded": false,
      "confidential": true,
      "availability": "Limited - requires 30-day notice for trial",
      "backgroundCheck": "Completed - Excellent credentials",
      "expertiseArea": "Orthopedic Surgery, Spine Injuries",
      "compensation": "\$500/hour + expenses",
      "documents": ["expert_report.pdf", "cv_resume.pdf", "medical_opinion.docx", "fee_agreement.pdf"],
    },
    {
      "id": 3,
      "statementNumber": "WS-2024-003",
      "witnessName": "Officer James Wilson",
      "type": "police",
      "status": "completed",
      "caseNumber": "CR-2024-002",
      "caseName": "State vs. Williams",
      "dateRecorded": "2024-01-09",
      "duration": "00:45:30",
      "location": "Police Station Interview Room",
      "interviewer": "Lisa Chen, Defense Attorney",
      "witnessContact": {
        "phone": "(555) 555-0123",
        "email": "j.wilson@police.gov",
        "address": "Police Department, City, State 12345"
      },
      "credibility": "High",
      "favorability": "Neutral",
      "keyPoints": [
        "Conducted initial traffic stop for erratic driving",
        "Observed signs of impairment during field sobriety test",
        "Followed proper protocol for DUI arrest",
        "Body camera footage available for review"
      ],
      "summary": "Police officer testimony regarding DUI arrest procedures and observations of defendant's condition",
      "concerns": "Defense may challenge calibration of breathalyzer equipment",
      "followUpNeeded": true,
      "confidential": false,
      "availability": "Available during off-duty hours",
      "backgroundCheck": "N/A - Active police officer",
      "expertiseArea": "DUI Investigation, Field Sobriety Testing",
      "compensation": "Standard police witness fee",
      "documents": ["officer_report.pdf", "body_cam_transcript.pdf", "arrest_report.pdf"],
    },
    {
      "id": 4,
      "statementNumber": "WS-2024-004",
      "witnessName": "Elena Martinez",
      "type": "victim",
      "status": "reviewed",
      "caseNumber": "FL-2024-003",
      "caseName": "Martinez Family Custody",
      "dateRecorded": "2024-01-06",
      "duration": "01:20:15",
      "location": "Family Court Services",
      "interviewer": "David Thompson, Attorney",
      "witnessContact": {
        "phone": "(555) 234-5678",
        "email": "elena.martinez@email.com",
        "address": "789 Oak Street, City, State 12345"
      },
      "credibility": "High",
      "favorability": "Favorable",
      "keyPoints": [
        "Primary caregiver for children for past 5 years",
        "Documented concerns about ex-spouse's behavior",
        "Strong support system and stable employment",
        "Children express preference to remain with mother"
      ],
      "summary": "Mother's testimony in custody case detailing care arrangements and concerns about father's fitness",
      "concerns": "Emotional testimony may need preparation for cross-examination",
      "followUpNeeded": true,
      "confidential": true,
      "availability": "Flexible schedule, prefers afternoon sessions",
      "backgroundCheck": "Completed - No concerns",
      "expertiseArea": null,
      "compensation": "No compensation required",
      "documents": ["custody_statement.pdf", "support_documentation.pdf", "character_references.pdf"],
    },
    {
      "id": 5,
      "statementNumber": "WS-2024-005",
      "witnessName": "Jennifer Adams",
      "type": "character",
      "status": "scheduled",
      "caseNumber": "CR-2024-002",
      "caseName": "State vs. Williams",
      "dateRecorded": null,
      "duration": null,
      "location": "TBD",
      "interviewer": "Lisa Chen, Defense Attorney",
      "witnessContact": {
        "phone": "(555) 345-6789",
        "email": "j.adams@company.com",
        "address": "321 Business Blvd, City, State 12345"
      },
      "credibility": "Unknown",
      "favorability": "Favorable",
      "keyPoints": [
        "Defendant's supervisor for 3 years",
        "Can testify to defendant's reliability and character",
        "No knowledge of any alcohol-related issues",
        "Willing to testify about work performance"
      ],
      "summary": "Character witness to testify about defendant's reputation and work history",
      "concerns": "Limited knowledge of defendant's personal life outside work",
      "followUpNeeded": true,
      "confidential": false,
      "availability": "Needs advance notice due to work schedule",
      "backgroundCheck": "Pending",
      "expertiseArea": null,
      "compensation": "Standard witness fee",
      "documents": ["preliminary_interview.pdf"],
    },
    {
      "id": 6,
      "statementNumber": "WS-2024-006",
      "witnessName": "Dr. Sarah Kim",
      "type": "medical",
      "status": "subpoenaed",
      "caseNumber": "CV-2024-001",
      "caseName": "Johnson vs. Acme Corporation",
      "dateRecorded": "2024-01-11",
      "duration": "01:05:20",
      "location": "Hospital Medical Records Office",
      "interviewer": "Michael Rodriguez, Attorney",
      "witnessContact": {
        "phone": "(555) 456-7890",
        "email": "s.kim@hospital.org",
        "address": "St. Mary's Hospital, City, State 12345"
      },
      "credibility": "Very High",
      "favorability": "Neutral",
      "keyPoints": [
        "Emergency room physician who treated plaintiff",
        "Can testify to initial injury assessment",
        "Documented immediate post-accident condition",
        "Ordered diagnostic tests and treatment plan"
      ],
      "summary": "Medical testimony regarding initial treatment and injury assessment following workplace accident",
      "concerns": "May require subpoena due to hospital policy",
      "followUpNeeded": false,
      "confidential": true,
      "availability": "Very limited - requires court order",
      "backgroundCheck": "N/A - Licensed physician",
      "expertiseArea": "Emergency Medicine",
      "compensation": "Expert witness rate",
      "documents": ["medical_records.pdf", "er_report.pdf", "subpoena.pdf", "treatment_notes.pdf"],
    },
  ];

  List<Map<String, dynamic>> get filteredStatements {
    var filtered = witnessStatements.where((statement) {
      bool matchesSearch = statement["witnessName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          statement["statementNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          statement["summary"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType == "All" || statement["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || statement["status"] == selectedStatus;
      bool matchesCase = selectedCase == "All" || statement["caseNumber"] == selectedCase;
      
      if (currentTab == 1) { // Expert Witnesses
        return matchesSearch && matchesStatus && matchesCase && 
               (statement["type"] == "expert" || statement["type"] == "medical");
      } else if (currentTab == 2) { // Pending
        return matchesSearch && matchesType && matchesCase && 
               (statement["status"] == "scheduled" || statement["followUpNeeded"] == true);
      }
      
      return matchesSearch && matchesType && matchesStatus && matchesCase;
    }).toList();

    filtered.sort((a, b) {
      if (a["dateRecorded"] == null && b["dateRecorded"] == null) return 0;
      if (a["dateRecorded"] == null) return 1;
      if (b["dateRecorded"] == null) return -1;
      return b["dateRecorded"].compareTo(a["dateRecorded"]);
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "scheduled":
        return warningColor;
      case "completed":
        return infoColor;
      case "transcribed":
        return primaryColor;
      case "reviewed":
        return successColor;
      case "approved":
        return successColor;
      case "subpoenaed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "eyewitness":
        return primaryColor;
      case "expert":
        return successColor;
      case "character":
        return infoColor;
      case "victim":
        return warningColor;
      case "police":
        return dangerColor;
      case "medical":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getFavorabilityColor(String favorability) {
    switch (favorability.toLowerCase()) {
      case "favorable":
        return successColor;
      case "neutral":
        return warningColor;
      case "unfavorable":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "eyewitness":
        return "Eyewitness";
      case "expert":
        return "Expert";
      case "character":
        return "Character";
      case "victim":
        return "Victim";
      case "police":
        return "Police";
      case "medical":
        return "Medical";
      default:
        return type.toUpperCase();
    }
  }

  Widget _buildWitnessCard(Map<String, dynamic> witness) {
    bool needsFollowUp = witness["followUpNeeded"] == true;
    bool isScheduled = witness["status"] == "scheduled";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: needsFollowUp || isScheduled
            ? Border.all(color: warningColor, width: 2)
            : Border(
                left: BorderSide(
                  width: 4,
                  color: _getTypeColor("${witness["type"]}"),
                ),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${witness["statementNumber"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getTypeColor("${witness["type"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getTypeLabel("${witness["type"]}"),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getTypeColor("${witness["type"]}"),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor("${witness["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${witness["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${witness["status"]}"),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getFavorabilityColor("${witness["favorability"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${witness["favorability"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getFavorabilityColor("${witness["favorability"]}"),
                  ),
                ),
              ),
            ],
          ),
          if (needsFollowUp || isScheduled) ...[
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    needsFollowUp ? Icons.assignment_late : Icons.schedule,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    needsFollowUp ? "Follow-up needed" : "Interview scheduled",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Text(
            "${witness["witnessName"]}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Case: ${witness["caseNumber"]} - ${witness["caseName"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: infoColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${witness["summary"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Interviewed by: ${witness["interviewer"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              if (witness["credibility"] != null) ...[
                Icon(Icons.verified, size: 16, color: _getFavorabilityColor("${witness["credibility"]}")),
                SizedBox(width: spXs),
                Text(
                  "Credibility: ${witness["credibility"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getFavorabilityColor("${witness["credibility"]}"),
                  ),
                ),
              ],
            ],
          ),
          if (witness["dateRecorded"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Recorded: ${witness["dateRecorded"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                if (witness["duration"] != null) ...[
                  SizedBox(width: spSm),
                  Icon(Icons.timer, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "Duration: ${witness["duration"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ],
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Location: ${witness["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          if (witness["expertiseArea"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.school, size: 16, color: successColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Expertise: ${witness["expertiseArea"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Key Points:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(witness["keyPoints"] as List).map(
                  (point) => Padding(
                    padding: EdgeInsets.only(left: spSm, bottom: 2),
                    child: Text(
                      "• $point",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ),
                if (witness["concerns"] != null && witness["concerns"] != "None identified - consistent and credible testimony") ...[
                  SizedBox(height: spSm),
                  Text(
                    "Concerns:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${witness["concerns"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: dangerColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spSm),
          ExpansionTile(
            title: Text(
              "Contact & Availability",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Information:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Phone: ${witness["witnessContact"]["phone"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Email: ${witness["witnessContact"]["email"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Address: ${witness["witnessContact"]["address"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Availability:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${witness["availability"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Compensation:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${witness["compensation"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ExpansionTile(
            title: Row(
              children: [
                Text(
                  "Documents",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${(witness["documents"] as List).length} files",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (witness["documents"] as List).map<Widget>((doc) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.attach_file, size: 12, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "$doc",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          QButton(
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Statement",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int expertCount = witnessStatements.where((w) => w["type"] == "expert" || w["type"] == "medical").length;
    int pendingCount = witnessStatements.where((w) => w["status"] == "scheduled" || w["followUpNeeded"] == true).length;
    
    return QTabBar(
      title: "Witness Statements",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Witnesses", icon: Icon(Icons.people)),
        Tab(text: "Experts", icon: Icon(Icons.school)),
        Tab(text: "Pending", icon: Icon(Icons.pending_actions)),
      ],
      tabChildren: [
        // All Witnesses Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search and Filters
              QTextField(
                label: "Search witnesses",
                value: searchQuery,
                hint: "Search by name, statement number, or summary",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Type",
                      items: typeOptions,
                      value: selectedType,
                      onChanged: (value, label) {
                        selectedType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Status",
                      items: statusOptions,
                      value: selectedStatus,
                      onChanged: (value, label) {
                        selectedStatus = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),

              QDropdownField(
                label: "Case",
                items: caseOptions,
                value: selectedCase,
                onChanged: (value, label) {
                  selectedCase = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spLg),

              // Quick Stats
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
                          Icon(Icons.people, color: primaryColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "${witnessStatements.length}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Total Witnesses",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
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
                          Icon(Icons.school, color: successColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "$expertCount",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Expert Witnesses",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
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
                          Icon(Icons.pending_actions, color: warningColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "$pendingCount",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
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
                          Icon(Icons.check_circle, color: infoColor, size: 24),
                          SizedBox(height: spXs),
                          Text(
                            "${witnessStatements.where((w) => w["status"] == "approved" || w["status"] == "transcribed").length}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spLg),

              // Witness List
              Text(
                "Witness Statements (${filteredStatements.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              if (filteredStatements.isEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.people_outline, size: 64, color: disabledColor),
                      SizedBox(height: spSm),
                      Text(
                        "No witness statements found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Try adjusting your search or filter criteria",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: filteredStatements.map((witness) => _buildWitnessCard(witness)).toList(),
                ),
            ],
          ),
        ),
        
        // Expert Witnesses Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: filteredStatements.map((witness) => _buildWitnessCard(witness)).toList(),
          ),
        ),
        
        // Pending Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: filteredStatements.map((witness) => _buildWitnessCard(witness)).toList(),
          ),
        ),
      ],
      onInit: (tabController) {
        // Optional tab controller access
      },
    );
  }
}
