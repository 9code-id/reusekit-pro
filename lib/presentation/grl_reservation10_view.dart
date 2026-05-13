import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReservation10View extends StatefulWidget {
  @override
  State<GrlReservation10View> createState() => _GrlReservation10ViewState();
}

class _GrlReservation10ViewState extends State<GrlReservation10View> {
  String eventType = "Conference";
  String eventName = "";
  String eventDescription = "";
  String startDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
  String endDate = DateTime.now().add(Duration(days: 30)).toString().split(' ')[0];
  String startTime = "09:00";
  String endTime = "17:00";
  String venue = "";
  String capacity = "";
  String budget = "";
  String organizerName = "";
  String organizerEmail = "";
  String organizerPhone = "";
  String cateringPreference = "None";
  String audioVisualNeeds = "";
  String decorationTheme = "";
  String specialRequirements = "";
  bool needsPhotography = false;
  bool needsLiveStreaming = false;
  bool needsSecurityService = false;
  bool needsTransportation = false;
  bool agreeToTerms = false;

  List<Map<String, dynamic>> eventTypes = [
    {
      "name": "Conference",
      "description": "Professional conferences and seminars",
      "icon": Icons.business_center,
      "basePrice": 5000.0
    },
    {
      "name": "Wedding",
      "description": "Wedding ceremonies and receptions",
      "icon": Icons.favorite,
      "basePrice": 8000.0
    },
    {
      "name": "Corporate Event",
      "description": "Company meetings and corporate functions",
      "icon": Icons.business,
      "basePrice": 4000.0
    },
    {
      "name": "Birthday Party",
      "description": "Birthday celebrations and parties",
      "icon": Icons.cake,
      "basePrice": 2000.0
    },
    {
      "name": "Exhibition",
      "description": "Trade shows and exhibitions",
      "icon": Icons.store,
      "basePrice": 6000.0
    },
    {
      "name": "Cultural Event",
      "description": "Cultural performances and festivals",
      "icon": Icons.theater_comedy,
      "basePrice": 3500.0
    }
  ];

