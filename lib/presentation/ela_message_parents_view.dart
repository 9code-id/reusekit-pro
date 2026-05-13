import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaMessageParentsView extends StatefulWidget {
  const ElaMessageParentsView({super.key});

  @override
  State<ElaMessageParentsView> createState() => _ElaMessageParentsViewState();
}

class _ElaMessageParentsViewState extends State<ElaMessageParentsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  String messageText = "";
  String selectedRecipient = "";
  String selectedSubject = "";
  List<String> selectedParents = [];
  List<String> attachments = [];

  List<Map<String, dynamic>> conversations = [
    {
      "id": 1,
      "parentName": "Mrs. Sarah Johnson",
      "studentName": "Emma Johnson",
      "lastMessage": "Thank you for the update on Emma's progress in mathematics. We'll work on the homework together at home.",
      "lastMessageDate": "2024-03-15T14:30:00Z",
      "isRead": true,
      "messageCount": 5,
      "priority": "normal",
      "subject": "Mathematics Progress",
      "parentAvatar": "https://picsum.photos/100/100?random=1",
      "unreadCount": 0
    },
    {
      "id": 2,
      "parentName": "Mr. David Chen",
      "studentName": "Alex Chen",
      "lastMessage": "I wanted to discuss Alex's behavior incident yesterday. Could we schedule a meeting?",
      "lastMessageDate": "2024-03-15T11:20:00Z",
      "isRead": false,
      "messageCount": 3,
      "priority": "high",
      "subject": "Behavior Discussion",
      "parentAvatar": "https://picsum.photos/100/100?random=2",
      "unreadCount": 2
    },
    {
      "id": 3,
      "parentName": "Mrs. Lisa Rodriguez",
      "studentName": "Sofia Rodriguez",
      "lastMessage": "Sofia mentioned the upcoming science fair. Could you provide more details about the requirements?",
      "lastMessageDate": "2024-03-14T16:45:00Z",
      "isRead": true,
      "messageCount": 8,
      "priority": "normal",
      "subject": "Science Fair Inquiry",
      "parentAvatar": "https://picsum.photos/100/100?random=3",
      "unreadCount": 0
    },
    {
      "id": 4,
      "parentName": "Mr. James Wilson",
      "studentName": "Tyler Wilson",
      "lastMessage": "Tyler has been struggling with reading comprehension. Any suggestions for home practice?",
      "lastMessageDate": "2024-03-14T09:15:00Z",
      "isRead": false,
      "messageCount": 4,
      "priority": "medium",
      "subject": "Reading Support",
      "parentAvatar": "https://picsum.photos/100/100?random=4",
      "unreadCount": 1
    },
    {
      "id": 5,
      "parentName": "Mrs. Amanda Thompson",
      "studentName": "Grace Thompson",
      "lastMessage": "Grace is very excited about the art project. Thank you for encouraging her creativity!",
      "lastMessageDate": "2024-03-13T13:30:00Z",
      "isRead": true,
      "messageCount": 12,
      "priority": "normal",
      "subject": "Art Project Appreciation",
      "parentAvatar": "https://picsum.photos/100/100?random=5",
      "unreadCount": 0
    }
  ];

  List<Map<String, dynamic>> parentContacts = [
    {
      "name": "Mrs. Sarah Johnson",
      "student": "Emma Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1-555-0101",
      "class": "Grade 5A",
      "avatar": "https://picsum.photos/100/100?random=1"
    },
    {
      "name": "Mr. David Chen",
      "student": "Alex Chen", 
      "email": "david.chen@email.com",
      "phone": "+1-555-0102",
      "class": "Grade 5A",
      "avatar": "https://picsum.photos/100/100?random=2"
    },
    {
      "name": "Mrs. Lisa Rodriguez",
      "student": "Sofia Rodriguez",
      "email": "lisa.rodriguez@email.com",
      "phone": "+1-555-0103",
      "class": "Grade 5B",
      "avatar": "https://picsum.photos/100/100?random=3"
    },
    {
      "name": "Mr. James Wilson",
      "student": "Tyler Wilson",
      "email": "james.wilson@email.com",
      "phone": "+1-555-0104",
      "class": "Grade 5A",
      "avatar": "https://picsum.photos/100/100?random=4"
    },
    {
      "name": "Mrs. Amanda Thompson",
      "student": "Grace Thompson",
      "email": "amanda.thompson@email.com",
      "phone": "+1-555-0105",
      "class": "Grade 5B",
      "avatar": "https://picsum.photos/100/100?random=5"
    }
  ];

  List<Map<String, dynamic>> messageTemplates = [
    {
      "title": "Weekly Progress Update",
      "subject": "Weekly Progress Report for [Student Name]",
      "content": "Dear [Parent Name],\n\nI hope this message finds you well. I wanted to provide you with an update on [Student Name]'s progress this week.\n\nAcademic Performance:\n- [Subject]: [Performance notes]\n- [Subject]: [Performance notes]\n\nBehavior and Participation:\n- [Behavior notes]\n\nUpcoming Events:\n- [Event details]\n\nPlease feel free to reach out if you have any questions or concerns.\n\nBest regards,\n[Teacher Name]"
    },
    {
      "title": "Assignment Reminder",
      "subject": "Assignment Reminder - [Assignment Name]",
      "content": "Dear [Parent Name],\n\nThis is a friendly reminder that [Student Name] has an upcoming assignment due on [Due Date].\n\nAssignment Details:\n- Subject: [Subject]\n- Description: [Assignment description]\n- Requirements: [Requirements]\n\nIf [Student Name] needs any assistance, please don't hesitate to contact me.\n\nThank you for your support!\n\nBest regards,\n[Teacher Name]"
    },
    {
      "title": "Meeting Request",
      "subject": "Meeting Request - [Student Name]",
      "content": "Dear [Parent Name],\n\nI would like to schedule a meeting to discuss [Student Name]'s progress and development.\n\nProposed Meeting Details:\n- Purpose: [Meeting purpose]\n- Duration: Approximately 30 minutes\n- Availability: [Your available times]\n\nPlease let me know what time works best for you.\n\nLooking forward to our conversation.\n\nBest regards,\n[Teacher Name]"
    }
  ];

  List<Map<String, dynamic>> get filteredConversations {
    var filtered = conversations.where((conversation) {
      bool matchesSearch = conversation["parentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          conversation["studentName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          conversation["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" ||
                          (selectedFilter == "Unread" && !(conversation["isRead"] as bool)) ||
                          (selectedFilter == "High Priority" && conversation["priority"] == "high") ||
                          (selectedFilter == "Recent" && DateTime.parse(conversation["lastMessageDate"]).isAfter(DateTime.now().subtract(Duration(days: 1))));
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    filtered.sort((a, b) => DateTime.parse(b["lastMessageDate"]).compareTo(DateTime.parse(a["lastMessageDate"])));
    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "normal":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Parent Messages",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Conversations", icon: Icon(Icons.chat)),
        Tab(text: "Compose", icon: Icon(Icons.edit)),
        Tab(text: "Contacts", icon: Icon(Icons.contacts)),
      ],
      tabChildren: [
        _buildConversationsTab(),
        _buildComposeTab(),
        _buildContactsTab(),
      ],
    );
  }

  Widget _buildConversationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search conversations...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.filter_list,
                      size: bs.sm,
                      onPressed: () => _showFilterDialog(),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Filter by",
                  items: [
                    {"label": "All Conversations", "value": "All"},
                    {"label": "Unread Messages", "value": "Unread"},
                    {"label": "High Priority", "value": "High Priority"},
                    {"label": "Recent (24h)", "value": "Recent"},
                  ],
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Statistics
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    "Total",
                    "${conversations.length}",
                    Icons.chat,
                    primaryColor,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    "Unread",
                    "${conversations.where((c) => !(c["isRead"] as bool)).length}",
                    Icons.mark_chat_unread,
                    warningColor,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    "Priority",
                    "${conversations.where((c) => c["priority"] == "high").length}",
                    Icons.priority_high,
                    dangerColor,
                  ),
                ),
              ],
            ),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.message, color: primaryColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Stay connected with parents and guardians",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                QButton(
                  label: "New Message",
                  size: bs.sm,
                  onPressed: () {
                    currentTab = 1;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Conversations List
          ...filteredConversations.map((conversation) => _buildConversationCard(conversation)),
        ],
      ),
    );
  }

  Widget _buildComposeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Compose Form
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.edit, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Compose New Message",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                QDropdownField(
                  label: "Select Parent/Guardian",
                  items: parentContacts.map((parent) => {
                    "label": "${parent["name"]} (${parent["student"]})",
                    "value": parent["name"],
                  }).toList(),
                  value: selectedRecipient,
                  onChanged: (value, label) {
                    selectedRecipient = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Subject",
                  value: selectedSubject,
                  onChanged: (value) {
                    selectedSubject = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Message",
                  value: messageText,
                  hint: "Type your message here...",
                  onChanged: (value) {
                    messageText = value;
                    setState(() {});
                  },
                ),
                
                QAttachmentPicker(
                  label: "Attachments",
                  value: attachments,
                  hint: "Add files to your message",
                  maxAttachments: 5,
                  onChanged: (value) {
                    attachments = value;
                    setState(() {});
                  },
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Save as Draft",
                        size: bs.md,
                        onPressed: () => _saveDraft(),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Send Message",
                        size: bs.md,
                        onPressed: () => _sendMessage(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Message Templates
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.description, color: infoColor),
                    SizedBox(width: spSm),
                    Text(
                      "Message Templates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Use pre-made templates to save time",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                ...messageTemplates.map((template) => _buildTemplateCard(template)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search Contacts
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search parent contacts...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Contact Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.contacts, color: successColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${parentContacts.length} parent contacts available",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contacts List
          ...parentContacts.map((contact) => _buildContactCard(contact)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationCard(Map<String, dynamic> conversation) {
    bool isUnread = !(conversation["isRead"] as bool);
    DateTime lastMessageDate = DateTime.parse(conversation["lastMessageDate"]);
    int unreadCount = conversation["unreadCount"] as int;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isUnread ? Border.all(color: primaryColor.withAlpha(100), width: 1) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusSm),
          onTap: () => _openConversation(conversation),
          child: Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(conversation["parentAvatar"]),
                ),
                SizedBox(width: spSm),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${conversation["parentName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(conversation["priority"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${conversation["priority"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: _getPriorityColor(conversation["priority"]),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "Student: ${conversation["studentName"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      Text(
                        "${conversation["subject"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: infoColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      Text(
                        "${conversation["lastMessage"]}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      Row(
                        children: [
                          Text(
                            lastMessageDate.dMMMy,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${conversation["messageCount"]} messages",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (unreadCount > 0) ...[
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$unreadCount",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      margin: EdgeInsets.only(top: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusXs),
          onTap: () => _useTemplate(template),
          child: Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${template["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${template["content"]}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(contact["avatar"]),
            ),
            SizedBox(width: spSm),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "${contact["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Student: ${contact["student"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${contact["class"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, size: 12, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${contact["email"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Column(
              spacing: spXs,
              children: [
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  onPressed: () => _messageContact(contact),
                ),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () => _callContact(contact),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    // Show filter options
  }

  void _openConversation(Map<String, dynamic> conversation) {
    conversation["isRead"] = true;
    setState(() {});
    // Navigate to conversation detail
  }

  void _saveDraft() {
    if (messageText.isNotEmpty) {
      ss("Message saved as draft");
    } else {
      se("Please enter a message to save");
    }
  }

  void _sendMessage() async {
    if (selectedRecipient.isEmpty) {
      se("Please select a recipient");
      return;
    }
    if (selectedSubject.isEmpty) {
      se("Please enter a subject");
      return;
    }
    if (messageText.isEmpty) {
      se("Please enter a message");
      return;
    }

    bool isConfirmed = await confirm("Send message to $selectedRecipient?");
    if (isConfirmed) {
      // Clear form
      selectedRecipient = "";
      selectedSubject = "";
      messageText = "";
      attachments = [];
      setState(() {});
      
      ss("Message sent successfully");
      
      // Switch to conversations tab
      currentTab = 0;
      setState(() {});
    }
  }

  void _useTemplate(Map<String, dynamic> template) {
    selectedSubject = template["subject"];
    messageText = template["content"];
    setState(() {});
    ss("Template applied");
  }

  void _messageContact(Map<String, dynamic> contact) {
    selectedRecipient = contact["name"];
    currentTab = 1;
    setState(() {});
  }

  void _callContact(Map<String, dynamic> contact) {
    // Initiate phone call
    ss("Calling ${contact["name"]}...");
  }
}
