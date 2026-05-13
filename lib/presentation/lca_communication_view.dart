import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCommunicationView extends StatefulWidget {
  const LcaCommunicationView({super.key});

  @override
  State<LcaCommunicationView> createState() => _LcaCommunicationViewState();
}

class _LcaCommunicationViewState extends State<LcaCommunicationView> {
  String selectedFilter = "All";
  String searchQuery = "";
  String messageContent = "";
  String selectedContact = "";
  String selectedTemplate = "";
  bool isComposing = false;
  int selectedTab = 0;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Unread", "value": "Unread"},
    {"label": "Important", "value": "Important"},
    {"label": "Clients", "value": "Clients"},
    {"label": "Colleagues", "value": "Colleagues"},
    {"label": "Courts", "value": "Courts"},
  ];

  List<Map<String, dynamic>> contacts = [
    {"label": "Select Contact", "value": ""},
    {"label": "John Smith (Client)", "value": "john_smith"},
    {"label": "Sarah Johnson (Colleague)", "value": "sarah_johnson"},
    {"label": "Michael Davis (Client)", "value": "michael_davis"},
    {"label": "Court Clerk - District Court", "value": "court_clerk"},
    {"label": "Emily Wilson (Partner)", "value": "emily_wilson"},
  ];

  List<Map<String, dynamic>> templates = [
    {"label": "Select Template", "value": ""},
    {"label": "Initial Client Consultation", "value": "consultation"},
    {"label": "Case Status Update", "value": "status_update"},
    {"label": "Document Request", "value": "doc_request"},
    {"label": "Court Filing Confirmation", "value": "filing_confirm"},
    {"label": "Settlement Proposal", "value": "settlement"},
    {"label": "Meeting Reminder", "value": "meeting_reminder"},
  ];

  List<Map<String, dynamic>> communications = [
    {
      "id": "1",
      "type": "email",
      "from": "john.smith@email.com",
      "from_name": "John Smith",
      "subject": "Contract Review - Urgent",
      "preview": "I need your review on the employment contract we discussed. There are some clauses that concern me...",
      "timestamp": "2024-12-15T09:30:00Z",
      "is_read": false,
      "is_important": true,
      "category": "Clients",
      "attachments": 2,
      "tags": ["contract", "urgent", "employment"],
    },
    {
      "id": "2",
      "type": "message",
      "from": "sarah.johnson@firm.com",
      "from_name": "Sarah Johnson",
      "subject": "Case Law Research - Patent Litigation",
      "preview": "Found some relevant precedents for our patent case. The Federal Circuit decision from last month might be helpful...",
      "timestamp": "2024-12-15T08:45:00Z",
      "is_read": true,
      "is_important": false,
      "category": "Colleagues",
      "attachments": 1,
      "tags": ["patent", "research", "litigation"],
    },
    {
      "id": "3",
      "type": "court_notice",
      "from": "clerk@districtcourt.gov",
      "from_name": "District Court Clerk",
      "subject": "Hearing Scheduled - Case #2024-CV-1234",
      "preview": "A hearing has been scheduled for December 20, 2024, at 10:00 AM in Courtroom 3. Please confirm attendance...",
      "timestamp": "2024-12-14T16:20:00Z",
      "is_read": false,
      "is_important": true,
      "category": "Courts",
      "attachments": 0,
      "tags": ["hearing", "court", "important"],
    },
    {
      "id": "4",
      "type": "email",
      "from": "michael.davis@company.com",
      "from_name": "Michael Davis",
      "subject": "Settlement Discussion",
      "preview": "After reviewing the discovery materials, I think we should discuss settlement options. When would be a good time to meet?",
      "timestamp": "2024-12-14T14:15:00Z",
      "is_read": true,
      "is_important": false,
      "category": "Clients",
      "attachments": 0,
      "tags": ["settlement", "discussion", "meeting"],
    },
    {
      "id": "5",
      "type": "internal",
      "from": "emily.wilson@firm.com",
      "from_name": "Emily Wilson",
      "subject": "Team Meeting - Weekly Review",
      "preview": "Weekly team meeting scheduled for Friday at 3 PM. Please prepare case updates and billing summaries...",
      "timestamp": "2024-12-13T11:30:00Z",
      "is_read": true,
      "is_important": false,
      "category": "Colleagues",
      "attachments": 0,
      "tags": ["meeting", "team", "weekly"],
    },
    {
      "id": "6",
      "type": "client_portal",
      "from": "portal@legalfirm.com",
      "from_name": "Client Portal",
      "subject": "New Document Upload - Johnson vs. ABC Corp",
      "preview": "Client has uploaded new documents to the case portal. Documents include financial statements and contracts...",
      "timestamp": "2024-12-13T09:45:00Z",
      "is_read": false,
      "is_important": false,
      "category": "Clients",
      "attachments": 3,
      "tags": ["documents", "upload", "portal"],
    },
  ];

  List<Map<String, dynamic>> recentContacts = [
    {
      "name": "John Smith",
      "email": "john.smith@email.com",
      "type": "Client",
      "last_contact": "2024-12-15T09:30:00Z",
      "status": "Active Case",
    },
    {
      "name": "Sarah Johnson",
      "email": "sarah.johnson@firm.com", 
      "type": "Colleague",
      "last_contact": "2024-12-15T08:45:00Z",
      "status": "Available",
    },
    {
      "name": "Michael Davis",
      "email": "michael.davis@company.com",
      "type": "Client",
      "last_contact": "2024-12-14T14:15:00Z",
      "status": "Settlement Phase",
    },
  ];

  List<Map<String, dynamic>> get filteredCommunications {
    return communications.where((comm) {
      bool matchesSearch = searchQuery.isEmpty ||
          (comm["subject"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (comm["from_name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (comm["preview"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Unread" && comm["is_read"] == false) ||
          (selectedFilter == "Important" && comm["is_important"] == true) ||
          comm["category"] == selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Icon getTypeIcon(String type) {
    switch (type) {
      case "email": return Icon(Icons.email, color: primaryColor);
      case "message": return Icon(Icons.message, color: successColor);
      case "court_notice": return Icon(Icons.gavel, color: warningColor);
      case "internal": return Icon(Icons.business, color: infoColor);
      case "client_portal": return Icon(Icons.cloud_upload, color: Colors.purple);
      default: return Icon(Icons.message, color: disabledBoldColor);
    }
  }

  void _showComposeDialog() {
    messageContent = "";
    selectedContact = "";
    selectedTemplate = "";
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            "Compose Message",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QDropdownField(
                    label: "To",
                    items: contacts,
                    value: selectedContact,
                    onChanged: (value, label) {
                      selectedContact = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Template",
                    items: templates,
                    value: selectedTemplate,
                    onChanged: (value, label) {
                      selectedTemplate = value;
                      // Auto-fill template content
                      if (value == "consultation") {
                        messageContent = "Dear Client,\n\nThank you for choosing our firm. I would like to schedule an initial consultation to discuss your legal matter...\n\nBest regards,";
                      } else if (value == "status_update") {
                        messageContent = "Dear Client,\n\nI wanted to provide you with an update on your case. Recent developments include...\n\nPlease let me know if you have any questions.\n\nBest regards,";
                      }
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Message",
                    value: messageContent,
                    hint: "Type your message here...",
                    validator: Validator.required,
                    onChanged: (value) {
                      messageContent = value;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: disabledBoldColor),
              ),
            ),
            QButton(
              label: "Send",
              size: bs.sm,
              onPressed: () {
                if (selectedContact.isNotEmpty && messageContent.isNotEmpty) {
                  Navigator.pop(context);
                  ss("Message sent successfully");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Communications"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _showComposeDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filterOptions.length,
              itemBuilder: (context, index) {
                final filter = filterOptions[index];
                bool isSelected = selectedFilter == filter["value"];
                return Container(
                  margin: EdgeInsets.only(right: spSm, top: spSm, bottom: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedFilter = filter["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        "${filter["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(spMd),
            child: QTextField(
              label: "Search Communications",
              value: searchQuery,
              hint: "Search by subject, sender, or content...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Statistics Row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${communications.where((c) => c["is_read"] == false).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Unread",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
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
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${communications.where((c) => c["is_important"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Important",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
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
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${communications.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Communications List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredCommunications.length,
              itemBuilder: (context, index) {
                final comm = filteredCommunications[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: comm["is_read"] == false 
                          ? primaryColor.withAlpha(30) 
                          : disabledOutlineBorderColor,
                      width: comm["is_read"] == false ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: comm["is_read"] == false 
                              ? primaryColor.withAlpha(20) 
                              : disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: getTypeIcon("${comm["type"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${comm["from_name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (comm["is_important"] == true)
                                  Icon(
                                    Icons.priority_high,
                                    color: warningColor,
                                    size: 16,
                                  ),
                                SizedBox(width: spXs),
                                Text(
                                  DateTime.parse("${comm["timestamp"]}").dMMMy,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${comm["subject"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: comm["is_read"] == false 
                                    ? FontWeight.w600 
                                    : FontWeight.normal,
                                color: comm["is_read"] == false 
                                    ? primaryColor 
                                    : disabledBoldColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${comm["preview"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${comm["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if ((comm["attachments"] as int) > 0) ...[
                                  SizedBox(width: spSm),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.attach_file,
                                        size: 12,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${comm["attachments"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                Spacer(),
                                if (comm["is_read"] == false)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showComposeDialog,
        backgroundColor: primaryColor,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
