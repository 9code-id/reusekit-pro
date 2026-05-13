import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCandidateCommunicationView extends StatefulWidget {
  const RhaCandidateCommunicationView({super.key});

  @override
  State<RhaCandidateCommunicationView> createState() => _RhaCandidateCommunicationViewState();
}

class _RhaCandidateCommunicationViewState extends State<RhaCandidateCommunicationView> {
  String selectedCandidate = "";
  String selectedCommunicationType = "";
  String selectedStatus = "";
  int selectedTabIndex = 0;
  String messageContent = "";
  String emailSubject = "";
  String emailContent = "";

  List<Map<String, dynamic>> candidates = [
    {"label": "All Candidates", "value": ""},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Chen", "value": "michael_chen"},
    {"label": "Emily Rodriguez", "value": "emily_rodriguez"},
    {"label": "David Kim", "value": "david_kim"},
  ];

  List<Map<String, dynamic>> communicationTypes = [
    {"label": "All Types", "value": ""},
    {"label": "Email", "value": "email"},
    {"label": "Phone Call", "value": "phone"},
    {"label": "Video Call", "value": "video"},
    {"label": "Text Message", "value": "sms"},
    {"label": "In-Person", "value": "in_person"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Sent", "value": "sent"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Read", "value": "read"},
    {"label": "Replied", "value": "replied"},
    {"label": "Failed", "value": "failed"},
  ];

  List<Map<String, dynamic>> communicationHistory = [
    {
      "id": "COMM001",
      "candidateName": "Sarah Johnson",
      "candidateAvatar": "https://picsum.photos/40/40?random=1&person",
      "type": "email",
      "typeLabel": "Email",
      "subject": "Follow-up on Technical Interview",
      "content": "Hi Sarah, Thank you for taking the time to interview with us yesterday. We were impressed with your technical skills and problem-solving approach. We'll be in touch with next steps within the next few days.",
      "direction": "outgoing",
      "status": "read",
      "timestamp": "2024-12-18T14:30:00",
      "senderName": "John Smith",
      "senderRole": "Technical Lead",
      "attachments": ["interview_feedback.pdf"],
    },
    {
      "id": "COMM002",
      "candidateName": "Sarah Johnson",
      "candidateAvatar": "https://picsum.photos/40/40?random=1&person",
      "type": "email",
      "typeLabel": "Email",
      "subject": "Re: Follow-up on Technical Interview",
      "content": "Hi John, Thank you for the update! I really enjoyed our conversation and I'm excited about the opportunity. I look forward to hearing about the next steps. Please let me know if you need any additional information.",
      "direction": "incoming",
      "status": "read",
      "timestamp": "2024-12-18T16:45:00",
      "senderName": "Sarah Johnson",
      "senderRole": "Candidate",
      "attachments": [],
    },
    {
      "id": "COMM003",
      "candidateName": "Michael Chen",
      "candidateAvatar": "https://picsum.photos/40/40?random=2&person",
      "type": "phone",
      "typeLabel": "Phone Call",
      "subject": "Initial Screening Call",
      "content": "30-minute screening call completed. Discussed background, experience with product management, and career goals. Candidate shows strong interest in the role and has relevant experience.",
      "direction": "outgoing",
      "status": "completed",
      "timestamp": "2024-12-17T10:00:00",
      "senderName": "Lisa Davis",
      "senderRole": "HR Manager",
      "attachments": [],
    },
    {
      "id": "COMM004",
      "candidateName": "Emily Rodriguez",
      "candidateAvatar": "https://picsum.photos/40/40?random=3&person",
      "type": "video",
      "typeLabel": "Video Call",
      "subject": "Portfolio Review Session",
      "content": "1-hour video call to review design portfolio. Discussed recent projects, design process, and approach to user research. Excellent presentation skills and strong design thinking.",
      "direction": "outgoing",
      "status": "completed",
      "timestamp": "2024-12-16T14:00:00",
      "senderName": "David Park",
      "senderRole": "Design Director",
      "attachments": ["portfolio_notes.pdf"],
    },
    {
      "id": "COMM005",
      "candidateName": "David Kim",
      "candidateAvatar": "https://picsum.photos/40/40?random=4&person",
      "type": "sms",
      "typeLabel": "Text Message",
      "subject": "Interview Reminder",
      "content": "Hi David, just a friendly reminder about your technical interview tomorrow at 2 PM. Please reply to confirm. Looking forward to speaking with you!",
      "direction": "outgoing",
      "status": "delivered",
      "timestamp": "2024-12-15T18:00:00",
      "senderName": "Sarah Thompson",
      "senderRole": "Recruiter",
      "attachments": [],
    },
  ];

