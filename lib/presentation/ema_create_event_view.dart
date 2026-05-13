import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaCreateEventView extends StatefulWidget {
  const EmaCreateEventView({super.key});

  @override
  State<EmaCreateEventView> createState() => _EmaCreateEventViewState();
}

class _EmaCreateEventViewState extends State<EmaCreateEventView> {
  final formKey = GlobalKey<FormState>();
  
  // Basic Info
  String eventTitle = "";
  String eventDescription = "";
  String selectedCategory = "";
  List<String> eventImages = [];
  
  // Date & Time
  DateTime selectedDate = DateTime.now().add(Duration(days: 7));
  TimeOfDay startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 17, minute: 0);
  
  // Location
  String selectedVenue = "";
  String customLocation = "";
  bool useCustomLocation = false;
  
  // Pricing
  bool isFreeEvent = true;
  List<Map<String, dynamic>> ticketTypes = [
    {"name": "General Admission", "price": 0.0, "quantity": 100, "description": ""},
  ];
  
  // Settings
  bool allowRegistration = true;
  bool requireApproval = false;
  bool sendReminders = true;
  int maxAttendees = 100;
  
  final categories = [
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Education", "value": "education"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Sports", "value": "sports"},
    {"label": "Health & Wellness", "value": "health"},
    {"label": "Arts & Culture", "value": "arts"},
    {"label": "Food & Drink", "value": "food"},
  ];

  final venues = [
    {"label": "Grand Convention Center", "value": "grand_convention"},
    {"label": "Tech Hub Conference Room", "value": "tech_hub"},
    {"label": "Downtown Event Space", "value": "downtown_space"},
    {"label": "University Auditorium", "value": "university_hall"},
    {"label": "Community Center", "value": "community_center"},
    {"label": "Custom Location", "value": "custom"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
        leading: GestureDetector(
          onTap: () => back(),
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(
            onTap: _saveAsDraft,
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              _buildBasicInfo(),
              _buildEventImages(),
              _buildDateTimeSection(),
              _buildLocationSection(),
              _buildPricingSection(),
              _buildSettingsSection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Event Title",
            value: eventTitle,
            hint: "Enter a compelling event title",
            validator: Validator.required,
            onChanged: (value) {
              eventTitle = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Event Description",
            value: eventDescription,
            hint: "Describe your event in detail...",
            validator: Validator.required,
            onChanged: (value) {
              eventDescription = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Event Category",
            items: categories,
            value: selectedCategory,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventImages() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Event Images",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMultiImagePicker(
            label: "Upload Event Photos",
            value: eventImages,
            maxImages: 5,
            hint: "Add photos to showcase your event",
            helper: "You can upload up to 5 high-quality images",
            onChanged: (value) {
              eventImages = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Date & Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDatePicker(
            label: "Event Date",
            value: selectedDate,
            validator: Validator.required,
            onChanged: (value) {
              selectedDate = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTimePicker(
                  label: "Start Time",
                  value: startTime,
                  validator: Validator.required,
                  onChanged: (value) {
                    startTime = value!;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTimePicker(
                  label: "End Time",
                  value: endTime,
                  validator: Validator.required,
                  onChanged: (value) {
                    endTime = value!;
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

  Widget _buildLocationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Location",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Venue",
            items: venues,
            value: selectedVenue,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedVenue = value;
              useCustomLocation = value == "custom";
              setState(() {});
            },
          ),
          if (useCustomLocation)
            QTextField(
              label: "Custom Location",
              value: customLocation,
              hint: "Enter the exact address or location details",
              validator: Validator.required,
              onChanged: (value) {
                customLocation = value;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Pricing & Tickets",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Free Event",
                "value": true,
                "checked": isFreeEvent,
              }
            ],
            value: [if (isFreeEvent) {"label": "Free Event", "value": true, "checked": true}],
            onChanged: (values, ids) {
              isFreeEvent = values.isNotEmpty;
              if (isFreeEvent) {
                ticketTypes.clear();
                ticketTypes.add({
                  "name": "Free Admission",
                  "price": 0.0,
                  "quantity": maxAttendees,
                  "description": "Free entry for all attendees"
                });
              }
              setState(() {});
            },
          ),
          if (!isFreeEvent) ...[
            ...ticketTypes.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> ticket = entry.value;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Ticket Type ${index + 1}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (ticketTypes.length > 1)
                          GestureDetector(
                            onTap: () {
                              ticketTypes.removeAt(index);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.delete,
                              color: dangerColor,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                    QTextField(
                      label: "Ticket Name",
                      value: ticket["name"],
                      onChanged: (value) {
                        ticketTypes[index]["name"] = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Price (\$)",
                            value: ticket["price"].toString(),
                            onChanged: (value) {
                              ticketTypes[index]["price"] = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QNumberField(
                            label: "Quantity",
                            value: ticket["quantity"].toString(),
                            onChanged: (value) {
                              ticketTypes[index]["quantity"] = int.tryParse(value) ?? 0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Description",
                      value: ticket["description"],
                      hint: "Brief description of this ticket type",
                      onChanged: (value) {
                        ticketTypes[index]["description"] = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Add Another Ticket Type",
                size: bs.sm,
                onPressed: () {
                  ticketTypes.add({
                    "name": "",
                    "price": 0.0,
                    "quantity": 50,
                    "description": ""
                  });
                  setState(() {});
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            "Event Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Maximum Attendees",
            value: maxAttendees.toString(),
            validator: Validator.required,
            onChanged: (value) {
              maxAttendees = int.tryParse(value) ?? 100;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Allow Online Registration",
                "value": "registration",
                "checked": allowRegistration,
              },
              {
                "label": "Require Approval",
                "value": "approval",
                "checked": requireApproval,
              },
              {
                "label": "Send Email Reminders",
                "value": "reminders",
                "checked": sendReminders,
              }
            ],
            value: [
              if (allowRegistration) {"label": "Allow Online Registration", "value": "registration", "checked": true},
              if (requireApproval) {"label": "Require Approval", "value": "approval", "checked": true},
              if (sendReminders) {"label": "Send Email Reminders", "value": "reminders", "checked": true},
            ],
            onChanged: (values, ids) {
              allowRegistration = values.any((v) => v["value"] == "registration");
              requireApproval = values.any((v) => v["value"] == "approval");
              sendReminders = values.any((v) => v["value"] == "reminders");
              setState(() {});
            },
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
            label: "Create Event",
            size: bs.md,
            onPressed: _createEvent,
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Preview Event",
            size: bs.md,
            onPressed: _previewEvent,
          ),
        ),
      ],
    );
  }

  void _saveAsDraft() {
    ss("Event saved as draft");
  }

  void _createEvent() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Event created successfully!");
      back();
    }
  }

  void _previewEvent() {
    if (eventTitle.isEmpty) {
      se("Please enter an event title first");
      return;
    }
    
    // Navigate to preview
    // navigateTo(EmaEventDetailView())
    si("Preview functionality would show here");
  }
}
