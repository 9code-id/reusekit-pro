import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerInteractionsView extends StatefulWidget {
  const CmaCustomerInteractionsView({super.key});

  @override
  State<CmaCustomerInteractionsView> createState() => _CmaCustomerInteractionsViewState();
}

class _CmaCustomerInteractionsViewState extends State<CmaCustomerInteractionsView> {
  String selectedCustomer = "customer_001";
  String selectedInteractionType = "";
  String selectedChannel = "";
  String searchQuery = "";
  bool showAddDialog = false;
  String newInteractionType = "";
  String newInteractionChannel = "";
  String newInteractionSubject = "";
  String newInteractionNotes = "";
  String selectedOutcome = "";

  List<Map<String, dynamic>> customers = [
    {"label": "Tech Solutions Inc.", "value": "customer_001"},
    {"label": "Global Manufacturing Ltd.", "value": "customer_002"},
    {"label": "Retail Chain Corp", "value": "customer_003"},
    {"label": "Healthcare Partners", "value": "customer_004"},
    {"label": "Financial Services Group", "value": "customer_005"},
  ];

  List<Map<String, dynamic>> interactionTypes = [
    {"label": "All Types", "value": ""},
    {"label": "Sales Call", "value": "sales_call"},
    {"label": "Support Call", "value": "support_call"},
    {"label": "Meeting", "value": "meeting"},
    {"label": "Email", "value": "email"},
    {"label": "Demo", "value": "demo"},
    {"label": "Follow-up", "value": "follow_up"},
  ];

  List<Map<String, dynamic>> channels = [
    {"label": "All Channels", "value": ""},
    {"label": "Phone", "value": "phone"},
    {"label": "Email", "value": "email"},
    {"label": "Video Call", "value": "video"},
    {"label": "In Person", "value": "in_person"},
    {"label": "Chat", "value": "chat"},
    {"label": "Social Media", "value": "social"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "Sales Call", "value": "sales_call"},
    {"label": "Support Call", "value": "support_call"},
    {"label": "Meeting", "value": "meeting"},
    {"label": "Email", "value": "email"},
    {"label": "Demo", "value": "demo"},
    {"label": "Follow-up", "value": "follow_up"},
    {"label": "Training", "value": "training"},
  ];

  List<Map<String, dynamic>> channelOptions = [
    {"label": "Phone", "value": "phone"},
    {"label": "Email", "value": "email"},
    {"label": "Video Call", "value": "video"},
    {"label": "In Person", "value": "in_person"},
    {"label": "Chat", "value": "chat"},
    {"label": "Social Media", "value": "social"},
  ];

  List<Map<String, dynamic>> outcomeOptions = [
    {"label": "Positive", "value": "positive"},
    {"label": "Neutral", "value": "neutral"},
    {"label": "Negative", "value": "negative"},
    {"label": "Follow-up Required", "value": "follow_up_required"},
    {"label": "Resolved", "value": "resolved"},
  ];

