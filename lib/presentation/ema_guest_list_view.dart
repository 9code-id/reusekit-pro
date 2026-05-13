import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaGuestListView extends StatefulWidget {
  const EmaGuestListView({super.key});

  @override
  State<EmaGuestListView> createState() => _EmaGuestListViewState();
}

class _EmaGuestListViewState extends State<EmaGuestListView> {
  String selectedEvent = "evt_001";
  String searchQuery = "";
  String filterStatus = "all";
  String sortBy = "name";

  List<Map<String, dynamic>> events = [
    {
      "id": "evt_001",
      "name": "Annual Company Meeting",
      "date": "2024-12-15",
      "location": "Main Conference Hall",
    },
    {
      "id": "evt_002",
      "name": "Product Launch Event", 
      "date": "2024-12-20",
      "location": "Grand Ballroom",
    },
    {
      "id": "evt_003",
      "name": "Team Building Workshop",
      "date": "2024-12-10",
      "location": "Training Room A",
    }
  ];

  List<Map<String, dynamic>> guests = [
    {
      "id": "guest_001",
      "eventId": "evt_001",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "phone": "+1 234 567 8900",
      "company": "TechCorp Inc.",
      "position": "Marketing Director",
      "department": "Marketing",
      "invitationSent": true,
      "rsvpStatus": "accepted",
      "dietaryRestrictions": "Vegetarian",
      "specialRequests": "None",
      "checkedIn": true,
      "checkedInAt": "2024-12-15T08:45:00Z",
      "notes": "VIP guest",
      "tags": ["VIP", "Speaker"],
      "tableNumber": "A1",
      "guestType": "internal"
    },
    {
      "id": "guest_002",
      "eventId": "evt_001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@external.com",
      "phone": "+1 234 567 8901",
      "company": "Partner Solutions",
      "position": "CEO",
      "department": "Executive",
      "invitationSent": true,
      "rsvpStatus": "pending",
      "dietaryRestrictions": "None",
      "specialRequests": "Wheelchair accessible",
      "checkedIn": false,
      "checkedInAt": null,
      "notes": "External partner",
      "tags": ["External", "Partner"],
      "tableNumber": "B2",
      "guestType": "external"
    },
    {
      "id": "guest_003",
      "eventId": "evt_001",
      "name": "Mike Wilson",
      "email": "mike.wilson@company.com",
      "phone": "+1 234 567 8902",
      "company": "TechCorp Inc.",
      "position": "Senior Developer",
      "department": "Engineering",
      "invitationSent": true,
      "rsvpStatus": "declined",
      "dietaryRestrictions": "Gluten-free",
      "specialRequests": "None",
      "checkedIn": false,
      "checkedInAt": null,
      "notes": "Team lead",
      "tags": ["Internal"],
      "tableNumber": "C3",
      "guestType": "internal"
    },
    {
      "id": "guest_004",
      "eventId": "evt_002",
      "name": "Lisa Chen",
      "email": "lisa.chen@media.com",
      "phone": "+1 234 567 8903",
      "company": "Media Plus",
      "position": "Journalist",
      "department": "Media",
      "invitationSent": true,
      "rsvpStatus": "accepted",
      "dietaryRestrictions": "None",
      "specialRequests": "Media access required",
      "checkedIn": false,
      "checkedInAt": null,
      "notes": "Press coverage",
      "tags": ["Media", "Press"],
      "tableNumber": "D1",
      "guestType": "media"
    }
  ];

