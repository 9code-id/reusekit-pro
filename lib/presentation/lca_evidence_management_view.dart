import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaEvidenceManagementView extends StatefulWidget {
  const LcaEvidenceManagementView({super.key});

  @override
  State<LcaEvidenceManagementView> createState() => _LcaEvidenceManagementViewState();
}

class _LcaEvidenceManagementViewState extends State<LcaEvidenceManagementView> {
  String searchQuery = "";
  String selectedType = "All";
  String selectedStatus = "All";
  String selectedCase = "All";
  bool showChainOfCustody = false;

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Physical", "value": "physical"},
    {"label": "Digital", "value": "digital"},
    {"label": "Documentary", "value": "documentary"},
    {"label": "Testimonial", "value": "testimonial"},
    {"label": "Photographic", "value": "photographic"},
    {"label": "Audio/Video", "value": "audio_video"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Collected", "value": "collected"},
    {"label": "Analyzed", "value": "analyzed"},
    {"label": "Authenticated", "value": "authenticated"},
    {"label": "Admitted", "value": "admitted"},
    {"label": "Challenged", "value": "challenged"},
    {"label": "Excluded", "value": "excluded"},
  ];

  List<Map<String, dynamic>> caseOptions = [
    {"label": "All", "value": "All"},
    {"label": "Johnson vs. Acme", "value": "CV-2024-001"},
    {"label": "State vs. Williams", "value": "CR-2024-002"},
    {"label": "Martinez Custody", "value": "FL-2024-003"},
    {"label": "Property Dispute", "value": "RE-2024-004"},
  ];

