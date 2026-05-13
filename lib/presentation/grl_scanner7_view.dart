import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlScanner7View extends StatefulWidget {
  @override
  State<GrlScanner7View> createState() => _GrlScanner7ViewState();
}

class _GrlScanner7ViewState extends State<GrlScanner7View> {
  String currentSessionId = "SES-20240115-001";
  String sessionName = "Product Inventory";
  DateTime sessionStartTime = DateTime.now().subtract(Duration(minutes: 45));
  int sessionScans = 127;
  bool isSessionActive = true;
  
  List<Map<String, dynamic>> recentScans = [
    {
      "id": "1",
      "content": "PRD-45789",
      "timestamp": "14:30:25",
      "type": "Product",
    },
    {
      "id": "2",
      "content": "PRD-45788",
      "timestamp": "14:29:42",
      "type": "Product",
    },
    {
      "id": "3",
      "content": "PRD-45787",
      "timestamp": "14:28:55",
      "type": "Product",
    },
    {
      "id": "4",
      "content": "PRD-45786",
      "timestamp": "14:28:12",
      "type": "Product",
    },
    {
      "id": "5",
      "content": "PRD-45785",
      "timestamp": "14:27:33",
      "type": "Product",
    },
  ];
  
  List<Map<String, dynamic>> sessionTemplates = [
    {
      "name": "Product Inventory",
      "description": "Scan product barcodes for inventory management",
      "icon": Icons.inventory,
      "scansCount": 156,
    },
    {
      "name": "Document Archive",
      "description": "Scan QR codes on documents for digital archival",
      "icon": Icons.archive,
      "scansCount": 89,
    },
    {
      "name": "Asset Tracking",
      "description": "Track company assets with QR code scanning",
      "icon": Icons.business_center,
      "scansCount": 234,
    },
    {
      "name": "Event Check-in",
      "description": "Scan attendee tickets for event management",
      "icon": Icons.event,
      "scansCount": 67,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Sessions"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to session history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Active Session Card
            if (isSessionActive)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.fiber_manual_record,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Active Session",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showSessionOptions();
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: successColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      sessionName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      spacing: spMd,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Session ID",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                currentSessionId,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Duration",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.now().difference(sessionStartTime).inMinutes} minutes",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Scans",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "$sessionScans",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Continue Scanning",
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to scanner
                            },
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "End Session",
                            size: bs.sm,
                            onPressed: () {
                              _endSession();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            
            // Recent Scans (if session active)
            if (isSessionActive)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Recent Scans",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "Last 5 scans",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    ...recentScans.map((scan) => Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.qr_code,
                              color: primaryColor,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 2,
                              children: [
                                Text(
                                  "${scan["content"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                Text(
                                  "${scan["timestamp"]}",
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
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${scan["type"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            
            // Session Templates (if no active session)
            if (!isSessionActive)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Start New Session",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Choose a template or start a custom session",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...sessionTemplates.map((template) => GestureDetector(
                      onTap: () {
                        _startSession(template["name"]);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: disabledOutlineBorderColor),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                template["icon"],
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${template["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${template["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${template["scansCount"]} scans completed",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
                    
                    // Custom Session Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Start Custom Session",
                        size: bs.md,
                        onPressed: () {
                          _showCustomSessionDialog();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            
            // Session Statistics
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Session Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "24",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Sessions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "1,247",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Total Scans",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "52",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Avg/Session",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _startSession(String templateName) {
    setState(() {
      isSessionActive = true;
      sessionName = templateName;
      currentSessionId = "SES-${DateTime.now().millisecondsSinceEpoch}";
      sessionStartTime = DateTime.now();
      sessionScans = 0;
    });
    ss("Session '$templateName' started");
  }
  
  void _endSession() async {
    bool isConfirmed = await confirm("Are you sure you want to end the current session?");
    if (isConfirmed) {
      setState(() {
        isSessionActive = false;
      });
      ss("Session ended successfully");
    }
  }
  
  void _showSessionOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            Text(
              "Session Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            _buildOptionItem(Icons.pause, "Pause Session"),
            _buildOptionItem(Icons.save, "Save Session"),
            _buildOptionItem(Icons.share, "Export Data"),
            _buildOptionItem(Icons.stop, "End Session", color: dangerColor),
          ],
        ),
      ),
    );
  }
  
  void _showCustomSessionDialog() {
    String customSessionName = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Start Custom Session"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Session Name",
              value: customSessionName,
              onChanged: (value) {
                customSessionName = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              if (customSessionName.isNotEmpty) {
                _startSession(customSessionName);
              }
            },
            child: Text("Start"),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOptionItem(IconData icon, String title, {Color? color}) {
    return GestureDetector(
      onTap: () {
        back();
        ss("$title selected");
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        child: Row(
          spacing: spSm,
          children: [
            Icon(
              icon,
              color: color ?? disabledBoldColor,
              size: 24,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color ?? Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