  List<Map<String, dynamic>> emailTemplates = [
    {
      "id": "TEMP001",
      "name": "Interview Invitation",
      "subject": "Interview Invitation - {position} Role",
      "content": "Hi {candidate_name},\n\nWe're excited to invite you for an interview for the {position} role at our company. Please let us know your availability for the coming week.\n\nBest regards,\n{sender_name}",
    },
    {
      "id": "TEMP002",
      "name": "Interview Follow-up",
      "subject": "Thank you for interviewing with us",
      "content": "Hi {candidate_name},\n\nThank you for taking the time to interview with us for the {position} role. We'll be in touch with next steps within the next few days.\n\nBest regards,\n{sender_name}",
    },
    {
      "id": "TEMP003",
      "name": "Rejection Email",
      "subject": "Update on your application",
      "content": "Hi {candidate_name},\n\nThank you for your interest in the {position} role. After careful consideration, we've decided to move forward with another candidate. We appreciate your time and wish you all the best.\n\nBest regards,\n{sender_name}",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Candidate Communication",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Send Message", icon: Icon(Icons.send)),
        Tab(text: "Templates", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildHistoryTab(),
        _buildSendMessageTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildHistoryTab() {
    List<Map<String, dynamic>> filteredHistory = communicationHistory.where((comm) {
      bool matchesCandidate = selectedCandidate.isEmpty || comm["candidateName"].toString().toLowerCase().contains(selectedCandidate.toLowerCase());
      bool matchesType = selectedCommunicationType.isEmpty || comm["type"] == selectedCommunicationType;
      bool matchesStatus = selectedStatus.isEmpty || comm["status"] == selectedStatus;
      return matchesCandidate && matchesType && matchesStatus;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCommunicationStats(),
          _buildHistoryFilters(),
          _buildCommunicationList(filteredHistory),
        ],
      ),
    );
  }

  Widget _buildCommunicationStats() {
    Map<String, int> typeStats = {};
    Map<String, int> statusStats = {};
    
    for (var comm in communicationHistory) {
      String type = comm["typeLabel"];
      String status = comm["status"];
      
      typeStats[type] = (typeStats[type] ?? 0) + 1;
      statusStats[status] = (statusStats[status] ?? 0) + 1;
    }

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
              Icon(Icons.analytics, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Communication Statistics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatCard("Total Communications", communicationHistory.length, Icons.message, primaryColor),
              _buildStatCard("Emails Sent", typeStats["Email"] ?? 0, Icons.email, successColor),
              _buildStatCard("Calls Made", (typeStats["Phone Call"] ?? 0) + (typeStats["Video Call"] ?? 0), Icons.phone, infoColor),
              _buildStatCard("Pending Responses", communicationHistory.where((c) => c["status"] == "sent" || c["status"] == "delivered").length, Icons.schedule, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                "$value",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
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
              Icon(Icons.filter_list, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Filter Communications",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _clearFilters(),
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QDropdownField(
                label: "Candidate",
                items: candidates,
                value: selectedCandidate,
                onChanged: (value, label) {
                  selectedCandidate = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Communication Type",
                items: communicationTypes,
                value: selectedCommunicationType,
                onChanged: (value, label) {
                  selectedCommunicationType = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationList(List<Map<String, dynamic>> communications) {
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
              Icon(Icons.history, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Communication History",
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${communications.length} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (communications.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.message,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No communications found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          if (communications.isNotEmpty)
            Column(
              spacing: spSm,
              children: communications.map((comm) {
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
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage("${comm["candidateAvatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${comm["candidateName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getTypeColor(comm["type"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            _getTypeIcon(comm["type"]),
                                            size: 12,
                                            color: _getTypeColor(comm["type"]),
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${comm["typeLabel"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: _getTypeColor(comm["type"]),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(comm["status"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${comm["status"].toString().toUpperCase()}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getStatusColor(comm["status"]),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      comm["direction"] == "outgoing" ? Icons.call_made : Icons.call_received,
                                      size: 12,
                                      color: comm["direction"] == "outgoing" ? successColor : infoColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () => _showCommunicationOptions(comm),
                          ),
                        ],
                      ),
                      if (comm["subject"].toString().isNotEmpty)
                        Text(
                          "${comm["subject"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      Text(
                        "${comm["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),
                      if ((comm["attachments"] as List).isNotEmpty)
                        QHorizontalScroll(
                          children: (comm["attachments"] as List).map((attachment) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: successColor.withAlpha(50)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.attach_file,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "$attachment",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      Row(
                        children: [
                          Text(
                            "From: ${comm["senderName"]} (${comm["senderRole"]})",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            _formatDateTime(comm["timestamp"]),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
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

  Widget _buildSendMessageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickActions(),
          _buildComposeMessage(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
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
              Icon(Icons.flash_on, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildQuickActionCard("Send Interview Invite", Icons.calendar_today, primaryColor),
              _buildQuickActionCard("Follow-up Email", Icons.email, successColor),
              _buildQuickActionCard("Schedule Call", Icons.phone, infoColor),
              _buildQuickActionCard("Send Reminder", Icons.alarm, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Send",
              size: bs.sm,
              onPressed: () => _sendQuickMessage(title),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposeMessage() {
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
              Icon(Icons.create, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Compose Message",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Candidate",
            items: candidates.where((c) => c["value"].isNotEmpty).toList(),
            value: selectedCandidate,
            onChanged: (value, label) {
              selectedCandidate = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Communication Type",
            items: communicationTypes.where((c) => c["value"].isNotEmpty).toList(),
            value: selectedCommunicationType,
            onChanged: (value, label) {
              selectedCommunicationType = value;
              setState(() {});
            },
          ),
          if (selectedCommunicationType == "email") ...[
            QTextField(
              label: "Subject",
              value: emailSubject,
              onChanged: (value) {
                emailSubject = value;
                setState(() {});
              },
            ),
            QMemoField(
              label: "Email Content",
              value: emailContent,
              onChanged: (value) {
                emailContent = value;
                setState(() {});
              },
            ),
          ] else ...[
            QMemoField(
              label: "Message Content",
              value: messageContent,
              onChanged: (value) {
                messageContent = value;
                setState(() {});
              },
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Send Message",
                  size: bs.md,
                  onPressed: () => _sendMessage(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Save Draft",
                  size: bs.md,
                  onPressed: () => _saveDraft(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTemplatesSection(),
        ],
      ),
    );
  }

  Widget _buildTemplatesSection() {
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
              Icon(Icons.add, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Email Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Create Template",
                size: bs.sm,
                onPressed: () => _createTemplate(),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: emailTemplates.map((template) {
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
                        Icon(Icons.email, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${template["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () => _showTemplateOptions(template),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subject: ${template["subject"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${template["content"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Use Template",
                            size: bs.sm,
                            onPressed: () => _useTemplate(template),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Edit Template",
                            size: bs.sm,
                            onPressed: () => _editTemplate(template),
                          ),
                        ),
                      ],
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

  Color _getTypeColor(String type) {
    switch (type) {
      case "email":
        return primaryColor;
      case "phone":
        return successColor;
      case "video":
        return infoColor;
      case "sms":
        return warningColor;
      case "in_person":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "email":
        return Icons.email;
      case "phone":
        return Icons.phone;
      case "video":
        return Icons.videocam;
      case "sms":
        return Icons.sms;
      case "in_person":
        return Icons.person;
      default:
        return Icons.message;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "sent":
        return infoColor;
      case "delivered":
        return warningColor;
      case "read":
        return primaryColor;
      case "replied":
        return successColor;
      case "completed":
        return successColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatDateTime(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  void _clearFilters() {
    setState(() {
      selectedCandidate = "";
      selectedCommunicationType = "";
      selectedStatus = "";
    });
    ss("Filters cleared");
  }

  void _showCommunicationOptions(Map<String, dynamic> comm) {
    si("Show options for communication ${comm["id"]}");
  }

  void _sendQuickMessage(String type) {
    ss("$type sent successfully");
  }

  void _sendMessage() {
    ss("Message sent successfully");
  }

  void _saveDraft() {
    ss("Draft saved");
  }

  void _createTemplate() {
    si("Create new email template");
  }

  void _showTemplateOptions(Map<String, dynamic> template) {
    si("Show options for template ${template["id"]}");
  }

  void _useTemplate(Map<String, dynamic> template) {
    setState(() {
      emailSubject = template["subject"];
      emailContent = template["content"];
      selectedCommunicationType = "email";
      selectedTabIndex = 1;
    });
    ss("Template applied");
  }

  void _editTemplate(Map<String, dynamic> template) {
    si("Edit template ${template["name"]}");
  }
}
