import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaInvitationSenderView extends StatefulWidget {
  const EmaInvitationSenderView({super.key});

  @override
  State<EmaInvitationSenderView> createState() => _EmaInvitationSenderViewState();
}

class _EmaInvitationSenderViewState extends State<EmaInvitationSenderView> {
  String selectedEvent = "";
  String selectedTemplate = "formal";
  String emailSubject = "";
  String emailMessage = "";
  String senderName = "Event Organizer";
  String senderEmail = "organizer@company.com";
  bool includeQrCode = true;
  bool includeEventDetails = true;
  bool includeAgenda = false;
  bool includeDirections = true;
  bool sendReminder = true;
  String reminderDays = "3";
  List<String> selectedGuests = [];
  String filterStatus = "all";

  List<Map<String, dynamic>> events = [
    {
      "id": "evt_001",
      "name": "Annual Company Meeting",
      "date": "2024-12-15",
      "time": "09:00",
      "location": "Main Conference Hall",
      "address": "123 Business Ave, Corporate City",
      "description": "Annual company meeting to discuss yearly achievements and future plans.",
    },
    {
      "id": "evt_002",
      "name": "Product Launch Event",
      "date": "2024-12-20",
      "time": "14:00",
      "location": "Grand Ballroom",
      "address": "456 Event Center, Downtown",
      "description": "Exclusive product launch event for our latest innovation.",
    },
  ];

  List<Map<String, dynamic>> emailTemplates = [
    {
      "id": "formal",
      "name": "Formal Business",
      "subject": "Invitation to {eventName}",
      "content": "Dear {guestName},\n\nYou are cordially invited to attend {eventName} on {eventDate} at {eventTime}.\n\nLocation: {eventLocation}\nAddress: {eventAddress}\n\nPlease RSVP by responding to this email.\n\nBest regards,\n{senderName}",
    },
    {
      "id": "casual",
      "name": "Casual Friendly",
      "subject": "You're Invited! {eventName}",
      "content": "Hi {guestName},\n\nWe'd love to have you join us for {eventName}!\n\nWhen: {eventDate} at {eventTime}\nWhere: {eventLocation}\n\nLet us know if you can make it!\n\nCheers,\n{senderName}",
    },
    {
      "id": "corporate",
      "name": "Corporate Professional",
      "subject": "Professional Invitation: {eventName}",
      "content": "Dear {guestName},\n\nWe are pleased to invite you to {eventName}.\n\nEvent Details:\n- Date: {eventDate}\n- Time: {eventTime}\n- Venue: {eventLocation}\n- Address: {eventAddress}\n\n{eventDescription}\n\nKindly confirm your attendance.\n\nSincerely,\n{senderName}",
    },
  ];

  List<Map<String, dynamic>> guests = [
    {
      "id": "guest_001",
      "eventId": "evt_001",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "rsvpStatus": "pending",
      "selected": false,
    },
    {
      "id": "guest_002",
      "eventId": "evt_001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@external.com",
      "rsvpStatus": "pending",
      "selected": false,
    },
    {
      "id": "guest_003",
      "eventId": "evt_001",
      "name": "Mike Wilson",
      "email": "mike.wilson@company.com",
      "rsvpStatus": "accepted",
      "selected": false,
    },
    {
      "id": "guest_004",
      "eventId": "evt_002",
      "name": "Lisa Chen",
      "email": "lisa.chen@media.com",
      "rsvpStatus": "pending",
      "selected": false,
    },
  ];

  List<Map<String, dynamic>> get filteredGuests {
    return guests.where((guest) {
      bool matchesEvent = selectedEvent.isEmpty || guest["eventId"] == selectedEvent;
      bool matchesStatus = filterStatus == "all" || guest["rsvpStatus"] == filterStatus;
      return matchesEvent && matchesStatus;
    }).toList();
  }

  Map<String, dynamic> get selectedEventData {
    if (selectedEvent.isEmpty) return {};
    return events.firstWhere((event) => event["id"] == selectedEvent, orElse: () => {});
  }

