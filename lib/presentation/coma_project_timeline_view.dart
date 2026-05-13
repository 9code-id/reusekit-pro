import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectTimelineView extends StatefulWidget {
  const ComaProjectTimelineView({Key? key}) : super(key: key);

  @override
  State<ComaProjectTimelineView> createState() => _ComaProjectTimelineViewState();
}

class _ComaProjectTimelineViewState extends State<ComaProjectTimelineView> {
  String selectedFilter = "all";
  String searchQuery = "";
  int currentView = 0; // 0 = Timeline, 1 = Calendar
  
  Map<String, dynamic> project = {
    "name": "Riverside Commercial Complex",
    "status": "in_progress",
    "progress": 65.0,
    "startDate": "2024-01-15",
    "endDate": "2024-12-30",
  };

  List<Map<String, dynamic>> timelineEvents = [
    {
      "id": 1,
      "title": "Project Initiation",
      "description": "Project kick-off meeting and initial planning",
      "date": "2024-01-15",
      "time": "09:00",
      "type": "milestone",
      "status": "completed",
      "category": "planning",
      "responsible": "Sarah Wilson",
      "duration": 120,
      "priority": "high"
    },
    {
      "id": 2,
      "title": "Site Survey Completed",
      "description": "Comprehensive site assessment and geological survey",
      "date": "2024-01-25",
      "time": "10:30",
      "type": "task",
      "status": "completed",
      "category": "planning",
      "responsible": "Mike Chen",
      "duration": 480,
      "priority": "high"
    },
    {
      "id": 3,
      "title": "Foundation Excavation Started",
      "description": "Begin excavation work for building foundation",
      "date": "2024-02-01",
      "time": "07:00",
      "type": "task",
      "status": "completed",
      "category": "construction",
      "responsible": "Construction Team A",
      "duration": 960,
      "priority": "critical"
    },
    {
      "id": 4,
      "title": "Foundation Concrete Pour",
      "description": "Complete concrete pour for foundation structure",
      "date": "2024-02-15",
      "time": "06:00",
      "type": "milestone",
      "status": "completed",
      "category": "construction",
      "responsible": "Construction Team B",
      "duration": 720,
      "priority": "critical"
    },
    {
      "id": 5,
      "title": "Steel Framework Installation",
      "description": "Installation of main structural steel framework",
      "date": "2024-03-01",
      "time": "08:00",
      "type": "task",
      "status": "completed",
      "category": "construction",
      "responsible": "Steel Installation Team",
      "duration": 1440,
      "priority": "high"
    },
    {
      "id": 6,
      "title": "First Floor Concrete Pour",
      "description": "Concrete work for first floor structure",
      "date": "2024-04-10",
      "time": "07:30",
      "type": "task",
      "status": "completed",
      "category": "construction",
      "responsible": "Construction Team A",
      "duration": 600,
      "priority": "high"
    },
    {
      "id": 7,
      "title": "Electrical Rough-In",
      "description": "Installation of electrical conduits and wiring",
      "date": "2024-05-15",
      "time": "08:00",
      "type": "task",
      "status": "in_progress",
      "category": "electrical",
      "responsible": "Electrical Team",
      "duration": 960,
      "priority": "medium"
    },
    {
      "id": 8,
      "title": "Plumbing Installation",
      "description": "Installation of plumbing systems and fixtures",
      "date": "2024-06-01",
      "time": "09:00",
      "type": "task",
      "status": "in_progress",
      "category": "plumbing",
      "responsible": "Plumbing Team",
      "duration": 720,
      "priority": "medium"
    },
    {
      "id": 9,
      "title": "HVAC System Installation",
      "description": "Installation of heating, ventilation, and air conditioning systems",
      "date": "2024-06-20",
      "time": "08:30",
      "type": "task",
      "status": "scheduled",
      "category": "hvac",
      "responsible": "HVAC Specialists",
      "duration": 1200,
      "priority": "medium"
    },
    {
      "id": 10,
      "title": "Interior Drywall Installation",
      "description": "Installation of interior walls and drywall systems",
      "date": "2024-07-15",
      "time": "07:00",
      "type": "task",
      "status": "scheduled",
      "category": "interior",
      "responsible": "Interior Team",
      "duration": 960,
      "priority": "medium"
    },
    {
      "id": 11,
      "title": "Final Inspection Milestone",
      "description": "Final building inspection and approval",
      "date": "2024-12-15",
      "time": "10:00",
      "type": "milestone",
      "status": "scheduled",
      "category": "inspection",
      "responsible": "Building Inspector",
      "duration": 240,
      "priority": "critical"
    },
    {
      "id": 12,
      "title": "Project Completion",
      "description": "Official project completion and handover",
      "date": "2024-12-30",
      "time": "14:00",
      "type": "milestone",
      "status": "scheduled",
      "category": "completion",
      "responsible": "Sarah Wilson",
      "duration": 180,
      "priority": "critical"
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Events", "value": "all"},
    {"label": "Milestones", "value": "milestone"},
    {"label": "Tasks", "value": "task"},
    {"label": "Completed", "value": "completed"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Scheduled", "value": "scheduled"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'in_progress':
        return primaryColor;
      case 'scheduled':
        return infoColor;
      case 'delayed':
        return dangerColor;
      case 'cancelled':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'planning':
        return infoColor;
      case 'construction':
        return primaryColor;
      case 'electrical':
        return warningColor;
      case 'plumbing':
        return successColor;
      case 'hvac':
        return secondaryColor;
      case 'interior':
        return Colors.purple;
      case 'inspection':
        return dangerColor;
      case 'completion':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return primaryColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'in_progress':
        return 'In Progress';
      case 'scheduled':
        return 'Scheduled';
      case 'delayed':
        return 'Delayed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredEvents {
    return timelineEvents.where((event) {
      bool matchesSearch = event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          event["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          event["responsible"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "all" || 
          event["type"] == selectedFilter || 
          event["status"] == selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Timeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddEventDialog(),
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProjectHeader(),
          _buildSearchAndFilters(),
          _buildViewToggle(),
          Expanded(
            child: currentView == 0 ? _buildTimelineView() : _buildCalendarView(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${project["name"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "Progress: ${(project["progress"] as num).toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: LinearProgressIndicator(
                  value: (project["progress"] as num) / 100,
                  backgroundColor: disabledOutlineBorderColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${DateTime.parse(project["startDate"]).dMMMy} - ${DateTime.parse(project["endDate"]).dMMMy}",
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
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search timeline events...",
                  value: searchQuery,
                  hint: "Search by title, description, or responsible person",
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
        ],
      ),
    );
  }

  Widget _buildViewToggle() {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                currentView = 0;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: currentView == 0 ? primaryColor : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: currentView == 0 ? primaryColor : disabledOutlineBorderColor,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timeline,
                        color: currentView == 0 ? Colors.white : disabledBoldColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Timeline View",
                        style: TextStyle(
                          color: currentView == 0 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                currentView = 1;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  color: currentView == 1 ? primaryColor : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: currentView == 1 ? primaryColor : disabledOutlineBorderColor,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: currentView == 1 ? Colors.white : disabledBoldColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Calendar View",
                        style: TextStyle(
                          color: currentView == 1 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineView() {
    List<Map<String, dynamic>> events = filteredEvents;
    events.sort((a, b) => DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"])));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: events.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> event = entry.value;
          bool isLast = index == events.length - 1;
          
          return _buildTimelineItem(event, isLast);
        }).toList(),
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> event, bool isLast) {
    Color statusColor = _getStatusColor(event["status"]);
    Color categoryColor = _getCategoryColor(event["category"]);
    Color priorityColor = _getPriorityColor(event["priority"]);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [shadowSm],
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: disabledOutlineBorderColor,
              ),
          ],
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: statusColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${event["title"]}",
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
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getStatusLabel(event["status"]),
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${DateTime.parse(event["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${event["priority"].toString().toUpperCase()}",
                        style: TextStyle(
                          fontSize: 9,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["responsible"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.schedule,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${((event["duration"] as num) / 60).toStringAsFixed(1)}h",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${event["category"].toString().toUpperCase()}",
                        style: TextStyle(
                          fontSize: 9,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                if (event["type"] == "milestone") ...[
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "MILESTONE EVENT",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                SizedBox(height: spSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      color: infoColor,
                      onPressed: () => _showEditEventDialog(event),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () => _showEventOptions(event),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Calendar view integration would require a calendar widget. This is a placeholder for the calendar implementation.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Upcoming Events This Week",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredEvents.take(5).length,
                      itemBuilder: (context, index) {
                        final event = filteredEvents[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getStatusColor(event["status"]).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: _getStatusColor(event["status"]).withAlpha(30),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(event["status"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${event["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(event["status"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getStatusLabel(event["status"]),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
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
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledOutlineBorderColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Filter Timeline Events",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Filter By",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear Filter",
                    size: bs.sm,
                    color: disabledBoldColor,
                    onPressed: () {
                      selectedFilter = "all";
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Filter",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Timeline Event"),
        content: Text("Feature to add new timeline events would be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Event added to timeline");
            },
            child: Text("Add Event"),
          ),
        ],
      ),
    );
  }

  void _showEditEventDialog(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Event"),
        content: Text("Edit timeline event: ${event["title"]}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              si("Event updated successfully");
            },
            child: Text("Save Changes"),
          ),
        ],
      ),
    );
  }

  void _showEventOptions(Map<String, dynamic> event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "${event["title"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Duplicate",
                    icon: Icons.copy,
                    size: bs.sm,
                    color: infoColor,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Event duplicated");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Mark Complete",
                    icon: Icons.check,
                    size: bs.sm,
                    color: successColor,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Event marked as completed");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reschedule",
                    icon: Icons.schedule,
                    size: bs.sm,
                    color: warningColor,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Event rescheduled");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Delete",
                    icon: Icons.delete,
                    size: bs.sm,
                    color: dangerColor,
                    onPressed: () async {
                      Navigator.pop(context);
                      bool isConfirmed = await confirm("Delete this timeline event?");
                      if (isConfirmed) {
                        se("Event deleted");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
