import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsTableManagementView extends StatefulWidget {
  const RfsTableManagementView({super.key});

  @override
  State<RfsTableManagementView> createState() => _RfsTableManagementViewState();
}

class _RfsTableManagementViewState extends State<RfsTableManagementView> {
  int currentTab = 0;
  String selectedStatus = "All";
  String selectedSection = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> tables = [
    {
      "id": 1,
      "number": "T01",
      "section": "Main Hall",
      "capacity": 4,
      "status": "Occupied",
      "currentGuests": 3,
      "server": "Sarah",
      "timeSeated": "6:30 PM",
      "duration": 45,
      "orderTotal": 78.50,
      "lastOrder": "7:15 PM",
      "specialRequests": ["Window seat", "High chair"],
      "position": {"x": 50, "y": 100},
      "shape": "round",
      "isAvailable": false,
      "reservation": {
        "name": "Johnson Family",
        "phone": "+1-555-0123",
        "time": "6:30 PM",
        "partySize": 4,
        "specialRequests": "Birthday celebration"
      }
    },
    {
      "id": 2,
      "number": "T02",
      "section": "Main Hall",
      "capacity": 2,
      "status": "Available",
      "currentGuests": 0,
      "server": null,
      "timeSeated": null,
      "duration": 0,
      "orderTotal": 0.0,
      "lastOrder": null,
      "specialRequests": [],
      "position": {"x": 150, "y": 100},
      "shape": "square",
      "isAvailable": true,
      "reservation": null
    },
    {
      "id": 3,
      "number": "T03",
      "section": "Main Hall",
      "capacity": 6,
      "status": "Reserved",
      "currentGuests": 0,
      "server": "Mike",
      "timeSeated": null,
      "duration": 0,
      "orderTotal": 0.0,
      "lastOrder": null,
      "specialRequests": [],
      "position": {"x": 250, "y": 100},
      "shape": "rectangle",
      "isAvailable": false,
      "reservation": {
        "name": "Smith Group",
        "phone": "+1-555-0456",
        "time": "8:00 PM",
        "partySize": 6,
        "specialRequests": "Business dinner"
      }
    },
    {
      "id": 4,
      "number": "T04",
      "section": "Patio",
      "capacity": 4,
      "status": "Occupied",
      "currentGuests": 4,
      "server": "Emma",
      "timeSeated": "7:00 PM",
      "duration": 15,
      "orderTotal": 125.30,
      "lastOrder": "7:10 PM",
      "specialRequests": ["No onions", "Extra napkins"],
      "position": {"x": 50, "y": 200},
      "shape": "round",
      "isAvailable": false,
      "reservation": null
    },
    {
      "id": 5,
      "number": "T05",
      "section": "Patio",
      "capacity": 2,
      "status": "Cleaning",
      "currentGuests": 0,
      "server": null,
      "timeSeated": null,
      "duration": 0,
      "orderTotal": 0.0,
      "lastOrder": null,
      "specialRequests": [],
      "position": {"x": 150, "y": 200},
      "shape": "square",
      "isAvailable": false,
      "reservation": null
    },
    {
      "id": 6,
      "number": "T06",
      "section": "Private Room",
      "capacity": 8,
      "status": "Available",
      "currentGuests": 0,
      "server": null,
      "timeSeated": null,
      "duration": 0,
      "orderTotal": 0.0,
      "lastOrder": null,
      "specialRequests": [],
      "position": {"x": 350, "y": 150},
      "shape": "rectangle",
      "isAvailable": true,
      "reservation": null
    },
    {
      "id": 7,
      "number": "T07",
      "section": "VIP",
      "capacity": 4,
      "status": "Occupied",
      "currentGuests": 2,
      "server": "David",
      "timeSeated": "6:45 PM",
      "duration": 30,
      "orderTotal": 195.75,
      "lastOrder": "7:05 PM",
      "specialRequests": ["Champagne service", "Privacy"],
      "position": {"x": 450, "y": 100},
      "shape": "round",
      "isAvailable": false,
      "reservation": {
        "name": "Anderson VIP",
        "phone": "+1-555-0789",
        "time": "6:45 PM",
        "partySize": 2,
        "specialRequests": "Anniversary dinner"
      }
    },
    {
      "id": 8,
      "number": "T08",
      "section": "Bar Area",
      "capacity": 3,
      "status": "Available",
      "currentGuests": 0,
      "server": null,
      "timeSeated": null,
      "duration": 0,
      "orderTotal": 0.0,
      "lastOrder": null,
      "specialRequests": [],
      "position": {"x": 100, "y": 300},
      "shape": "round",
      "isAvailable": true,
      "reservation": null
    }
  ];

