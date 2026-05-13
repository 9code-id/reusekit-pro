import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCaseOverviewView extends StatefulWidget {
  const LcaCaseOverviewView({Key? key}) : super(key: key);

  @override
  State<LcaCaseOverviewView> createState() => _LcaCaseOverviewViewState();
}

class _LcaCaseOverviewViewState extends State<LcaCaseOverviewView> {
  String selectedTab = "overview";
  
  Map<String, dynamic> caseData = {
    "id": "CASE-2024-001",
    "title": "Johnson vs. Smith Corporation",
    "type": "Civil Litigation",
    "status": "active",
    "priority": "high",
    "client": {
      "name": "Johnson Family Trust",
      "contact": "Michael Johnson",
      "email": "mjohnson@email.com",
      "phone": "+1 (555) 123-4567",
    },
    "opposingParty": "Smith Corporation",
    "court": "Superior Court of California",
    "judge": "Hon. Sarah Williams",
    "dateCreated": "2024-03-15T10:30:00Z",
    "nextHearing": "2024-06-25T14:00:00Z",
    "estimatedValue": 250000,
    "billableHours": 87.5,
    "totalFees": 26250,
    "progress": 75,
    "description": "Commercial dispute regarding breach of contract and damages. Client seeks compensation for lost revenue due to defendant's failure to deliver goods as specified in the purchase agreement.",
  };

  List<Map<String, dynamic>> keyDates = [
    {
      "title": "Case Filed",
      "date": "2024-03-15T10:30:00Z",
      "type": "milestone",
      "status": "completed",
    },
    {
      "title": "Discovery Deadline",
      "date": "2024-05-20T23:59:00Z",
      "type": "deadline",
      "status": "completed",
    },
    {
      "title": "Motion to Dismiss Hearing",
      "date": "2024-06-25T14:00:00Z",
      "type": "hearing",
      "status": "upcoming",
    },
    {
      "title": "Settlement Conference",
      "date": "2024-07-10T10:00:00Z",
      "type": "meeting",
      "status": "scheduled",
    },
    {
      "title": "Trial Date",
      "date": "2024-09-15T09:00:00Z",
      "type": "trial",
      "status": "scheduled",
    },
  ];