  void _loadTemplate() {
    if (selectedTemplate.isNotEmpty && selectedEvent.isNotEmpty) {
      var template = emailTemplates.firstWhere((t) => t["id"] == selectedTemplate);
      var eventData = selectedEventData;
      
      setState(() {
        emailSubject = template["subject"]
            .replaceAll("{eventName}", eventData["name"] ?? "")
            .replaceAll("{eventDate}", DateTime.parse(eventData["date"]).dMMMy)
            .replaceAll("{eventTime}", eventData["time"] ?? "");
        
        emailMessage = template["content"]
            .replaceAll("{eventName}", eventData["name"] ?? "")
            .replaceAll("{eventDate}", DateTime.parse(eventData["date"]).dMMMy)
            .replaceAll("{eventTime}", eventData["time"] ?? "")
            .replaceAll("{eventLocation}", eventData["location"] ?? "")
            .replaceAll("{eventAddress}", eventData["address"] ?? "")
            .replaceAll("{eventDescription}", eventData["description"] ?? "")
            .replaceAll("{senderName}", senderName);
      });
    }
  }

  void _sendInvitations() async {
    var recipientGuests = filteredGuests.where((g) => selectedGuests.contains(g["id"])).toList();
    
    if (recipientGuests.isEmpty) {
      se("Please select at least one guest to send invitations");
      return;
    }
    
    if (emailSubject.isEmpty || emailMessage.isEmpty) {
      se("Please fill in the email subject and message");
      return;
    }

    bool isConfirmed = await confirm("Send invitations to ${recipientGuests.length} guests?");
    if (!isConfirmed) return;

    showLoading();
    
    // Simulate sending emails
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    ss("Invitations sent successfully to ${recipientGuests.length} guests");
    
    // Reset selection
    setState(() {
      selectedGuests.clear();
    });
  }

