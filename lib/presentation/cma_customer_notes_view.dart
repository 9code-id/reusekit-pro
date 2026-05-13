import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerNotesView extends StatefulWidget {
  const CmaCustomerNotesView({super.key});

  @override
  State<CmaCustomerNotesView> createState() => _CmaCustomerNotesViewState();
}

class _CmaCustomerNotesViewState extends State<CmaCustomerNotesView> {
  String searchQuery = "";
  String selectedNoteType = "";
  String selectedPriority = "";
  bool showAddDialog = false;
  String newNoteTitle = "";
  String newNoteContent = "";
  String selectedNoteCategory = "";
  String selectedNotePriority = "medium";
  bool isNotePrivate = false;

  List<Map<String, dynamic>> noteTypes = [
    {"label": "All Types", "value": ""},
    {"label": "General", "value": "general"},
    {"label": "Meeting", "value": "meeting"},
    {"label": "Call", "value": "call"},
    {"label": "Email", "value": "email"},
    {"label": "Issue", "value": "issue"},
    {"label": "Opportunity", "value": "opportunity"},
  ];

  List<Map<String, dynamic>> priorityLevels = [
    {"label": "All Priorities", "value": ""},
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];

  List<Map<String, dynamic>> noteCategories = [
    {"label": "General", "value": "general"},
    {"label": "Meeting Notes", "value": "meeting"},
    {"label": "Phone Call", "value": "call"},
    {"label": "Email Follow-up", "value": "email"},
    {"label": "Issue/Complaint", "value": "issue"},
    {"label": "Sales Opportunity", "value": "opportunity"},
    {"label": "Support Request", "value": "support"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Urgent", "value": "urgent"},
  ];

  List<Map<String, dynamic>> notes = [
    {
      "id": "1",
      "customerId": "customer_001",
      "customerName": "Tech Solutions Inc.",
      "title": "Quarterly Business Review Meeting",
      "content": "Discussed Q4 performance and outlined 2025 expansion plans. Client is interested in upgrading to premium service tier. Follow up required on pricing proposal by end of week.",
      "type": "meeting",
      "priority": "high",
      "isPrivate": false,
      "createdBy": "John Smith",
      "createdDate": "2024-12-15T14:30:00Z",
      "lastModified": "2024-12-15T14:30:00Z",
      "tags": ["upgrade", "premium", "expansion"],
      "attachments": ["meeting_notes.pdf", "proposal_draft.docx"],
    },
    {
      "id": "2",
      "customerId": "customer_002",
      "customerName": "Global Manufacturing Ltd.",
      "title": "Urgent: Production Line Issue",
      "content": "Customer reported critical issue with automated system causing production delays. Engineering team dispatched immediately. Estimated resolution time: 4-6 hours. Customer updated every hour.",
      "type": "issue",
      "priority": "urgent",
      "isPrivate": false,
      "createdBy": "Sarah Johnson",
      "createdDate": "2024-12-15T09:15:00Z",
      "lastModified": "2024-12-15T11:45:00Z",
      "tags": ["critical", "production", "urgent"],
      "attachments": ["error_log.txt", "diagnostic_report.pdf"],
    },
    {
      "id": "3",
      "customerId": "customer_003",
      "customerName": "Retail Chain Corp",
      "title": "New Store Rollout Opportunity",
      "content": "Client planning to open 15 new locations across the region. Interested in our integrated POS and inventory management solution. Estimated deal value: \$2.3M. Proposal deadline: January 15th.",
      "type": "opportunity",
      "priority": "high",
      "isPrivate": false,
      "createdBy": "Mike Chen",
      "createdDate": "2024-12-14T16:20:00Z",
      "lastModified": "2024-12-15T08:30:00Z",
      "tags": ["opportunity", "expansion", "pos"],
      "attachments": ["store_layout.png", "initial_proposal.pdf"],
    },
    {
      "id": "4",
      "customerId": "customer_004",
      "customerName": "Healthcare Partners",
      "title": "Weekly Check-in Call",
      "content": "Routine check-in with Dr. Martinez. All systems running smoothly. Discussed upcoming HIPAA compliance updates. Scheduled training session for next week.",
      "type": "call",
      "priority": "medium",
      "isPrivate": false,
      "createdBy": "Lisa Wang",
      "createdDate": "2024-12-14T10:00:00Z",
      "lastModified": "2024-12-14T10:15:00Z",
      "tags": ["check-in", "compliance", "training"],
      "attachments": [],
    },
    {
      "id": "5",
      "customerId": "customer_005",
      "customerName": "Financial Services Group",
      "title": "Contract Renewal Discussion",
      "content": "Annual contract up for renewal in March 2025. Client satisfied with current service level but seeking cost optimization. Preparing competitive analysis and value proposition presentation.",
      "type": "general",
      "priority": "medium",
      "isPrivate": false,
      "createdBy": "David Brown",
      "createdDate": "2024-12-13T13:45:00Z",
      "lastModified": "2024-12-14T09:20:00Z",
      "tags": ["renewal", "pricing", "contract"],
      "attachments": ["current_contract.pdf"],
    },
    {
      "id": "6",
      "customerId": "customer_006",
      "customerName": "E-commerce Startup",
      "title": "Confidential: Acquisition Talks",
      "content": "Client being acquired by larger competitor. Need to understand impact on our contract and relationship. Legal team reviewing agreement terms. Potential for expanded business opportunity.",
      "type": "general",
      "priority": "high",
      "isPrivate": true,
      "createdBy": "Jennifer Adams",
      "createdDate": "2024-12-12T15:30:00Z",
      "lastModified": "2024-12-13T11:15:00Z",
      "tags": ["confidential", "acquisition", "legal"],
      "attachments": ["nda_signed.pdf"],
    },
    {
      "id": "7",
      "customerId": "customer_007",
      "customerName": "Local Restaurant Chain",
      "title": "Payment Processing Issues",
      "content": "Multiple reports of payment gateway timeouts during peak hours. IT team investigating server capacity issues. Temporary workaround implemented. Permanent fix scheduled for weekend.",
      "type": "issue",
      "priority": "medium",
      "isPrivate": false,
      "createdBy": "Tom Wilson",
      "createdDate": "2024-12-12T11:20:00Z",
      "lastModified": "2024-12-12T14:30:00Z",
      "tags": ["payment", "gateway", "server"],
      "attachments": ["server_logs.zip"],
    },
  ];

  List<Map<String, dynamic>> get filteredNotes {
    List<Map<String, dynamic>> filtered = notes;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((note) {
        return note["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               note["content"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               note["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedNoteType.isNotEmpty) {
      filtered = filtered.where((note) => note["type"] == selectedNoteType).toList();
    }
    
    if (selectedPriority.isNotEmpty) {
      filtered = filtered.where((note) => note["priority"] == selectedPriority).toList();
    }
    
    return filtered..sort((a, b) => b["createdDate"].compareTo(a["createdDate"]));
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Note"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Note Title",
                value: newNoteTitle,
                hint: "Enter descriptive title",
                onChanged: (value) {
                  newNoteTitle = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Note Content",
                value: newNoteContent,
                hint: "Enter detailed note content",
                onChanged: (value) {
                  newNoteContent = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: noteCategories,
                      value: selectedNoteCategory,
                      onChanged: (value, label) {
                        selectedNoteCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Priority",
                      items: priorityOptions,
                      value: selectedNotePriority,
                      onChanged: (value, label) {
                        selectedNotePriority = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QSwitch(
                label: "Private Note",
                items: [
                  {
                    "label": "Mark as private (visible only to me)",
                    "value": true,
                    "checked": isNotePrivate,
                  }
                ],
                value: [
                  if (isNotePrivate)
                    {
                      "label": "Mark as private (visible only to me)",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    isNotePrivate = values.isNotEmpty;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetAddDialog();
            },
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Note",
            size: bs.sm,
            onPressed: () {
              if (newNoteTitle.isNotEmpty && newNoteContent.isNotEmpty) {
                _addNewNote();
                Navigator.pop(context);
                _resetAddDialog();
                ss("Note added successfully");
              }
            },
          ),
        ],
      ),
    );
  }

  void _resetAddDialog() {
    newNoteTitle = "";
    newNoteContent = "";
    selectedNoteCategory = "";
    selectedNotePriority = "medium";
    isNotePrivate = false;
  }

  void _addNewNote() {
    notes.insert(0, {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "customerId": "customer_new",
      "customerName": "Selected Customer",
      "title": newNoteTitle,
      "content": newNoteContent,
      "type": selectedNoteCategory,
      "priority": selectedNotePriority,
      "isPrivate": isNotePrivate,
      "createdBy": "Current User",
      "createdDate": DateTime.now().toIso8601String(),
      "lastModified": DateTime.now().toIso8601String(),
      "tags": [],
      "attachments": [],
    });
    setState(() {});
  }

  void _deleteNote(String noteId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this note?");
    if (isConfirmed) {
      notes.removeWhere((note) => note["id"] == noteId);
      setState(() {});
      ss("Note deleted successfully");
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "low": return infoColor;
      case "medium": return warningColor;
      case "high": return secondaryColor;
      case "urgent": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "meeting": return primaryColor;
      case "call": return infoColor;
      case "email": return successColor;
      case "issue": return dangerColor;
      case "opportunity": return warningColor;
      case "general": return disabledBoldColor;
      default: return disabledBoldColor;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "meeting": return "Meeting";
      case "call": return "Call";
      case "email": return "Email";
      case "issue": return "Issue";
      case "opportunity": return "Opportunity";
      case "general": return "General";
      default: return "Note";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Notes"),
        actions: [
          IconButton(
            onPressed: _showAddNoteDialog,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.note_alt,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Keep detailed notes on customer interactions, meetings, and important updates",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            QTextField(
              label: "Search Notes",
              value: searchQuery,
              hint: "Search by title, content, or customer name...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: noteTypes,
                    value: selectedNoteType,
                    onChanged: (value, label) {
                      selectedNoteType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Priority",
                    items: priorityLevels,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QHorizontalScroll(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${notes.length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Notes",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: dangerColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${notes.where((n) => n["priority"] == "urgent").length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Urgent",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${notes.where((n) => n["isPrivate"] == true).length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Private",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              spacing: spSm,
              children: filteredNotes.map((note) {
                Color priorityColor = _getPriorityColor(note["priority"]);
                Color typeColor = _getTypeColor(note["type"]);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: typeColor.withAlpha(100)),
                            ),
                            child: Text(
                              _getTypeLabel(note["type"]),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: typeColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: priorityColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: priorityColor.withAlpha(100)),
                            ),
                            child: Text(
                              "${note["priority"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: priorityColor,
                              ),
                            ),
                          ),
                          if (note["isPrivate"] == true) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: warningColor.withAlpha(100)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.lock, size: 10, color: warningColor),
                                  SizedBox(width: 2),
                                  Text(
                                    "PRIVATE",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          Spacer(),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Edit"),
                                  ],
                                ),
                                onTap: () {
                                  // Handle edit note
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.share, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Share"),
                                  ],
                                ),
                                onTap: () {
                                  // Handle share note
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: dangerColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Delete", style: TextStyle(color: dangerColor)),
                                  ],
                                ),
                                onTap: () => _deleteNote(note["id"]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Text(
                        "${note["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.business,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${note["customerName"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${note["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),

                      if ((note["tags"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (note["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: infoColor.withAlpha(100)),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      if ((note["attachments"] as List).isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Attachments:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(note["attachments"] as List).map((attachment) {
                                return Row(
                                  children: [
                                    Icon(Icons.attach_file, size: 14, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "$attachment",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),

                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "By ${note["createdBy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${DateTime.parse(note["createdDate"]).dMMMy}",
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

            if (filteredNotes.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.note_alt_outlined,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No notes found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or add a new note",
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
}
