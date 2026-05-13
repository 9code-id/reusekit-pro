import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBooking7View extends StatefulWidget {
  @override
  State<GrlBooking7View> createState() => _GrlBooking7ViewState();
}

class _GrlBooking7ViewState extends State<GrlBooking7View> {
  String selectedEvent = "";
  String selectedDate = DateTime.now().toString();
  String selectedTime = "";
  String guestCount = "";
  String venue = "";
  String contactName = "";
  String contactPhone = "";
  String contactEmail = "";
  String eventNotes = "";
  List<String> selectedServices = [];

  List<Map<String, dynamic>> eventTypes = [
    {
      "name": "Wedding Reception",
      "icon": Icons.favorite,
      "price": 2500.0,
      "duration": "6 hours",
      "maxGuests": 200,
      "description": "Elegant wedding celebration with full service"
    },
    {
      "name": "Corporate Event",
      "icon": Icons.business_center,
      "price": 1800.0,
      "duration": "4 hours",
      "maxGuests": 150,
      "description": "Professional business meetings and conferences"
    },
    {
      "name": "Birthday Party",
      "icon": Icons.cake,
      "price": 800.0,
      "duration": "3 hours",
      "maxGuests": 50,
      "description": "Fun birthday celebration for all ages"
    },
    {
      "name": "Anniversary",
      "icon": Icons.celebration,
      "price": 1200.0,
      "duration": "4 hours",
      "maxGuests": 100,
      "description": "Romantic anniversary dinner and celebration"
    },
  ];

  List<Map<String, dynamic>> additionalServices = [
    {
      "name": "Photography",
      "price": 500.0,
      "description": "Professional event photography"
    },
    {
      "name": "Live Music",
      "price": 800.0,
      "description": "Live band or acoustic performance"
    },
    {
      "name": "Decoration",
      "price": 400.0,
      "description": "Themed decoration and setup"
    },
    {
      "name": "Catering Premium",
      "price": 1200.0,
      "description": "Premium catering with multiple courses"
    },
    {
      "name": "Video Recording",
      "price": 600.0,
      "description": "Professional video documentation"
    },
  ];

  List<String> timeSlots = [
    "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", 
    "15:00", "16:00", "17:00", "18:00", "19:00", "20:00"
  ];

  List<Map<String, dynamic>> guestOptions = [
    {"label": "10-25 guests", "value": "10-25"},
    {"label": "26-50 guests", "value": "26-50"},
    {"label": "51-100 guests", "value": "51-100"},
    {"label": "101-150 guests", "value": "101-150"},
    {"label": "150+ guests", "value": "150+"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Event"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildEventTypeSelection(),
            _buildEventDetails(),
            _buildAdditionalServices(),
            _buildContactInformation(),
            _buildBookingSummary(),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEventTypeSelection() {
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
              Icon(
                Icons.event,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Select Event Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: eventTypes.map((event) {
              final isSelected = selectedEvent == event["name"];
              return GestureDetector(
                onTap: () {
                  selectedEvent = event["name"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            event["icon"] as IconData,
                            color: isSelected ? primaryColor : disabledBoldColor,
                            size: 32,
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: primaryColor,
                              size: 20,
                            ),
                        ],
                      ),
                      Text(
                        "${event["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${event["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${event["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(event["price"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails() {
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
              Icon(
                Icons.calendar_today,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Event Details",
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
                child: QDatePicker(
                  label: "Event Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Start Time",
                  items: timeSlots.map((time) => {
                    "label": time,
                    "value": time,
                  }).toList(),
                  value: selectedTime,
                  onChanged: (value, label) {
                    selectedTime = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Expected Guests",
            items: guestOptions,
            value: guestCount,
            onChanged: (value, label) {
              guestCount = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Venue Location",
            value: venue,
            hint: "Enter venue address or location",
            onChanged: (value) {
              venue = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Event Notes",
            value: eventNotes,
            hint: "Special requirements, theme, or additional information",
            onChanged: (value) {
              eventNotes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalServices() {
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
              Icon(
                Icons.add_circle_outline,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Additional Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Select additional services to enhance your event",
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
                  selectedServices.add(service["name"]);
                }
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withAlpha(20) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: isSelected ? primaryColor : Colors.grey[400]!,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : null,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
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
                      "+\$${(service["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
              Icon(
                Icons.person,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Contact Name",
            value: contactName,
            hint: "Event organizer name",
            onChanged: (value) {
              contactName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: contactPhone,
            hint: "Primary contact number",
            onChanged: (value) {
              contactPhone = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: contactEmail,
            hint: "Email for confirmation",
            onChanged: (value) {
              contactEmail = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
    if (selectedEvent.isEmpty) return Container();
    
    final selectedEventData = eventTypes.firstWhere(
      (event) => event["name"] == selectedEvent,
    );
    
    double totalPrice = selectedEventData["price"] as double;
    
    for (String serviceName in selectedServices) {
      final service = additionalServices.firstWhere(
        (s) => s["name"] == serviceName,
      );
      totalPrice += service["price"] as double;
    }
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spXs),
              Text(
                "Booking Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          _buildSummaryRow("Event Type", selectedEvent),
          _buildSummaryRow("Date", DateTime.parse(selectedDate).dMMMy),
          _buildSummaryRow("Time", selectedTime),
          _buildSummaryRow("Guests", guestCount),
          if (venue.isNotEmpty)
            _buildSummaryRow("Venue", venue),
          if (selectedServices.isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "Additional Services:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            ...selectedServices.map((serviceName) {
              final service = additionalServices.firstWhere(
                (s) => s["name"] == serviceName,
              );
              return Padding(
                padding: EdgeInsets.only(left: spSm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "• $serviceName",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "+\$${(service["price"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
          Divider(color: primaryColor.withAlpha(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Book Event",
        size: bs.md,
        onPressed: () {
          ss("Event booked successfully!");
        },
      ),
    );
  }
}
