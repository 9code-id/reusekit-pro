import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmBadgePrintingView extends StatefulWidget {
  const EcmBadgePrintingView({super.key});

  @override
  State<EcmBadgePrintingView> createState() => _EcmBadgePrintingViewState();
}

class _EcmBadgePrintingViewState extends State<EcmBadgePrintingView> {
  String selectedTemplate = "standard";
  String selectedPrinter = "printer_1";
  bool isPrinting = false;
  String printStatus = "Ready";

  List<Map<String, dynamic>> badgeTemplates = [
    {
      "id": "standard",
      "name": "Standard Badge",
      "description": "Basic attendee information with logo",
      "preview": "https://picsum.photos/200/300?random=1&business",
    },
    {
      "id": "vip",
      "name": "VIP Badge",
      "description": "Premium design with special border",
      "preview": "https://picsum.photos/200/300?random=2&business",
    },
    {
      "id": "speaker",
      "name": "Speaker Badge",
      "description": "Distinguished design for speakers",
      "preview": "https://picsum.photos/200/300?random=3&business",
    },
    {
      "id": "staff",
      "name": "Staff Badge",
      "description": "Official staff identification",
      "preview": "https://picsum.photos/200/300?random=4&business",
    },
  ];

  List<Map<String, dynamic>> printers = [
    {
      "id": "printer_1",
      "name": "Badge Printer 1",
      "status": "Online",
      "location": "Registration Desk A",
      "paper_level": 85,
    },
    {
      "id": "printer_2",
      "name": "Badge Printer 2",
      "status": "Online",
      "location": "Registration Desk B",
      "paper_level": 92,
    },
    {
      "id": "printer_3",
      "name": "VIP Printer",
      "status": "Offline",
      "location": "VIP Lounge",
      "paper_level": 45,
    },
  ];

  List<Map<String, dynamic>> printQueue = [
    {
      "id": 1,
      "attendee_name": "Alex Johnson",
      "template": "VIP Badge",
      "status": "Printing",
      "priority": "High",
      "queue_time": DateTime.now().subtract(Duration(minutes: 2)),
    },
    {
      "id": 2,
      "attendee_name": "Sarah Chen",
      "template": "Standard Badge",
      "status": "Queued",
      "priority": "Normal",
      "queue_time": DateTime.now().subtract(Duration(minutes: 1)),
    },
    {
      "id": 3,
      "attendee_name": "Michael Rodriguez",
      "template": "Speaker Badge",
      "status": "Queued",
      "priority": "High",
      "queue_time": DateTime.now(),
    },
  ];

