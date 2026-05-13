import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestMessagingView extends StatefulWidget {
  const HhaGuestMessagingView({super.key});

  @override
  State<HhaGuestMessagingView> createState() => _HhaGuestMessagingViewState();
}

class _HhaGuestMessagingViewState extends State<HhaGuestMessagingView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedDepartment = "All";
  String selectedRoom = "All";
  String messageText = "";
  String selectedConversation = "";
  
  List<Map<String, dynamic>> statusOptions = [
    {
      "label": "All Status",
      "value": "All",
    },
    {
      "label": "Active",
      "value": "active",
    },
    {
      "label": "Pending",
      "value": "pending",
    },
    {
      "label": "Resolved",
      "value": "resolved",
    },
    {
      "label": "Closed",
      "value": "closed",
    },
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {
      "label": "All Departments",
      "value": "All",
    },
    {
      "label": "Front Desk",
      "value": "front_desk",
    },
    {
      "label": "Housekeeping",
      "value": "housekeeping",
    },
    {
      "label": "Maintenance",
      "value": "maintenance",
    },
    {
      "label": "Concierge",
      "value": "concierge",
    },
    {
      "label": "Room Service",
      "value": "room_service",
    },
  ];

  List<Map<String, dynamic>> roomOptions = [
    {
      "label": "All Rooms",
      "value": "All",
    },
    {
      "label": "Room 101",
      "value": "101",
    },
    {
      "label": "Room 102",
      "value": "102",
    },
    {
      "label": "Room 201",
      "value": "201",
    },
    {
      "label": "Room 305",
      "value": "305",
    },
  ];

  List<Map<String, dynamic>> conversations = [
    {
      "id": "conv_001",
      "guest_name": "John Smith",
      "room_number": "305",
      "check_in_date": "2024-12-10",
      "check_out_date": "2024-12-18",
      "status": "active",
      "priority": "high",
      "department": "maintenance",
      "last_message": "The air conditioning in my room is still not working properly. It's quite warm.",
      "last_message_time": "2024-12-15T14:30:00",
      "last_sender": "guest",
      "unread_count": 2,
      "created_at": "2024-12-15T10:15:00",
      "assigned_to": "Mike Rodriguez",
    },
    {
      "id": "conv_002",
      "guest_name": "Emily Johnson",
      "room_number": "201",
      "check_in_date": "2024-12-12",
      "check_out_date": "2024-12-20",
      "status": "pending",
      "priority": "normal",
      "department": "housekeeping",
      "last_message": "Could I get extra towels and pillows for tonight?",
      "last_message_time": "2024-12-15T13:20:00",
      "last_sender": "guest",
      "unread_count": 1,
      "created_at": "2024-12-15T13:20:00",
      "assigned_to": "Lisa Chen",
    },
    {
      "id": "conv_003",  
      "guest_name": "Michael Chen",
      "room_number": "102",
      "check_in_date": "2024-12-11",
      "check_out_date": "2024-12-16",
      "status": "resolved",
      "priority": "low",
      "department": "concierge",
      "last_message": "Thank you for the restaurant recommendations! We had a wonderful dinner.",
      "last_message_time": "2024-12-14T19:45:00",
      "last_sender": "guest",
      "unread_count": 0,
      "created_at": "2024-12-14T16:30:00",
      "assigned_to": "Sarah Johnson",
    },
    {
      "id": "conv_004",
      "guest_name": "Sarah Williams",
      "room_number": "101",
      "check_in_date": "2024-12-13",
      "check_out_date": "2024-12-17",
      "status": "active",
      "priority": "normal",
      "department": "room_service",
      "last_message": "I'd like to order breakfast for tomorrow morning at 8 AM.",
      "last_message_time": "2024-12-15T20:15:00",
      "last_sender": "guest",
      "unread_count": 1,
      "created_at": "2024-12-15T20:15:00",
      "assigned_to": "David Brown",
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": "msg_001",
      "conversation_id": "conv_001",
      "sender": "guest",
      "sender_name": "John Smith",
      "message": "Hello, the air conditioning in my room is not working properly. It's quite warm and uncomfortable.",
      "timestamp": "2024-12-15T10:15:00",
      "message_type": "text",
      "is_read": true,
    },
    {
      "id": "msg_002",
      "conversation_id": "conv_001",
      "sender": "staff",
      "sender_name": "Mike Rodriguez",
      "message": "Hello Mr. Smith, I apologize for the inconvenience. I'm from maintenance and I'll be right up to check the AC unit in your room.",
      "timestamp": "2024-12-15T10:30:00",
      "message_type": "text",
      "is_read": true,
    },
    {
      "id": "msg_003",
      "conversation_id": "conv_001",
      "sender": "guest",  
      "sender_name": "John Smith",
      "message": "Thank you for the quick response. I'll be in the room for the next hour.",
      "timestamp": "2024-12-15T10:35:00",
      "message_type": "text",
      "is_read": true,
    },
    {
      "id": "msg_004",
      "conversation_id": "conv_001",
      "sender": "staff",
      "sender_name": "Mike Rodriguez",
      "message": "I've checked the unit and made the necessary adjustments. It should be cooling down within the next 15 minutes. Please let me know if you need anything else.",
      "timestamp": "2024-12-15T11:45:00",
      "message_type": "text",
      "is_read": true,
    },
    {
      "id": "msg_005", 
      "conversation_id": "conv_001",
      "sender": "guest",
      "sender_name": "John Smith",
      "message": "The air conditioning in my room is still not working properly. It's quite warm.",
      "timestamp": "2024-12-15T14:30:00",
      "message_type": "text",
      "is_read": false,
    },
  ];

  List<Map<String, dynamic>> get filteredConversations {
    return conversations.where((conv) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${conv["guest_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${conv["room_number"]}".contains(searchQuery) ||
          "${conv["last_message"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || conv["status"] == selectedStatus;
      bool matchesDepartment = selectedDepartment == "All" || conv["department"] == selectedDepartment;
      bool matchesRoom = selectedRoom == "All" || conv["room_number"] == selectedRoom;
      
      return matchesSearch && matchesStatus && matchesDepartment && matchesRoom;
    }).toList();
  }

  List<Map<String, dynamic>> get currentMessages {
    if (selectedConversation.isEmpty) return [];
    return messages.where((msg) => msg["conversation_id"] == selectedConversation).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "resolved":
        return infoColor;
      case "closed":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "normal":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Messaging"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Open search
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Conversations List Panel
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Search and Filters
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    spacing: spXs,
                    children: [
                      QTextField(
                        label: "Search conversations...",
                        value: searchQuery,
                        hint: "Search by guest name, room, or message",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                      Row(
                        children: [
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
                          SizedBox(width: spXs),
                          Expanded(
                            child: QDropdownField(
                              label: "Department",
                              items: departmentOptions,
                              value: selectedDepartment,
                              onChanged: (value, label) {
                                selectedDepartment = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Statistics Summary
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${conversations.length}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${conversations.where((c) => c["status"] == "pending").length}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Pending",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${conversations.where((c) => c["status"] == "active").length}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spSm),

                // Conversations List
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredConversations.length,
                    itemBuilder: (context, index) {
                      final conversation = filteredConversations[index];
                      final isSelected = selectedConversation == conversation["id"];
                      
                      return GestureDetector(
                        onTap: () {
                          selectedConversation = "${conversation["id"]}";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                color: disabledOutlineBorderColor.withAlpha(50),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              // Guest Info and Status
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: primaryColor.withAlpha(30),
                                    child: Text(
                                      "${conversation["guest_name"]}".split(' ').map((name) => name[0]).join(''),
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
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
                                                "${conversation["guest_name"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                              decoration: BoxDecoration(
                                                color: _getStatusColor("${conversation["status"]}").withAlpha(30),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "${conversation["status"]}".toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: _getStatusColor("${conversation["status"]}"),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Room ${conversation["room_number"]} • ${conversation["department"]}".replaceAll('_', ' '),
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

                              // Last Message
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${conversation["last_message"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              // Time and Unread Count
                              Row(
                                children: [
                                  Text(
                                    DateTime.parse("${conversation["last_message_time"]}").dMMMykkss,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
                                    ),
                                  ),
                                  Spacer(),
                                  if ((conversation["unread_count"] as int) > 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Text(
                                        "${conversation["unread_count"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${conversation["priority"]}").withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${conversation["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: _getPriorityColor("${conversation["priority"]}"),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
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

          // Messages Panel
          Expanded(
            child: selectedConversation.isEmpty
                ? Container(
                    color: Colors.grey[50],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Select a conversation to start messaging",
                            style: TextStyle(
                              fontSize: fsH6,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Choose a guest conversation from the list to view and respond to messages",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    color: Colors.grey[50],
                    child: Column(
                      children: [
                        // Chat Header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: primaryColor.withAlpha(30),
                                child: Text(
                                  conversations.firstWhere((c) => c["id"] == selectedConversation)["guest_name"].split(' ').map((name) => name[0]).join(''),
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          conversations.firstWhere((c) => c["id"] == selectedConversation)["guest_name"],
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor("${conversations.firstWhere((c) => c["id"] == selectedConversation)["status"]}").withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${conversations.firstWhere((c) => c["id"] == selectedConversation)["status"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: _getStatusColor("${conversations.firstWhere((c) => c["id"] == selectedConversation)["status"]}"),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Room ${conversations.firstWhere((c) => c["id"] == selectedConversation)["room_number"]} • Check-out: ${DateTime.parse("${conversations.firstWhere((c) => c["id"] == selectedConversation)["check_out_date"]}").dMMMy}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: Icons.info,
                                size: bs.sm,
                                onPressed: () {
                                  // Show guest info
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show more options
                                },
                              ),
                            ],
                          ),
                        ),

                        // Messages Area
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(spSm),
                            itemCount: currentMessages.length,
                            itemBuilder: (context, index) {
                              final message = currentMessages[index];
                              final isStaffMessage = message["sender"] == "staff";
                              
                              return Container(
                                margin: EdgeInsets.only(bottom: spSm),
                                child: Row(
                                  mainAxisAlignment: isStaffMessage 
                                      ? MainAxisAlignment.end 
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isStaffMessage) ...[
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: infoColor.withAlpha(30),
                                        child: Icon(
                                          Icons.person,
                                          color: infoColor,
                                          size: 16,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                    ],
                                    
                                    Flexible(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                                        ),
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: isStaffMessage 
                                              ? primaryColor 
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(radiusMd),
                                          boxShadow: [shadowSm],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${message["sender_name"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: isStaffMessage 
                                                    ? Colors.white.withAlpha(200)
                                                    : infoColor,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "${message["message"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isStaffMessage 
                                                    ? Colors.white 
                                                    : disabledBoldColor,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              DateTime.parse("${message["timestamp"]}").dMMMy + " " + 
                                              DateTime.parse("${message["timestamp"]}").hour.toString().padLeft(2, '0') + ":" +
                                              DateTime.parse("${message["timestamp"]}").minute.toString().padLeft(2, '0'),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: isStaffMessage 
                                                    ? Colors.white.withAlpha(150)
                                                    : disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    
                                    if (isStaffMessage) ...[
                                      SizedBox(width: spXs),
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: primaryColor.withAlpha(30),
                                        child: Icon(
                                          Icons.support_agent,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        // Message Input
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            spacing: spXs,
                            children: [
                              // Quick Actions
                              Row(
                                children: [
                                  QButton(
                                    label: "Resolve",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Mark as resolved
                                      ss("Conversation marked as resolved");
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    label: "Transfer",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Transfer to another department
                                    },
                                  ),
                                  Spacer(),
                                  Text(
                                    "Assigned to: ${conversations.firstWhere((c) => c["id"] == selectedConversation)["assigned_to"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              // Message Input Row
                              Row(
                                children: [
                                  QButton(
                                    icon: Icons.attach_file,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Attach file
                                    },
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QTextField(
                                      label: "Type your response...",
                                      value: messageText,
                                      hint: "Type your message to the guest",
                                      onChanged: (value) {
                                        messageText = value;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.send,
                                    size: bs.sm,
                                    onPressed: () {
                                      if (messageText.trim().isNotEmpty) {
                                        // Send message
                                        messageText = "";
                                        setState(() {});
                                        ss("Message sent to guest!");
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