  List<String> statusOptions = ["All", "Available", "Occupied", "Reserved", "Cleaning"];
  List<String> sectionOptions = ["All", "Main Hall", "Patio", "Private Room", "VIP", "Bar Area"];

  List<Map<String, dynamic>> get filteredTables {
    return tables.where((table) {
      bool matchesSearch = table["number"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          (table["server"] ?? "").toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || table["status"] == selectedStatus;
      bool matchesSection = selectedSection == "All" || table["section"] == selectedSection;
      return matchesSearch && matchesStatus && matchesSection;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Occupied":
        return warningColor;
      case "Reserved":
        return infoColor;
      case "Cleaning":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _showTableDetails(Map<String, dynamic> table) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Table ${table["number"]}"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Section", "${table["section"]}"),
                _buildDetailRow("Capacity", "${table["capacity"]} guests"),
                _buildDetailRow("Status", "${table["status"]}"),
                if (table["currentGuests"] > 0) ...[
                  _buildDetailRow("Current Guests", "${table["currentGuests"]}"),
                  _buildDetailRow("Server", "${table["server"] ?? "Not assigned"}"),
                  _buildDetailRow("Time Seated", "${table["timeSeated"]}"),
                  _buildDetailRow("Duration", "${table["duration"]} minutes"),
                  _buildDetailRow("Order Total", "\$${(table["orderTotal"] as double).toStringAsFixed(2)}"),
                  if (table["lastOrder"] != null)
                    _buildDetailRow("Last Order", "${table["lastOrder"]}"),
                ],
                if (table["reservation"] != null) ...[
                  SizedBox(height: spSm),
                  Text("Reservation Details:", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: spXs),
                  _buildDetailRow("Guest Name", "${table["reservation"]["name"]}"),
                  _buildDetailRow("Phone", "${table["reservation"]["phone"]}"),
                  _buildDetailRow("Time", "${table["reservation"]["time"]}"),
                  _buildDetailRow("Party Size", "${table["reservation"]["partySize"]}"),
                  if (table["reservation"]["specialRequests"] != null)
                    _buildDetailRow("Special Requests", "${table["reservation"]["specialRequests"]}"),
                ],
                if ((table["specialRequests"] as List).isNotEmpty) ...[
                  SizedBox(height: spSm),
                  Text("Current Special Requests:", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: spXs),
                  ...(table["specialRequests"] as List).map((request) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text("• ${request}", style: TextStyle(fontSize: 12, color: warningColor)),
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
          actions: [
            if (table["status"] == "Available")
              QButton(
                label: "Seat Guests",
                size: bs.sm,
                onPressed: () {
                  Navigator.of(context).pop();
                  _seatGuests(table);
                },
              ),
            if (table["status"] == "Occupied")
              QButton(
                label: "Check Order",
                size: bs.sm,
                onPressed: () {
                  Navigator.of(context).pop();
                  ss("Viewing order for Table ${table["number"]}");
                },
              ),
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _seatGuests(Map<String, dynamic> table) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int partySize = 2;
        String server = "Sarah";
        String specialRequests = "";
        
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Seat Guests - Table ${table["number"]}"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  QNumberField(
                    label: "Party Size",
                    value: partySize.toString(),
                    onChanged: (value) {
                      partySize = int.tryParse(value) ?? 2;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Assign Server",
                    items: [
                      {"label": "Sarah", "value": "Sarah"},
                      {"label": "Mike", "value": "Mike"},
                      {"label": "Emma", "value": "Emma"},
                      {"label": "David", "value": "David"},
                    ],
                    value: server,
                    onChanged: (value, label) {
                      server = value;
                      setDialogState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Special Requests",
                    value: specialRequests,
                    onChanged: (value) {
                      specialRequests = value;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
              actions: [
                QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                QButton(
                  label: "Seat Guests",
                  size: bs.sm,
                  onPressed: () {
                    setState(() {
                      table["status"] = "Occupied";
                      table["currentGuests"] = partySize;
                      table["server"] = server;
                      table["timeSeated"] = "Now";
                      table["duration"] = 0;
                      table["isAvailable"] = false;
                      if (specialRequests.isNotEmpty) {
                        (table["specialRequests"] as List).add(specialRequests);
                      }
                    });
                    Navigator.of(context).pop();
                    ss("Guests seated at Table ${table["number"]}");
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: disabledBoldColor),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCard(Map<String, dynamic> table) {
    Color statusColor = _getStatusColor(table["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: statusColor),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Center(
                    child: Text(
                      "${table["number"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, color: statusColor),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Table ${table["number"]}",
                        style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${table["section"]} • ${table["capacity"]} seats",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${table["status"]}",
                    style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            if (table["status"] == "Occupied") ...[
              Row(
                children: [
                  Icon(Icons.people, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text("${table["currentGuests"]} guests", style: TextStyle(fontSize: 12)),
                  SizedBox(width: spSm),
                  Icon(Icons.person, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text("${table["server"]}", style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text("${table["duration"]} mins", style: TextStyle(fontSize: 12)),
                  SizedBox(width: spSm),
                  Icon(Icons.attach_money, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text("\$${(table["orderTotal"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
            if (table["status"] == "Reserved" && table["reservation"] != null) ...[
              Row(
                children: [
                  Icon(Icons.event, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text("${table["reservation"]["time"]}", style: TextStyle(fontSize: 12)),
                  SizedBox(width: spSm),
                  Icon(Icons.person, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text("${table["reservation"]["name"]}", style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
            if ((table["specialRequests"] as List).isNotEmpty) ...[
              SizedBox(height: spXs),
              Wrap(
                spacing: spXs,
                children: (table["specialRequests"] as List).take(2).map((request) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${request}",
                      style: TextStyle(fontSize: 10, color: warningColor),
                    ),
                  );
                }).toList(),
              ),
            ],
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () => _showTableDetails(table),
                  ),
                ),
                SizedBox(width: spSm),
                if (table["status"] == "Available")
                  QButton(
                    icon: Icons.people,
                    size: bs.sm,
                    onPressed: () => _seatGuests(table),
                  ),
                if (table["status"] == "Occupied")
                  QButton(
                    icon: Icons.receipt,
                    size: bs.sm,
                    onPressed: () => ss("Viewing order for Table ${table["number"]}"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    int availableTables = tables.where((t) => t["status"] == "Available").length;
    int occupiedTables = tables.where((t) => t["status"] == "Occupied").length;
    int reservedTables = tables.where((t) => t["status"] == "Reserved").length;
    int cleaningTables = tables.where((t) => t["status"] == "Cleaning").length;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Table Management", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spSm),
          
          // Status Overview
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$availableTables",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: successColor),
                      ),
                      Text("Available", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$occupiedTables",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: warningColor),
                      ),
                      Text("Occupied", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$reservedTables",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: infoColor),
                      ),
                      Text("Reserved", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions.map((status) => {"label": status, "value": status}).toList(),
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
                  label: "Section",
                  items: sectionOptions.map((section) => {"label": section, "value": section}).toList(),
                  value: selectedSection,
                  onChanged: (value, label) {
                    selectedSection = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Search tables or servers...",
            value: searchQuery,
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Tables List
          Text("Tables (${filteredTables.length})", 
               style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spSm),
          
          ...filteredTables.map((table) => _buildTableCard(table)).toList(),
        ],
      ),
    );
  }

  Widget _buildReservationsTab() {
    List<Map<String, dynamic>> reservedTables = tables.where((t) => t["reservation"] != null).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Reservations", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spMd),
          
          if (reservedTables.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Icon(Icons.event_available, size: 48, color: infoColor),
                  SizedBox(height: spSm),
                  Text("No reservations for today", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("All tables are available for walk-ins", style: TextStyle(color: disabledBoldColor)),
                ],
              ),
            ),
          ] else ...[
            ...reservedTables.map((table) {
              Map<String, dynamic> reservation = table["reservation"];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(width: 4, color: infoColor),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Center(
                            child: Text(
                              "${table["number"]}",
                              style: TextStyle(fontWeight: FontWeight.bold, color: infoColor),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${reservation["name"]}",
                                style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Table ${table["number"]} • ${table["section"]}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${reservation["time"]}",
                            style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.people, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${reservation["partySize"]} guests", style: TextStyle(fontSize: 12)),
                        SizedBox(width: spSm),
                        Icon(Icons.phone, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text("${reservation["phone"]}", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    if (reservation["specialRequests"] != null) ...[
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.note, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text("${reservation["specialRequests"]}", 
                                         style: TextStyle(fontSize: 12, color: warningColor)),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Check In",
                            size: bs.sm,
                            onPressed: () {
                              setState(() {
                                table["status"] = "Occupied";
                                table["currentGuests"] = reservation["partySize"];
                                table["server"] = "Sarah";
                                table["timeSeated"] = "Now";
                                table["duration"] = 0;
                                table["isAvailable"] = false;
                              });
                              ss("${reservation["name"]} checked in to Table ${table["number"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.info,
                          size: bs.sm,
                          onPressed: () => _showTableDetails(table),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    double averageOccupancy = (tables.where((t) => t["status"] == "Occupied").length / tables.length) * 100;
    double totalRevenue = tables.fold(0.0, (sum, table) => sum + (table["orderTotal"] as double));
    int totalGuests = tables.fold(0, (sum, table) => sum + (table["currentGuests"] as int));
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Table Analytics", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
          SizedBox(height: spMd),
          
          // Key Metrics
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${averageOccupancy.toStringAsFixed(1)}%",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                      Text("Occupancy Rate", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${totalRevenue.toStringAsFixed(0)}",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: successColor),
                      ),
                      Text("Total Revenue", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalGuests",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: warningColor),
                      ),
                      Text("Current Guests", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Section Performance
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Section Performance", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                ...sectionOptions.skip(1).map((section) {
                  List<Map<String, dynamic>> sectionTables = tables.where((t) => t["section"] == section).toList();
                  int occupiedCount = sectionTables.where((t) => t["status"] == "Occupied").length;
                  double sectionRevenue = sectionTables.fold(0.0, (sum, table) => sum + (table["orderTotal"] as double));
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(section, style: TextStyle(fontWeight: FontWeight.w600)),
                              Text("$occupiedCount/${sectionTables.length} occupied", 
                                   style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                            ],
                          ),
                        ),
                        Text("\$${sectionRevenue.toStringAsFixed(0)}", 
                             style: TextStyle(fontWeight: FontWeight.bold, color: successColor)),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Server Performance
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Server Performance", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: spSm),
                ...["Sarah", "Mike", "Emma", "David"].map((server) {
                  List<Map<String, dynamic>> serverTables = tables.where((t) => t["server"] == server).toList();
                  double serverRevenue = serverTables.fold(0.0, (sum, table) => sum + (table["orderTotal"] as double));
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Center(
                            child: Text(
                              server[0],
                              style: TextStyle(fontWeight: FontWeight.bold, color: infoColor),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(server, style: TextStyle(fontWeight: FontWeight.w600)),
                              Text("${serverTables.length} tables", 
                                   style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                            ],
                          ),
                        ),
                        Text("\$${serverRevenue.toStringAsFixed(0)}", 
                             style: TextStyle(fontWeight: FontWeight.bold, color: successColor)),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Table Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.restaurant)),
        Tab(text: "Reservations", icon: Icon(Icons.event)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildReservationsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }
}
