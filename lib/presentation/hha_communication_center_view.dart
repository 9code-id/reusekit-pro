import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaCommunicationCenterView extends StatefulWidget {
  const HhaCommunicationCenterView({super.key});

  @override
  State<HhaCommunicationCenterView> createState() => _HhaCommunicationCenterViewState();
}

class _HhaCommunicationCenterViewState extends State<HhaCommunicationCenterView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPriority = "All";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> priorityOptions = [
    {
      "label": "All Priority",
      "value": "All",
    },
    {
      "label": "Urgent",
      "value": "urgent",
    },
    {
      "label": "High",
      "value": "high",
    },
    {
      "label": "Normal",
      "value": "normal",
    },
    {
      "label": "Low",
      "value": "low",
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {
      "label": "All Categories",
      "value": "All",
    },
    {
      "label": "General",
      "value": "general",
    },
    {
      "label": "Maintenance",
      "value": "maintenance",
    },
    {
      "label": "Guest Services",
      "value": "guest_services",
    },
    {
      "label": "Safety",
      "value": "safety",
    },
    {
      "label": "Training",
      "value": "training",
    },
  ];

  List<Map<String, dynamic>> announcements = [
    {
      "id": "ANN001",
      "title": "New Check-in Procedures Effective Immediately",
      "message": "Please note the updated check-in procedures for all guests. All front desk staff must verify guest identification and confirm reservation details before issuing room keys.",
      "category": "guest_services",
      "priority": "urgent",
      "sender": "Maria Santos",
      "sender_role": "Front Office Manager",
      "created_at": "2024-12-15T09:30:00",
      "is_pinned": true,
      "read_by": 12,
      "total_recipients": 25,
      "attachments": [
        {
          "name": "check_in_procedures.pdf",
          "type": "document",
          "url": "#"
        }
      ]
    },
    {
      "id": "ANN002",
      "title": "Fire Safety Drill Schedule - December 2024",
      "message": "Monthly fire safety drill scheduled for December 20th at 2:00 PM. All staff must participate. Guests will be notified in advance.",
      "category": "safety",
      "priority": "high",
      "sender": "John Wilson",
      "sender_role": "Safety Coordinator",
      "created_at": "2024-12-14T14:15:00",
      "is_pinned": false,
      "read_by": 18,
      "total_recipients": 25,
      "attachments": []
    },
    {
      "id": "ANN003",
      "title": "Housekeeping Supplies Inventory Update",
      "message": "New housekeeping supplies have arrived. Please update your inventory sheets and collect new cleaning products from the storage room.",
      "category": "maintenance",
      "priority": "normal",
      "sender": "Lisa Chen",
      "sender_role": "Housekeeping Supervisor",
      "created_at": "2024-12-13T11:45:00",
      "is_pinned": false,
      "read_by": 8,
      "total_recipients": 15,
      "attachments": [
        {
          "name": "supply_list.xlsx",
          "type": "document",
          "url": "#"
        }
      ]
    },
    {
      "id": "ANN004",
      "title": "Customer Service Training Workshop",
      "message": "Mandatory customer service training workshop scheduled for all guest-facing staff on December 22nd from 10:00 AM to 12:00 PM in Conference Room A.",
      "category": "training",
      "priority": "high",
      "sender": "David Brown",
      "sender_role": "Training Manager",
      "created_at": "2024-12-12T16:20:00",
      "is_pinned": true,
      "read_by": 20,
      "total_recipients": 25,
      "attachments": []
    },
    {
      "id": "ANN005",
      "title": "Holiday Schedule and Staffing Updates",
      "message": "Please review the holiday schedule and staffing assignments. Additional shifts are available for those interested in overtime pay.",
      "category": "general",
      "priority": "normal",
      "sender": "Sarah Johnson",
      "sender_role": "HR Manager",
      "created_at": "2024-12-11T13:30:00",
      "is_pinned": false,
      "read_by": 22,
      "total_recipients": 25,
      "attachments": [
        {
          "name": "holiday_schedule.pdf",
          "type": "document",
          "url": "#"
        }
      ]
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": "MSG001",
      "sender": "Maria Santos",
      "sender_role": "Front Office Manager",
      "recipient": "All Staff",
      "subject": "Room 305 - Maintenance Required",
      "message": "Please note that Room 305 requires immediate maintenance attention. AC unit is not working properly. Please mark as out of order until fixed.",
      "priority": "urgent",
      "category": "maintenance",
      "created_at": "2024-12-15T10:15:00",
      "is_read": false,
      "has_attachments": false,
    },
    {
      "id": "MSG002",
      "sender": "John Wilson",
      "sender_role": "Maintenance Technician",
      "recipient": "Housekeeping Team",
      "subject": "Pool Area Cleaning Schedule",
      "message": "Pool maintenance completed. Area is now ready for regular housekeeping. Please resume normal cleaning schedule starting tomorrow.",
      "priority": "normal",
      "category": "maintenance",
      "created_at": "2024-12-14T16:45:00",
      "is_read": true,
      "has_attachments": false,
    },
    {
      "id": "MSG003",
      "sender": "Lisa Chen",
      "sender_role": "Guest Relations",
      "recipient": "Front Desk Team",
      "subject": "VIP Guest Arrival - Special Instructions",
      "message": "VIP guest arriving tomorrow evening. Please ensure room upgrade and welcome amenities are prepared. Contact me for specific requirements.",
      "priority": "high",
      "category": "guest_services",
      "created_at": "2024-12-13T14:20:00",
      "is_read": true,
      "has_attachments": true,
    },
    {
      "id": "MSG004",
      "sender": "David Brown",
      "sender_role": "Security",
      "recipient": "All Departments",
      "subject": "Parking Lot Security Camera Update",
      "message": "New security cameras installed in parking lot. Coverage now includes all guest and staff parking areas. System is fully operational.",
      "priority": "normal",
      "category": "safety",
      "created_at": "2024-12-12T09:30:00",
      "is_read": false,
      "has_attachments": false,
    },
  ];

  List<Map<String, dynamic>> get filteredAnnouncements {
    return announcements.where((ann) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${ann["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${ann["message"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority == "All" || ann["priority"] == selectedPriority;
      bool matchesCategory = selectedCategory == "All" || ann["category"] == selectedCategory;
      
      return matchesSearch && matchesPriority && matchesCategory;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredMessages {
    return messages.where((msg) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${msg["subject"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${msg["message"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${msg["sender"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority == "All" || msg["priority"] == selectedPriority;
      bool matchesCategory = selectedCategory == "All" || msg["category"] == selectedCategory;
      
      return matchesSearch && matchesPriority && matchesCategory;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      case "normal":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case "urgent":
        return Icons.priority_high;
      case "high":
        return Icons.keyboard_arrow_up;
      case "normal":
        return Icons.remove;
      case "low":
        return Icons.keyboard_arrow_down;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Communication Center",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Announcements", icon: Icon(Icons.campaign)),
        Tab(text: "Messages", icon: Icon(Icons.message)),
        Tab(text: "Compose", icon: Icon(Icons.edit)),
      ],
      tabChildren: [
        // Announcements Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Search and Filters
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Search announcements...",
                      value: searchQuery,
                      hint: "Search by title or message content",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityOptions,
                            value: selectedPriority,
                            onChanged: (value, label) {
                              selectedPriority = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categoryOptions,
                            value: selectedCategory,
                            onChanged: (value, label) {
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Statistics
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
                          Icon(
                            Icons.campaign,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${announcements.length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                          Icon(
                            Icons.push_pin,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${announcements.where((a) => a["is_pinned"] == true).length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Pinned",
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

              // Announcements List
              ...filteredAnnouncements.map((announcement) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: announcement["is_pinned"] == true
                        ? Border.all(color: warningColor, width: 1)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header
                      Row(
                        children: [
                          if (announcement["is_pinned"] == true)
                            Icon(
                              Icons.push_pin,
                              size: 16,
                              color: warningColor,
                            ),
                          if (announcement["is_pinned"] == true)
                            SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${announcement["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${announcement["priority"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getPriorityIcon("${announcement["priority"]}"),
                                  size: 12,
                                  color: _getPriorityColor("${announcement["priority"]}"),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${announcement["priority"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getPriorityColor("${announcement["priority"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Sender Info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: primaryColor.withAlpha(30),
                            child: Text(
                              "${announcement["sender"]}".split(' ').map((name) => name[0]).join(''),
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
                                Text(
                                  "${announcement["sender"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${announcement["sender_role"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            DateTime.parse("${announcement["created_at"]}").dMMMykkss,
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Message
                      Text(
                        "${announcement["message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      // Attachments
                      if ((announcement["attachments"] as List).isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.attach_file,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${(announcement["attachments"] as List).length} attachment(s)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              QButton(
                                label: "View",
                                size: bs.sm,
                                onPressed: () {
                                  // View attachments
                                },
                              ),
                            ],
                          ),
                        ),

                      // Read Statistics
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Read by ${announcement["read_by"]}/${announcement["total_recipients"]} recipients",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // Show more options
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),

              if (filteredAnnouncements.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.campaign,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No announcements found",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        // Messages Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Search and Filters (reuse the same component)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Search messages...",
                      value: searchQuery,
                      hint: "Search by subject, sender, or content",
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityOptions,
                            value: selectedPriority,
                            onChanged: (value, label) {
                              selectedPriority = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Category",
                            items: categoryOptions,
                            value: selectedCategory,
                            onChanged: (value, label) {
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),  
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Messages List
              ...filteredMessages.map((message) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: !message["is_read"]
                        ? Border.all(color: primaryColor, width: 1)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header
                      Row(
                        children: [
                          if (!message["is_read"])
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          if (!message["is_read"])
                            SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${message["subject"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: message["is_read"] ? FontWeight.w600 : FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${message["priority"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getPriorityIcon("${message["priority"]}"),
                                  size: 12,
                                  color: _getPriorityColor("${message["priority"]}"),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${message["priority"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getPriorityColor("${message["priority"]}"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Sender and Recipient
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: primaryColor.withAlpha(30),
                            child: Text(
                              "${message["sender"]}".split(' ').map((name) => name[0]).join(''),
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
                                Text(
                                  "${message["sender"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "To: ${message["recipient"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                DateTime.parse("${message["created_at"]}").dMMMykkss,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (message["has_attachments"])
                                Icon(
                                  Icons.attach_file,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                            ],
                          ),
                        ],
                      ),

                      // Message Preview
                      Text(
                        "${message["message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Read Message",
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to message details
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.reply,
                            size: bs.sm,
                            onPressed: () {
                              // Reply to message
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
                    ],
                  ),
                );
              }).toList(),

              if (filteredMessages.isEmpty)
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
                        "No messages found",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        // Compose Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Compose New Message",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QDropdownField(
                  label: "Message Type",
                  items: [
                    {"label": "Announcement", "value": "announcement"},
                    {"label": "Direct Message", "value": "message"},
                  ],
                  value: "announcement",
                  onChanged: (value, label) {
                    // Handle message type change
                  },
                ),

                QTextField(
                  label: "Subject",
                  value: "",
                  hint: "Enter message subject",
                  onChanged: (value) {
                    // Handle subject change
                  },
                ),

                QDropdownField(
                  label: "Recipients",
                  items: [
                    {"label": "All Staff", "value": "all"},
                    {"label": "Front Desk Team", "value": "front_desk"},
                    {"label": "Housekeeping Team", "value": "housekeeping"},
                    {"label": "Maintenance Team", "value": "maintenance"},
                    {"label": "Management", "value": "management"},
                  ],
                  value: "all",
                  onChanged: (value, label) {
                    // Handle recipients change
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityOptions.where((p) => p["value"] != "All").toList(),
                        value: "normal",
                        onChanged: (value, label) {
                          // Handle priority change
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions.where((c) => c["value"] != "All").toList(),
                        value: "general",
                        onChanged: (value, label) {
                          // Handle category change
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Message",
                  value: "",
                  hint: "Enter your message content here...",
                  onChanged: (value) {
                    // Handle message change
                  },
                ),

                Row(
                  children: [
                    QButton(
                      icon: Icons.attach_file,
                      label: "Attach Files",
                      size: bs.sm,
                      onPressed: () {
                        // Handle file attachment
                      },
                    ),
                    Spacer(),
                    QSwitch(
                      items: [
                        {
                          "label": "Pin Message",
                          "value": true,
                          "checked": false,
                        }
                      ],
                      value: [],
                      onChanged: (values, ids) {
                        // Handle pin toggle
                      },
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Send Message",
                        onPressed: () {
                          // Send message
                          ss("Message sent successfully!");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Save Draft",
                      size: bs.sm,
                      onPressed: () {
                        // Save as draft
                        si("Message saved as draft");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
      onInit: (tabController) {
        // Initialize tab controller if needed
      },
    );
  }
}
