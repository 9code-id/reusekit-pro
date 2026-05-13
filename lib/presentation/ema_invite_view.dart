import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaInviteView extends StatefulWidget {
  const EmaInviteView({super.key});

  @override
  State<EmaInviteView> createState() => _EmaInviteViewState();
}

class _EmaInviteViewState extends State<EmaInviteView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedEvent = "";
  String guestName = "";
  String guestEmail = "";
  String guestPhone = "";
  String guestCompany = "";
  String guestPosition = "";
  String guestDepartment = "";
  String guestType = "internal";
  String tableNumber = "";
  String dietaryRestrictions = "";
  String specialRequests = "";
  String notes = "";
  List<String> selectedTags = [];
  bool sendInvitation = true;
  bool requireRsvp = true;
  
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

  List<Map<String, dynamic>> availableTags = [
    {"label": "VIP", "value": "VIP", "checked": false},
    {"label": "Speaker", "value": "Speaker", "checked": false},
    {"label": "Media", "value": "Media", "checked": false},
    {"label": "Partner", "value": "Partner", "checked": false},
    {"label": "Executive", "value": "Executive", "checked": false},
    {"label": "External", "value": "External", "checked": false},
    {"label": "Press", "value": "Press", "checked": false},
    {"label": "Sponsor", "value": "Sponsor", "checked": false},
  ];

  List<Map<String, dynamic>> guestTypeItems = [
    {"label": "Internal Employee", "value": "internal"},
    {"label": "External Guest", "value": "external"},
    {"label": "Media/Press", "value": "media"},
    {"label": "VIP Guest", "value": "vip"},
    {"label": "Partner", "value": "partner"},
    {"label": "Vendor", "value": "vendor"},
  ];

  void _addGuest() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      
      ss("Guest successfully added to ${events.firstWhere((e) => e["id"] == selectedEvent)["name"]}");
      
      // Reset form
      _resetForm();
    }
  }

  void _resetForm() {
    setState(() {
      guestName = "";
      guestEmail = "";
      guestPhone = "";
      guestCompany = "";
      guestPosition = "";
      guestDepartment = "";
      tableNumber = "";
      dietaryRestrictions = "";
      specialRequests = "";
      notes = "";
      selectedTags = [];
      sendInvitation = true;
      requireRsvp = true;
    });
  }

  void _importGuests() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Import Guests"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Import guests from:"),
            SizedBox(height: spSm),
            QButton(
              label: "CSV File",
              icon: Icons.file_upload,
              size: bs.sm,
              onPressed: () {
                Navigator.of(context).pop();
                ss("CSV import feature");
              },
            ),
            SizedBox(height: spXs),
            QButton(
              label: "Excel File",
              icon: Icons.file_upload,
              size: bs.sm,
              onPressed: () {
                Navigator.of(context).pop();
                ss("Excel import feature");
              },
            ),
            SizedBox(height: spXs),
            QButton(
              label: "Previous Event",
              icon: Icons.event,
              size: bs.sm,
              onPressed: () {
                Navigator.of(context).pop();
                ss("Import from previous event");
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
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(top: spMd, bottom: spSm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: primaryColor),
          SizedBox(width: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Guest"),
        actions: [
          QButton(
            icon: Icons.file_upload,
            size: bs.sm,
            onPressed: _importGuests,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Selection
              _buildSectionHeader("Event Information", Icons.event),
              QDropdownField(
                label: "Select Event",
                items: events.map((e) => {
                  "label": "${e["name"]} - ${DateTime.parse(e["date"]).dMMMy}",
                  "value": "${e["id"]}"
                }).toList(),
                value: selectedEvent,
                validator: Validator.required,
                onChanged: (value, label) {
                  selectedEvent = value;
                  setState(() {});
                },
              ),
              
              if (selectedEvent.isNotEmpty) ...[
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${events.firstWhere((e) => e["id"] == selectedEvent)["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 12, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${DateTime.parse(events.firstWhere((e) => e["id"] == selectedEvent)["date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                          SizedBox(width: 4),
                          Text(
                            "${events.firstWhere((e) => e["id"] == selectedEvent)["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],

              // Guest Information
              _buildSectionHeader("Guest Information", Icons.person),
              QTextField(
                label: "Full Name",
                value: guestName,
                hint: "Enter guest's full name",
                validator: Validator.required,
                onChanged: (value) {
                  guestName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Email Address",
                value: guestEmail,
                hint: "Enter email address",
                validator: Validator.email,
                onChanged: (value) {
                  guestEmail = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Phone Number",
                value: guestPhone,
                hint: "Enter phone number",
                onChanged: (value) {
                  guestPhone = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Company",
                      value: guestCompany,
                      hint: "Company name",
                      onChanged: (value) {
                        guestCompany = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Position",
                      value: guestPosition,
                      hint: "Job title",
                      onChanged: (value) {
                        guestPosition = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Guest Type",
                      items: guestTypeItems,
                      value: guestType,
                      onChanged: (value, label) {
                        guestType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Department",
                      value: guestDepartment,
                      hint: "Department name",
                      onChanged: (value) {
                        guestDepartment = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Event Details
              _buildSectionHeader("Event Details", Icons.table_restaurant),
              QTextField(
                label: "Table Number",
                value: tableNumber,
                hint: "Assigned table number",
                onChanged: (value) {
                  tableNumber = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Dietary Restrictions",
                value: dietaryRestrictions,
                hint: "Any dietary restrictions or preferences",
                onChanged: (value) {
                  dietaryRestrictions = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Special Requests",
                value: specialRequests,
                hint: "Any special accommodation requests",
                onChanged: (value) {
                  specialRequests = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Notes",
                value: notes,
                hint: "Additional notes about the guest",
                onChanged: (value) {
                  notes = value;
                  setState(() {});
                },
              ),

              // Tags
              _buildSectionHeader("Tags", Icons.local_offer),
              QSwitch(
                label: "Guest Tags",
                items: availableTags,
                value: availableTags.where((tag) => selectedTags.contains(tag["value"])).toList(),
                onChanged: (values, ids) {
                  selectedTags = values.map((v) => v["value"].toString()).toList();
                  setState(() {});
                },
              ),

              // Invitation Settings
              _buildSectionHeader("Invitation Settings", Icons.email),
              QSwitch(
                label: "Send invitation email immediately",
                items: [
                  {
                    "label": "Send invitation email",
                    "value": true,
                    "checked": sendInvitation,
                  }
                ],
                value: [if (sendInvitation) {"label": "Send invitation email", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  sendInvitation = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QSwitch(
                label: "Require RSVP response",
                items: [
                  {
                    "label": "Require RSVP",
                    "value": true,
                    "checked": requireRsvp,
                  }
                ],
                value: [if (requireRsvp) {"label": "Require RSVP", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  requireRsvp = values.isNotEmpty;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Add Guest",
                      icon: Icons.person_add,
                      size: bs.md,
                      onPressed: _addGuest,
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Reset",
                    icon: Icons.refresh,
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to reset the form?");
                      if (isConfirmed) {
                        _resetForm();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),

              // Additional Actions
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, size: 16, color: infoColor),
                        SizedBox(width: spXs),
                        Text(
                          "Quick Actions",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Add Multiple",
                            icon: Icons.group_add,
                            size: bs.sm,
                            onPressed: () {
                              ss("Add multiple guests feature");
                            },
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: QButton(
                            label: "Import CSV",
                            icon: Icons.file_upload,
                            size: bs.sm,
                            onPressed: _importGuests,
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
      ),
    );
  }
}
