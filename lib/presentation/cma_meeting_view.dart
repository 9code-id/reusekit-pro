import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaMeetingView extends StatefulWidget {
  const CmaMeetingView({super.key});

  @override
  State<CmaMeetingView> createState() => _CmaMeetingViewState();
}

class _CmaMeetingViewState extends State<CmaMeetingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedDate = "";
  
  List<Map<String, dynamic>> meetings = [
    {
      "id": 1,
      "title": "Quarterly Business Review",
      "client": "ABC Corporation",
      "contact_person": "John Smith",
      "date": DateTime.now().add(Duration(days: 1)),
      "time": "09:00",
      "duration": 120, // minutes
      "location": "Conference Room A",
      "meeting_type": "in_person",
      "status": "scheduled",
      "attendees": 5,
      "description": "Review Q4 performance and discuss upcoming projects for next quarter.",
      "agenda": "1. Performance review\n2. Project updates\n3. Budget planning\n4. Q&A session",
      "client_avatar": "https://picsum.photos/60/60?random=1&keyword=business",
      "priority": "high",
      "meeting_link": "",
      "documents": ["Q4_Report.pdf", "Budget_Proposal.xlsx"],
    },
    {
      "id": 2,
      "title": "Product Demo Session",
      "client": "XYZ Industries",
      "contact_person": "Sarah Johnson",
      "date": DateTime.now().add(Duration(hours: 4)),
      "time": "14:30",
      "duration": 60,
      "location": "Virtual Meeting",
      "meeting_type": "video_call",
      "status": "scheduled",
      "attendees": 3,
      "description": "Demonstrate new product features and discuss implementation timeline.",
      "agenda": "1. Product overview\n2. Feature demonstration\n3. Implementation plan\n4. Pricing discussion",
      "client_avatar": "https://picsum.photos/60/60?random=2&keyword=business",
      "priority": "medium",
      "meeting_link": "https://meet.company.com/demo-xyz",
      "documents": ["Product_Demo.pptx"],
    },
    {
      "id": 3,
      "title": "Contract Negotiation",
      "client": "Tech Solutions Ltd",
      "contact_person": "Mike Davis",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "time": "11:00",
      "duration": 90,
      "location": "Client Office",
      "meeting_type": "in_person",
      "status": "completed",
      "attendees": 4,
      "description": "Finalize contract terms and pricing structure for annual service agreement.",
      "agenda": "1. Contract review\n2. Pricing negotiation\n3. Service level agreements\n4. Contract signing",
      "client_avatar": "https://picsum.photos/60/60?random=3&keyword=business",
      "priority": "high",
      "meeting_link": "",
      "documents": ["Contract_Draft.pdf", "SLA_Terms.docx"],
    },
    {
      "id": 4,
      "title": "Follow-up Consultation",
      "client": "Design Studio Pro",
      "contact_person": "Emma Wilson",
      "date": DateTime.now().add(Duration(days: 3)),
      "time": "16:00",
      "duration": 45,
      "location": "Phone Call",
      "meeting_type": "phone_call",
      "status": "scheduled",
      "attendees": 2,
      "description": "Follow up on initial consultation and answer any remaining questions.",
      "agenda": "1. Address client concerns\n2. Provide additional information\n3. Schedule next steps",
      "client_avatar": "https://picsum.photos/60/60?random=4&keyword=business",
      "priority": "low",
      "meeting_link": "",
      "documents": [],
    },
    {
      "id": 5,
      "title": "Project Kickoff Meeting",
      "client": "Global Marketing Inc",
      "contact_person": "Robert Brown",
      "date": DateTime.now().add(Duration(days: 7)),
      "time": "10:30",
      "duration": 180,
      "location": "Virtual Meeting",
      "meeting_type": "video_call",
      "status": "scheduled",
      "attendees": 8,
      "description": "Official project launch meeting with all stakeholders and team members.",
      "agenda": "1. Project overview\n2. Team introductions\n3. Timeline review\n4. Resource allocation\n5. Communication protocols",
      "client_avatar": "https://picsum.photos/60/60?random=5&keyword=business",
      "priority": "high",
      "meeting_link": "https://meet.company.com/kickoff-global",
      "documents": ["Project_Charter.pdf", "Timeline.xlsx", "Resource_Plan.docx"],
    },
    {
      "id": 6,
      "title": "Weekly Check-in",
      "client": "Startup Ventures",
      "contact_person": "Lisa Anderson",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "time": "13:00",
      "duration": 30,
      "location": "Virtual Meeting",
      "meeting_type": "video_call",
      "status": "completed",
      "attendees": 3,
      "description": "Regular weekly progress update and issue resolution.",
      "agenda": "1. Progress updates\n2. Issue discussion\n3. Next week planning",
      "client_avatar": "https://picsum.photos/60/60?random=6&keyword=business",
      "priority": "medium",
      "meeting_link": "https://meet.company.com/weekly-startup",
      "documents": ["Weekly_Report.pdf"],
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Meetings", "value": "all"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
    {"label": "Rescheduled", "value": "rescheduled"},
  ];

  List<Map<String, dynamic>> meetingTypeOptions = [
    {"label": "In Person", "value": "in_person"},
    {"label": "Video Call", "value": "video_call"},
    {"label": "Phone Call", "value": "phone_call"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "High Priority", "value": "high"},
    {"label": "Medium Priority", "value": "medium"},
    {"label": "Low Priority", "value": "low"},
  ];

  // Form fields for new meeting
  String meetingTitle = "";
  String clientName = "";
  String contactPerson = "";
  String meetingDate = "";
  String meetingTime = "";
  String duration = "";
  String location = "";
  String selectedMeetingType = "video_call";
  String selectedPriority = "medium";
  String description = "";
  String agenda = "";
  String meetingLink = "";

  List<Map<String, dynamic>> get filteredMeetings {
    return meetings.where((meeting) {
      bool matchesSearch = searchQuery.isEmpty || 
          (meeting["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (meeting["client"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (meeting["contact_person"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || meeting["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList()..sort((a, b) => (a["date"] as DateTime).compareTo(b["date"] as DateTime));
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "scheduled":
        return primaryColor;
      case "completed":
        return successColor;
      case "cancelled":
        return dangerColor;
      case "rescheduled":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color getMeetingTypeColor(String type) {
    switch (type) {
      case "in_person":
        return primaryColor;
      case "video_call":
        return infoColor;
      case "phone_call":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData getMeetingTypeIcon(String type) {
    switch (type) {
      case "in_person":
        return Icons.person;
      case "video_call":
        return Icons.video_call;
      case "phone_call":
        return Icons.phone;
      default:
        return Icons.event;
    }
  }

  Widget _buildMeetingsTab() {
    return Column(
      spacing: spMd,
      children: [
        // Quick Stats
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildStatCard("Total Meetings", "${meetings.length}", Icons.event, primaryColor),
            _buildStatCard("This Week", "${meetings.where((m) => (m["date"] as DateTime).isAfter(DateTime.now()) && (m["date"] as DateTime).isBefore(DateTime.now().add(Duration(days: 7)))).length}", Icons.calendar_today, infoColor),
            _buildStatCard("Completed", "${meetings.where((m) => m["status"] == "completed").length}", Icons.check_circle, successColor),
            _buildStatCard("High Priority", "${meetings.where((m) => m["priority"] == "high").length}", Icons.priority_high, dangerColor),
          ],
        ),

        // Search and Filter
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search meetings...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Filter by Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        // Meetings List
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Icon(Icons.event, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Upcoming Meetings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "New Meeting",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {
                        currentTab = 1;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredMeetings.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final meeting = filteredMeetings[index];
                  return _buildMeetingCard(meeting);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleTab() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Icon(Icons.event_note, color: primaryColor, size: 24),
                  SizedBox(width: spSm),
                  Text(
                    "Schedule New Meeting",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              
              QTextField(
                label: "Meeting Title",
                value: meetingTitle,
                hint: "Enter meeting title",
                onChanged: (value) {
                  meetingTitle = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Client/Company",
                      value: clientName,
                      hint: "Client or company name",
                      onChanged: (value) {
                        clientName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Contact Person",
                      value: contactPerson,
                      hint: "Primary contact name",
                      onChanged: (value) {
                        contactPerson = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Meeting Date",
                      value: meetingDate.isNotEmpty ? DateTime.parse(meetingDate) : null,
                      onChanged: (value) {
                        meetingDate = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTimePicker(
                      label: "Meeting Time",
                      value: meetingTime.isNotEmpty ? TimeOfDay.fromDateTime(DateTime.parse(meetingTime)) : null,
                      onChanged: (value) {
                        meetingTime = value!.kkmm;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Duration (minutes)",
                      value: duration,
                      hint: "60",
                      onChanged: (value) {
                        duration = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Meeting Type",
                      items: meetingTypeOptions,
                      value: selectedMeetingType,
                      onChanged: (value, label) {
                        selectedMeetingType = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Location/Meeting Link",
                      value: location,
                      hint: "Conference room or meeting URL",
                      onChanged: (value) {
                        location = value;
                        setState(() {});
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
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              QMemoField(
                label: "Description",
                value: description,
                hint: "Meeting description and objectives",
                onChanged: (value) {
                  description = value;
                  setState(() {});
                },
              ),
              
              QMemoField(
                label: "Agenda",
                value: agenda,
                hint: "Meeting agenda items",
                onChanged: (value) {
                  agenda = value;
                  setState(() {});
                },
              ),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Draft",
                      color: disabledBoldColor,
                      size: bs.md,
                      onPressed: () {
                        ss("Meeting saved as draft");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Schedule Meeting",
                      size: bs.md,
                      onPressed: () {
                        ss("Meeting scheduled successfully");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarTab() {
    Map<String, List<Map<String, dynamic>>> meetingsByDate = {};
    for (var meeting in meetings) {
      String dateKey = (meeting["date"] as DateTime).dMMMy;
      if (!meetingsByDate.containsKey(dateKey)) {
        meetingsByDate[dateKey] = [];
      }
      meetingsByDate[dateKey]!.add(meeting);
    }

    return Column(
      spacing: spMd,
      children: [
        // Calendar Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_month, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Meeting Calendar",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.today,
                size: bs.sm,
                onPressed: () {
                  // Jump to today
                },
              ),
            ],
          ),
        ),

        // Meetings by Date
        ...meetingsByDate.entries.map((entry) => _buildDateSection(entry.key, entry.value)),
      ],
    );
  }

  Widget _buildDateSection(String date, List<Map<String, dynamic>> dayMeetings) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "${dayMeetings.length} meeting${dayMeetings.length != 1 ? 's' : ''}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dayMeetings.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final meeting = dayMeetings[index];
              return _buildMeetingCard(meeting);
            },
          ),
        ],
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
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingCard(Map<String, dynamic> meeting) {
    bool isUpcoming = (meeting["date"] as DateTime).isAfter(DateTime.now());
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              // Meeting Type Icon
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: getMeetingTypeColor("${meeting["meeting_type"]}").withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  getMeetingTypeIcon("${meeting["meeting_type"]}"),
                  color: getMeetingTypeColor("${meeting["meeting_type"]}"),
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              
              // Meeting Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${meeting["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${meeting["client"]} • ${meeting["contact_person"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Priority & Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: getPriorityColor("${meeting["priority"]}").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${meeting["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: getPriorityColor("${meeting["priority"]}"),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: getStatusColor("${meeting["status"]}").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${meeting["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: getStatusColor("${meeting["status"]}"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Meeting Details
          Row(
            children: [
              Icon(Icons.access_time, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${meeting["time"]} • ${meeting["duration"]} min",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${meeting["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                "${meeting["attendees"]} attendees",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          // Description
          if ((meeting["description"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${meeting["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
            ),
          
          // Action Buttons
          Row(
            children: [
              if (isUpcoming && (meeting["meeting_link"] as String).isNotEmpty)
                QButton(
                  label: "Join Meeting",
                  icon: Icons.video_call,
                  color: successColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Joining meeting...");
                  },
                ),
              if (isUpcoming && (meeting["meeting_link"] as String).isNotEmpty)
                SizedBox(width: spSm),
              QButton(
                label: "View Details",
                icon: Icons.info,
                color: infoColor,
                size: bs.sm,
                onPressed: () {
                  // Navigate to meeting details
                },
              ),
              if (isUpcoming)
                SizedBox(width: spSm),
              if (isUpcoming)
                QButton(
                  label: "Reschedule",
                  icon: Icons.schedule,
                  color: warningColor,
                  size: bs.sm,
                  onPressed: () {
                    ss("Rescheduling meeting...");
                  },
                ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                color: disabledBoldColor,
                size: bs.sm,
                onPressed: () {
                  // More options menu
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Meeting Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Meetings", icon: Icon(Icons.event)),
        Tab(text: "Schedule", icon: Icon(Icons.add_circle)),
        Tab(text: "Calendar", icon: Icon(Icons.calendar_month)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildMeetingsTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildScheduleTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCalendarTab(),
        ),
      ],
      onInit: (tabController) {},
    );
  }
}
