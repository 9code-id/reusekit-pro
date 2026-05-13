import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCheckInSystemView extends StatefulWidget {
  const EcmCheckInSystemView({super.key});

  @override
  State<EcmCheckInSystemView> createState() => _EcmCheckInSystemViewState();
}

class _EcmCheckInSystemViewState extends State<EcmCheckInSystemView> {
  String qrCodeInput = "";
  String searchQuery = "";
  bool isScanning = false;
  String selectedCheckInMethod = "qr";

  List<Map<String, dynamic>> recentCheckIns = [
    {
      "id": 1,
      "name": "Alex Johnson",
      "email": "alex.johnson@company.com",
      "company": "Tech Solutions Inc",
      "avatar": "https://picsum.photos/60/60?random=1&face",
      "check_in_time": DateTime.now().subtract(Duration(minutes: 5)),
      "ticket_type": "VIP",
      "method": "QR Code",
    },
    {
      "id": 2,
      "name": "Sarah Chen",
      "email": "sarah.chen@startup.io",
      "company": "Innovation Labs",
      "avatar": "https://picsum.photos/60/60?random=2&face",
      "check_in_time": DateTime.now().subtract(Duration(minutes: 12)),
      "ticket_type": "Standard",
      "method": "Manual",
    },
    {
      "id": 3,
      "name": "Michael Rodriguez",
      "email": "m.rodriguez@enterprise.com",
      "company": "Enterprise Corp",
      "avatar": "https://picsum.photos/60/60?random=3&face",
      "check_in_time": DateTime.now().subtract(Duration(minutes: 18)),
      "ticket_type": "VIP",
      "method": "QR Code",
    },
  ];

  List<Map<String, dynamic>> searchResults = [];

  List<Map<String, dynamic>> checkInMethods = [
    {"label": "QR Code Scan", "value": "qr"},
    {"label": "Manual Search", "value": "manual"},
    {"label": "Badge Scan", "value": "badge"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check-In System"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Settings not implemented");
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
            _buildCheckInStats(),
            _buildCheckInMethods(),
            _buildCheckInInterface(),
            _buildRecentCheckIns(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckInStats() {
    int totalCheckIns = recentCheckIns.length;
    int todayCheckIns = recentCheckIns
        .where((c) => (c["check_in_time"] as DateTime).isAfter(
            DateTime.now().subtract(Duration(days: 1))))
        .length;

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
                  Icons.people,
                  size: 32,
                  color: successColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "$todayCheckIns",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Today's Check-ins",
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
                  Icons.access_time,
                  size: 32,
                  color: primaryColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "2.3",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Avg. Check-in Time",
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
                  Icons.qr_code_scanner,
                  size: 32,
                  color: infoColor,
                ),
                SizedBox(height: spXs),
                Text(
                  "95%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "QR Success Rate",
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

  Widget _buildCheckInMethods() {
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
            "Check-in Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: checkInMethods,
            value: selectedCheckInMethod,
            onChanged: (index, label, value, item) {
              selectedCheckInMethod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInInterface() {
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
            "Check-in Interface",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (selectedCheckInMethod == "qr") _buildQRScanner(),
          if (selectedCheckInMethod == "manual") _buildManualSearch(),
          if (selectedCheckInMethod == "badge") _buildBadgeScanner(),
        ],
      ),
    );
  }

  Widget _buildQRScanner() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: 64,
                color: isScanning ? primaryColor : disabledBoldColor,
              ),
              SizedBox(height: spSm),
              Text(
                isScanning ? "Scanning for QR Code..." : "Position QR Code in the frame",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isScanning ? primaryColor : disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Or enter QR code manually",
                value: qrCodeInput,
                hint: "ATT-2024-001-VIP",
                onChanged: (value) {
                  qrCodeInput = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.check,
              size: bs.sm,
              onPressed: () {
                if (qrCodeInput.isNotEmpty) {
                  _processCheckIn("QR Code", qrCodeInput);
                }
              },
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: isScanning ? "Stop Scanning" : "Start QR Scanner",
            size: bs.md,
            onPressed: () {
              isScanning = !isScanning;
              setState(() {});
              if (isScanning) {
                si("QR Scanner started");
                // Simulate finding QR code after 3 seconds
                Future.delayed(Duration(seconds: 3), () {
                  if (isScanning) {
                    _processCheckIn("QR Code", "ATT-2024-${DateTime.now().millisecondsSinceEpoch % 1000}-VIP");
                    isScanning = false;
                    setState(() {});
                  }
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildManualSearch() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search attendee",
                value: searchQuery,
                hint: "Name, email, or ticket number",
                onChanged: (value) {
                  searchQuery = value;
                  _performSearch();
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.search,
              size: bs.sm,
              onPressed: () {
                _performSearch();
              },
            ),
          ],
        ),
        if (searchResults.isNotEmpty) ...[
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final attendee = searchResults[index];
                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("https://picsum.photos/40/40?random=${index + 10}&face"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Attendee ${index + 1}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "example${index + 1}@company.com",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Check In",
                        size: bs.sm,
                        onPressed: () {
                          _processCheckIn("Manual", "Attendee ${index + 1}");
                          searchResults.clear();
                          searchQuery = "";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ] else if (searchQuery.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_off,
                  color: warningColor,
                ),
                SizedBox(width: spSm),
                Text(
                  "No attendees found for '$searchQuery'",
                  style: TextStyle(
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBadgeScanner() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.badge,
                size: 48,
                color: infoColor,
              ),
              SizedBox(height: spSm),
              Text(
                "Tap or scan badge to check in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: infoColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Simulate Badge Scan",
            size: bs.md,
            onPressed: () {
              _processCheckIn("Badge", "BADGE-${DateTime.now().millisecondsSinceEpoch % 1000}");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCheckIns() {
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
                "Recent Check-ins",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${recentCheckIns.length} total",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...recentCheckIns.map((checkIn) => _buildCheckInItem(checkIn)),
        ],
      ),
    );
  }

  Widget _buildCheckInItem(Map<String, dynamic> checkIn) {
    DateTime checkInTime = checkIn["check_in_time"] as DateTime;
    String timeAgo = _getTimeAgo(checkInTime);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border(
          left: BorderSide(
            width: 3,
            color: successColor,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage("${checkIn["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${checkIn["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${checkIn["company"]}",
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
                  color: checkIn["ticket_type"] == "VIP" ? warningColor : infoColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${checkIn["ticket_type"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                timeAgo,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${checkIn["method"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    if (searchQuery.isEmpty) {
      searchResults.clear();
      setState(() {});
      return;
    }

    // Simulate search results
    searchResults = List.generate(3, (index) => {
      "id": index + 10,
      "name": "Search Result ${index + 1}",
      "email": "result${index + 1}@company.com",
    });
    setState(() {});
  }

  void _processCheckIn(String method, String identifier) {
    // Simulate check-in process
    Map<String, dynamic> newCheckIn = {
      "id": DateTime.now().millisecondsSinceEpoch,
      "name": "New Attendee",
      "email": "attendee@company.com",
      "company": "Demo Company",
      "avatar": "https://picsum.photos/60/60?random=${DateTime.now().millisecondsSinceEpoch % 100}&face",
      "check_in_time": DateTime.now(),
      "ticket_type": "Standard",
      "method": method,
    };

    recentCheckIns.insert(0, newCheckIn);
    if (recentCheckIns.length > 10) {
      recentCheckIns.removeLast();
    }

    qrCodeInput = "";
    setState(() {});
    ss("Check-in successful via $method");
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
