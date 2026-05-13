import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerCommunicationView extends StatefulWidget {
  const FsmCustomerCommunicationView({super.key});

  @override
  State<FsmCustomerCommunicationView> createState() => _FsmCustomerCommunicationViewState();
}

class _FsmCustomerCommunicationViewState extends State<FsmCustomerCommunicationView> {
  int selectedTab = 0;
  String selectedCustomer = "";
  String messageText = "";
  List<String> attachments = [];
  bool isTyping = false;

  List<Map<String, dynamic>> conversations = [
    {
      "id": "1",
      "customerName": "Sarah Johnson",
      "lastMessage": "Thank you for the update! See you at 2:30 PM.",
      "lastMessageTime": "2:15 PM",
      "unreadCount": 0,
      "isOnline": true,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "serviceType": "HVAC Maintenance",
      "appointmentTime": "2:30 PM",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@email.com",
      "priority": "High"
    },
    {
      "id": "2",
      "customerName": "Mike Rodriguez",
      "lastMessage": "Can we reschedule to next week?",
      "lastMessageTime": "1:45 PM",
      "unreadCount": 2,
      "isOnline": false,
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "serviceType": "Plumbing Repair",
      "appointmentTime": "4:00 PM",
      "phone": "+1 (555) 987-6543",
      "email": "mike.rodriguez@email.com",
      "priority": "Medium"
    },
    {
      "id": "3",
      "customerName": "Lisa Chen",
      "lastMessage": "Perfect, I'll be ready at 5:15 PM.",
      "lastMessageTime": "12:30 PM",
      "unreadCount": 0,
      "isOnline": true,
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "serviceType": "Electrical Inspection",
      "appointmentTime": "5:15 PM",
      "phone": "+1 (555) 456-7890",
      "email": "lisa.chen@email.com",
      "priority": "Low"
    }
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "senderId": "tech",
      "text": "Hi Sarah, I'm on my way to your location for the HVAC maintenance. I should arrive around 2:25 PM.",
      "timestamp": "2:20 PM",
      "type": "text",
      "status": "delivered"
    },
    {
      "id": "2",
      "senderId": "customer",
      "text": "Thank you for the update! See you at 2:30 PM.",
      "timestamp": "2:15 PM",
      "type": "text",
      "status": "read"
    },
    {
      "id": "3",
      "senderId": "tech",
      "text": "Your appointment is confirmed for today at 2:30 PM. Please ensure access to the HVAC unit.",
      "timestamp": "9:00 AM",
      "type": "text",
      "status": "read"
    },
    {
      "id": "4",
      "senderId": "customer",
      "text": "Great! The unit is accessible through the side yard gate. Code is 1234.",
      "timestamp": "9:05 AM",
      "type": "text",
      "status": "read"
    }
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "1",
      "category": "Arrival",
      "title": "On My Way",
      "content": "Hi [Customer], I'm on my way to your location for the [Service]. I should arrive around [Time].",
      "usageCount": 45
    },
    {
      "id": "2",
      "category": "Arrival",
      "title": "Running Late",
      "content": "Hi [Customer], I'm running about [Minutes] minutes behind schedule. I'll be there around [NewTime]. Thank you for your patience.",
      "usageCount": 23
    },
    {
      "id": "3",
      "category": "Completion",
      "title": "Service Complete",
      "content": "Hi [Customer], I've completed the [Service] at your location. Everything is working properly. Please let me know if you have any questions.",
      "usageCount": 78
    },
    {
      "id": "4",
      "category": "Follow-up",
      "title": "Satisfaction Check",
      "content": "Hi [Customer], I hope you're satisfied with the [Service] we completed. If you have any concerns or feedback, please don't hesitate to reach out.",
      "usageCount": 34
    },
    {
      "id": "5",
      "category": "Issues",
      "title": "Additional Work Needed",
      "content": "Hi [Customer], during the [Service], I discovered [Issue]. This will require additional work. Please call me to discuss options.",
      "usageCount": 12
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Communication",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Messages", icon: Icon(Icons.message)),
        Tab(text: "Templates", icon: Icon(Icons.text_snippet)),
        Tab(text: "Contacts", icon: Icon(Icons.contacts)),
      ],
      tabChildren: [
        _buildMessagesTab(),
        _buildTemplatesTab(),
        _buildContactsTab(),
      ],
    );
  }

  Widget _buildMessagesTab() {
    return Row(
      children: [
        // Conversation List
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(right: BorderSide(color: disabledOutlineBorderColor)),
          ),
          child: Column(
            children: [
              // Search Header
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: disabledBoldColor, size: 20),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Search conversations...",
                                style: TextStyle(
                                  fontSize: 14,
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
              // Conversations List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    final conversation = conversations[index];
                    bool isSelected = selectedCustomer == conversation["id"];
                    
                    return GestureDetector(
                      onTap: () {
                        selectedCustomer = conversation["id"] as String;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
                          border: Border(bottom: BorderSide(color: disabledOutlineBorderColor.withAlpha(50))),
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage("${conversation["avatar"]}"),
                                ),
                                if (conversation["isOnline"] as bool)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                              ],
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
                                          "${conversation["customerName"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      if ((conversation["unreadCount"] as int) > 0)
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${conversation["unreadCount"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "${conversation["lastMessage"]}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "${conversation["lastMessageTime"]}",
                                    style: TextStyle(
                                      fontSize: 10,
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
                  },
                ),
              ),
            ],
          ),
        ),
        // Chat Area
        Expanded(
          child: selectedCustomer.isEmpty ? _buildEmptyChat() : _buildChatArea(),
        ),
      ],
    );
  }

  Widget _buildEmptyChat() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "Select a conversation to start chatting",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatArea() {
    final customer = conversations.firstWhere((c) => c["id"] == selectedCustomer);
    
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Chat Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("${customer["avatar"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${customer["customerName"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${customer["serviceType"]} - ${customer["appointmentTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    ss("Calling ${customer["customerName"]}");
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () {
                    ss("Customer details");
                  },
                ),
              ],
            ),
          ),
          // Messages Area
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isFromTech = message["senderId"] == "tech";
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    mainAxisAlignment: isFromTech ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isFromTech) SizedBox(width: 50),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isFromTech ? primaryColor : Colors.grey[200],
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${message["text"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isFromTech ? Colors.white : primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${message["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isFromTech ? Colors.white.withAlpha(180) : disabledBoldColor,
                                    ),
                                  ),
                                  if (isFromTech) ...[
                                    SizedBox(width: spXs),
                                    Icon(
                                      message["status"] == "read" ? Icons.done_all : Icons.done,
                                      size: 12,
                                      color: Colors.white.withAlpha(180),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isFromTech) SizedBox(width: 50),
                    ],
                  ),
                );
              },
            ),
          ),
          // Message Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Row(
              children: [
                QButton(
                  icon: Icons.attach_file,
                  size: bs.sm,
                  onPressed: () {
                    ss("Adding attachment");
                  },
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Type your message...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: disabledBoldColor),
                            ),
                            onChanged: (value) {
                              messageText = value;
                              setState(() {});
                            },
                          ),
                        ),
                        QButton(
                          icon: Icons.emoji_emotions,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening emoji picker");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: () {
                    if (messageText.isNotEmpty) {
                      ss("Message sent");
                      messageText = "";
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
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
        children: [
          // Template Categories
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.text_snippet, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Message Templates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Create New",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {
                        ss("Creating new template");
                      },
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "All",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Arrival",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Completion",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Follow-up",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Templates List
          ...templates.map((template) => _buildTemplateCard(template)),
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
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: disabledBoldColor, size: 20),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Search customers...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.filter_list,
                      size: bs.sm,
                      onPressed: () {
                        ss("Opening filters");
                      },
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "All Customers",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Today's Clients",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Favorites",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Customer Cards
          ...conversations.map((customer) => _buildCustomerCard(customer)),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    Color categoryColor = _getCategoryColor(template["category"] as String);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${template["category"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${template["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "Used ${template["usageCount"]} times",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Text(
              "${template["content"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Use Template",
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: () {
                    ss("Template selected");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  ss("Editing template");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.copy,
                size: bs.sm,
                onPressed: () {
                  ss("Template copied");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    Color priorityColor = _getPriorityColor(customer["priority"] as String);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${customer["avatar"]}"),
                  ),
                  if (customer["isOnline"] as bool)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${customer["customerName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${customer["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${customer["serviceType"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Appointment: ${customer["appointmentTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${customer["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.email, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${customer["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Message",
                  icon: Icons.message,
                  size: bs.sm,
                  onPressed: () {
                    selectedCustomer = customer["id"] as String;
                    selectedTab = 0;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Call",
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    ss("Calling ${customer["customerName"]}");
                  },
                ),
              ),
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () {
                  ss("Customer details");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'arrival': return primaryColor;
      case 'completion': return successColor;
      case 'follow-up': return infoColor;
      case 'issues': return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high': return dangerColor;
      case 'medium': return warningColor;
      case 'low': return successColor;
      default: return disabledBoldColor;
    }
  }
}
