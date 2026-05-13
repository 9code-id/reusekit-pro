import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSocialCalendarView extends StatefulWidget {
  const DmsSocialCalendarView({super.key});

  @override
  State<DmsSocialCalendarView> createState() => _DmsSocialCalendarViewState();
}

class _DmsSocialCalendarViewState extends State<DmsSocialCalendarView> {
  int currentTab = 0;
  DateTime selectedDate = DateTime.now();
  String selectedView = "month";
  String selectedPlatform = "";
  bool loading = false;

  // Calendar data
  Map<String, List<Map<String, dynamic>>> scheduledPosts = {
    "2024-01-22": [
      {
        "id": "1",
        "title": "Morning Motivation",
        "time": "09:00",
        "platform": "facebook",
        "status": "scheduled",
        "type": "text",
      },
      {
        "id": "2",
        "title": "Product Update",
        "time": "14:30",
        "platform": "instagram",
        "status": "scheduled", 
        "type": "image",
      },
    ],
    "2024-01-23": [
      {
        "id": "3",
        "title": "Team Spotlight",
        "time": "10:00",
        "platform": "linkedin",
        "status": "scheduled",
        "type": "text",
      },
      {
        "id": "4",
        "title": "Behind the Scenes",
        "time": "16:00",
        "platform": "twitter",
        "status": "scheduled",
        "type": "video",
      },
    ],
    "2024-01-24": [
      {
        "id": "5",
        "title": "Tips Tuesday",
        "time": "11:30",
        "platform": "facebook",
        "status": "scheduled",
        "type": "text",
      },
    ],
    "2024-01-25": [
      {
        "id": "6",
        "title": "Customer Story",
        "time": "13:00",
        "platform": "instagram",
        "status": "published",
        "type": "image",
      },
      {
        "id": "7",
        "title": "Industry News",
        "time": "15:45",
        "platform": "twitter",
        "status": "failed",
        "type": "link",
      },
    ],
  };

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Month View", "value": "month"},
    {"label": "Week View", "value": "week"},
    {"label": "Day View", "value": "day"},
    {"label": "List View", "value": "list"},
  ];

  List<Map<String, dynamic>> platformItems = [
    {"label": "All Platforms", "value": ""},
    {"label": "Facebook", "value": "facebook"},
    {"label": "Instagram", "value": "instagram"},
    {"label": "Twitter", "value": "twitter"},
    {"label": "LinkedIn", "value": "linkedin"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Social Calendar",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Calendar", icon: Icon(Icons.calendar_month)),
        Tab(text: "Timeline", icon: Icon(Icons.timeline)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildCalendarTab(),
        _buildTimelineTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildCalendarTab() {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Calendar Controls
          _buildCalendarControls(),

          // Calendar View
          if (selectedView == "month") _buildMonthView(),
          if (selectedView == "week") _buildWeekView(),
          if (selectedView == "day") _buildDayView(),
          if (selectedView == "list") _buildListView(),

          // Quick Actions
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildCalendarControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              QButton(
                icon: Icons.chevron_left,
                size: bs.sm,
                onPressed: _previousPeriod,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  _getDateRangeText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.chevron_right,
                size: bs.sm,
                onPressed: _nextPeriod,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "View",
                  items: viewOptions,
                  value: selectedView,
                  onChanged: (value, label) {
                    selectedView = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Platform Filter",
                  items: platformItems,
                  value: selectedPlatform,
                  onChanged: (value, label) {
                    selectedPlatform = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Today",
                size: bs.sm,
                onPressed: () {
                  selectedDate = DateTime.now();
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthView() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Days of week header
          _buildDaysOfWeekHeader(),
          
          // Calendar grid
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildDaysOfWeekHeader() {
    List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    
    return Row(
      children: days.map((day) => 
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: spXs),
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    DateTime firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    int daysInMonth = lastDayOfMonth.day;
    int startWeekday = firstDayOfMonth.weekday;

    List<Widget> calendarDays = [];

    // Add empty cells for days before the first day of month
    for (int i = 1; i < startWeekday; i++) {
      calendarDays.add(Container());
    }

    // Add days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(selectedDate.year, selectedDate.month, day);
      String dateKey = "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
      List<Map<String, dynamic>> dayPosts = scheduledPosts[dateKey] ?? [];
      
      // Filter by platform if selected
      if (selectedPlatform.isNotEmpty) {
        dayPosts = dayPosts.where((post) => post["platform"] == selectedPlatform).toList();
      }

      calendarDays.add(_buildCalendarDay(day, dayPosts, currentDate));
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: calendarDays,
    );
  }

  Widget _buildCalendarDay(int day, List<Map<String, dynamic>> posts, DateTime date) {
    bool isToday = date.day == DateTime.now().day && 
                   date.month == DateTime.now().month && 
                   date.year == DateTime.now().year;
    bool isSelected = date.day == selectedDate.day && 
                      date.month == selectedDate.month && 
                      date.year == selectedDate.year;

    return GestureDetector(
      onTap: () {
        selectedDate = date;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : 
                 isToday ? successColor.withAlpha(10) : Colors.transparent,
          border: isSelected ? Border.all(color: primaryColor, width: 2) :
                  isToday ? Border.all(color: successColor) : null,
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Column(
          children: [
            SizedBox(height: 4),
            Text(
              "$day",
              style: TextStyle(
                fontSize: 14,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? primaryColor : 
                       isToday ? successColor : primaryColor,
              ),
            ),
            SizedBox(height: 2),
            Expanded(
              child: Column(
                children: [
                  ...posts.take(2).map((post) => Container(
                    width: double.infinity,
                    height: 12,
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                      color: _getPlatformColor(post["platform"]).withAlpha(30),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Center(
                      child: Icon(
                        _getPlatformIcon(post["platform"]),
                        size: 8,
                        color: _getPlatformColor(post["platform"]),
                      ),
                    ),
                  )),
                  if (posts.length > 2)
                    Text(
                      "+${posts.length - 2}",
                      style: TextStyle(
                        fontSize: 8,
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

  Widget _buildWeekView() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Week header
          _buildWeekHeader(),
          
          // Week content
          _buildWeekContent(),
        ],
      ),
    );
  }

  Widget _buildWeekHeader() {
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    
    return Row(
      children: List.generate(7, (index) {
        DateTime day = startOfWeek.add(Duration(days: index));
        bool isToday = day.day == DateTime.now().day && 
                       day.month == DateTime.now().month && 
                       day.year == DateTime.now().year;
        
        return Expanded(
          child: Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: isToday ? successColor.withAlpha(10) : null,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              children: [
                Text(
                  ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${day.day}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? successColor : primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWeekContent() {
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    
    return Container(
      height: 400,
      child: Row(
        children: List.generate(7, (index) {
          DateTime day = startOfWeek.add(Duration(days: index));
          String dateKey = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
          List<Map<String, dynamic>> dayPosts = scheduledPosts[dateKey] ?? [];
          
          if (selectedPlatform.isNotEmpty) {
            dayPosts = dayPosts.where((post) => post["platform"] == selectedPlatform).toList();
          }
          
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
                ),
              ),
              child: Column(
                children: dayPosts.map((post) => _buildWeekPostItem(post)).toList(),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWeekPostItem(Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: _getPlatformColor(post["platform"]).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(
          color: _getPlatformColor(post["platform"]).withAlpha(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getPlatformIcon(post["platform"]),
                size: 12,
                color: _getPlatformColor(post["platform"]),
              ),
              SizedBox(width: 2),
              Text(
                "${post["time"]}",
                style: TextStyle(
                  fontSize: 8,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "${post["title"]}",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDayView() {
    String dateKey = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    List<Map<String, dynamic>> dayPosts = scheduledPosts[dateKey] ?? [];
    
    if (selectedPlatform.isNotEmpty) {
      dayPosts = dayPosts.where((post) => post["platform"] == selectedPlatform).toList();
    }

    return Container(
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
            "${selectedDate.dMMMy} - ${dayPosts.length} posts scheduled",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (dayPosts.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.event_available,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No posts scheduled for this day",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Schedule a Post",
                    size: bs.md,
                    onPressed: () {},
                  ),
                ],
              ),
            )
          else
            ...dayPosts.map((post) => _buildDayPostItem(post)),
        ],
      ),
    );
  }

  Widget _buildDayPostItem(Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getPlatformColor(post["platform"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getPlatformIcon(post["platform"]),
              color: _getPlatformColor(post["platform"]),
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${post["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${post["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      _getStatusIcon(post["status"]),
                      size: 16,
                      color: _getStatusColor(post["status"]),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${post["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(post["status"]),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      _getTypeIcon(post["type"]),
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${post["type"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: disabledBoldColor),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Edit"),
                  onTap: () => _editPost(post),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.copy),
                  title: Text("Duplicate"),
                  onTap: () => _duplicatePost(post),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.delete, color: dangerColor),
                  title: Text("Delete", style: TextStyle(color: dangerColor)),
                  onTap: () => _deletePost(post),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    List<Map<String, dynamic>> allPosts = [];
    
    scheduledPosts.forEach((date, posts) {
      for (var post in posts) {
        Map<String, dynamic> postWithDate = Map.from(post);
        postWithDate["date"] = date;
        allPosts.add(postWithDate);
      }
    });

    // Filter by platform
    if (selectedPlatform.isNotEmpty) {
      allPosts = allPosts.where((post) => post["platform"] == selectedPlatform).toList();
    }

    // Sort by date and time
    allPosts.sort((a, b) {
      int dateComparison = a["date"].compareTo(b["date"]);
      if (dateComparison != 0) return dateComparison;
      return a["time"].compareTo(b["time"]);
    });

    return Container(
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
            "All Scheduled Posts (${allPosts.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...allPosts.map((post) => _buildListPostItem(post)),
        ],
      ),
    );
  }

  Widget _buildListPostItem(Map<String, dynamic> post) {
    DateTime postDate = DateTime.parse(post["date"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getPlatformColor(post["platform"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getPlatformIcon(post["platform"]),
              color: _getPlatformColor(post["platform"]),
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${post["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${postDate.dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${post["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(post["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${post["status"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(post["status"]),
                        ),
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
  }

  Widget _buildQuickActions() {
    return Container(
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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              QButton(
                label: "Schedule New Post",
                icon: Icons.add,
                size: bs.md,
                onPressed: () {},
              ),
              QButton(
                label: "Bulk Upload",
                icon: Icons.upload,
                size: bs.md,
                onPressed: () {},
              ),
              QButton(
                label: "Export Calendar",
                icon: Icons.download,
                size: bs.md,
                onPressed: () {},
              ),
              QButton(
                label: "Import Posts",
                icon: Icons.file_upload,
                size: bs.md,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Timeline Filters
          _buildTimelineFilters(),

          // Timeline View
          _buildTimelineContent(),
        ],
      ),
    );
  }

  Widget _buildTimelineFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Time Range",
              items: [
                {"label": "This Week", "value": "week"},
                {"label": "This Month", "value": "month"},
                {"label": "Next 30 Days", "value": "30days"},
                {"label": "Custom Range", "value": "custom"},
              ],
              value: "week",
              onChanged: (value, label) {},
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Platform",
              items: platformItems,
              value: selectedPlatform,
              onChanged: (value, label) {
                selectedPlatform = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineContent() {
    return Container(
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
            "Posting Timeline",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 400,
            child: _buildTimelineChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineChart() {
    // Simple timeline visualization
    List<String> hours = List.generate(24, (index) => "${index.toString().padLeft(2, '0')}:00");
    
    return Column(
      children: [
        // Hour labels
        Container(
          height: 30,
          child: Row(
            children: hours.take(12).map((hour) => 
              Expanded(
                child: Text(
                  hour,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ).toList(),
          ),
        ),
        
        // Timeline bars
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              children: List.generate(7, (dayIndex) {
                DateTime day = DateTime.now().add(Duration(days: dayIndex));
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        padding: EdgeInsets.all(spXs),
                        child: Text(
                          "${day.dMMMy}".substring(0, 6),
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          child: _buildTimelineBar(day),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineBar(DateTime day) {
    String dateKey = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    List<Map<String, dynamic>> dayPosts = scheduledPosts[dateKey] ?? [];

    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: List.generate(24, (hour) {
          bool hasPost = dayPosts.any((post) => 
            int.parse(post["time"].split(":")[0]) == hour);
          
          return Expanded(
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: hasPost ? primaryColor.withAlpha(60) : Colors.transparent,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Posting Analytics
          _buildPostingAnalytics(),

          // Platform Distribution
          _buildPlatformDistribution(),

          // Best Times to Post
          _buildBestTimes(),
        ],
      ),
    );
  }

  Widget _buildPostingAnalytics() {
    return Container(
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
            "Posting Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Total Posts This Month", "127", Icons.post_add, primaryColor),
              _buildAnalyticsCard("Posts This Week", "28", Icons.today, successColor),
              _buildAnalyticsCard("Scheduled", "45", Icons.schedule, warningColor),
              _buildAnalyticsCard("Failed Posts", "3", Icons.error, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformDistribution() {
    return Container(
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
            "Platform Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildPlatformChart(),
        ],
      ),
    );
  }

  Widget _buildPlatformChart() {
    List<Map<String, dynamic>> platformData = [
      {"platform": "facebook", "posts": 45, "percentage": 35.4},
      {"platform": "instagram", "posts": 38, "percentage": 29.9},
      {"platform": "twitter", "posts": 32, "percentage": 25.2},
      {"platform": "linkedin", "posts": 12, "percentage": 9.4},
    ];

    return Column(
      spacing: spSm,
      children: platformData.map((data) => 
        Row(
          children: [
            Icon(
              _getPlatformIcon(data["platform"]),
              color: _getPlatformColor(data["platform"]),
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              flex: 2,
              child: Text(
                "${data["platform"]}".toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  widthFactor: (data["percentage"] as double) / 100,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _getPlatformColor(data["platform"]),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: spSm),
            Text(
              "${data["posts"]} (${(data["percentage"] as double).toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ).toList(),
    );
  }

  Widget _buildBestTimes() {
    return Container(
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
            "Best Times to Post",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Based on your audience engagement data",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildBestTimeCard("Facebook", "2:00 PM - 4:00 PM", "Weekdays", successColor),
              _buildBestTimeCard("Instagram", "11:00 AM - 1:00 PM", "All days", infoColor),
              _buildBestTimeCard("Twitter", "9:00 AM - 10:00 AM", "Weekdays", warningColor),
              _buildBestTimeCard("LinkedIn", "8:00 AM - 10:00 AM", "Tue-Thu", primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBestTimeCard(String platform, String time, String days, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        border: Border.all(color: color.withAlpha(30)),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Text(
            platform,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            days,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH4,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDateRangeText() {
    switch (selectedView) {
      case "month":
        return "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}";
      case "week":
        DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
        return "${startOfWeek.dMMMy} - ${endOfWeek.dMMMy}";
      case "day":
        return selectedDate.dMMMy;
      default:
        return selectedDate.dMMMy;
    }
  }

  void _previousPeriod() {
    switch (selectedView) {
      case "month":
        selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1);
        break;
      case "week":
        selectedDate = selectedDate.subtract(Duration(days: 7));
        break;
      case "day":
        selectedDate = selectedDate.subtract(Duration(days: 1));
        break;
    }
    setState(() {});
  }

  void _nextPeriod() {
    switch (selectedView) {
      case "month":
        selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
        break;
      case "week":
        selectedDate = selectedDate.add(Duration(days: 7));
        break;
      case "day":
        selectedDate = selectedDate.add(Duration(days: 1));
        break;
    }
    setState(() {});
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt;
      case 'twitter':
        return Icons.alternate_email;
      case 'linkedin':
        return Icons.business;
      default:
        return Icons.public;
    }
  }

  Color _getPlatformColor(String platform) {
    switch (platform) {
      case 'facebook':
        return Color(0xFF1877F2);
      case 'instagram':
        return Color(0xFFE4405F);
      case 'twitter':
        return Color(0xFF1DA1F2);
      case 'linkedin':
        return Color(0xFF0A66C2);
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return warningColor;
      case 'published':
        return successColor;
      case 'failed':
        return dangerColor;
      case 'draft':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'scheduled':
        return Icons.schedule;
      case 'published':
        return Icons.check_circle;
      case 'failed':
        return Icons.error;
      case 'draft':
        return Icons.edit;
      default:
        return Icons.help;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'text':
        return Icons.text_fields;
      case 'image':
        return Icons.image;
      case 'video':
        return Icons.video_library;
      case 'link':
        return Icons.link;
      default:
        return Icons.post_add;
    }
  }

  void _editPost(Map<String, dynamic> post) {
    // Navigate to edit post
    si("Edit post feature will be implemented");
  }

  void _duplicatePost(Map<String, dynamic> post) {
    // Duplicate post logic
    ss("Post duplicated successfully");
  }

  void _deletePost(Map<String, dynamic> post) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this post?");
    if (isConfirmed) {
      ss("Post deleted successfully");
    }
  }
}
