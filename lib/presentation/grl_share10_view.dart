import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlShare10View extends StatefulWidget {
  @override
  State<GrlShare10View> createState() => _GrlShare10ViewState();
}

class _GrlShare10ViewState extends State<GrlShare10View> {
  final formKey = GlobalKey<FormState>();
  
  // Event sharing form
  String eventTitle = "";
  String eventDescription = "";
  String eventLocation = "";
  DateTime eventDate = DateTime.now().add(Duration(days: 7));
  TimeOfDay eventTime = TimeOfDay(hour: 10, minute: 0);
  DateTime eventEndDate = DateTime.now().add(Duration(days: 7));
  TimeOfDay eventEndTime = TimeOfDay(hour: 11, minute: 0);
  String organizerName = "";
  String organizerEmail = "";
  String eventCategory = "meeting";
  String eventImage = "";
  List<String> eventAttachments = [];
  
  // Sharing settings
  List<String> shareChannels = [];
  bool includeReminder = true;
  String reminderTime = "15_minutes";
  bool allowGuestEdit = false;
  bool requireRSVP = true;
  String eventPrivacy = "public";
  String calendarFormat = "ics";
  
  // RSVP settings
  int maxAttendees = 50;
  bool enableWaitlist = false;
  String registrationDeadline = "event_start";
  
  // Sample categories
  List<Map<String, dynamic>> eventCategories = [
    {"label": "Meeting", "value": "meeting"},
    {"label": "Conference", "value": "conference"},
    {"label": "Workshop", "value": "workshop"},
    {"label": "Webinar", "value": "webinar"},
    {"label": "Social Event", "value": "social"},
    {"label": "Training", "value": "training"},
    {"label": "Birthday", "value": "birthday"},
    {"label": "Wedding", "value": "wedding"},
    {"label": "Other", "value": "other"},
  ];
  
  // Sample sharing channels
  List<Map<String, dynamic>> availableChannels = [
    {
      "label": "Email Invitation",
      "value": "email",
      "icon": Icons.email,
      "description": "Send calendar invites via email"
    },
    {
      "label": "WhatsApp",
      "value": "whatsapp",
      "icon": Icons.chat,
      "description": "Share event details on WhatsApp"
    },
    {
      "label": "Facebook Event",
      "value": "facebook",
      "icon": Icons.facebook,
      "description": "Create Facebook event"
    },
    {
      "label": "LinkedIn",
      "value": "linkedin",
      "icon": Icons.work,
      "description": "Share professional events"
    },
    {
      "label": "Calendar Link",
      "value": "calendar",
      "icon": Icons.event,
      "description": "Generate calendar subscription link"
    },
    {
      "label": "QR Code",
      "value": "qr_code",
      "icon": Icons.qr_code,
      "description": "Generate QR code for event"
    },
  ];
  
  // Sample reminder options
  List<Map<String, dynamic>> reminderOptions = [
    {"label": "5 minutes before", "value": "5_minutes"},
    {"label": "15 minutes before", "value": "15_minutes"},
    {"label": "30 minutes before", "value": "30_minutes"},
    {"label": "1 hour before", "value": "1_hour"},
    {"label": "1 day before", "value": "1_day"},
    {"label": "1 week before", "value": "1_week"},
  ];
  
  // Sample privacy options
  List<Map<String, dynamic>> privacyOptions = [
    {"label": "Public", "value": "public"},
    {"label": "Private", "value": "private"},
    {"label": "Invite Only", "value": "invite_only"},
  ];
  
  // Sample calendar formats
  List<Map<String, dynamic>> formatOptions = [
    {"label": "iCalendar (.ics)", "value": "ics"},
    {"label": "Google Calendar", "value": "google"},
    {"label": "Outlook", "value": "outlook"},
    {"label": "Yahoo Calendar", "value": "yahoo"},
  ];
  
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Event"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: _showEventPreview,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Event Information Section
              _buildEventInfoSection(),
              
              // Date & Time Section
              _buildDateTimeSection(),
              
              // Organizer Information Section
              _buildOrganizerSection(),
              
              // RSVP Settings Section
              _buildRSVPSection(),
              
              // Share Settings Section
              _buildShareSettingsSection(),
              
              // Privacy & Reminder Section
              _buildPrivacySection(),
              