  List<Map<String, dynamic>> recentDocuments = [
    {
      "name": "Motion to Dismiss",
      "type": "motion",
      "date": "2024-06-14T16:30:00Z",
      "size": "2.3 MB",
      "author": "Attorney Smith",
      "status": "filed",
    },
    {
      "name": "Discovery Response",
      "type": "response",
      "date": "2024-06-10T11:20:00Z",
      "size": "1.8 MB",
      "author": "Attorney Smith",
      "status": "submitted",
    },
    {
      "name": "Contract Analysis",
      "type": "analysis",
      "date": "2024-06-08T09:45:00Z",
      "size": "856 KB",
      "author": "Paralegal Jones",
      "status": "draft",
    },
    {
      "name": "Client Interview Notes",
      "type": "notes",
      "date": "2024-06-05T14:15:00Z",
      "size": "425 KB",
      "author": "Attorney Smith",
      "status": "confidential",
    },
  ];

  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "John Smith",
      "role": "Lead Attorney",
      "email": "j.smith@lawfirm.com",
      "phone": "+1 (555) 234-5678",
      "hours": 45.5,
      "avatar": "https://picsum.photos/200/200?random=1",
    },
    {
      "name": "Sarah Johnson",
      "role": "Associate Attorney",
      "email": "s.johnson@lawfirm.com",
      "phone": "+1 (555) 345-6789",
      "hours": 28.0,
      "avatar": "https://picsum.photos/200/200?random=2",
    },
    {
      "name": "Michael Jones",
      "role": "Paralegal",
      "email": "m.jones@lawfirm.com",
      "phone": "+1 (555) 456-7890",
      "hours": 14.0,
      "avatar": "https://picsum.photos/200/200?random=3",
    },
  ];

  List<Map<String, dynamic>> caseNotes = [
    {
      "id": "1",
      "title": "Client Meeting Summary",
      "content": "Met with client to discuss discovery findings. Client satisfied with progress and authorizes continued litigation strategy.",
      "author": "John Smith",
      "date": "2024-06-14T15:30:00Z",
      "isPrivate": false,
    },
    {
      "id": "2",
      "title": "Legal Research Update",
      "content": "Completed research on precedent cases. Found favorable ruling in Martinez v. TechCorp (2023) that supports our position.",
      "author": "Sarah Johnson",
      "date": "2024-06-12T11:20:00Z",
      "isPrivate": false,
    },
    {
      "id": "3",
      "title": "Strategy Discussion",
      "content": "Internal strategy meeting concluded. Recommend proceeding with motion to dismiss while preparing for potential settlement.",
      "author": "John Smith",
      "date": "2024-06-10T16:45:00Z",
      "isPrivate": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${caseData["id"]}"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editCase(),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showCaseMenu(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCaseHeader(),
            SizedBox(height: spLg),
            _buildTabNavigation(),
            SizedBox(height: spLg),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseHeader() {
    Color statusColor = _getStatusColor("${caseData["status"]}");
    Color priorityColor = _getPriorityColor("${caseData["priority"]}");
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${caseData["title"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${caseData["type"]} • ${caseData["court"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${caseData["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${caseData["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Text(
              "${caseData["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildQuickInfo("Progress", "${caseData["progress"]}%", Icons.timeline),
              SizedBox(width: spMd),
              _buildQuickInfo("Value", "\$${((caseData["estimatedValue"] as int).toDouble()).currency}", Icons.attach_money),
              SizedBox(width: spMd),
              _buildQuickInfo("Hours", "${caseData["billableHours"]}h", Icons.timer),
            ],
          ),
          SizedBox(height: spMd),
          LinearProgressIndicator(
            value: (caseData["progress"] as int) / 100,
            backgroundColor: disabledColor.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(priorityColor),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfo(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 16),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNavigation() {
    List<Map<String, dynamic>> tabs = [
      {"id": "overview", "label": "Overview", "icon": Icons.dashboard},
      {"id": "timeline", "label": "Timeline", "icon": Icons.timeline},
      {"id": "documents", "label": "Documents", "icon": Icons.description},
      {"id": "team", "label": "Team", "icon": Icons.people},
      {"id": "notes", "label": "Notes", "icon": Icons.note},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: tabs.map((tab) {
          bool isSelected = selectedTab == tab["id"];
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = tab["id"] as String;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      tab["icon"] as IconData,
                      color: isSelected ? primaryColor : disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${tab["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "overview":
        return _buildOverviewTab();
      case "timeline":
        return _buildTimelineTab();
      case "documents":
        return _buildDocumentsTab();
      case "team":
        return _buildTeamTab();
      case "notes":
        return _buildNotesTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      children: [
        _buildClientInfo(),
        SizedBox(height: spLg),
        _buildCaseDetails(),
        SizedBox(height: spLg),
        _buildNextDeadlines(),
      ],
    );
  }

  Widget _buildClientInfo() {
    Map<String, dynamic> client = caseData["client"] as Map<String, dynamic>;
    
    return Container(
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
            "Client Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoRow(Icons.business, "Client", "${client["name"]}"),
          _buildInfoRow(Icons.person, "Contact", "${client["contact"]}"),
          _buildInfoRow(Icons.email, "Email", "${client["email"]}"),
          _buildInfoRow(Icons.phone, "Phone", "${client["phone"]}"),
          _buildInfoRow(Icons.gavel, "Opposing Party", "${caseData["opposingParty"]}"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(width: spSm),
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseDetails() {
    return Container(
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
            "Case Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoRow(Icons.calendar_today, "Date Created", DateTime.parse("${caseData["dateCreated"]}").dMMMy),
          _buildInfoRow(Icons.account_balance, "Court", "${caseData["court"]}"),
          _buildInfoRow(Icons.person, "Judge", "${caseData["judge"]}"),
          _buildInfoRow(Icons.schedule, "Next Hearing", DateTime.parse("${caseData["nextHearing"]}").dMMMy),
          _buildInfoRow(Icons.attach_money, "Estimated Value", "\$${((caseData["estimatedValue"] as int).toDouble()).currency}"),
          _buildInfoRow(Icons.receipt, "Total Fees", "\$${((caseData["totalFees"] as int).toDouble()).currency}"),
        ],
      ),
    );
  }

  Widget _buildNextDeadlines() {
    List<Map<String, dynamic>> upcomingDeadlines = keyDates.where((date) => 
      date["status"] == "upcoming" || date["status"] == "scheduled"
    ).toList();
    
    return Container(
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
            "Upcoming Deadlines",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...upcomingDeadlines.map((deadline) {
            DateTime date = DateTime.parse("${deadline["date"]}");
            Color typeColor = _getTypeColor("${deadline["type"]}");
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: typeColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: typeColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: typeColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(_getTypeIcon("${deadline["type"]}"), color: typeColor, size: 16),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${deadline["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${deadline["type"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    date.dMMMy,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: typeColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineTab() {
    return Container(
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
            "Case Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...keyDates.map((date) {
            DateTime eventDate = DateTime.parse("${date["date"]}");
            Color typeColor = _getTypeColor("${date["type"]}");
            Color statusColor = _getEventStatusColor("${date["status"]}");
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(_getTypeIcon("${date["type"]}"), color: statusColor, size: 20),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: typeColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${date["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${date["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${date["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            eventDate.dMMMy,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: typeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Case Documents",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _addDocument(),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...recentDocuments.map((doc) {
            DateTime docDate = DateTime.parse("${doc["date"]}");
            Color statusColor = _getDocumentStatusColor("${doc["status"]}");
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(Icons.description, color: statusColor, size: 20),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${doc["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${doc["author"]} • ${doc["size"]} • ${docDate.dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${doc["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => _viewDocument("${doc["name"]}"),
                    child: Icon(Icons.arrow_forward, size: 16, color: primaryColor),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTeamTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Case Team",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () => _addTeamMember(),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...teamMembers.map((member) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage("${member["avatar"]}"),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${member["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${member["role"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${member["email"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${member["hours"]}h",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Logged",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Case Notes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _addNote(),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...caseNotes.map((note) {
            DateTime noteDate = DateTime.parse("${note["date"]}");
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusMd),
                border: note["isPrivate"] as bool
                    ? Border.all(color: dangerColor.withAlpha(100))
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${note["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      if (note["isPrivate"] as bool)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.lock, size: 10, color: dangerColor),
                              SizedBox(width: spXs),
                              Text(
                                "PRIVATE",
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${note["content"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.person, size: 12, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${note["author"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        noteDate.dMMMy,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "review":
        return infoColor;
      case "closed":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case "deadline":
        return dangerColor;
      case "hearing":
        return warningColor;
      case "meeting":
        return infoColor;
      case "trial":
        return primaryColor;
      case "milestone":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case "deadline":
        return Icons.schedule;
      case "hearing":
        return Icons.gavel;
      case "meeting":
        return Icons.meeting_room;
      case "trial":
        return Icons.account_balance;
      case "milestone":
        return Icons.flag;
      default:
        return Icons.event;
    }
  }

  Color _getEventStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return successColor;
      case "upcoming":
        return warningColor;
      case "scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDocumentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "filed":
        return successColor;
      case "submitted":
        return infoColor;
      case "draft":
        return warningColor;
      case "confidential":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _editCase() {
    si("Opening case editor");
    // Navigate to case edit
    //navigateTo('');
  }

  void _showCaseMenu() {
    si("Showing case menu");
    // Show case actions menu
  }

  void _addDocument() {
    si("Adding new document");
    // Navigate to document upload
    //navigateTo('');
  }

  void _viewDocument(String documentName) {
    si("Opening document: $documentName");
    // Navigate to document viewer
    //navigateTo('');
  }

  void _addTeamMember() {
    si("Adding team member");
    // Show add team member dialog
  }

  void _addNote() {
    si("Adding new note");
    // Show add note dialog
  }
}