  List<Map<String, dynamic>> interactions = [
    {
      "id": "1",
      "customerId": "customer_001",
      "type": "sales_call",
      "channel": "video",
      "subject": "Q1 2025 Expansion Discussion",
      "notes": "Discussed scaling up operations for Q1. Customer interested in adding 25 more user licenses and premium support package. Pricing proposal to be sent by Friday.",
      "duration": 45,
      "outcome": "positive",
      "nextAction": "Send proposal with pricing",
      "contactPerson": "John Martinez - CTO",
      "performedBy": "Sarah Wilson",
      "timestamp": "2024-12-15T14:00:00Z",
      "followupDate": "2024-12-18",
      "priority": "high",
      "tags": ["expansion", "pricing", "proposal"],
    },
    {
      "id": "2",
      "customerId": "customer_001",
      "type": "support_call",
      "channel": "phone",
      "subject": "Login Issues Resolution",
      "notes": "Customer reported intermittent login failures. Diagnosed issue as browser cache conflict. Provided step-by-step resolution guide and verified fix worked.",
      "duration": 20,
      "outcome": "resolved",
      "nextAction": "Monitor for any recurring issues",
      "contactPerson": "Lisa Chen - IT Manager",
      "performedBy": "Mike Rodriguez",
      "timestamp": "2024-12-14T10:30:00Z",
      "followupDate": "",
      "priority": "medium",
      "tags": ["technical", "login", "browser"],
    },
    {
      "id": "3",
      "customerId": "customer_001",
      "type": "email",
      "channel": "email",
      "subject": "Monthly Newsletter and Product Updates",
      "notes": "Sent monthly newsletter featuring new product features, upcoming webinars, and industry insights. Customer acknowledged receipt and expressed interest in AI automation features.",
      "duration": 0,
      "outcome": "positive",
      "nextAction": "Schedule AI features demo",
      "contactPerson": "John Martinez - CTO",
      "performedBy": "Marketing Team",
      "timestamp": "2024-12-13T09:00:00Z",
      "followupDate": "2024-12-20",
      "priority": "low",
      "tags": ["newsletter", "ai", "features"],
    },
    {
      "id": "4",
      "customerId": "customer_001",
      "type": "meeting",
      "channel": "in_person",
      "subject": "Quarterly Business Review",
      "notes": "Comprehensive review of Q4 performance metrics. Customer satisfaction at 92%. Discussed roadmap for 2025 including new integrations and mobile app development.",
      "duration": 120,
      "outcome": "positive",
      "nextAction": "Prepare 2025 roadmap document",
      "contactPerson": "David Kim - CEO",
      "performedBy": "Account Team",
      "timestamp": "2024-12-12T13:00:00Z",
      "followupDate": "2024-12-19",
      "priority": "high",
      "tags": ["qbr", "roadmap", "satisfaction"],
    },
    {
      "id": "5",
      "customerId": "customer_001",
      "type": "demo",
      "channel": "video",
      "subject": "New Analytics Dashboard Demo",
      "notes": "Demonstrated new real-time analytics dashboard capabilities. Customer impressed with data visualization and export features. Requested trial access for team evaluation.",
      "duration": 60,
      "outcome": "positive",
      "nextAction": "Set up trial environment",
      "contactPerson": "Jennifer Wong - Data Analyst",
      "performedBy": "Product Specialist",
      "timestamp": "2024-12-10T16:00:00Z",
      "followupDate": "2024-12-17",
      "priority": "medium",
      "tags": ["demo", "analytics", "trial"],
    },
    {
      "id": "6",
      "customerId": "customer_001",
      "type": "follow_up",
      "channel": "phone",
      "subject": "Implementation Status Check",
      "notes": "Checked progress on new feature rollout. Implementation 80% complete. Customer reported minor user adoption challenges. Recommended additional training sessions.",
      "duration": 25,
      "outcome": "follow_up_required",
      "nextAction": "Schedule training sessions",
      "contactPerson": "Mark Thompson - Project Manager",
      "performedBy": "Implementation Team",
      "timestamp": "2024-12-08T11:00:00Z",
      "followupDate": "2024-12-15",
      "priority": "medium",
      "tags": ["implementation", "training", "adoption"],
    },
    {
      "id": "7",
      "customerId": "customer_001",
      "type": "support_call",
      "channel": "chat",
      "subject": "API Integration Question",
      "notes": "Developer needed clarification on API rate limits and authentication methods. Provided technical documentation and sample code. Issue resolved quickly.",
      "duration": 15,
      "outcome": "resolved",
      "nextAction": "Update documentation with common examples",
      "contactPerson": "Alex Johnson - Developer",
      "performedBy": "Technical Support",
      "timestamp": "2024-12-06T15:30:00Z",
      "followupDate": "",
      "priority": "low",
      "tags": ["api", "documentation", "developer"],
    },
  ];

