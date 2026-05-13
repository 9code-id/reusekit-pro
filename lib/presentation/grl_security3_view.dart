import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity3View extends StatefulWidget {
  @override
  State<GrlSecurity3View> createState() => _GrlSecurity3ViewState();
}

class _GrlSecurity3ViewState extends State<GrlSecurity3View> {
  List<Map<String, dynamic>> securityLogs = [
    {
      "action": "Successful Login",
      "device": "iPhone 13 Pro",
      "location": "New York, NY",
      "timestamp": "2 hours ago",
      "ip": "192.168.1.105",
      "status": "success",
      "icon": Icons.login
    },
    {
      "action": "Password Changed",
      "device": "MacBook Pro",
      "location": "New York, NY",
      "timestamp": "1 day ago",
      "ip": "192.168.1.102",
      "status": "warning",
      "icon": Icons.lock_reset
    },
    {
      "action": "Failed Login Attempt",
      "device": "Unknown Device",
      "location": "Los Angeles, CA",
      "timestamp": "2 days ago",
      "ip": "203.45.67.89",
      "status": "danger",
      "icon": Icons.warning
    },
    {
      "action": "Two-Factor Auth Enabled",
      "device": "iPad Air",
      "location": "Boston, MA",
      "timestamp": "3 days ago",
      "ip": "192.168.1.108",
      "status": "success",
      "icon": Icons.security
    },
    {
      "action": "Device Added",
      "device": "Samsung Galaxy",
      "location": "Miami, FL",
      "timestamp": "5 days ago",
      "ip": "156.78.90.123",
      "status": "info",
      "icon": Icons.devices
    },
    {
      "action": "Suspicious Activity Detected",
      "device": "Unknown Device",
      "location": "Unknown",
      "timestamp": "1 week ago",
      "ip": "45.67.89.123",
      "status": "danger",
      "icon": Icons.report_problem
    },
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Success", "Warning", "Danger", "Info"];

  Color getStatusColor(String status) {
    switch (status) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "danger":
        return dangerColor;
      case "info":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Activity"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.file_download,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.shield_outlined,
                    size: 30,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Security Activity Log",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Monitor all security events for your account",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            QCategoryPicker(
              label: "Filter Activity",
              items: filterOptions.map((filter) => {
                "label": filter,
                "value": filter,
              }).toList(),
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Security logs are kept for 90 days. Export logs for longer retention.",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Column(
              children: securityLogs.map((log) {
                Color statusColor = getStatusColor(log["status"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              log["icon"],
                              size: 20,
                              color: statusColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${log["action"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${log["device"]} • ${log["location"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${log["status"].toString().toUpperCase()}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${log["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.public,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "IP: ${log["ip"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                                fontFamily: 'monospace',
                              ),
                            ),
                            Spacer(),
                            if (log["status"] == "danger")
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Block IP",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Activity",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