  List<String> cateringOptions = [
    "None",
    "Light Refreshments",
    "Lunch/Dinner",
    "Full Catering",
    "Custom Menu"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Planning"),
        actions: [
          IconButton(
            icon: Icon(Icons.event),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventTypeSelection(),
            SizedBox(height: spMd),
            _buildEventDetails(),
            SizedBox(height: spMd),
            _buildDateTimeSection(),
            SizedBox(height: spMd),
            _buildVenueAndCapacity(),
            SizedBox(height: spMd),
            _buildOrganizerInformation(),
            SizedBox(height: spMd),
            _buildCateringSection(),
            SizedBox(height: spMd),
            _buildAdditionalServices(),
            SizedBox(height: spMd),
            _buildSpecialRequirements(),
            SizedBox(height: spMd),
            _buildTermsAndConditions(),
            SizedBox(height: spMd),
            _buildEventSummary(),
            SizedBox(height: spMd),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEventTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Event Type",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 150,
          children: eventTypes.map((type) {
            bool isSelected = eventType == type["name"];
            
            return GestureDetector(
              onTap: () {
                eventType = type["name"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected ? [shadowSm] : [],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : primaryColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        type["icon"],
                        color: isSelected ? Colors.white : primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${type["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${type["description"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "From \$${(type["basePrice"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEventDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Event Name",
          value: eventName,
          hint: "Enter the name of your event",
          onChanged: (value) {
            eventName = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Event Description",
          value: eventDescription,
          hint: "Describe your event, its purpose, and key details",
          onChanged: (value) {
            eventDescription = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date & Time",
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
              child: QDatePicker(
                label: "Start Date",
                value: DateTime.parse(startDate),
                onChanged: (value) {
                  startDate = value.toString().split(' ')[0];
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDatePicker(
                label: "End Date",
                value: DateTime.parse(endDate),
                onChanged: (value) {
                  endDate = value.toString().split(' ')[0];
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
              child: QTimePicker(
                label: "Start Time",
                value: TimeOfDay(
                  hour: int.parse(startTime.split(':')[0]),
                  minute: int.parse(startTime.split(':')[1]),
                ),
                onChanged: (value) {
                  startTime = value!.kkmm;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTimePicker(
                label: "End Time",
                value: TimeOfDay(
                  hour: int.parse(endTime.split(':')[0]),
                  minute: int.parse(endTime.split(':')[1]),
                ),
                onChanged: (value) {
                  endTime = value!.kkmm;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVenueAndCapacity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Venue & Capacity",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Preferred Venue",
          value: venue,
          hint: "Venue name or location preference",
          onChanged: (value) {
            venue = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QNumberField(
                label: "Expected Guests",
                value: capacity,
                onChanged: (value) {
                  capacity = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Budget Range",
                value: budget,
                hint: "e.g., \$5,000 - \$10,000",
                onChanged: (value) {
                  budget = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrganizerInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Organizer Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QTextField(
          label: "Organizer Name",
          value: organizerName,
          onChanged: (value) {
            organizerName = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Email Address",
                value: organizerEmail,
                onChanged: (value) {
                  organizerEmail = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Phone Number",
                value: organizerPhone,
                onChanged: (value) {
                  organizerPhone = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCateringSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Catering & Refreshments",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QDropdownField(
          label: "Catering Preference",
          value: cateringPreference,
          items: cateringOptions.map((option) => {
            "label": option,
            "value": option,
          }).toList(),
          onChanged: (value, label) {
            cateringPreference = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Audio/Visual Requirements",
          value: audioVisualNeeds,
          hint: "Microphones, projectors, sound system, lighting, etc.",
          onChanged: (value) {
            audioVisualNeeds = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Decoration Theme",
          value: decorationTheme,
          hint: "Color scheme, style, or specific theme",
          onChanged: (value) {
            decorationTheme = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildAdditionalServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional Services",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              _buildServiceSwitch(
                "Photography & Videography",
                "Professional event photography and video recording",
                needsPhotography,
                (value) => needsPhotography = value,
              ),
              
              _buildServiceSwitch(
                "Live Streaming",
                "Live broadcast of your event online",
                needsLiveStreaming,
                (value) => needsLiveStreaming = value,
              ),
              
              _buildServiceSwitch(
                "Security Service",
                "Professional security personnel for the event",
                needsSecurityService,
                (value) => needsSecurityService = value,
              ),
              
              _buildServiceSwitch(
                "Transportation",
                "Guest transportation and parking arrangements",
                needsTransportation,
                (value) => needsTransportation = value,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSwitch(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(20) : Colors.transparent,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? primaryColor : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: (newValue) {
                onChanged(newValue);
                setState(() {});
              },
              activeColor: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Special Requirements",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Additional Requirements",
          value: specialRequirements,
          hint: "Any specific needs, accessibility requirements, or special arrangements",
          onChanged: (value) {
            specialRequirements = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Terms & Conditions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Important Notes:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "• Event planning consultation is required before final booking\n"
                "• 50% deposit required to secure the date\n"
                "• Cancellation policy applies based on timing\n"
                "• Final guest count needed 7 days before event\n"
                "• Additional charges may apply for extra services",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spSm),
        
        QSwitch(
          items: [
            {
              "label": "I agree to the terms and conditions",
              "value": true,
              "checked": agreeToTerms,
            }
          ],
          value: [
            if (agreeToTerms)
              {
                "label": "I agree to the terms and conditions",
                "value": true,
                "checked": true
              }
          ],
          onChanged: (values, ids) {
            setState(() {
              agreeToTerms = values.isNotEmpty;
            });
          },
        ),
      ],
    );
  }

  Widget _buildEventSummary() {
    if (eventType.isEmpty || eventName.isEmpty) {
      return Container();
    }

    Map<String, dynamic> selectedEventType = eventTypes.firstWhere(
      (type) => type["name"] == eventType,
    );

    double basePrice = selectedEventType["basePrice"];
    double additionalServices = 0;
    
    if (needsPhotography) additionalServices += 1500;
    if (needsLiveStreaming) additionalServices += 800;
    if (needsSecurityService) additionalServices += 600;
    if (needsTransportation) additionalServices += 400;

    double totalEstimate = basePrice + additionalServices;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          _buildSummaryRow("Event Type", eventType),
          _buildSummaryRow("Event Name", eventName),
          _buildSummaryRow("Start Date", DateTime.parse(startDate).dMMMy),
          _buildSummaryRow("End Date", DateTime.parse(endDate).dMMMy),
          _buildSummaryRow("Time", "$startTime - $endTime"),
          if (capacity.isNotEmpty) _buildSummaryRow("Expected Guests", capacity),
          if (venue.isNotEmpty) _buildSummaryRow("Venue", venue),
          _buildSummaryRow("Catering", cateringPreference),
          _buildSummaryRow("Organizer", organizerName),
          
          if (additionalServices > 0) ...[
            SizedBox(height: spSm),
            Text(
              "Additional Services:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            if (needsPhotography) Text("• Photography & Videography", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
            if (needsLiveStreaming) Text("• Live Streaming", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
            if (needsSecurityService) Text("• Security Service", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
            if (needsTransportation) Text("• Transportation", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
          ],
          
          Divider(height: spMd * 2),
          
          _buildSummaryRow("Base Package", "\$${basePrice.toStringAsFixed(0)}"),
          if (additionalServices > 0)
            _buildSummaryRow("Additional Services", "\$${additionalServices.toStringAsFixed(0)}"),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Text(
                "Estimated Total",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "\$${totalEstimate.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Text(
            "*Final pricing will be determined after consultation",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    bool canSubmit = eventType.isNotEmpty &&
                     eventName.isNotEmpty &&
                     organizerName.isNotEmpty &&
                     organizerEmail.isNotEmpty &&
                     organizerPhone.isNotEmpty &&
                     agreeToTerms;

    return Container(
      width: double.infinity,
      child: QButton(
        label: "Submit Event Planning Request",
        size: bs.md,
        onPressed: canSubmit ? () {
          _submitEventRequest();
        } : null,
      ),
    );
  }

  void _submitEventRequest() {
    if (!agreeToTerms) {
      se("Please agree to the terms and conditions");
      return;
    }
    
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: successColor),
              SizedBox(width: spSm),
              Text("Request Submitted"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your event planning request has been submitted successfully!"),
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("What happens next:", style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("• Our event planner will contact you within 24 hours"),
                    Text("• We'll schedule a consultation meeting"),
                    Text("• Detailed proposal and quote will be provided"),
                    Text("• Once approved, we'll start planning your event"),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "A confirmation email has been sent to $organizerEmail with your request details.",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                back();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    });
  }
}
