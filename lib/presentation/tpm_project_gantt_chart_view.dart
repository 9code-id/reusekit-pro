import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmProjectGanttChartView extends StatefulWidget {
  const TpmProjectGanttChartView({super.key});

  @override
  State<TpmProjectGanttChartView> createState() => _TpmProjectGanttChartViewState();
}

class _TpmProjectGanttChartViewState extends State<TpmProjectGanttChartView> {
  String selectedTimeRange = "month";
  DateTime currentDate = DateTime.now();
  
  List<Map<String, dynamic>> ganttTasks = [
    {
      "id": 1,
      "name": "Project Planning",
      "startDate": DateTime.now().subtract(Duration(days: 5)),
      "endDate": DateTime.now().add(Duration(days: 2)),
      "progress": 85,
      "color": "#3B82F6",
      "assignee": "John Doe",
      "dependencies": [],
      "status": "in_progress"
    },
    {
      "id": 2,
      "name": "Design Phase",
      "startDate": DateTime.now().add(Duration(days: 1)),
      "endDate": DateTime.now().add(Duration(days: 8)),
      "progress": 45,
      "color": "#10B981",
      "assignee": "Jane Smith",
      "dependencies": [1],
      "status": "in_progress"
    },
    {
      "id": 3,
      "name": "Development",
      "startDate": DateTime.now().add(Duration(days: 7)),
      "endDate": DateTime.now().add(Duration(days: 21)),
      "progress": 15,
      "color": "#F59E0B",
      "assignee": "Mike Johnson",
      "dependencies": [2],
      "status": "not_started"
    },
    {
      "id": 4,
      "name": "Testing",
      "startDate": DateTime.now().add(Duration(days: 19)),
      "endDate": DateTime.now().add(Duration(days: 26)),
      "progress": 0,
      "color": "#EF4444",
      "assignee": "Sarah Wilson",
      "dependencies": [3],
      "status": "not_started"
    },
    {
      "id": 5,
      "name": "Deployment",
      "startDate": DateTime.now().add(Duration(days: 25)),
      "endDate": DateTime.now().add(Duration(days: 28)),
      "progress": 0,
      "color": "#8B5CF6",
      "assignee": "Tom Brown",
      "dependencies": [4],
      "status": "not_started"
    },
  ];

  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Week", "value": "week"},
    {"label": "Month", "value": "month"},
    {"label": "Quarter", "value": "quarter"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gantt Chart"),
        actions: [
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {
              setState(() {
                currentDate = DateTime.now();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Time Range",
                        items: timeRangeOptions,
                        value: selectedTimeRange,
                        onChanged: (value, label) {
                          selectedTimeRange = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    QButton(
                      icon: Icons.chevron_left,
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          currentDate = currentDate.subtract(Duration(days: 30));
                        });
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.chevron_right,
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          currentDate = currentDate.add(Duration(days: 30));
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Text(
                      "${currentDate.dMMMy}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    _buildLegend(),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTimelineHeader(),
                  ...ganttTasks.map((task) => _buildGanttRow(task)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _buildLegendItem("Not Started", Color(0xFFE5E7EB)),
        SizedBox(width: spSm),
        _buildLegendItem("In Progress", Color(0xFF3B82F6)),
        SizedBox(width: spSm),
        _buildLegendItem("Completed", Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineHeader() {
    List<DateTime> dates = [];
    for (int i = 0; i < 30; i++) {
      dates.add(currentDate.add(Duration(days: i)));
    }

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Tasks",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: dates.map((date) => _buildDateColumn(date)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateColumn(DateTime date) {
    bool isToday = date.day == DateTime.now().day && 
                   date.month == DateTime.now().month && 
                   date.year == DateTime.now().year;
    
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: isToday ? primaryColor.withAlpha(20) : Colors.transparent,
        border: Border(
          right: BorderSide(color: disabledOutlineBorderColor.withAlpha(100)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${date.day}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              color: isToday ? primaryColor : disabledBoldColor,
            ),
          ),
          Text(
            ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][date.weekday % 7],
            style: TextStyle(
              fontSize: 10,
              color: isToday ? primaryColor : disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGanttRow(Map<String, dynamic> task) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor.withAlpha(100)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${task["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${task["assignee"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${(task["progress"] as int)}%",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _getStatusColor(task["status"]),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: (task["progress"] as int) / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getStatusColor(task["status"]),
                        ),
                        minHeight: 3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 1200,
                child: _buildGanttBar(task),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGanttBar(Map<String, dynamic> task) {
    DateTime startDate = task["startDate"];
    DateTime endDate = task["endDate"];
    
    int daysDifference = currentDate.difference(startDate).inDays;
    int taskDuration = endDate.difference(startDate).inDays;
    
    double leftOffset = ((daysDifference as int).toDouble()) * 40.0;
    double barWidth = ((taskDuration as int).toDouble()) * 40.0;
    
    if (leftOffset < 0) {
      barWidth += leftOffset;
      leftOffset = 0;
    }
    
    if (barWidth <= 0) return Container();
    
    return Stack(
      children: [
        Positioned(
          left: leftOffset,
          top: 25,
          child: Container(
            width: barWidth,
            height: 30,
            decoration: BoxDecoration(
              color: Color(int.parse(task["color"].replaceFirst('#', '0xFF'))),
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Stack(
              children: [
                Container(
                  width: barWidth * ((task["progress"] as int) / 100),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(int.parse(task["color"].replaceFirst('#', '0xFF'))).withAlpha(255),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
                Container(
                  width: barWidth,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(int.parse(task["color"].replaceFirst('#', '0xFF'))).withAlpha(100),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
                Center(
                  child: Text(
                    "${(task["progress"] as int)}%",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Dependencies lines
        ..._buildDependencyLines(task),
      ],
    );
  }

  List<Widget> _buildDependencyLines(Map<String, dynamic> task) {
    List<Widget> lines = [];
    List<dynamic> dependencies = task["dependencies"] ?? [];
    
    for (int depId in dependencies) {
      Map<String, dynamic>? depTask = ganttTasks.firstWhere(
        (t) => t["id"] == depId,
        orElse: () => {},
      );
      
      if (depTask.isNotEmpty) {
        // Add dependency line visualization logic here
        // This would require more complex calculations for arrow positioning
      }
    }
    
    return lines;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return primaryColor;
      case "not_started":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }
}