import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEvent3View extends StatefulWidget {
  @override
  State<GrlEvent3View> createState() => _GrlEvent3ViewState();
}

class _GrlEvent3ViewState extends State<GrlEvent3View> {
  String selectedTab = "Upcoming";
  String selectedFilter = "All";
  String searchQuery = "";
  bool showMap = false;
  String selectedLocation = "All Locations";

  List<Map<String, dynamic>> myEvents = [
    {
      "id": 1,
      "title": "Flutter Conference 2024",
      "category": "Technology",
      "date": "2024-07-15",
      "time": "09:00",
      "location": "Tech Center",
      "city": "San Francisco",
      "status": "confirmed",
      "image": "https://picsum.photos/300/200?random=1&keyword=conference",
      "price": 299.0,
      "attendees": 250,
      "isVirtual": false,
      "ticketType": "Premium",
      "qrCode": "FLTR2024001"
    },
    {
      "id": 2,
      "title": "Digital Marketing Summit",
      "category": "Business",
      "date": "2024-07-20",
      "time": "10:00",
      "location": "Business Hub",
      "city": "New York",
      "status": "pending",
      "image": "https://picsum.photos/300/200?random=2&keyword=marketing",
      "price": 199.0,
      "attendees": 180,
      "isVirtual": true,
      "ticketType": "Standard",
      "qrCode": "DIGI2024002"
    },
    {
      "id": 3,
      "title": "Design Thinking Workshop",
      "category": "Design",
      "date": "2024-06-10",
      "time": "14:00",
      "location": "Creative Space",
      "city": "Los Angeles",
      "status": "attended",
      "image": "https://picsum.photos/300/200?random=3&keyword=design",
      "price": 149.0,
      "attendees": 50,
      "isVirtual": false,
      "ticketType": "Workshop",
      "qrCode": "DSGN2024003"
    },
    {
      "id": 4,
      "title": "AI & Machine Learning Expo",
      "category": "Technology",
      "date": "2024-08-05",
      "time": "09:30",
      "location": "Innovation Center",
      "city": "Seattle",
      "status": "cancelled",
      "image": "https://picsum.photos/300/200?random=4&keyword=ai",
      "price": 399.0,
      "attendees": 500,
      "isVirtual": false,
      "ticketType": "VIP",
      "qrCode": "AIML2024004"
    }
  ];

  List<String> tabItems = ["Upcoming", "Past", "Cancelled"];
  
  List<String> filterItems = ["All", "Technology", "Business", "Design", "Health"];
  
  List<String> locationItems = ["All Locations", "San Francisco", "New York", "Los Angeles", "Seattle"];