  List<Map<String, dynamic>> get filteredGuests {
    var filtered = guests.where((guest) {
      bool matchesEvent = guest["eventId"] == selectedEvent;
      bool matchesStatus = filterStatus == "all" || guest["rsvpStatus"] == filterStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          guest["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          guest["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          guest["company"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesEvent && matchesStatus && matchesSearch;
    }).toList();

    // Sort guests
    filtered.sort((a, b) {
      switch (sortBy) {
        case "name":
          return a["name"].toString().compareTo(b["name"].toString());
        case "company":
          return a["company"].toString().compareTo(b["company"].toString());
        case "rsvpStatus":
          return a["rsvpStatus"].toString().compareTo(b["rsvpStatus"].toString());
        case "checkedIn":
          if (a["checkedIn"] == b["checkedIn"]) return 0;
          return a["checkedIn"] ? -1 : 1;
        default:
          return 0;
      }
    });

    return filtered;
  }

  Map<String, dynamic> get selectedEventData {
    return events.firstWhere((event) => event["id"] == selectedEvent);
  }

  Color _getRsvpStatusColor(String status) {
    switch (status) {
      case "accepted":
        return successColor;
      case "declined":
        return dangerColor;
      case "pending":
        return warningColor;
      case "maybe":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatRsvpStatus(String status) {
    switch (status) {
      case "accepted":
        return "Accepted";
      case "declined":
        return "Declined";
      case "pending":
        return "Pending";
      case "maybe":
        return "Maybe";
      default:
        return "Unknown";
    }
  }

  Color _getGuestTypeColor(String type) {
    switch (type) {
      case "internal":
        return primaryColor;
      case "external":
        return infoColor;
      case "media":
        return warningColor;
      case "vip":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showGuestDetails(Map<String, dynamic> guest) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${guest["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow("Email", "${guest["email"]}"),
              _buildDetailRow("Phone", "${guest["phone"]}"),
              _buildDetailRow("Company", "${guest["company"]}"),
              _buildDetailRow("Position", "${guest["position"]}"),
              _buildDetailRow("Department", "${guest["department"]}"),
              _buildDetailRow("RSVP Status", _formatRsvpStatus(guest["rsvpStatus"])),
              _buildDetailRow("Guest Type", "${guest["guestType"]}".toUpperCase()),
              _buildDetailRow("Table Number", "${guest["tableNumber"]}"),
              if (guest["dietaryRestrictions"].toString().isNotEmpty)
                _buildDetailRow("Dietary Restrictions", "${guest["dietaryRestrictions"]}"),
              if (guest["specialRequests"].toString().isNotEmpty)
                _buildDetailRow("Special Requests", "${guest["specialRequests"]}"),
              if (guest["checkedIn"])
                _buildDetailRow("Checked In", "${DateTime.parse(guest["checkedInAt"]).dMMMy} at ${DateTime.parse(guest["checkedInAt"]).kkmm}"),
              if (guest["notes"].toString().isNotEmpty)
                _buildDetailRow("Notes", "${guest["notes"]}"),
              if ((guest["tags"] as List).isNotEmpty) ...[
                SizedBox(height: spXs),
                Text(
                  "Tags:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: (guest["tags"] as List).map((tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Edit Guest",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              ss("Edit guest feature");
            },
          ),
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestCard(Map<String, dynamic> guest) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getGuestTypeColor(guest["guestType"]),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: _getGuestTypeColor(guest["guestType"]).withAlpha(20),
                child: Text(
                  "${guest["name"]}".substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getGuestTypeColor(guest["guestType"]),
                  ),
                ),
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
                            "${guest["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (guest["checkedIn"])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Checked In",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${guest["position"]} at ${guest["company"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.email, size: 12, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "${guest["email"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
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
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.table_restaurant, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "Table ${guest["tableNumber"]}",
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
                  color: _getRsvpStatusColor(guest["rsvpStatus"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _formatRsvpStatus(guest["rsvpStatus"]),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getRsvpStatusColor(guest["rsvpStatus"]),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              GestureDetector(
                onTap: () => _showGuestDetails(guest),
                child: Icon(
                  Icons.info_outline,
                  size: 18,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((guest["tags"] as List).isNotEmpty) ...[
            SizedBox(height: spXs),
            Wrap(
              spacing: 4,
              children: (guest["tags"] as List).take(3).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 9,
                    color: primaryColor,
                  ),
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var eventGuests = filteredGuests;
    var acceptedCount = eventGuests.where((g) => g["rsvpStatus"] == "accepted").length;
    var declinedCount = eventGuests.where((g) => g["rsvpStatus"] == "declined").length;
    var pendingCount = eventGuests.where((g) => g["rsvpStatus"] == "pending").length;
    var checkedInCount = eventGuests.where((g) => g["checkedIn"] == true).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Guest List"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              ss("Add new guest");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Selection
            QDropdownField(
              label: "Select Event",
              items: events.map((e) => {"label": "${e["name"]}", "value": "${e["id"]}"}).toList(),
              value: selectedEvent,
              onChanged: (value, label) {
                selectedEvent = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Event Info Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.event, color: primaryColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedEventData["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${DateTime.parse(selectedEventData["date"]).dMMMy} • ${selectedEventData["location"]}",
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
            ),
            SizedBox(height: spMd),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Guests",
                    "${eventGuests.length}",
                    Icons.people,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Accepted",
                    "$acceptedCount",
                    Icons.check_circle,
                    successColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Pending",
                    "$pendingCount", 
                    Icons.schedule,
                    warningColor,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: _buildStatCard(
                    "Checked In",
                    "$checkedInCount",
                    Icons.login,
                    infoColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filters and Search
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search guests...",
                    value: searchQuery,
                    hint: "Name, email, or company",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "RSVP Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Accepted", "value": "accepted"},
                      {"label": "Declined", "value": "declined"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Maybe", "value": "maybe"},
                    ],
                    value: filterStatus,
                    onChanged: (value, label) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Sort by",
              items: [
                {"label": "Name", "value": "name"},
                {"label": "Company", "value": "company"},
                {"label": "RSVP Status", "value": "rsvpStatus"},
                {"label": "Check-in Status", "value": "checkedIn"},
              ],
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export List",
                    icon: Icons.file_download,
                    size: bs.sm,
                    onPressed: () {
                      ss("Export guest list");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Send Invitations",
                    icon: Icons.send,
                    size: bs.sm,
                    onPressed: () {
                      ss("Send invitations");
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Guest List
            Text(
              "Guests (${eventGuests.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            if (eventGuests.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No guests found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or add new guests",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...eventGuests.map((guest) => _buildGuestCard(guest)).toList(),
          ],
        ),
      ),
    );
  }
}
