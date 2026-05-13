import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvitation3View extends StatefulWidget {
  @override
  State<GrlInvitation3View> createState() => _GrlInvitation3ViewState();
}

class _GrlInvitation3ViewState extends State<GrlInvitation3View> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Information
  String eventTitle = "";
  String eventDescription = "";
  String eventDate = DateTime.now().add(Duration(days: 7)).toIso8601String().substring(0, 10);
  String eventTime = "18:00";
  String eventLocation = "";
  String eventCategory = "personal";
  
  // Invitation Details
  String invitationMessage = "";
  String rsvpDeadline = DateTime.now().add(Duration(days: 3)).toIso8601String().substring(0, 10);
  bool allowPlusOne = false;
  bool requireRSVP = true;
  
  // Recipients
  List<Map<String, dynamic>> recipients = [];
  String recipientName = "";
  String recipientEmail = "";
  
  // Settings
  String sendTime = "immediately";
  bool sendReminders = true;
  String templateStyle = "modern";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Personal Event", "value": "personal"},
    {"label": "Business Meeting", "value": "business"},
    {"label": "Social Gathering", "value": "social"},
    {"label": "Charity Event", "value": "charity"},
    {"label": "Educational", "value": "education"},
    {"label": "Sports & Recreation", "value": "sports"},
  ];

  List<Map<String, dynamic>> sendTimeOptions = [
    {"label": "Send Immediately", "value": "immediately"},
    {"label": "Schedule for Later", "value": "scheduled"},
    {"label": "Save as Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> templateOptions = [
    {"label": "Modern", "value": "modern"},
    {"label": "Classic", "value": "classic"},
    {"label": "Elegant", "value": "elegant"},
    {"label": "Casual", "value": "casual"},
  ];

  void _addRecipient() {
    if (recipientName.isNotEmpty && recipientEmail.isNotEmpty) {
      recipients.add({
        "name": recipientName,
        "email": recipientEmail,
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
      });
      
      recipientName = "";
      recipientEmail = "";
      setState(() {});
    }
  }

  void _removeRecipient(String id) {
    recipients.removeWhere((recipient) => recipient["id"] == id);
    setState(() {});
  }

  Future<void> _sendInvitations() async {
    if (!formKey.currentState!.validate()) {
      se("Please complete all required fields");
      return;
    }

    if (recipients.isEmpty) {
      se("Please add at least one recipient");
      return;
    }

    showLoading();
    
    // Simulate sending invitations
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    ss("${recipients.length} invitation(s) sent successfully!");
    
    // Reset form
    _resetForm();
  }

  void _resetForm() {
    eventTitle = "";
    eventDescription = "";
    eventDate = DateTime.now().add(Duration(days: 7)).toIso8601String().substring(0, 10);
    eventTime = "18:00";
    eventLocation = "";
    eventCategory = "personal";
    invitationMessage = "";
    rsvpDeadline = DateTime.now().add(Duration(days: 3)).toIso8601String().substring(0, 10);
    allowPlusOne = false;
    requireRSVP = true;
    recipients = [];
    recipientName = "";
    recipientEmail = "";
    sendTime = "immediately";
    sendReminders = true;
    templateStyle = "modern";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Invitation"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              // Preview invitation
            },
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
              // Header
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Icon(Icons.create, color: Colors.white, size: 28),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Your Invitation",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Design and send beautiful invitations",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(220),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (recipients.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${recipients.length} recipient${recipients.length > 1 ? 's' : ''}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Event Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Event Title",
                      value: eventTitle,
                      validator: Validator.required,
                      onChanged: (value) {
                        eventTitle = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Event Description",
                      value: eventDescription,
                      hint: "Describe your event in detail...",
                      onChanged: (value) {
                        eventDescription = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Event Category",
                      items: categoryOptions,
                      value: eventCategory,
                      onChanged: (value, label) {
                        eventCategory = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QDatePicker(
                            label: "Event Date",
                            value: DateTime.parse(eventDate),
                            onChanged: (value) {
                              eventDate = value.toIso8601String().substring(0, 10);
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Event Time",
                            value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $eventTime:00")),
                            onChanged: (value) {
                              eventTime = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Event Location",
                      value: eventLocation,
                      validator: Validator.required,
                      hint: "Enter venue address or location",
                      onChanged: (value) {
                        eventLocation = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Invitation Message
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Invitation Message",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "Personal Message",
                      value: invitationMessage,
                      hint: "Add a personal message to your guests...",
                      onChanged: (value) {
                        invitationMessage = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Template Style",
                      items: templateOptions,
                      value: templateStyle,
                      onChanged: (value, label) {
                        templateStyle = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // RSVP Settings
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "RSVP Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QSwitch(
                      items: [
                        {
                          "label": "Require RSVP response",
                          "value": true,
                          "checked": requireRSVP,
                        }
                      ],
                      value: [if (requireRSVP) {"label": "Require RSVP response", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        requireRSVP = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (requireRSVP) ...[
                      SizedBox(height: spSm),
                      QDatePicker(
                        label: "RSVP Deadline",
                        value: DateTime.parse(rsvpDeadline),
                        onChanged: (value) {
                          rsvpDeadline = value.toIso8601String().substring(0, 10);
                          setState(() {});
                        },
                      ),
                    ],
                    SizedBox(height: spSm),
                    QSwitch(
                      items: [
                        {
                          "label": "Allow guests to bring a plus one",
                          "value": true,
                          "checked": allowPlusOne,
                        }
                      ],
                      value: [if (allowPlusOne) {"label": "Allow guests to bring a plus one", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        allowPlusOne = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Add Recipients
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Recipients",
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
                            label: "Recipient Name",
                            value: recipientName,
                            onChanged: (value) {
                              recipientName = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTextField(
                            label: "Email Address",
                            value: recipientEmail,
                            onChanged: (value) {
                              recipientEmail = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add",
                          size: bs.sm,
                          onPressed: _addRecipient,
                        ),
                      ],
                    ),
                    
                    // Recipients List
                    if (recipients.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Text(
                        "Recipients (${recipients.length})",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Column(
                        children: recipients.map((recipient) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: successColor.withAlpha(30)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.person, color: successColor, size: 20),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recipient["name"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        recipient["email"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _removeRecipient(recipient["id"]),
                                  child: Icon(
                                    Icons.close,
                                    color: dangerColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Send Settings
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Send Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "When to Send",
                      items: sendTimeOptions,
                      value: sendTime,
                      onChanged: (value, label) {
                        sendTime = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QSwitch(
                      items: [
                        {
                          "label": "Send automatic reminders",
                          "value": true,
                          "checked": sendReminders,
                        }
                      ],
                      value: [if (sendReminders) {"label": "Send automatic reminders", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        sendReminders = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Summary Card
              if (eventTitle.isNotEmpty && recipients.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: infoColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info, color: infoColor),
                          SizedBox(width: spSm),
                          Text(
                            "Invitation Summary",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Event: $eventTitle",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Date: ${DateTime.parse(eventDate).dMMMy} at $eventTime",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Location: $eventLocation",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Recipients: ${recipients.length}",
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
                    ],
                  ),
                ),
              
              SizedBox(height: spMd),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save as Draft",
                      size: bs.md,
                      onPressed: () {
                        // Save as draft
                        ss("Invitation saved as draft");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: sendTime == "immediately" ? "Send Invitations" : "Schedule Invitations",
                      size: bs.md,
                      onPressed: _sendInvitations,
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
}