  List<Map<String, dynamic>> get filteredEvents {
    return myEvents.where((event) {
      bool matchesTab = true;
      DateTime eventDate = DateTime.parse("${event["date"]} ${event["time"]}:00");
      DateTime now = DateTime.now();
      
      if (selectedTab == "Upcoming") {
        matchesTab = eventDate.isAfter(now) && event["status"] != "cancelled";
      } else if (selectedTab == "Past") {
        matchesTab = eventDate.isBefore(now) && event["status"] == "attended";
      } else if (selectedTab == "Cancelled") {
        matchesTab = event["status"] == "cancelled";
      }

      bool matchesFilter = selectedFilter == "All" || event["category"] == selectedFilter;
      bool matchesSearch = searchQuery.isEmpty || 
          event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesLocation = selectedLocation == "All Locations" || event["city"] == selectedLocation;

      return matchesTab && matchesFilter && matchesSearch && matchesLocation;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "pending":
        return warningColor;
      case "attended":
        return infoColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "confirmed":
        return "Confirmed";
      case "pending":
        return "Pending";
      case "attended":
        return "Attended";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${event["image"]}",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(event["status"]).withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  _getStatusText(event["status"]),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(event["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (event["status"] == "confirmed") ...[
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  color: primaryColor,
                                  size: 40,
                                ),
                                Text(
                                  "QR Code",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time, color: primaryColor, size: 20),
                              SizedBox(width: spSm),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date & Time",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Icon(
                                event["isVirtual"] ? Icons.videocam : Icons.location_on,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event["isVirtual"] ? "Virtual Event" : "Location",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    event["isVirtual"] ? "Online Meeting" : "${event["location"]}, ${event["city"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Icon(Icons.confirmation_number, color: primaryColor, size: 20),
                              SizedBox(width: spSm),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ticket Info",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${event["ticketType"]} - \$${(event["price"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    if (event["status"] == "confirmed") ...[
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Ticket",
                              icon: Icons.confirmation_number,
                              size: bs.md,
                              onPressed: () {
                                back();
                                ss("Ticket displayed successfully");
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Share Event",
                              icon: Icons.share,
                              size: bs.md,
                              onPressed: () {
                                back();
                                ss("Event link copied to clipboard");
                              },
                            ),
                          ),
                        ],
                      ),
                    ] else if (event["status"] == "pending") ...[
                      QButton(
                        label: "Check Status",
                        icon: Icons.refresh,
                        size: bs.md,
                        onPressed: () {
                          back();
                          ss("Checking registration status...");
                        },
                      ),
                    ] else if (event["status"] == "cancelled") ...[
                      QButton(
                        label: "Request Refund",
                        icon: Icons.money_off,
                        size: bs.md,
                        onPressed: () {
                          back();
                          ss("Refund request submitted");
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQRCode(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusLg)),
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Event Ticket",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_2,
                      size: 120,
                      color: primaryColor,
                    ),
                    Text(
                      "${event["qrCode"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "${event["title"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Download",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        back();
                        ss("Ticket downloaded successfully");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Share",
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        back();
                        ss("Ticket shared successfully");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Events"),
        actions: [
          IconButton(
            icon: Icon(showMap ? Icons.list : Icons.map),
            onPressed: () {
              showMap = !showMap;
              setState(() {});
              ss(showMap ? "Map view enabled" : "List view enabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterModal();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: "Search my events...",
                        prefixIcon: Icon(Icons.search, color: disabledBoldColor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      ss("Navigate to event discovery");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: tabItems.map((tab) => {
                "label": tab,
                "value": tab,
              }).toList(),
              value: selectedTab,
              onChanged: (index, label, value, item) {
                selectedTab = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spMd),

          // Statistics Summary
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${myEvents.where((e) => e["status"] == "confirmed").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Confirmed",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${myEvents.where((e) => e["status"] == "attended").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Attended",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${myEvents.where((e) => e["status"] == "pending").length}",
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
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Events List
          Expanded(
            child: filteredEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 80,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No events found",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your filters or search terms",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Discover Events",
                          icon: Icons.explore,
                          size: bs.md,
                          onPressed: () {
                            ss("Navigate to event discovery");
                          },
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = filteredEvents[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: InkWell(
                          onTap: () => _showEventDetails(event),
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                                    child: Image.network(
                                      "${event["image"]}",
                                      width: double.infinity,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: spSm,
                                    right: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(event["status"]),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        _getStatusText(event["status"]),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (event["status"] == "confirmed")
                                    Positioned(
                                      top: spSm,
                                      left: spSm,
                                      child: GestureDetector(
                                        onTap: () => _showQRCode(event),
                                        child: Container(
                                          padding: EdgeInsets.all(spXs),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withAlpha(200),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            Icons.qr_code,
                                            color: primaryColor,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(spMd),
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
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "${event["category"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, color: disabledBoldColor, size: 16),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${DateTime.parse(event["date"]).dMMMy} at ${event["time"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(
                                          event["isVirtual"] ? Icons.videocam : Icons.location_on,
                                          color: disabledBoldColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            event["isVirtual"] ? "Virtual Event" : "${event["location"]}, ${event["city"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Icon(Icons.confirmation_number, color: primaryColor, size: 16),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${event["ticketType"]} - \$${(event["price"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.people, color: disabledBoldColor, size: 16),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${event["attendees"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
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
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Events",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Select Category",
                    items: filterItems.map((filter) => {
                      "label": filter,
                      "value": filter,
                    }).toList(),
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Select Location",
                    items: locationItems.map((location) => {
                      "label": location,
                      "value": location,
                    }).toList(),
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reset",
                          size: bs.md,
                          onPressed: () {
                            selectedFilter = "All";
                            selectedLocation = "All Locations";
                            setState(() {});
                            back();
                            ss("Filters reset successfully");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Apply",
                          size: bs.md,
                          onPressed: () {
                            back();
                            ss("Filters applied successfully");
                          },
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
}