  void _previewInvitation() {
    if (emailSubject.isEmpty || emailMessage.isEmpty) {
      se("Please fill in the email subject and message");
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Invitation Preview"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Subject:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(emailSubject),
              SizedBox(height: spSm),
              Text(
                "Message:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(emailMessage),
              if (includeQrCode) ...[
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "QR Code will be included for easy check-in",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestSelectionCard(Map<String, dynamic> guest) {
    bool isSelected = selectedGuests.contains(guest["id"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isSelected ? primaryColor : Colors.transparent,
          width: 1,
        ),
      ),
      child: CheckboxListTile(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              selectedGuests.add(guest["id"]);
            } else {
              selectedGuests.remove(guest["id"]);
            }
          });
        },
        title: Text(
          "${guest["name"]}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${guest["email"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: guest["rsvpStatus"] == "accepted" 
                    ? successColor.withAlpha(20)
                    : guest["rsvpStatus"] == "declined"
                    ? dangerColor.withAlpha(20)
                    : warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${guest["rsvpStatus"]}".toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: guest["rsvpStatus"] == "accepted" 
                      ? successColor
                      : guest["rsvpStatus"] == "declined"
                      ? dangerColor
                      : warningColor,
                ),
              ),
            ),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Send Invitations",
      selectedIndex: 0,
      tabs: [
        Tab(text: "Compose", icon: Icon(Icons.edit)),
        Tab(text: "Recipients", icon: Icon(Icons.people)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        // Compose Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Selection
              QDropdownField(
                label: "Select Event",
                items: events.map((e) => {
                  "label": "${e["name"]} - ${DateTime.parse(e["date"]).dMMMy}",
                  "value": "${e["id"]}"
                }).toList(),
                value: selectedEvent,
                onChanged: (value, label) {
                  selectedEvent = value;
                  _loadTemplate();
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              // Template Selection
              QDropdownField(
                label: "Email Template",
                items: emailTemplates.map((t) => {
                  "label": "${t["name"]}",
                  "value": "${t["id"]}"
                }).toList(),
                value: selectedTemplate,
                onChanged: (value, label) {
                  selectedTemplate = value;
                  _loadTemplate();
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Email Content
              Text(
                "Email Content",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Email Subject",
                value: emailSubject,
                hint: "Enter email subject",
                onChanged: (value) {
                  emailSubject = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Email Message",
                value: emailMessage,
                hint: "Enter your invitation message",
                onChanged: (value) {
                  emailMessage = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Sender Information
              Text(
                "Sender Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Sender Name",
                      value: senderName,
                      onChanged: (value) {
                        senderName = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Sender Email",
                      value: senderEmail,
                      onChanged: (value) {
                        senderEmail = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Preview",
                      icon: Icons.preview,
                      size: bs.sm,
                      onPressed: _previewInvitation,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Load Template",
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: _loadTemplate,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Recipients Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Event",
                      items: [
                        {"label": "All Events", "value": ""},
                        ...events.map((e) => {
                          "label": "${e["name"]}",
                          "value": "${e["id"]}"
                        }).toList(),
                      ],
                      value: selectedEvent,
                      onChanged: (value, label) {
                        selectedEvent = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by RSVP",
                      items: [
                        {"label": "All Status", "value": "all"},
                        {"label": "Pending", "value": "pending"},
                        {"label": "Accepted", "value": "accepted"},
                        {"label": "Declined", "value": "declined"},
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
              SizedBox(height: spMd),

              // Selection Controls
              Row(
                children: [
                  QButton(
                    label: "Select All",
                    icon: Icons.select_all,
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        selectedGuests = filteredGuests.map((g) => g["id"].toString()).toList();
                      });
                    },
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    label: "Clear All",
                    icon: Icons.clear_all,
                    size: bs.sm,
                    onPressed: () {
                      setState(() {
                        selectedGuests.clear();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: spSm),

              // Selected Count
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.people, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "${selectedGuests.length} of ${filteredGuests.length} guests selected",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Guest List
              if (filteredGuests.isEmpty)
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
                    ],
                  ),
                )
              else
                ...filteredGuests.map((guest) => _buildGuestSelectionCard(guest)).toList(),
              
              SizedBox(height: spMd),
              
              // Send Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Send Invitations (${selectedGuests.length})",
                  icon: Icons.send,
                  size: bs.md,
                  onPressed: selectedGuests.isEmpty ? () {} : _sendInvitations,
                ),
              ),
            ],
          ),
        ),

        // Settings Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Invitation Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QSwitch(
                label: "Include QR code for check-in",
                items: [
                  {
                    "label": "Include QR code",
                    "value": true,
                    "checked": includeQrCode,
                  }
                ],
                value: [if (includeQrCode) {"label": "Include QR code", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  includeQrCode = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QSwitch(
                label: "Include event details",
                items: [
                  {
                    "label": "Include event details",
                    "value": true,
                    "checked": includeEventDetails,
                  }
                ],
                value: [if (includeEventDetails) {"label": "Include event details", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  includeEventDetails = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QSwitch(
                label: "Include agenda",
                items: [
                  {
                    "label": "Include agenda",
                    "value": true,
                    "checked": includeAgenda,
                  }
                ],
                value: [if (includeAgenda) {"label": "Include agenda", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  includeAgenda = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QSwitch(
                label: "Include directions",
                items: [
                  {
                    "label": "Include directions",
                    "value": true,
                    "checked": includeDirections,
                  }
                ],
                value: [if (includeDirections) {"label": "Include directions", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  includeDirections = values.isNotEmpty;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              Text(
                "Reminder Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QSwitch(
                label: "Send reminder emails",
                items: [
                  {
                    "label": "Send reminders",
                    "value": true,
                    "checked": sendReminder,
                  }
                ],
                value: [if (sendReminder) {"label": "Send reminders", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  sendReminder = values.isNotEmpty;
                  setState(() {});
                },
              ),
              if (sendReminder) ...[
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Reminder timing",
                  items: [
                    {"label": "1 day before", "value": "1"},
                    {"label": "3 days before", "value": "3"},
                    {"label": "7 days before", "value": "7"},
                    {"label": "14 days before", "value": "14"},
                  ],
                  value: reminderDays,
                  onChanged: (value, label) {
                    reminderDays = value;
                    setState(() {});
                  },
                ),
              ],
              
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: warningColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "These settings will apply to all invitations sent in this session.",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