  Map<String, dynamic> sampleAttendee = {
    "name": "John Doe",
    "company": "Sample Company",
    "position": "Software Developer",
    "ticket_type": "Standard",
    "email": "john.doe@sample.com",
    "avatar": "https://picsum.photos/100/100?random=5&face",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Badge Printing"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Printer settings not implemented");
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
            _buildPrinterStatus(),
            _buildBadgeDesigner(),
            _buildPrintQueue(),
            _buildPrintActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrinterStatus() {
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
            "Printer Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...printers.map((printer) => _buildPrinterItem(printer)),
        ],
      ),
    );
  }

  Widget _buildPrinterItem(Map<String, dynamic> printer) {
    bool isOnline = printer["status"] == "Online";
    int paperLevel = printer["paper_level"] as int;
    Color statusColor = isOnline ? successColor : dangerColor;
    Color paperColor = paperLevel > 50 ? successColor : paperLevel > 20 ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: statusColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.print,
            color: statusColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${printer["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${printer["location"]}",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${printer["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.description,
                    size: 12,
                    color: paperColor,
                  ),
                  SizedBox(width: 2),
                  Text(
                    "$paperLevel%",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: paperColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeDesigner() {
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
            "Badge Designer",
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
                  label: "Badge Template",
                  items: badgeTemplates.map((template) => {
                    "label": template["name"],
                    "value": template["id"],
                  }).toList(),
                  value: selectedTemplate,
                  onChanged: (value, label) {
                    selectedTemplate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Printer",
                  items: printers.where((p) => p["status"] == "Online").map((printer) => {
                    "label": printer["name"],
                    "value": printer["id"],
                  }).toList(),
                  value: selectedPrinter,
                  onChanged: (value, label) {
                    selectedPrinter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildBadgePreview(),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildBadgeDetails(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgePreview() {
    Map<String, dynamic>? template = badgeTemplates.firstWhere(
      (t) => t["id"] == selectedTemplate,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Preview",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
            boxShadow: [shadowSm],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${sampleAttendee["avatar"]}"),
              ),
              SizedBox(height: spSm),
              Text(
                "${sampleAttendee["name"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${sampleAttendee["position"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${sampleAttendee["company"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: selectedTemplate == "vip" ? warningColor : 
                        selectedTemplate == "speaker" ? infoColor :
                        selectedTemplate == "staff" ? dangerColor : primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  template["name"],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeDetails() {
    Map<String, dynamic>? template = badgeTemplates.firstWhere(
      (t) => t["id"] == selectedTemplate,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Template Details",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusXs),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                template["name"],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                template["description"],
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              _buildDetailRow("Size", "3.5\" x 2.125\""),
              _buildDetailRow("Orientation", "Landscape"),
              _buildDetailRow("Colors", "Full Color"),
              _buildDetailRow("Material", "PVC Card"),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Customize Template",
                  size: bs.sm,
                  onPressed: () {
                    si("Template customization not implemented");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPrintQueue() {
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
                "Print Queue",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${printQueue.length} items",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (printQueue.isEmpty) ...[
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
                    Icons.print_disabled,
                    size: 32,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "No items in print queue",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...printQueue.map((item) => _buildQueueItem(item)),
          ],
        ],
      ),
    );
  }

  Widget _buildQueueItem(Map<String, dynamic> item) {
    String status = item["status"];
    Color statusColor = status == "Printing" ? infoColor : 
                       status == "Completed" ? successColor :
                       status == "Error" ? dangerColor : warningColor;
    
    String priority = item["priority"];
    bool isHighPriority = priority == "High";

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border(
          left: BorderSide(
            width: 3,
            color: isHighPriority ? dangerColor : statusColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            status == "Printing" ? Icons.print : 
            status == "Completed" ? Icons.check_circle :
            status == "Error" ? Icons.error : Icons.schedule,
            color: statusColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${item["attendee_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (isHighPriority) ...[
                      SizedBox(width: spXs),
                      Icon(
                        Icons.priority_high,
                        size: 14,
                        color: dangerColor,
                      ),
                    ],
                  ],
                ),
                Text(
                  "${item["template"]}",
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                _getTimeAgo(item["queue_time"] as DateTime),
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

  Widget _buildPrintActions() {
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
            "Print Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (isPrinting) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Printing in Progress",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          printStatus,
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Print Test Badge",
                  size: bs.sm,
                  onPressed: isPrinting ? null : () {
                    _startPrinting("Test Badge");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Print Sample",
                  size: bs.sm,
                  onPressed: isPrinting ? null : () {
                    _startPrinting("Sample Badge for ${sampleAttendee["name"]}");
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Clear Queue",
                  size: bs.sm,
                  onPressed: () async {
                    bool confirmed = await confirm("Clear all items from print queue?");
                    if (confirmed) {
                      printQueue.clear();
                      setState(() {});
                      ss("Print queue cleared");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Bulk Print",
                  size: bs.sm,
                  onPressed: () {
                    si("Bulk printing not implemented");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startPrinting(String jobName) {
    isPrinting = true;
    printStatus = "Preparing print job...";
    setState(() {});

    // Simulate printing process
    Future.delayed(Duration(seconds: 2), () {
      printStatus = "Sending to printer...";
      setState(() {});
    });

    Future.delayed(Duration(seconds: 4), () {
      printStatus = "Printing...";
      setState(() {});
    });

    Future.delayed(Duration(seconds: 6), () {
      isPrinting = false;
      printStatus = "Ready";
      setState(() {});
      ss("$jobName printed successfully");
    });
  }

  String _getTimeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }
}
