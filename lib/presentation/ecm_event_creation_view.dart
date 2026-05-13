import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmEventCreationView extends StatefulWidget {
  const EcmEventCreationView({super.key});

  @override
  State<EcmEventCreationView> createState() => _EcmEventCreationViewState();
}

class _EcmEventCreationViewState extends State<EcmEventCreationView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  
  // Basic Information
  String eventName = "";
  String eventType = "";
  String description = "";
  String eventCategory = "";
  
  // Date & Time
  String startDate = "";
  String endDate = "";
  String startTime = "";
  String endTime = "";
  String timezone = "";
  
  // Location & Venue
  String venueType = "";
  String venueName = "";
  String address = "";
  String city = "";
  String country = "";
  String onlineUrl = "";
  
  // Capacity & Ticketing
  String maxAttendees = "";
  bool isPrivate = false;
  bool requiresApproval = false;
  String ticketType = "";
  String ticketPrice = "";
  
  // Event Settings
  List<String> eventImages = [];
  bool allowNetworking = true;
  bool enableChat = true;
  bool recordEvent = false;
  String registrationDeadline = "";
  
  List<Map<String, dynamic>> eventTypes = [
    {"label": "Conference", "value": "conference"},
    {"label": "Workshop", "value": "workshop"},
    {"label": "Seminar", "value": "seminar"},
    {"label": "Webinar", "value": "webinar"},
    {"label": "Corporate Event", "value": "corporate"},
    {"label": "Wedding", "value": "wedding"},
    {"label": "Birthday Party", "value": "birthday"},
    {"label": "Festival", "value": "festival"},
    {"label": "Concert", "value": "concert"},
    {"label": "Exhibition", "value": "exhibition"},
    {"label": "Other", "value": "other"},
  ];
  
  List<Map<String, dynamic>> venueTypes = [
    {"label": "Physical Venue", "value": "physical"},
    {"label": "Online Event", "value": "online"},
    {"label": "Hybrid Event", "value": "hybrid"},
  ];
  
  List<Map<String, dynamic>> ticketTypes = [
    {"label": "Free Event", "value": "free"},
    {"label": "Paid Event", "value": "paid"},
    {"label": "Donation Based", "value": "donation"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Event"),
        actions: [
          GestureDetector(
            onTap: () {
              si("Save as draft");
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                children: [
                  Icon(Icons.save, size: 20, color: primaryColor),
                  SizedBox(width: spXs),
                  Text(
                    "Draft",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: List.generate(4, (index) {
                    bool isActive = index <= currentStep;
                    bool isCurrent = index == currentStep;
                    
                    return Expanded(
                      child: Row(
                        children: [
                          if (index > 0) 
                            Expanded(
                              child: Container(
                                height: 2,
                                color: isActive ? primaryColor : disabledColor,
                              ),
                            ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isActive ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (index < 3)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: isActive && index < currentStep ? primaryColor : disabledColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: spMd),
                Text(
                  _getStepTitle(currentStep),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  _getStepSubtitle(currentStep),
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Step content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: _buildStepContent(),
              ),
            ),
          ),
          
          // Navigation buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                if (currentStep > 0) ...[
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                ],
                Expanded(
                  flex: currentStep > 0 ? 2 : 1,
                  child: QButton(
                    label: currentStep < 3 ? "Next" : "Create Event",
                    size: bs.md,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (currentStep < 3) {
                          currentStep++;
                          setState(() {});
                        } else {
                          _createEvent();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildDateTimeStep();
      case 2:
        return _buildLocationStep();
      case 3:
        return _buildSettingsStep();
      default:
        return Container();
    }
  }
  
  Widget _buildBasicInfoStep() {
    return Column(
      spacing: spMd,
      children: [
        QTextField(
          label: "Event Name",
          value: eventName,
          hint: "Enter a compelling event name",
          validator: Validator.required,
          onChanged: (value) {
            eventName = value;
            setState(() {});
          },
        ),
        
        QDropdownField(
          label: "Event Type",
          items: eventTypes,
          value: eventType,
          onChanged: (value, label) {
            eventType = value;
            setState(() {});
          },
        ),
        
        QMemoField(
          label: "Event Description",
          value: description,
          hint: "Describe what your event is about, what attendees can expect, and why they should attend",
          validator: Validator.required,
          onChanged: (value) {
            description = value;
            setState(() {});
          },
        ),
        
        QMultiImagePicker(
          label: "Event Images",
          value: eventImages,
          hint: "Add high-quality images to showcase your event",
          maxImages: 5,
          onChanged: (value) {
            eventImages = value;
            setState(() {});
          },
        ),
        
        Row(
          children: [
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Private Event",
                    "value": true,
                    "checked": isPrivate,
                  }
                ],
                value: [
                  if (isPrivate)
                    {
                      "label": "Private Event",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    isPrivate = values.isNotEmpty;
                  });
                },
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Requires Approval",
                    "value": true,
                    "checked": requiresApproval,
                  }
                ],
                value: [
                  if (requiresApproval)
                    {
                      "label": "Requires Approval",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    requiresApproval = values.isNotEmpty;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildDateTimeStep() {
    return Column(
      spacing: spMd,
      children: [
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDatePicker(
                label: "Start Date",
                value: startDate.isNotEmpty ? DateTime.parse(startDate) : DateTime.now(),
                onChanged: (value) {
                  startDate = value.toIso8601String();
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTimePicker(
                label: "Start Time",
                value: startTime.isNotEmpty 
                    ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $startTime"))
                    : TimeOfDay.now(),
                onChanged: (value) {
                  startTime = value!.kkmm;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QDatePicker(
                label: "End Date",
                value: endDate.isNotEmpty ? DateTime.parse(endDate) : DateTime.now(),
                onChanged: (value) {
                  endDate = value.toIso8601String();
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: QTimePicker(
                label: "End Time",
                value: endTime.isNotEmpty 
                    ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $endTime"))
                    : TimeOfDay.now(),
                onChanged: (value) {
                  endTime = value!.kkmm;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        
        QTextField(
          label: "Timezone",
          value: timezone,
          hint: "e.g., UTC-5, EST, PST",
          validator: Validator.required,
          onChanged: (value) {
            timezone = value;
            setState(() {});
          },
        ),
        
        QDatePicker(
          label: "Registration Deadline",
          value: registrationDeadline.isNotEmpty 
              ? DateTime.parse(registrationDeadline) 
              : DateTime.now(),
          onChanged: (value) {
            registrationDeadline = value.toIso8601String();
            setState(() {});
          },
        ),
      ],
    );
  }
  
  Widget _buildLocationStep() {
    return Column(
      spacing: spMd,
      children: [
        QDropdownField(
          label: "Venue Type",
          items: venueTypes,
          value: venueType,
          onChanged: (value, label) {
            venueType = value;
            setState(() {});
          },
        ),
        
        if (venueType == "physical" || venueType == "hybrid") ...[
          QTextField(
            label: "Venue Name",
            value: venueName,
            hint: "Enter venue name",
            validator: Validator.required,
            onChanged: (value) {
              venueName = value;
              setState(() {});
            },
          ),
          
          QTextField(
            label: "Street Address",
            value: address,
            hint: "Enter complete address",
            validator: Validator.required,
            onChanged: (value) {
              address = value;
              setState(() {});
            },
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "City",
                  value: city,
                  hint: "City",
                  validator: Validator.required,
                  onChanged: (value) {
                    city = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Country",
                  value: country,
                  hint: "Country",
                  validator: Validator.required,
                  onChanged: (value) {
                    country = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
        
        if (venueType == "online" || venueType == "hybrid") ...[
          QTextField(
            label: "Online Meeting URL",
            value: onlineUrl,
            hint: "Zoom, Teams, or other platform link",
            validator: venueType == "online" ? Validator.required : null,
            onChanged: (value) {
              onlineUrl = value;
              setState(() {});
            },
          ),
        ],
        
        QNumberField(
          label: "Maximum Attendees",
          value: maxAttendees,
          validator: Validator.required,
          onChanged: (value) {
            maxAttendees = value;
            setState(() {});
          },
        ),
      ],
    );
  }
  
  Widget _buildSettingsStep() {
    return Column(
      spacing: spMd,
      children: [
        QDropdownField(
          label: "Ticket Type",
          items: ticketTypes,
          value: ticketType,
          onChanged: (value, label) {
            ticketType = value;
            setState(() {});
          },
        ),
        
        if (ticketType == "paid") ...[
          QNumberField(
            label: "Ticket Price (\$)",
            value: ticketPrice,
            validator: Validator.required,
            onChanged: (value) {
              ticketPrice = value;
              setState(() {});
            },
          ),
        ],
        
        Text(
          "Event Features",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        QSwitch(
          items: [
            {
              "label": "Allow Networking",
              "value": "networking",
              "checked": allowNetworking,
            },
            {
              "label": "Enable Live Chat",
              "value": "chat",
              "checked": enableChat,
            },
            {
              "label": "Record Event",
              "value": "record",
              "checked": recordEvent,
            },
          ],
          value: [
            if (allowNetworking) {"label": "Allow Networking", "value": "networking", "checked": true},
            if (enableChat) {"label": "Enable Live Chat", "value": "chat", "checked": true},
            if (recordEvent) {"label": "Record Event", "value": "record", "checked": true},
          ],
          onChanged: (values, ids) {
            setState(() {
              allowNetworking = values.any((v) => v["value"] == "networking");
              enableChat = values.any((v) => v["value"] == "chat");
              recordEvent = values.any((v) => v["value"] == "record");
            });
          },
        ),
        
        // Event preview
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: primaryColor.withAlpha(60)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Event Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              if (eventName.isNotEmpty) ...[
                Text(
                  eventName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
              ],
              
              if (startDate.isNotEmpty && startTime.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "$startDate at $startTime",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
              ],
              
              if (venueName.isNotEmpty || onlineUrl.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      venueType == "online" ? "Online Event" : venueName,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
              ],
              
              if (maxAttendees.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Max $maxAttendees attendees",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
  
  String _getStepTitle(int step) {
    switch (step) {
      case 0: return "Basic Information";
      case 1: return "Date & Time";
      case 2: return "Location & Venue";
      case 3: return "Settings & Preview";
      default: return "";
    }
  }
  
  String _getStepSubtitle(int step) {
    switch (step) {
      case 0: return "Tell us about your event";
      case 1: return "When will your event take place?";
      case 2: return "Where will your event be held?";
      case 3: return "Configure final settings";
      default: return "";
    }
  }
  
  void _createEvent() {
    ss("Event '${eventName}' created successfully!");
    back();
  }
}