  List<Map<String, dynamic>> get filteredInteractions {
    List<Map<String, dynamic>> filtered = interactions.where((interaction) => 
      interaction["customerId"] == selectedCustomer
    ).toList();
    
    if (selectedInteractionType.isNotEmpty) {
      filtered = filtered.where((interaction) => interaction["type"] == selectedInteractionType).toList();
    }
    
    if (selectedChannel.isNotEmpty) {
      filtered = filtered.where((interaction) => interaction["channel"] == selectedChannel).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((interaction) {
        return interaction["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               interaction["notes"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               interaction["contactPerson"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filtered..sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));
  }

  void _showAddInteractionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Interaction"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Type",
                      items: typeOptions,
                      value: newInteractionType,
                      onChanged: (value, label) {
                        newInteractionType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Channel",
                      items: channelOptions,
                      value: newInteractionChannel,
                      onChanged: (value, label) {
                        newInteractionChannel = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QTextField(
                label: "Subject",
                value: newInteractionSubject,
                hint: "Brief description of interaction",
                onChanged: (value) {
                  newInteractionSubject = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Notes",
                value: newInteractionNotes,
                hint: "Detailed notes about the interaction",
                onChanged: (value) {
                  newInteractionNotes = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Outcome",
                items: outcomeOptions,
                value: selectedOutcome,
                onChanged: (value, label) {
                  selectedOutcome = value;
                  setState(() {});
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
            label: "Add Interaction",
            size: bs.sm,
            onPressed: () {
              if (newInteractionType.isNotEmpty && newInteractionSubject.isNotEmpty) {
                _addNewInteraction();
                Navigator.pop(context);
                _resetAddDialog();
                ss("Interaction added successfully");
              }
            },
          ),
        ],
      ),
    );
  }

  void _resetAddDialog() {
    newInteractionType = "";
    newInteractionChannel = "";
    newInteractionSubject = "";
    newInteractionNotes = "";
    selectedOutcome = "";
  }

  void _addNewInteraction() {
    interactions.insert(0, {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "customerId": selectedCustomer,
      "type": newInteractionType,
      "channel": newInteractionChannel,
      "subject": newInteractionSubject,
      "notes": newInteractionNotes,
      "duration": 0,
      "outcome": selectedOutcome,
      "nextAction": "",
      "contactPerson": "Customer Contact",
      "performedBy": "Current User",
      "timestamp": DateTime.now().toIso8601String(),
      "followupDate": "",
      "priority": "medium",
      "tags": [],
    });
    setState(() {});
  }

  void _deleteInteraction(String interactionId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this interaction?");
    if (isConfirmed) {
      interactions.removeWhere((interaction) => interaction["id"] == interactionId);
      setState(() {});
      ss("Interaction deleted successfully");
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "sales_call": return successColor;
      case "support_call": return warningColor;
      case "meeting": return primaryColor;
      case "email": return infoColor;
      case "demo": return secondaryColor;
      case "follow_up": return dangerColor;
      case "training": return primaryColor;
      default: return disabledBoldColor;
    }
  }

  Color _getChannelColor(String channel) {
    switch (channel) {
      case "phone": return primaryColor;
      case "email": return infoColor;
      case "video": return successColor;
      case "in_person": return warningColor;
      case "chat": return secondaryColor;
      case "social": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getOutcomeColor(String outcome) {
    switch (outcome) {
      case "positive": return successColor;
      case "neutral": return infoColor;
      case "negative": return dangerColor;
      case "follow_up_required": return warningColor;
      case "resolved": return primaryColor;
      default: return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high": return dangerColor;
      case "medium": return warningColor;
      case "low": return infoColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "sales_call": return Icons.phone_in_talk;
      case "support_call": return Icons.support_agent;
      case "meeting": return Icons.meeting_room;
      case "email": return Icons.email;
      case "demo": return Icons.slideshow;
      case "follow_up": return Icons.schedule;
      case "training": return Icons.school;
      default: return Icons.chat;
    }
  }

  String _getTypeLabel(String type) {
    return type.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }

  String _getChannelLabel(String channel) {
    return channel.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = filteredInteractions;
    
    Map<String, int> typeStats = {};
    Map<String, int> outcomeStats = {};
    int totalDuration = 0;
    
    for (var interaction in filteredList) {
      String type = interaction["type"];
      String outcome = interaction["outcome"];
      typeStats[type] = (typeStats[type] ?? 0) + 1;
      outcomeStats[outcome] = (outcomeStats[outcome] ?? 0) + 1;
      totalDuration += (interaction["duration"] as int);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Interactions"),
        actions: [
          IconButton(
            onPressed: _showAddInteractionDialog,
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
                    Icons.chat_bubble_outline,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Track and manage all customer interactions across different channels and touchpoints",
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

            QDropdownField(
              label: "Select Customer",
              items: customers,
              value: selectedCustomer,
              onChanged: (value, label) {
                selectedCustomer = value;
                setState(() {});
              },
            ),

            QTextField(
              label: "Search Interactions",
              value: searchQuery,
              hint: "Search by subject, notes, or contact person...",
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
                    items: interactionTypes,
                    value: selectedInteractionType,
                    onChanged: (value, label) {
                      selectedInteractionType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Channel",
                    items: channels,
                    value: selectedChannel,
                    onChanged: (value, label) {
                      selectedChannel = value;
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
                        "${filteredList.length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Interactions",
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
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${(totalDuration / 60).toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Total Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${outcomeStats["positive"] ?? 0}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Positive Outcomes",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
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
                        "${outcomeStats["follow_up_required"] ?? 0}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Follow-ups Needed",
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
              children: filteredList.map((interaction) {
                Color typeColor = _getTypeColor(interaction["type"]);
                Color channelColor = _getChannelColor(interaction["channel"]);
                Color outcomeColor = _getOutcomeColor(interaction["outcome"]);
                Color priorityColor = _getPriorityColor(interaction["priority"]);
                
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              _getTypeIcon(interaction["type"]),
                              size: 16,
                              color: typeColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: typeColor.withAlpha(100)),
                            ),
                            child: Text(
                              _getTypeLabel(interaction["type"]),
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
                              color: channelColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: channelColor.withAlpha(100)),
                            ),
                            child: Text(
                              _getChannelLabel(interaction["channel"]),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: channelColor,
                              ),
                            ),
                          ),
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
                                  // Handle edit interaction
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.schedule, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Schedule Follow-up"),
                                  ],
                                ),
                                onTap: () {
                                  // Handle schedule follow-up
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
                                onTap: () => _deleteInteraction(interaction["id"]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Text(
                        "${interaction["subject"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${interaction["contactPerson"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${interaction["notes"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),

                      if ((interaction["tags"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (interaction["tags"] as List).map((tag) {
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

                      Row(
                        children: [
                          if ((interaction["duration"] as int) > 0)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${interaction["duration"]}min",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: outcomeColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${interaction["outcome"]}".toUpperCase().replaceAll('_', ' '),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: outcomeColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(
                            "By ${interaction["performedBy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${DateTime.parse(interaction["timestamp"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      if (interaction["nextAction"].isNotEmpty || interaction["followupDate"].isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: warningColor.withAlpha(100)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              if (interaction["nextAction"].isNotEmpty)
                                Row(
                                  children: [
                                    Icon(Icons.task_alt, size: 14, color: warningColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Next: ${interaction["nextAction"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              if (interaction["followupDate"].isNotEmpty)
                                Row(
                                  children: [
                                    Icon(Icons.schedule, size: 14, color: warningColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Follow-up: ${DateTime.parse(interaction["followupDate"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
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
              }).toList(),
            ),

            if (filteredList.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No interactions found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters or add a new interaction",
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
