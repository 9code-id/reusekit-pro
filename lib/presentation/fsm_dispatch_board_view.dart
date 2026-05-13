import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmDispatchBoardView extends StatefulWidget {
  const FsmDispatchBoardView({super.key});

  @override
  State<FsmDispatchBoardView> createState() => _FsmDispatchBoardViewState();
}

class _FsmDispatchBoardViewState extends State<FsmDispatchBoardView> {
  List<Map<String, dynamic>> dispatchQueues = [
    {
      "status": "Emergency",
      "count": 3,
      "color": dangerColor,
      "jobs": [
        {
          "id": "E001",
          "title": "Water Leak Emergency",
          "client": "Downtown Hospital",
          "priority": "Critical",
          "estimatedTime": 2.0,
          "skills": ["Plumbing", "Emergency"],
          "location": "Medical District",
          "reportedTime": "08:30",
          "clientPhone": "+1 555-0101",
          "description": "Major water leak in basement affecting electrical systems"
        },
        {
          "id": "E002",
          "title": "Power Outage",
          "client": "Shopping Mall",
          "priority": "Critical",
          "estimatedTime": 3.0,
          "skills": ["Electrical", "Emergency"],
          "location": "Commercial Zone",
          "reportedTime": "09:15",
          "clientPhone": "+1 555-0102",
          "description": "Complete power failure affecting all operations"
        },
        {
          "id": "E003",
          "title": "HVAC System Failure",
          "client": "Senior Care Center",
          "priority": "Critical",
          "estimatedTime": 4.0,
          "skills": ["HVAC", "Emergency"],
          "location": "Healthcare District",
          "reportedTime": "10:00",
          "clientPhone": "+1 555-0103",
          "description": "Climate control failure in patient care areas"
        }
      ]
    },
    {
      "status": "High Priority",
      "count": 5,
      "color": warningColor,
      "jobs": [
        {
          "id": "H001",
          "title": "Security System Repair",
          "client": "Bank Branch",
          "priority": "High",
          "estimatedTime": 2.5,
          "skills": ["Security", "Electrical"],
          "location": "Financial District",
          "reportedTime": "07:45",
          "clientPhone": "+1 555-0201",
          "description": "Main security panel malfunction"
        },
        {
          "id": "H002",
          "title": "Elevator Maintenance",
          "client": "Office Tower",
          "priority": "High",
          "estimatedTime": 3.5,
          "skills": ["Mechanical", "Safety"],
          "location": "Business District",
          "reportedTime": "08:20",
          "clientPhone": "+1 555-0202",
          "description": "Elevator stopped between floors"
        },
        {
          "id": "H003",
          "title": "Fire Safety System",
          "client": "Manufacturing Plant",
          "priority": "High",
          "estimatedTime": 2.0,
          "skills": ["Safety", "Electrical"],
          "location": "Industrial Zone",
          "reportedTime": "09:30",
          "clientPhone": "+1 555-0203",
          "description": "Fire alarm system not responding"
        }
      ]
    },
    {
      "status": "Scheduled",
      "count": 8,
      "color": infoColor,
      "jobs": [
        {
          "id": "S001",
          "title": "Routine HVAC Check",
          "client": "Office Building A",
          "priority": "Medium",
          "estimatedTime": 1.5,
          "skills": ["HVAC"],
          "location": "Downtown",
          "scheduledTime": "14:00",
          "clientPhone": "+1 555-0301",
          "description": "Monthly HVAC system inspection"
        },
        {
          "id": "S002",
          "title": "Electrical Installation",
          "client": "New Restaurant",
          "priority": "Medium",
          "estimatedTime": 4.0,
          "skills": ["Electrical"],
          "location": "Restaurant Row",
          "scheduledTime": "10:00",
          "clientPhone": "+1 555-0302",
          "description": "Kitchen equipment electrical setup"
        }
      ]
    },
    {
      "status": "Pending",
      "count": 12,
      "color": disabledBoldColor,
      "jobs": [
        {
          "id": "P001",
          "title": "Plumbing Inspection",
          "client": "Apartment Complex",
          "priority": "Low",
          "estimatedTime": 2.0,
          "skills": ["Plumbing"],
          "location": "Residential Area",
          "requestedDate": "Tomorrow",
          "clientPhone": "+1 555-0401",
          "description": "Annual plumbing system inspection"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> technicians = [
    {
      "id": "1",
      "name": "John Smith",
      "status": "Available",
      "skills": ["Electrical", "HVAC", "Emergency"],
      "currentJob": null,
      "rating": 4.8,
      "location": "Downtown Area",
      "nextAvailable": "Now"
    },
    {
      "id": "2",
      "name": "Sarah Johnson",
      "status": "On Job",
      "skills": ["HVAC", "Mechanical", "Safety"],
      "currentJob": "System Installation - Factory C",
      "rating": 4.9,
      "location": "Industrial Zone",
      "nextAvailable": "14:30"
    },
    {
      "id": "3",
      "name": "Mike Davis",
      "status": "Available",
      "skills": ["Plumbing", "Emergency", "General"],
      "currentJob": null,
      "rating": 4.7,
      "location": "Residential Area",
      "nextAvailable": "Now"
    },
    {
      "id": "4",
      "name": "Emma Wilson",
      "status": "Traveling",
      "skills": ["Security", "Electrical", "Safety"],
      "currentJob": "En route to Mall Security",
      "rating": 4.6,
      "location": "Commercial Zone",
      "nextAvailable": "11:30"
    }
  ];

  bool showDispatchForm = false;
  Map<String, dynamic>? selectedJob;
  String selectedTechnician = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dispatch Board"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Dispatch board refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildDispatchSummary(),
            _buildTechnicianStatus(),
            _buildDispatchQueues(),
            if (showDispatchForm) _buildDispatchForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildDispatchSummary() {
    int totalJobs = dispatchQueues.fold(0, (sum, queue) => sum + (queue["count"] as int));
    int emergencyJobs = dispatchQueues.firstWhere((q) => q["status"] == "Emergency")["count"];
    int availableTechs = technicians.where((t) => t["status"] == "Available").length;
    int activeTechs = technicians.where((t) => t["status"] == "On Job").length;

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
            "Dispatch Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              _buildSummaryCard("Total Jobs", "$totalJobs", primaryColor),
              _buildSummaryCard("Emergency", "$emergencyJobs", dangerColor),
              _buildSummaryCard("Available", "$availableTechs", successColor),
              _buildSummaryCard("Active", "$activeTechs", infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicianStatus() {
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
            "Technician Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: technicians.map((tech) => _buildTechnicianCard(tech)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianCard(Map<String, dynamic> technician) {
    Color statusColor = technician["status"] == "Available" ? successColor :
                       technician["status"] == "On Job" ? infoColor :
                       technician["status"] == "Traveling" ? warningColor : disabledBoldColor;

    return Container(
      width: 200,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${technician["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${technician["status"]}",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
          if (technician["currentJob"] != null) ...[
            Text(
              "${technician["currentJob"]}",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
          Row(
            children: [
              Icon(Icons.location_on, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${technician["location"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Next: ${technician["nextAvailable"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.star, size: 12, color: warningColor),
              SizedBox(width: spXs),
              Text(
                "${technician["rating"]}",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${(technician["skills"] as List).length} skills",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDispatchQueues() {
    return Column(
      spacing: spMd,
      children: dispatchQueues.map((queue) => _buildQueueSection(queue)).toList(),
    );
  }

  Widget _buildQueueSection(Map<String, dynamic> queue) {
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
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: queue["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${queue["status"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (queue["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${queue["count"]} jobs",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: queue["color"] as Color,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: (queue["jobs"] as List<Map<String, dynamic>>).map((job) => 
              _buildJobCard(job, queue["color"] as Color)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job, Color categoryColor) {
    String timeLabel = job["reportedTime"] ?? job["scheduledTime"] ?? job["requestedDate"] ?? "N/A";
    String timeType = job["reportedTime"] != null ? "Reported" :
                     job["scheduledTime"] != null ? "Scheduled" : "Requested";

    return GestureDetector(
      onTap: () {
        selectedJob = job;
        showDispatchForm = true;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border(
            left: BorderSide(
              width: 3,
              color: categoryColor,
            ),
          ),
        ),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${job["id"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${job["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Client: ${job["client"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Location: ${job["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Text(
                      "$timeType:",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      timeLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${job["estimatedTime"]}h",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.build, size: 14, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    (job["skills"] as List).join(", "),
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Dispatch",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDispatchForm() {
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
          Row(
            children: [
              Text(
                "Dispatch Job",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showDispatchForm = false;
                  selectedJob = null;
                  selectedTechnician = "";
                  setState(() {});
                },
                child: Icon(Icons.close, color: disabledBoldColor),
              ),
            ],
          ),
          if (selectedJob != null) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "${selectedJob!["id"]} - ${selectedJob!["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Client: ${selectedJob!["client"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Location: ${selectedJob!["location"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Estimated Time: ${selectedJob!["estimatedTime"]}h",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Required Skills: ${(selectedJob!["skills"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (selectedJob!["description"] != null) ...[
                    SizedBox(height: spXs),
                    Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${selectedJob!["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              "Available Technicians",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              spacing: spXs,
              children: technicians.where((tech) => 
                tech["status"] == "Available" &&
                (selectedJob!["skills"] as List).any((skill) =>
                  (tech["skills"] as List).contains(skill))
              ).map((tech) => _buildTechnicianSelector(tech)).toList(),
            ),
            QMemoField(
              label: "Dispatch Notes",
              value: "",
              onChanged: (value) {},
            ),
          ],
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  color: disabledBoldColor,
                  size: bs.sm,
                  onPressed: () {
                    showDispatchForm = false;
                    selectedJob = null;
                    selectedTechnician = "";
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Dispatch Job",
                  size: bs.sm,
                  onPressed: () {
                    if (selectedTechnician.isNotEmpty) {
                      ss("Job dispatched successfully");
                      showDispatchForm = false;
                      selectedJob = null;
                      selectedTechnician = "";
                      setState(() {});
                    } else {
                      se("Please select a technician");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianSelector(Map<String, dynamic> technician) {
    bool isSelected = selectedTechnician == technician["id"];

    return GestureDetector(
      onTap: () {
        selectedTechnician = technician["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[100],
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "${technician["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Skills: ${(technician["skills"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Location: ${technician["location"]} • Rating: ${technician["rating"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: primaryColor, size: 20),
          ],
        ),
      ),
    );
  }
}