  List<Map<String, dynamic>> evidenceItems = [
    {
      "id": 1,
      "evidenceNumber": "EV-2024-001-A",
      "title": "Surveillance Video - Workplace Accident",
      "type": "audio_video",
      "status": "authenticated",
      "caseNumber": "CV-2024-001",
      "caseName": "Johnson vs. Acme Corporation",
      "description": "Security camera footage showing the slip and fall incident at client's workplace",
      "dateCollected": "2024-01-12",
      "collectedBy": "Private Investigator John Smith",
      "location": "Acme Corporation, Building A, Entrance",
      "fileSize": "2.4 GB",
      "format": "MP4",
      "duration": "00:45:30",
      "custodyChain": [
        {"person": "John Smith", "date": "2024-01-12", "action": "Collected", "notes": "Original footage obtained from security office"},
        {"person": "Sarah Mitchell", "date": "2024-01-13", "action": "Received", "notes": "Transferred to attorney for review"},
        {"person": "Tech Lab Inc.", "date": "2024-01-14", "action": "Analyzed", "notes": "Enhanced video quality and timestamps verified"},
        {"person": "Court Clerk", "date": "2024-01-15", "action": "Filed", "notes": "Submitted as Exhibit A"},
      ],
      "relevance": "Primary evidence of negligent maintenance causing accident",
      "admissibility": "Likely admissible - authentic security footage",
      "confidential": false,
      "tags": ["surveillance", "workplace accident", "video evidence"],
      "attachments": ["enhanced_video.mp4", "timestamp_analysis.pdf", "chain_of_custody.pdf"],
    },
    {
      "id": 2,
      "evidenceNumber": "EV-2024-002-B",
      "title": "Medical Records - Injury Documentation",
      "type": "documentary",
      "status": "collected",
      "caseNumber": "CV-2024-001",
      "caseName": "Johnson vs. Acme Corporation",
      "description": "Complete medical records documenting extent of back injury and treatment",
      "dateCollected": "2024-01-10",
      "collectedBy": "Paralegal Lisa Martinez",
      "location": "St. Mary's Hospital Medical Records",
      "fileSize": "45.8 MB",
      "format": "PDF",
      "duration": null,
      "custodyChain": [
        {"person": "Lisa Martinez", "date": "2024-01-10", "action": "Collected", "notes": "HIPAA authorization obtained, records copied"},
        {"person": "Michael Rodriguez", "date": "2024-01-11", "action": "Reviewed", "notes": "Medical timeline established"},
      ],
      "relevance": "Establishes causation and damages from workplace accident",
      "admissibility": "Admissible as business records exception",
      "confidential": true,
      "tags": ["medical records", "injury documentation", "HIPAA"],
      "attachments": ["medical_records.pdf", "hipaa_authorization.pdf", "medical_timeline.docx"],
    },
    {
      "id": 3,
      "evidenceNumber": "EV-2024-003-C",
      "title": "Breathalyzer Test Results",
      "type": "physical",
      "status": "challenged",
      "caseNumber": "CR-2024-002",
      "caseName": "State vs. Williams",
      "description": "Blood alcohol test results from roadside DUI stop",
      "dateCollected": "2024-01-08",
      "collectedBy": "Officer James Wilson",
      "location": "Highway 101, Mile Marker 45",
      "fileSize": "2.1 MB",
      "format": "Digital Report",
      "duration": null,
      "custodyChain": [
        {"person": "Officer James Wilson", "date": "2024-01-08", "action": "Administered", "notes": "Breathalyzer test conducted at scene"},
        {"person": "Evidence Technician", "date": "2024-01-08", "action": "Logged", "notes": "Results logged into evidence system"},
        {"person": "Defense Attorney", "date": "2024-01-09", "action": "Challenged", "notes": "Motion filed questioning calibration"},
      ],
      "relevance": "Core evidence for DUI prosecution",
      "admissibility": "Under challenge - calibration records requested",
      "confidential": false,
      "tags": ["DUI", "breathalyzer", "criminal evidence"],
      "attachments": ["breathalyzer_results.pdf", "calibration_records.pdf", "challenge_motion.pdf"],
    },
    {
      "id": 4,
      "evidenceNumber": "EV-2024-004-D",
      "title": "Child Custody Evaluation Report",
      "type": "testimonial",
      "status": "admitted",
      "caseNumber": "FL-2024-003",
      "caseName": "Martinez Family Custody",
      "description": "Court-ordered psychological evaluation of family members for custody determination",
      "dateCollected": "2024-01-05",
      "collectedBy": "Dr. Patricia Chen, Licensed Psychologist",
      "location": "Family Court Services Office",
      "fileSize": "12.3 MB",
      "format": "PDF Report",
      "duration": null,
      "custodyChain": [
        {"person": "Dr. Patricia Chen", "date": "2024-01-05", "action": "Completed", "notes": "Comprehensive family evaluation conducted"},
        {"person": "Court Clerk", "date": "2024-01-06", "action": "Filed", "notes": "Report submitted to family court"},
        {"person": "Judge Martinez", "date": "2024-01-13", "action": "Admitted", "notes": "Report admitted as court exhibit"},
      ],
      "relevance": "Professional assessment of best interests of child",
      "admissibility": "Admitted - court-ordered evaluation",
      "confidential": true,
      "tags": ["family law", "custody evaluation", "psychological assessment"],
      "attachments": ["custody_evaluation.pdf", "court_order.pdf", "admission_ruling.pdf"],
    },
    {
      "id": 5,
      "evidenceNumber": "EV-2024-005-E",
      "title": "Property Survey Documentation",
      "type": "documentary",
      "status": "analyzed",
      "caseNumber": "RE-2024-004",
      "caseName": "Commercial Property Dispute",
      "description": "Professional land survey showing disputed boundary lines",
      "dateCollected": "2024-01-07",
      "collectedBy": "Thompson Surveying Services",
      "location": "1234 Commerce Street, Downtown",
      "fileSize": "8.7 MB",
      "format": "CAD/PDF",
      "duration": null,
      "custodyChain": [
        {"person": "Thompson Surveying", "date": "2024-01-07", "action": "Completed", "notes": "Professional boundary survey conducted"},
        {"person": "Jennifer Adams", "date": "2024-01-08", "action": "Received", "notes": "Survey results reviewed by attorney"},
        {"person": "Expert Witness", "date": "2024-01-10", "action": "Analyzed", "notes": "Independent verification of survey accuracy"},
      ],
      "relevance": "Establishes true property boundaries in dispute",
      "admissibility": "Admissible - professional survey with expert testimony",
      "confidential": false,
      "tags": ["real estate", "property survey", "boundary dispute"],
      "attachments": ["property_survey.pdf", "survey_notes.pdf", "expert_analysis.pdf"],
    },
    {
      "id": 6,
      "evidenceNumber": "EV-2024-006-F",
      "title": "Digital Communication Records",
      "type": "digital",
      "status": "authenticated",
      "caseNumber": "CR-2024-002",
      "caseName": "State vs. Williams",
      "description": "Text messages and call logs from defendant's mobile device",
      "dateCollected": "2024-01-09",
      "collectedBy": "Digital Forensics Unit",
      "location": "Police Evidence Lab",
      "fileSize": "156.4 MB",
      "format": "Forensic Image",
      "duration": null,
      "custodyChain": [
        {"person": "Detective Sarah Kim", "date": "2024-01-09", "action": "Seized", "notes": "Mobile device seized with search warrant"},
        {"person": "Digital Forensics", "date": "2024-01-09", "action": "Imaged", "notes": "Complete forensic image created"},
        {"person": "Cyber Expert", "date": "2024-01-11", "action": "Authenticated", "notes": "Hash values verified, timeline established"},
      ],
      "relevance": "Shows defendant's communications before and after incident",
      "admissibility": "Authenticated - proper forensic procedures followed",
      "confidential": false,
      "tags": ["digital forensics", "mobile device", "communications"],
      "attachments": ["forensic_image.dd", "extraction_report.pdf", "authentication_cert.pdf"],
    },
  ];