              // Action Buttons
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventInfoSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.event, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Event Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Event Title",
            value: eventTitle,
            validator: Validator.required,
            onChanged: (value) {
              eventTitle = value;
              setState(() {});
            },
          ),
          
          QMemoField(
            label: "Event Description",
            value: eventDescription,
            hint: "Provide detailed information about the event",
            onChanged: (value) {
              eventDescription = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Event Location",
            value: eventLocation,
            hint: "Address or online meeting link",
            validator: Validator.required,
            onChanged: (value) {
              eventLocation = value;
              setState(() {});
            },
          ),
          
          QDropdownField(
            label: "Event Category",
            items: eventCategories,
            value: eventCategory,
            onChanged: (value, label) {
              eventCategory = value;
              setState(() {});
            },
          ),
          
          QImagePicker(
            label: "Event Image",
            value: eventImage,
            hint: "Add an event banner or image",
            onChanged: (value) {
              eventImage = value;
              setState(() {});
            },
          ),
          
          QAttachmentPicker(
            label: "Event Attachments",
            value: eventAttachments,
            hint: "Add agenda, documents, or other files",
            maxAttachments: 5,
            onChanged: (value) {
              eventAttachments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Date & Time",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          // Start Date & Time
          Text(
            "Event Start",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Start Date",
                  value: eventDate,
                  onChanged: (value) {
                    eventDate = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTimePicker(
                  label: "Start Time",
                  value: eventTime,
                  onChanged: (value) {
                    eventTime = value!;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // End Date & Time
          Text(
            "Event End",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDatePicker(
                  label: "End Date",
                  value: eventEndDate,
                  onChanged: (value) {
                    eventEndDate = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTimePicker(
                  label: "End Time",
                  value: eventEndTime,
                  onChanged: (value) {
                    eventEndTime = value!;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizerSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.person_pin, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Organizer Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          QTextField(
            label: "Organizer Name",
            value: organizerName,
            validator: Validator.required,
            onChanged: (value) {
              organizerName = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Organizer Email",
            value: organizerEmail,
            validator: Validator.email,
            onChanged: (value) {
              organizerEmail = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRSVPSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.how_to_reg, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "RSVP Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Require RSVP",
                      "value": true,
                      "checked": requireRSVP,
                    }
                  ],
                  value: [
                    if (requireRSVP)
                      {"label": "Require RSVP", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    requireRSVP = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          if (requireRSVP) ...[
            QNumberField(
              label: "Max Attendees",
              value: maxAttendees.toString(),
              onChanged: (value) {
                maxAttendees = int.tryParse(value) ?? 50;
                setState(() {});
              },
            ),
            
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Enable Waitlist",
                        "value": true,
                        "checked": enableWaitlist,
                      }
                    ],
                    value: [
                      if (enableWaitlist)
                        {"label": "Enable Waitlist", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      enableWaitlist = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildShareSettingsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.share, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Share Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Calendar Format",
            items: formatOptions,
            value: calendarFormat,
            onChanged: (value, label) {
              calendarFormat = value;
              setState(() {});
            },
          ),
          
          Text(
            "Share Channels",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          // Available Channels
          ...availableChannels.map((channel) {
            final isSelected = shareChannels.contains(channel["value"]);
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
                color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
              ),
              child: ListTile(
                leading: Icon(
                  channel["icon"],
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
                title: Text(
                  "${channel["label"]}",
                  style: TextStyle(
                    color: isSelected ? primaryColor : Colors.black,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  "${channel["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
                onTap: () {
                  if (isSelected) {
                    shareChannels.remove(channel["value"]);
                  } else {
                    shareChannels.add(channel["value"]);
                  }
                  setState(() {});
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Privacy & Reminders",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          QDropdownField(
            label: "Event Privacy",
            items: privacyOptions,
            value: eventPrivacy,
            onChanged: (value, label) {
              eventPrivacy = value;
              setState(() {});
            },
          ),
          
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include Reminder",
                      "value": true,
                      "checked": includeReminder,
                    }
                  ],
                  value: [
                    if (includeReminder)
                      {"label": "Include Reminder", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    includeReminder = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          if (includeReminder)
            QDropdownField(
              label: "Reminder Time",
              items: reminderOptions,
              value: reminderTime,
              onChanged: (value, label) {
                reminderTime = value;
                setState(() {});
              },
            ),
          
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Allow Guest Edit",
                      "value": true,
                      "checked": allowGuestEdit,
                    }
                  ],
                  value: [
                    if (allowGuestEdit)
                      {"label": "Allow Guest Edit", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    allowGuestEdit = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: loading ? "Creating Event..." : "Create & Share Event",
            onPressed: loading ? null : _shareEvent,
          ),
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Save Draft",
                size: bs.sm,
                onPressed: _saveDraft,
              ),
            ),
            Expanded(
              child: QButton(
                label: "Export Calendar",
                size: bs.sm,
                onPressed: _exportCalendar,
              ),
            ),
          ],
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "QR Code",
                size: bs.sm,
                onPressed: _generateQRCode,
              ),
            ),
            Expanded(
              child: QButton(
                label: "Copy Link",
                size: bs.sm,
                onPressed: _copyEventLink,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _shareEvent() async {
    if (!formKey.currentState!.validate()) return;
    
    if (shareChannels.isEmpty) {
      se("Please select at least one sharing channel");
      return;
    }
    
    if (eventDate.isBefore(DateTime.now())) {
      se("Event date cannot be in the past");
      return;
    }
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Event created and shared successfully via ${shareChannels.length} channel(s)");
  }

  void _saveDraft() async {
    await Future.delayed(Duration(seconds: 1));
    ss("Event saved as draft");
  }

  void _exportCalendar() async {
    if (!formKey.currentState!.validate()) return;
    
    await Future.delayed(Duration(seconds: 1));
    ss("Calendar file exported successfully");
  }

  void _generateQRCode() async {
    if (eventTitle.isEmpty) {
      se("Event title is required for QR code");
      return;
    }
    
    await Future.delayed(Duration(seconds: 1));
    ss("Event QR code generated successfully");
  }

  void _copyEventLink() async {
    if (eventTitle.isEmpty) {
      se("Event title is required to generate link");
      return;
    }
    
    await Future.delayed(Duration(seconds: 1));
    ss("Event link copied to clipboard");
  }

  void _showEventPreview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Event Preview"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (eventTitle.isNotEmpty) ...[
                Text(
                  eventTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
              ],
              
              if (eventDescription.isNotEmpty) ...[
                Text(eventDescription),
                SizedBox(height: spSm),
              ],
              
              Row(
                children: [
                  Icon(Icons.event, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text("${eventDate.dMMMy} at ${eventTime.kkmm}"),
                ],
              ),
              
              if (eventLocation.isNotEmpty) ...[
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(child: Text(eventLocation)),
                  ],
                ),
              ],
              
              if (organizerName.isNotEmpty) ...[
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text("Organized by $organizerName"),
                  ],
                ),
              ],
              
              if (requireRSVP) ...[
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "RSVP Required • Max $maxAttendees attendees",
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
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
