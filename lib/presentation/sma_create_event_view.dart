import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaCreateEventView extends StatefulWidget {
  const SmaCreateEventView({super.key});

  @override
  State<SmaCreateEventView> createState() => _SmaCreateEventViewState();
}

class _SmaCreateEventViewState extends State<SmaCreateEventView> {
  final formKey = GlobalKey<FormState>();
  
  String eventTitle = "";
  String category = "";
  String description = "";
  String location = "";
  String address = "";
  DateTime? eventDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String eventImage = "";
  bool isOnlineEvent = false;
  bool isFreeEvent = true;
  String ticketPrice = "";
  String maxAttendees = "";
  bool allowGuestList = true;
  bool requireApproval = false;
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "Conference", "value": "Conference"},
    {"label": "Workshop", "value": "Workshop"},
    {"label": "Meetup", "value": "Meetup"},
    {"label": "Party", "value": "Party"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Concert", "value": "Concert"},
    {"label": "Seminar", "value": "Seminar"},
    {"label": "Networking", "value": "Networking"},
    {"label": "Exhibition", "value": "Exhibition"},
    {"label": "Other", "value": "Other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
        actions: [
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                showLoading();
                await Future.delayed(Duration(seconds: 2));
                hideLoading();
                ss("Event created successfully!");
                back();
              }
            },
            child: Text(
              "Create",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Event Image Section
              Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Event Image",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      QImagePicker(
                        label: "Event Cover Image",
                        value: eventImage,
                        hint: "Select an attractive cover image for your event",
                        validator: Validator.required,
                        onChanged: (value) {
                          eventImage = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Basic Information Section
              Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Event Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      QTextField(
                        label: "Event Title",
                        value: eventTitle,
                        hint: "Enter your event title",
                        validator: Validator.required,
                        onChanged: (value) {
                          eventTitle = value;
                          setState(() {});
                        },
                      ),
                      
                      QDropdownField(
                        label: "Category",
                        value: category,
                        items: categoryItems,
                        validator: Validator.required,
                        onChanged: (value, label) {
                          category = value;
                          setState(() {});
                        },
                      ),
                      
                      QMemoField(
                        label: "Description",
                        value: description,
                        hint: "Describe your event, agenda, and what attendees can expect",
                        validator: Validator.required,
                        onChanged: (value) {
                          description = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Date and Time Section
              Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Date & Time",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      QDatePicker(
                        label: "Event Date",
                        value: eventDate,
                        validator: Validator.required,
                        onChanged: (value) {
                          eventDate = value;
                          setState(() {});
                        },
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: QTimePicker(
                              label: "Start Time",
                              value: startTime,
                              onChanged: (value) {
                                startTime = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTimePicker(
                              label: "End Time",
                              value: endTime,
                              onChanged: (value) {
                                endTime = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Location Section
              Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      QSwitch(
                        label: "Event Type",
                        items: [
                          {
                            "label": "Online Event",
                            "value": true,
                            "checked": isOnlineEvent,
                          }
                        ],
                        value: [
                          if (isOnlineEvent)
                            {
                              "label": "Online Event",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isOnlineEvent = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      
                      if (!isOnlineEvent) ...[
                        QTextField(
                          label: "Venue Name",
                          value: location,
                          hint: "Enter venue or location name",
                          validator: Validator.required,
                          onChanged: (value) {
                            location = value;
                            setState(() {});
                          },
                        ),
                        
                        QTextField(
                          label: "Full Address",
                          value: address,
                          hint: "Enter complete address with city and postal code",
                          validator: Validator.required,
                          onChanged: (value) {
                            address = value;
                            setState(() {});
                          },
                        ),
                      ] else ...[
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(76)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.video_call,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Online event link will be shared with attendees before the event",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Ticketing Section
              Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Ticketing",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      QSwitch(
                        label: "Ticket Type",
                        items: [
                          {
                            "label": "Free Event",
                            "value": true,
                            "checked": isFreeEvent,
                          }
                        ],
                        value: [
                          if (isFreeEvent)
                            {
                              "label": "Free Event",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          isFreeEvent = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      
                      if (!isFreeEvent) ...[
                        QNumberField(
                          label: "Ticket Price (\$)",
                          value: ticketPrice,
                          hint: "Enter ticket price",
                          validator: Validator.required,
                          onChanged: (value) {
                            ticketPrice = value;
                            setState(() {});
                          },
                        ),
                      ],
                      
                      QNumberField(
                        label: "Maximum Attendees",
                        value: maxAttendees,
                        hint: "Enter maximum number of attendees (optional)",
                        onChanged: (value) {
                          maxAttendees = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Settings Section
              Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Event Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      QSwitch(
                        label: "Guest List",
                        items: [
                          {
                            "label": "Allow attendees to see guest list",
                            "value": true,
                            "checked": allowGuestList,
                          }
                        ],
                        value: [
                          if (allowGuestList)
                            {
                              "label": "Allow attendees to see guest list",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          allowGuestList = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      
                      QSwitch(
                        label: "Approval Required",
                        items: [
                          {
                            "label": "Require approval for new attendees",
                            "value": true,
                            "checked": requireApproval,
                          }
                        ],
                        value: [
                          if (requireApproval)
                            {
                              "label": "Require approval for new attendees",
                              "value": true,
                              "checked": true
                            }
                        ],
                        onChanged: (values, ids) {
                          requireApproval = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Event Preview Section
              if (eventTitle.isNotEmpty) ...[
                Card(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Text(
                          "Event Preview",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: primaryColor.withAlpha(76)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              if (eventImage.isNotEmpty) ...[
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    color: disabledColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Event Cover Image",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              
                              Row(
                                children: [
                                  if (category.isNotEmpty) ...[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isFreeEvent ? successColor : warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      isFreeEvent ? "Free" : "\$$ticketPrice",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              Text(
                                eventTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              if (eventDate != null || startTime != null) ...[
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${eventDate?.dMMMy ?? "Date"} ${startTime?.kkmm ?? "Time"}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              
                              if (location.isNotEmpty || isOnlineEvent) ...[
                                Row(
                                  children: [
                                    Icon(
                                      isOnlineEvent ? Icons.video_call : Icons.location_on,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      isOnlineEvent ? "Online Event" : location,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              
                              if (description.isNotEmpty) ...[
                                Text(
                                  description.length > 100 
                                      ? "${description.substring(0, 100)}..."
                                      : description,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Create Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Event",
                  size: bs.md,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      showLoading();
                      await Future.delayed(Duration(seconds: 2));
                      hideLoading();
                      ss("Event created successfully!");
                      back();
                    }
                  },
                ),
              ),

              // Guidelines
              Card(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Event Guidelines",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: infoColor.withAlpha(76)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: infoColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Please follow these guidelines:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "• Use a clear and descriptive event title",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "• Select appropriate category and provide detailed description",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "• Use high-quality cover image that represents your event",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "• Provide accurate date, time, and location information",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "• Be clear about ticketing and attendance requirements",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