  List<Map<String, dynamic>> get filteredEvidence {
    return evidenceItems.where((item) {
      bool matchesSearch = item["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["evidenceNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          item["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesType = selectedType == "All" || item["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || item["status"] == selectedStatus;
      bool matchesCase = selectedCase == "All" || item["caseNumber"] == selectedCase;
      
      return matchesSearch && matchesType && matchesStatus && matchesCase;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "collected":
        return infoColor;
      case "analyzed":
        return warningColor;
      case "authenticated":
        return primaryColor;
      case "admitted":
        return successColor;
      case "challenged":
        return dangerColor;
      case "excluded":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "physical":
        return primaryColor;
      case "digital":
        return infoColor;
      case "documentary":
        return warningColor;
      case "testimonial":
        return successColor;
      case "photographic":
        return dangerColor;
      case "audio_video":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "audio_video":
        return "Audio/Video";
      case "physical":
        return "Physical";
      case "digital":
        return "Digital";
      case "documentary":
        return "Documentary";
      case "testimonial":
        return "Testimonial";
      case "photographic":
        return "Photographic";
      default:
        return type.toUpperCase();
    }
  }

  Widget _buildEvidenceCard(Map<String, dynamic> evidence) {
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
            color: _getTypeColor("${evidence["type"]}"),
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
                  "${evidence["evidenceNumber"]}",
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
                  color: _getTypeColor("${evidence["type"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getTypeLabel("${evidence["type"]}"),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getTypeColor("${evidence["type"]}"),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor("${evidence["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${evidence["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${evidence["status"]}"),
                  ),
                ),
              ),
              if (evidence["confidential"] == true) ...[
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "CONFIDENTIAL",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${evidence["title"]}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Case: ${evidence["caseNumber"]} - ${evidence["caseName"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: infoColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${evidence["description"]}",
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
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Collected: ${evidence["dateCollected"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "By: ${evidence["collectedBy"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Location: ${evidence["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.storage, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Format: ${evidence["format"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.folder, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Size: ${evidence["fileSize"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (evidence["duration"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.timer, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${evidence["duration"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
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
                  "Relevance:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${evidence["relevance"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Admissibility:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${evidence["admissibility"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          ExpansionTile(
            title: Text(
              "Chain of Custody (${(evidence["custodyChain"] as List).length} entries)",
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
                  children: (evidence["custodyChain"] as List).map<Widget>((entry) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: disabledColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${entry["person"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${entry["date"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${entry["action"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${entry["notes"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
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
          ExpansionTile(
            title: Row(
              children: [
                Text(
                  "Tags & Attachments",
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
                    "${(evidence["attachments"] as List).length} files",
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
                  children: [
                    Text(
                      "Tags:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (evidence["tags"] as List).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$tag",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Attachments:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(evidence["attachments"] as List).map(
                      (attachment) => Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: [
                            Icon(Icons.attach_file, size: 12, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "$attachment",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Evidence",
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
                icon: Icons.history,
                size: bs.sm,
                onPressed: () {
                  showChainOfCustody = !showChainOfCustody;
                  setState(() {});
                },
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Evidence Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add evidence
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            QTextField(
              label: "Search evidence",
              value: searchQuery,
              hint: "Search by title, number, or description",
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
                        Icon(Icons.inventory, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${evidenceItems.length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Items",
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
                        Icon(Icons.check_circle, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${evidenceItems.where((e) => e["status"] == "authenticated" || e["status"] == "admitted").length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Authenticated",
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
                        Icon(Icons.warning, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${evidenceItems.where((e) => e["status"] == "challenged").length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Challenged",
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
                        Icon(Icons.security, color: warningColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${evidenceItems.where((e) => e["confidential"] == true).length}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Confidential",
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

            // Evidence List
            Text(
              "Evidence Items (${filteredEvidence.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            if (filteredEvidence.isEmpty)
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
                    Icon(Icons.inventory_2_outlined, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No evidence found",
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
                children: filteredEvidence.map((evidence) => _buildEvidenceCard(evidence)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
