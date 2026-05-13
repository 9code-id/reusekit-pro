import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmWaitlistManagementView extends StatefulWidget {
  const EcmWaitlistManagementView({super.key});

  @override
  State<EcmWaitlistManagementView> createState() => _EcmWaitlistManagementViewState();
}

class _EcmWaitlistManagementViewState extends State<EcmWaitlistManagementView> {
  String selectedStatus = "all";
  String selectedPriority = "all";
  bool autoApprove = false;

  List<Map<String, dynamic>> waitlistEntries = [
    {
      "id": 1,
      "name": "Emma Wilson",
      "email": "emma.wilson@company.com",
      "company": "Digital Innovations",
      "position": "Marketing Director",
      "requested_ticket": "VIP",
      "status": "pending",
      "priority": "high",
      "request_date": DateTime.now().subtract(Duration(hours: 2)),
      "reason": "Company sponsor, key stakeholder meeting scheduled",
      "phone": "+1 555-0126",
      "avatar": "https://picsum.photos/60/60?random=1&face",
      "referral": "John Smith - CEO",
    },
    {
      "id": 2,
      "name": "David Chen",
      "email": "david.chen@startup.co",
      "company": "TechStart",
      "position": "CTO",
      "requested_ticket": "Standard",
      "status": "approved",
      "priority": "medium",
      "request_date": DateTime.now().subtract(Duration(hours: 5)),
      "reason": "Last minute business trip cancellation, very interested in attending",
      "phone": "+1 555-0127",
      "avatar": "https://picsum.photos/60/60?random=2&face",
      "referral": null,
    },
    {
      "id": 3,
      "name": "Lisa Rodriguez",
      "email": "lisa.r@enterprise.com",
      "company": "Enterprise Solutions",
      "position": "Product Manager",
      "requested_ticket": "VIP",
      "status": "rejected",
      "priority": "low",
      "request_date": DateTime.now().subtract(Duration(days: 1)),
      "reason": "Interested in networking and learning about new technologies",
      "phone": "+1 555-0128",
      "avatar": "https://picsum.photos/60/60?random=3&face",
      "referral": "Sarah Johnson - Sales Director",
    },
    {
      "id": 4,
      "name": "Mark Thompson",
      "email": "mark.t@consulting.org",
      "company": "Business Consulting",
      "position": "Senior Consultant",
      "requested_ticket": "Standard",
      "status": "pending",
      "priority": "high",
      "request_date": DateTime.now().subtract(Duration(minutes: 30)),
      "reason": "Client requested attendance for market research purposes",
      "phone": "+1 555-0129",
      "avatar": "https://picsum.photos/60/60?random=4&face",
      "referral": null,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waitlist Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("Notifications not implemented");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildStatisticsCards(),
            _buildFiltersAndSettings(),
            _buildWaitlistEntries(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCards() {
    int pendingCount = waitlistEntries.where((e) => e["status"] == "pending").length;
    int approvedCount = waitlistEntries.where((e) => e["status"] == "approved").length;
    int rejectedCount = waitlistEntries.where((e) => e["status"] == "rejected").length;
    int highPriorityCount = waitlistEntries.where((e) => e["priority"] == "high").length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.pending,
                  size: 28,
                  color: warningColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$pendingCount",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Pending",
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
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 28,
                  color: successColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$approvedCount",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Approved",
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
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cancel,
                  size: 28,
                  color: dangerColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$rejectedCount",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Rejected",
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
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.priority_high,
                  size: 28,
                  color: dangerColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$highPriorityCount",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "High Priority",
                  textAlign: TextAlign.center,
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
    );
  }

  Widget _buildFiltersAndSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Filters & Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
          QSwitch(
            items: [
              {
                "label": "Auto-approve standard requests",
                "value": true,
                "checked": autoApprove,
              }
            ],
            value: [
              if (autoApprove)
                {
                  "label": "Auto-approve standard requests",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              autoApprove = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWaitlistEntries() {
    List<Map<String, dynamic>> filteredEntries = waitlistEntries.where((entry) {
      bool statusMatch = selectedStatus == "all" || entry["status"] == selectedStatus;
      bool priorityMatch = selectedPriority == "all" || entry["priority"] == selectedPriority;
      return statusMatch && priorityMatch;
    }).toList();

    // Sort by priority and date
    filteredEntries.sort((a, b) {
      int priorityCompare = _getPriorityWeight(b["priority"]) - _getPriorityWeight(a["priority"]);
      if (priorityCompare != 0) return priorityCompare;
      return (b["request_date"] as DateTime).compareTo(a["request_date"] as DateTime);
    });

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Waitlist Entries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredEntries.length} entries",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredEntries.isEmpty) ...[
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 32,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "No waitlist entries found",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...filteredEntries.map((entry) => _buildWaitlistCard(entry)),
          ],
        ],
      ),
    );
  }

  Widget _buildWaitlistCard(Map<String, dynamic> entry) {
    String status = entry["status"];
    String priority = entry["priority"];
    DateTime requestDate = entry["request_date"] as DateTime;
    
    Color statusColor = status == "pending" ? warningColor :
                       status == "approved" ? successColor : dangerColor;
    
    Color priorityColor = priority == "high" ? dangerColor :
                         priority == "medium" ? warningColor : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${entry["avatar"]}"),
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
                            "${entry["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${priority.toUpperCase()}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${entry["position"]} at ${entry["company"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${entry["email"]}",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.request_quote,
                      size: 14,
                      color: primaryColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Requested: ${entry["requested_ticket"]} Ticket",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Requested ${_getTimeAgo(requestDate)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if (entry["referral"] != null) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 14,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Referred by: ${entry["referral"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                Text(
                  "Reason: ${entry["reason"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      status == "pending" ? Icons.schedule :
                      status == "approved" ? Icons.check_circle :
                      Icons.cancel,
                      size: 14,
                      color: Colors.white,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                "${entry["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (status == "pending") ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Approve",
                    size: bs.sm,
                    onPressed: () async {
                      bool confirmed = await confirm("Approve waitlist request for ${entry["name"]}?");
                      if (confirmed) {
                        entry["status"] = "approved";
                        setState(() {});
                        ss("${entry["name"]} approved and notified");
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Reject",
                    size: bs.sm,
                    onPressed: () async {
                      bool confirmed = await confirm("Reject waitlist request for ${entry["name"]}?");
                      if (confirmed) {
                        entry["status"] = "rejected";
                        setState(() {});
                        sw("${entry["name"]} rejected and notified");
                      }
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  onPressed: () {
                    si("Message feature not implemented");
                  },
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {
                      si("Detail view not implemented");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Send Message",
                    size: bs.sm,
                    onPressed: () {
                      si("Message feature not implemented");
                    },
                  ),
                ),
                if (status == "approved") ...[
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.email,
                    size: bs.sm,
                    onPressed: () {
                      ss("Registration email sent to ${entry["name"]}");
                    },
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  int _getPriorityWeight(String priority) {
    switch (priority) {
      case "high":
        return 3;
      case "medium":
        return 2;
      case "low":
        return 1;
      default:
        return 0;
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 1) {
      return "just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }
}
