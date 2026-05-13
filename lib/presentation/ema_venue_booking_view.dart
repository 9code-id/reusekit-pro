import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaVenueBookingView extends StatefulWidget {
  const EmaVenueBookingView({super.key});

  @override
  State<EmaVenueBookingView> createState() => _EmaVenueBookingViewState();
}

class _EmaVenueBookingViewState extends State<EmaVenueBookingView> {
  final formKey = GlobalKey<FormState>();
  
  // Event Details
  String eventTitle = "";
  String eventDescription = "";
  String eventType = "";
  DateTime selectedDate = DateTime.now().add(Duration(days: 7));
  TimeOfDay startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 17, minute: 0);
  int expectedAttendees = 100;
  
  // Booking Options
  List<String> selectedServices = [];
  bool needsCatering = false;
  bool needsAV = false;
  bool needsDecorations = false;
  bool needsPhotography = false;
  
  // Contact Information
  String organizerName = "";
  String organizerEmail = "";
  String organizerPhone = "";
  String organizerCompany = "";
  
  // Special Requirements
  String specialRequests = "";
  bool acceptTerms = false;
  
  final venue = {
    "name": "Grand Convention Center",
    "address": "123 Downtown Plaza, City Center",
    "capacity": 1000,
    "pricePerHour": 500.0,
    "image": "https://picsum.photos/400/200?random=1&keyword=convention",
  };

  final eventTypes = [
    {"label": "Conference", "value": "conference"},
    {"label": "Wedding", "value": "wedding"},
    {"label": "Corporate Event", "value": "corporate"},
    {"label": "Seminar", "value": "seminar"},
    {"label": "Workshop", "value": "workshop"},
    {"label": "Exhibition", "value": "exhibition"},
    {"label": "Gala", "value": "gala"},
    {"label": "Other", "value": "other"},
  ];

  final additionalServices = [
    {
      "name": "Premium Catering Package",
      "description": "Full-service catering with multiple menu options",
      "price": 25.0,
      "unit": "per person",
      "category": "catering"
    },
    {
      "name": "Audio/Visual Equipment",
      "description": "Professional sound system, projectors, and lighting",
      "price": 200.0,
      "unit": "per day",
      "category": "av"
    },
    {
      "name": "Event Decoration",
      "description": "Custom decoration and floral arrangements",
      "price": 500.0,
      "unit": "per event",
      "category": "decoration"
    },
    {
      "name": "Professional Photography",
      "description": "Event photography with edited photos",
      "price": 300.0,
      "unit": "per event",
      "category": "photography"
    },
    {
      "name": "Security Service",
      "description": "Professional security personnel",
      "price": 50.0,
      "unit": "per hour",
      "category": "security"
    },
    {
      "name": "Valet Parking",
      "description": "Premium valet parking service",
      "price": 10.0,
      "unit": "per vehicle",
      "category": "parking"
    },
  ];

  int get totalHours {
    if (startTime.hour > endTime.hour || 
        (startTime.hour == endTime.hour && startTime.minute >= endTime.minute)) {
      return 24 - startTime.hour + endTime.hour;
    }
    return endTime.hour - startTime.hour;
  }

  double get venueTotal {
    return (venue["pricePerHour"] as double) * totalHours;
  }

  double get servicesTotal {
    double total = 0.0;
    for (String serviceId in selectedServices) {
      final service = additionalServices.firstWhere((s) => s["name"] == serviceId);
      double price = service["price"] as double;
      
      switch (service["unit"]) {
        case "per person":
          total += price * expectedAttendees;
          break;
        case "per day":
        case "per event":
          total += price;
          break;
        case "per hour":
          total += price * totalHours;
          break;
        case "per vehicle":
          total += price * (expectedAttendees * 0.7); // Estimate 70% will drive
          break;
      }
    }
    return total;
  }

  double get grandTotal {
    return venueTotal + servicesTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Venue"),
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
              _buildVenueHeader(),
              _buildEventDetails(),
              _buildDateTimeSelection(),
              _buildAdditionalServices(),
              _buildContactInformation(),
              _buildSpecialRequests(),
              _buildBookingSummary(),
              _buildTermsAndConditions(),
              _buildBookingButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVenueHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${venue["image"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${venue["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${venue["address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Capacity: ${venue["capacity"]} people",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${(venue["pricePerHour"] as double).toStringAsFixed(0)}/hour",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails() {
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
            "Event Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Event Title",
            value: eventTitle,
            hint: "Enter the name of your event",
            validator: Validator.required,
            onChanged: (value) {
              eventTitle = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Event Description",
            value: eventDescription,
            hint: "Briefly describe your event...",
            validator: Validator.required,
            onChanged: (value) {
              eventDescription = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Event Type",
                  items: eventTypes,
                  value: eventType,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    eventType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QNumberField(
                  label: "Expected Attendees",
                  value: expectedAttendees.toString(),
                  validator: Validator.required,
                  onChanged: (value) {
                    expectedAttendees = int.tryParse(value) ?? 100;
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

  Widget _buildDateTimeSelection() {
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
          if (totalHours > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(51)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Total Duration: $totalHours hours",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAdditionalServices() {
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
            "Additional Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Select any additional services you need for your event",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          ...additionalServices.map((service) {
            final isSelected = selectedServices.contains(service["name"]);
            
            return GestureDetector(
              onTap: () {
                if (isSelected) {
                  selectedServices.remove(service["name"]);
                } else {
                  selectedServices.add(service["name"] as String);
                }
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(26) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        if (value == true) {
                          selectedServices.add(service["name"] as String);
                        } else {
                          selectedServices.remove(service["name"]);
                        }
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${service["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${service["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${(service["price"] as double).toStringAsFixed(0)} ${service["unit"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
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
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Organizer Name",
            value: organizerName,
            hint: "Your full name",
            validator: Validator.required,
            onChanged: (value) {
              organizerName = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Email Address",
                  value: organizerEmail,
                  hint: "your.email@example.com",
                  validator: Validator.email,
                  onChanged: (value) {
                    organizerEmail = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QTextField(
                  label: "Phone Number",
                  value: organizerPhone,
                  hint: "+1 (555) 123-4567",
                  validator: Validator.required,
                  onChanged: (value) {
                    organizerPhone = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Company/Organization",
            value: organizerCompany,
            hint: "Your company or organization name (optional)",
            onChanged: (value) {
              organizerCompany = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialRequests() {
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
            "Special Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Additional Requirements",
            value: specialRequests,
            hint: "Any special requirements, accessibility needs, or custom arrangements...",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
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
            "Booking Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(13),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                _buildSummaryRow(
                  "Venue Rental ($totalHours hours)",
                  "\$${venueTotal.toStringAsFixed(2)}",
                ),
                if (selectedServices.isNotEmpty) ...[
                  Divider(color: disabledOutlineBorderColor),
                  ...selectedServices.map((serviceName) {
                    final service = additionalServices.firstWhere((s) => s["name"] == serviceName);
                    double price = service["price"] as double;
                    double total = 0.0;
                    
                    switch (service["unit"]) {
                      case "per person":
                        total = price * expectedAttendees;
                        break;
                      case "per day":
                      case "per event":
                        total = price;
                        break;
                      case "per hour":
                        total = price * totalHours;
                        break;
                      case "per vehicle":
                        total = price * (expectedAttendees * 0.7);
                        break;
                    }
                    
                    return _buildSummaryRow(
                      "${service["name"]}",
                      "\$${total.toStringAsFixed(2)}",
                    );
                  }).toList(),
                ],
                Divider(color: primaryColor),
                _buildSummaryRow(
                  "Total Amount",
                  "\$${grandTotal.toStringAsFixed(2)}",
                  isTotal: true,
                ),
                _buildSummaryRow(
                  "Deposit Required (50%)",
                  "\$${(grandTotal * 0.5).toStringAsFixed(2)}",
                  isHighlight: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false, bool isHighlight = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 13,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? warningColor : (isTotal ? primaryColor : disabledBoldColor),
            ),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 16 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isHighlight ? warningColor : (isTotal ? primaryColor : primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
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
            "Terms & Conditions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(13),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(51)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Important Booking Policies:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "• 50% deposit required to confirm booking\n"
                  "• Cancellation must be made 48 hours in advance\n"
                  "• Setup time included 2 hours before event\n"
                  "• Additional charges may apply for extended hours\n"
                  "• Event insurance is recommended for all bookings",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "I agree to the terms and conditions and cancellation policy",
                "value": true,
                "checked": acceptTerms,
              }
            ],
            value: [if (acceptTerms) {"label": "I agree to the terms and conditions and cancellation policy", "value": true, "checked": true}],
            onChanged: (values, ids) {
              acceptTerms = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Confirm Booking - Pay Deposit (\$${(grandTotal * 0.5).toStringAsFixed(2)})",
            size: bs.md,
            onPressed: acceptTerms ? _confirmBooking : null,
          ),
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: QButton(
                label: "Save as Draft",
                size: bs.md,
                onPressed: _saveAsDraft,
              ),
            ),
            Expanded(
              child: QButton(
                label: "Request Quote",
                size: bs.md,
                onPressed: _requestQuote,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _saveAsDraft() {
    ss("Booking saved as draft");
  }

  void _requestQuote() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Quote request sent successfully!");
    }
  }

  void _confirmBooking() async {
    if (formKey.currentState!.validate()) {
      if (!acceptTerms) {
        se("Please accept the terms and conditions");
        return;
      }
      
      showLoading();
      await Future.delayed(Duration(seconds: 3));
      hideLoading();
      
      ss("Booking confirmed! Payment link sent to your email.");
      back();
    }
  }
}
