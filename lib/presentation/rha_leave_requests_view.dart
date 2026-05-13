import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaLeaveRequestsView extends StatefulWidget {
  const RhaLeaveRequestsView({super.key});

  @override
  State<RhaLeaveRequestsView> createState() => _RhaLeaveRequestsViewState();
}

class _RhaLeaveRequestsViewState extends State<RhaLeaveRequestsView> {
  String selectedLeaveType = "Annual Leave";
  String startDate = "";
  String endDate = "";
  String reason = "";
  String emergencyContact = "";
  String coverageArrangement = "";
  bool isHalfDay = false;
  bool attachMedicalCertificate = false;
  int totalDays = 0;

  List<Map<String, dynamic>> myLeaveHistory = [
    {
      "id": "LR001",
      "leaveType": "Annual Leave",
      "startDate": "2024-05-15",
      "endDate": "2024-05-19",
      "days": 5,
      "status": "Approved",
      "reason": "Family vacation",
      "appliedDate": "2024-04-20",
      "approvedBy": "John Smith",
      "approvalDate": "2024-04-22"
    },
    {
      "id": "LR002",
      "leaveType": "Sick Leave",
      "startDate": "2024-04-08",
      "endDate": "2024-04-10",
      "days": 3,
      "status": "Approved",
      "reason": "Medical treatment",
      "appliedDate": "2024-04-07",
      "approvedBy": "John Smith",
      "approvalDate": "2024-04-07"
    },
    {
      "id": "LR003",
      "leaveType": "Personal Leave",
      "startDate": "2024-07-25",
      "endDate": "2024-07-25",
      "days": 1,
      "status": "Pending",
      "reason": "Personal appointment",
      "appliedDate": "2024-06-28",
      "approvedBy": "",
      "approvalDate": ""
    },
    {
      "id": "LR004",
      "leaveType": "Annual Leave",
      "startDate": "2024-08-12",
      "endDate": "2024-08-16",
      "days": 5,
      "status": "Under Review",
      "reason": "Summer vacation",
      "appliedDate": "2024-06-25",
      "approvedBy": "",
      "approvalDate": ""
    }
  ];

  List<Map<String, dynamic>> leaveBalance = [
    {
      "type": "Annual Leave",
      "entitled": 21,
      "used": 10,
      "pending": 5,
      "remaining": 6,
      "color": primaryColor
    },
    {
      "type": "Sick Leave",
      "entitled": 10,
      "used": 3,
      "pending": 0,
      "remaining": 7,
      "color": warningColor
    },
    {
      "type": "Personal Leave",
      "entitled": 5,
      "used": 0,
      "pending": 1,
      "remaining": 4,
      "color": infoColor
    },
    {
      "type": "Maternity/Paternity",
      "entitled": 90,
      "used": 0,
      "pending": 0,
      "remaining": 90,
      "color": successColor
    }
  ];

  List<Map<String, dynamic>> leaveTypeItems = [
    {"label": "Annual Leave", "value": "Annual Leave"},
    {"label": "Sick Leave", "value": "Sick Leave"},
    {"label": "Personal Leave", "value": "Personal Leave"},
    {"label": "Maternity/Paternity", "value": "Maternity/Paternity"},
    {"label": "Emergency Leave", "value": "Emergency Leave"}
  ];

