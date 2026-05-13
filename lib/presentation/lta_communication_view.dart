import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaCommunicationView extends StatefulWidget {
  const LtaCommunicationView({super.key});

  @override
  State<LtaCommunicationView> createState() => _LtaCommunicationViewState();
}

class _LtaCommunicationViewState extends State<LtaCommunicationView> {
  List<Map<String, dynamic>> conversations = [
    {
      "id": "CONV-001",
      "customerName": "John Smith",
      "customerEmail": "john.smith@email.com",
      "customerPhone": "+1234567890",
      "subject": "Package delivery status inquiry",
      "lastMessage": "Thank you for the update. When can I expect delivery?",
      "lastMessageTime": "2024-03-20T16:30:00",
      "status": "Active",
      "priority": "Medium",
      "assignedTo": "Sarah Johnson",
      "messagesCount": 8,
      "trackingNumber": "LTA123456789",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "unread": true,
    },
    {
      "id": "CONV-002",
      "customerName": "Maria Garcia",
      "customerEmail": "maria.garcia@email.com",
      "customerPhone": "+1234567891",
      "subject": "Damaged package claim",
      "lastMessage": "I've uploaded the photos of the damaged items as requested.",
      "lastMessageTime": "2024-03-20T14:45:00",
      "status": "Pending",
      "priority": "High",
      "assignedTo": "Mike Chen",
      "messagesCount": 12,
      "trackingNumber": "LTA123456790",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=person",
      "unread": false,
    },
    {
      "id": "CONV-003",
      "customerName": "David Wilson",
      "customerEmail": "david.wilson@email.com",
      "customerPhone": "+1234567892",
      "subject": "Billing inquiry - duplicate charge",
      "lastMessage": "The refund has been processed. Thank you for your patience.",
      "lastMessageTime": "2024-03-20T11:20:00",
      "status": "Resolved",
      "priority": "Low",
      "assignedTo": "Lisa Park",
      "messagesCount": 6,
      "trackingNumber": "LTA123456791",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=person",
      "unread": false,
    },
    {
      "id": "CONV-004",
      "customerName": "Emma Thompson",
      "customerEmail": "emma.thompson@email.com",
      "customerPhone": "+1234567893",
      "subject": "Address change request",
      "lastMessage": "Can you update the delivery address before tomorrow?",
      "lastMessageTime": "2024-03-20T18:10:00",
      "status": "Urgent",
      "priority": "High",
      "assignedTo": "Alex Kumar",
      "messagesCount": 4,
      "trackingNumber": "LTA123456792",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=person",
      "unread": true,
    }
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "TEMP-001",
      "name": "Package Delivered",
      "subject": "Your package has been delivered",
      "content": "Dear {customer_name},\n\nWe're pleased to inform you that your package with tracking number {tracking_number} has been successfully delivered.\n\nDelivery details:\n- Date: {delivery_date}\n- Time: {delivery_time}\n- Location: {delivery_location}\n\nThank you for choosing our logistics service.\n\nBest regards,\nLTA Logistics Team",
      "category": "Delivery Updates",
    },
    {
      "id": "TEMP-002",
      "name": "Package Delayed",
      "subject": "Delivery delay notification",
      "content": "Dear {customer_name},\n\nWe apologize for the inconvenience, but your package with tracking number {tracking_number} has been delayed.\n\nReason: {delay_reason}\nNew estimated delivery: {new_delivery_date}\n\nWe're working hard to ensure your package reaches you as soon as possible.\n\nFor any questions, please contact our support team.\n\nBest regards,\nLTA Logistics Team",
      "category": "Delivery Updates",
    },
    {
      "id": "TEMP-003",
      "name": "Damage Report Response",
      "subject": "Re: Damage claim for package {tracking_number}",
      "content": "Dear {customer_name},\n\nThank you for reporting the damage to your package {tracking_number}.\n\nWe have reviewed your claim and the supporting documentation. Our team will process your request within 3-5 business days.\n\nNext steps:\n1. Investigation of the damage\n2. Review of insurance coverage\n3. Processing of compensation if applicable\n\nWe sincerely apologize for any inconvenience caused.\n\nBest regards,\nLTA Claims Team",
      "category": "Claims",
    }
  ];

  List<Map<String, dynamic>> filteredConversations = [];
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedPriority = "All";
  int selectedTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "Resolved", "value": "Resolved"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Critical", "value": "Critical"},
  ];

  @override
  void initState() {
    super.initState();
    _filterConversations();
  }

  void _filterConversations() {
    filteredConversations = conversations.where((conv) {
      bool matchesSearch = conv["customerName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          conv["subject"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          conv["trackingNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || conv["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || conv["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesPriority;
    }).toList();

    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return infoColor;
      case "Pending": return warningColor;
      case "Urgent": return dangerColor;
      case "Resolved": return successColor;
      default: return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical": return dangerColor;
      case "High": return warningColor;
      case "Medium": return infoColor;
      case "Low": return successColor;
      default: return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Communication",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Conversations", icon: Icon(Icons.chat)),
        Tab(text: "Templates", icon: Icon(Icons.message)),
        Tab(text: "Compose", icon: Icon(Icons.edit)),
      ],
      tabChildren: [
        _buildConversationsTab(),
        _buildTemplatesTab(),
        _buildComposeTab(),
      ],
    );
  }

  Widget _buildConversationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                QTextField(
                  label: "Search Conversations",
                  value: searchQuery,
                  hint: "Search by customer, subject, or tracking number",
                  onChanged: (value) {
                    searchQuery = value;
                    _filterConversations();
                  },
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          _filterConversations();
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityOptions,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          _filterConversations();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Conversations", conversations.length.toString(), Icons.chat, primaryColor),
              _buildStatCard("Unread", conversations.where((c) => c["unread"] == true).length.toString(), Icons.mark_chat_unread, warningColor),
              _buildStatCard("Active", conversations.where((c) => c["status"] == "Active").length.toString(), Icons.chat_bubble, infoColor),
              _buildStatCard("Urgent", conversations.where((c) => c["status"] == "Urgent").length.toString(), Icons.priority_high, dangerColor),
            ],
          ),
          SizedBox(height: spMd),

          // Conversations List
          if (filteredConversations.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.chat_bubble_outline, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No conversations found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search criteria",
                    style: TextStyle(color: disabledColor),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredConversations.length,
              itemBuilder: (context, index) {
                final conv = filteredConversations[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: conv["unread"] ? Border.all(color: primaryColor, width: 2) : null,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage("${conv["avatar"]}"),
                              radius: 25,
                            ),
                            if (conv["unread"])
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${conv["customerName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(conv["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${conv["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(conv["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: spXs),
                            Text(
                              "${conv["subject"]}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${conv["lastMessage"]}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: disabledBoldColor),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.schedule, size: 16, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${DateTime.parse(conv["lastMessageTime"]).dMMMy}",
                                  style: TextStyle(color: disabledColor, fontSize: 12),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.message, size: 16, color: disabledColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${conv["messagesCount"]} messages",
                                  style: TextStyle(color: disabledColor, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Tracking: ${conv["trackingNumber"]}",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(conv["priority"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${conv["priority"]} Priority",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _getPriorityColor(conv["priority"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Conversation",
                                    size: bs.sm,
                                    onPressed: () {
                                      conv["unread"] = false;
                                      setState(() {});
                                      si("Opening conversation: ${conv["id"]}");
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.reply,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Replying to conversation: ${conv["id"]}");
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.call,
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Calling customer: ${conv["customerPhone"]}");
                                  },
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
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Template Categories
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Message Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Use pre-defined templates to quickly respond to common customer inquiries.",
                  style: TextStyle(color: disabledBoldColor),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Templates List
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: ExpansionTile(
                  leading: Icon(Icons.message, color: primaryColor),
                  title: Text(
                    "${template["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("${template["category"]}"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subject: ${template["subject"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${template["content"]}",
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Use Template",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Template '${template["name"]}' copied to compose");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {
                                  si("Editing template: ${template["name"]}");
                                },
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

          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Template",
              size: bs.md,
              onPressed: () {
                si("Creating new message template");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposeTab() {
    String recipient = "";
    String subject = "";
    String message = "";
    String selectedTemplate = "";

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Compose Message",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),

            QTextField(
              label: "Recipient Email",
              value: recipient,
              hint: "Enter customer email address",
              onChanged: (value) {
                recipient = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Use Template (Optional)",
              items: [
                {"label": "None", "value": ""},
                ...templates.map((t) => {"label": t["name"], "value": t["id"]}).toList(),
              ],
              value: selectedTemplate,
              onChanged: (value, label) {
                selectedTemplate = value;
                if (value.isNotEmpty) {
                  final template = templates.firstWhere((t) => t["id"] == value);
                  subject = template["subject"];
                  message = template["content"];
                  setState(() {});
                }
              },
            ),
            SizedBox(height: spSm),

            QTextField(
              label: "Subject",
              value: subject,
              hint: "Enter message subject",
              onChanged: (value) {
                subject = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),

            QMemoField(
              label: "Message",
              value: message,
              hint: "Enter your message content...",
              onChanged: (value) {
                message = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Variables:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "{customer_name}, {tracking_number}, {delivery_date}, {delivery_time}, {delivery_location}",
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Send Message",
                    size: bs.md,
                    onPressed: () {
                      if (recipient.isNotEmpty && subject.isNotEmpty && message.isNotEmpty) {
                        ss("Message sent successfully!");
                        // Clear form
                        recipient = "";
                        subject = "";
                        message = "";
                        selectedTemplate = "";
                        setState(() {});
                      } else {
                        se("Please fill in all required fields");
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Save Draft",
                  size: bs.md,
                  onPressed: () {
                    si("Message saved as draft");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