  List<Map<String, dynamic>> upcomingLeaves = [
    {
      "employee": "Michael Chen",
      "department": "Marketing",
      "startDate": "2024-07-01",
      "endDate": "2024-07-05",
      "type": "Annual Leave",
      "days": 5
    },
    {
      "employee": "Emily Rodriguez",
      "department": "Design",
      "startDate": "2024-07-08",
      "endDate": "2024-07-08",
      "type": "Personal Leave",
      "days": 1
    },
    {
      "employee": "James Wilson",
      "department": "Sales",
      "startDate": "2024-07-15",
      "endDate": "2024-07-19",
      "type": "Annual Leave",
      "days": 5
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Under Review":
        return infoColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLeaveTypeColor(String leaveType) {
    switch (leaveType) {
      case "Annual Leave":
        return primaryColor;
      case "Sick Leave":
        return warningColor;
      case "Personal Leave":
        return infoColor;
      case "Maternity/Paternity":
        return successColor;
      case "Emergency Leave":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _calculateDays() {
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      try {
        final start = DateTime.parse(startDate);
        final end = DateTime.parse(endDate);
        final difference = end.difference(start).inDays + 1;
        totalDays = isHalfDay ? 1 : difference;
        setState(() {});
      } catch (e) {
        totalDays = 0;
      }
    }
  }

  Widget _buildRequestForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Leave Balance Summary
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
                Text(
                  "Your Leave Balance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: leaveBalance.map((balance) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (balance["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: (balance["color"] as Color).withAlpha(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "${balance["type"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: balance["color"] as Color,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Remaining",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${balance["remaining"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: balance["color"] as Color,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Used: ${balance["used"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Pending: ${balance["pending"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          // Leave Request Form
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
                Text(
                  "Request Leave",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Leave Type
                QDropdownField(
                  label: "Leave Type",
                  items: leaveTypeItems,
                  value: selectedLeaveType,
                  onChanged: (value, label) {
                    selectedLeaveType = value;
                    setState(() {});
                  },
                ),

                // Half Day Option
                QSwitch(
                  items: [
                    {
                      "label": "Half Day Leave",
                      "value": true,
                      "checked": isHalfDay,
                    }
                  ],
                  value: [
                    if (isHalfDay)
                      {
                        "label": "Half Day Leave",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    isHalfDay = values.isNotEmpty;
                    _calculateDays();
                  },
                ),

                // Dates
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Start Date",
                        value: startDate.isNotEmpty ? DateTime.parse(startDate) : null,
                        onChanged: (value) {
                          startDate = value.toString().split(' ')[0];
                          if (isHalfDay) {
                            endDate = startDate;
                          }
                          _calculateDays();
                        },
                      ),
                    ),
                    if (!isHalfDay)
                      Expanded(
                        child: QDatePicker(
                          label: "End Date",
                          value: endDate.isNotEmpty ? DateTime.parse(endDate) : null,
                          onChanged: (value) {
                            endDate = value.toString().split(' ')[0];
                            _calculateDays();
                          },
                        ),
                      ),
                  ],
                ),

                // Total Days Display
                if (totalDays > 0)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Total Leave Days: $totalDays",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Reason
                QMemoField(
                  label: "Reason for Leave",
                  value: reason,
                  hint: "Please provide a brief reason for your leave request",
                  onChanged: (value) {
                    reason = value;
                    setState(() {});
                  },
                ),

                // Coverage Arrangement
                QMemoField(
                  label: "Work Coverage Arrangement",
                  value: coverageArrangement,
                  hint: "Describe how your work will be covered during your absence",
                  onChanged: (value) {
                    coverageArrangement = value;
                    setState(() {});
                  },
                ),

                // Emergency Contact
                QTextField(
                  label: "Emergency Contact",
                  value: emergencyContact,
                  hint: "Contact person during your leave",
                  onChanged: (value) {
                    emergencyContact = value;
                    setState(() {});
                  },
                ),

                // Medical Certificate for Sick Leave
                if (selectedLeaveType == "Sick Leave")
                  QSwitch(
                    items: [
                      {
                        "label": "Attach Medical Certificate",
                        "value": true,
                        "checked": attachMedicalCertificate,
                      }
                    ],
                    value: [
                      if (attachMedicalCertificate)
                        {
                          "label": "Attach Medical Certificate",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      attachMedicalCertificate = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                // Submit Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Submit Leave Request",
                    icon: Icons.send,
                    onPressed: () {
                      if (startDate.isEmpty || reason.isEmpty) {
                        se("Please fill in all required fields");
                        return;
                      }
                      ss("Leave request submitted successfully");
                      // Reset form
                      startDate = "";
                      endDate = "";
                      reason = "";
                      emergencyContact = "";
                      coverageArrangement = "";
                      isHalfDay = false;
                      attachMedicalCertificate = false;
                      totalDays = 0;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
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
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.assignment,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Requests",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${myLeaveHistory.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.pending,
                            color: warningColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pending",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${myLeaveHistory.where((req) => req["status"] == "Pending" || req["status"] == "Under Review").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Approved",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${myLeaveHistory.where((req) => req["status"] == "Approved").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Leave History
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
                Text(
                  "My Leave History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...myLeaveHistory.map((request) => Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: _getLeaveTypeColor("${request["leaveType"]}").withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: _getLeaveTypeColor("${request["leaveType"]}").withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      // Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getLeaveTypeColor("${request["leaveType"]}"),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${request["leaveType"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${request["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${request["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${request["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Leave Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${DateTime.parse("${request["startDate"]}").dMMMy} - ${DateTime.parse("${request["endDate"]}").dMMMy}",
                                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${request["days"]} day${(request["days"] as int) > 1 ? 's' : ''}",
                                      style: TextStyle(fontSize: 14, color: disabledBoldColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: spXs,
                            children: [
                              Text(
                                "Applied: ${DateTime.parse("${request["appliedDate"]}").dMMMy}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                              if (request["approvalDate"] != null && "${request["approvalDate"]}".isNotEmpty)
                                Text(
                                  "Approved: ${DateTime.parse("${request["approvalDate"]}").dMMMy}",
                                  style: TextStyle(fontSize: 12, color: successColor),
                                ),
                            ],
                          ),
                        ],
                      ),

                      // Reason
                      if (request["reason"] != null && "${request["reason"]}".isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.notes, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${request["reason"]}",
                                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Actions for pending requests
                      if (request["status"] == "Pending" || request["status"] == "Under Review")
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Modify",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Modify request ${request["id"]}");
                                },
                              ),
                            ),
                            QButton(
                              label: "Cancel",
                              size: bs.sm,
                              onPressed: () {
                                sw("Cancel request ${request["id"]}");
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCalendarTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Team Leave Calendar",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "July 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "View your team's upcoming leave schedules to plan better",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Upcoming Team Leaves
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
                Text(
                  "Upcoming Team Leaves",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...upcomingLeaves.map((leave) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: _getLeaveTypeColor("${leave["type"]}").withAlpha(20),
                        child: Text(
                          "${leave["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getLeaveTypeColor("${leave["type"]}"),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${leave["employee"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${leave["department"]} • ${leave["type"]}",
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
                        children: [
                          Text(
                            "${DateTime.parse("${leave["startDate"]}").dMMMy} - ${DateTime.parse("${leave["endDate"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${leave["days"]} day${(leave["days"] as int) > 1 ? 's' : ''}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getLeaveTypeColor("${leave["type"]}"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Leave Types Legend
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
                Text(
                  "Leave Types",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: [
                    _buildLegendItem("Annual Leave", primaryColor),
                    _buildLegendItem("Sick Leave", warningColor),
                    _buildLegendItem("Personal Leave", infoColor),
                    _buildLegendItem("Maternity/Paternity", successColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Leave Requests",
      selectedIndex: 0,
      tabs: [
        Tab(text: "New Request", icon: Icon(Icons.add)),
        Tab(text: "My Requests", icon: Icon(Icons.assignment)),
        Tab(text: "Team Calendar", icon: Icon(Icons.calendar_today)),
      ],
      tabChildren: [
        _buildRequestForm(),
        _buildMyRequestsTab(),
        _buildTeamCalendarTab(),
      ],
    );
  }
}
