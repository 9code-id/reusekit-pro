import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaCarSearchView extends StatefulWidget {
  const TtaCarSearchView({super.key});

  @override
  State<TtaCarSearchView> createState() => _TtaCarSearchViewState();
}

class _TtaCarSearchViewState extends State<TtaCarSearchView> {
  String pickupLocation = "";
  String dropoffLocation = "";
  DateTime pickupDate = DateTime.now().add(Duration(days: 1));
  DateTime dropoffDate = DateTime.now().add(Duration(days: 3));
  String pickupTime = "10:00";
  String dropoffTime = "18:00";
  String driverAge = "25-65";
  bool needInsurance = false;
  bool needGPS = false;
  bool needChildSeat = false;

  List<Map<String, dynamic>> locationSuggestions = [
    {
      "name": "Downtown Hotel",
      "address": "123 Main St, Downtown",
      "type": "Hotel",
      "distance": "0.5 miles",
    },
    {
      "name": "International Airport",
      "address": "Airport Terminal 1",
      "type": "Airport",
      "distance": "15 miles",
    },
    {
      "name": "Central Train Station",
      "address": "456 Railway Ave",
      "type": "Train Station",
      "distance": "2 miles",
    },
    {
      "name": "City Center Mall",
      "address": "789 Shopping Blvd",
      "type": "Shopping Center",
      "distance": "3 miles",
    },
    {
      "name": "Convention Center",
      "address": "321 Conference Way",
      "type": "Convention",
      "distance": "5 miles",
    },
  ];

  List<Map<String, dynamic>> timeOptions = [
    {"label": "8:00 AM", "value": "08:00"},
    {"label": "9:00 AM", "value": "09:00"},
    {"label": "10:00 AM", "value": "10:00"},
    {"label": "11:00 AM", "value": "11:00"},
    {"label": "12:00 PM", "value": "12:00"},
    {"label": "1:00 PM", "value": "13:00"},
    {"label": "2:00 PM", "value": "14:00"},
    {"label": "3:00 PM", "value": "15:00"},
    {"label": "4:00 PM", "value": "16:00"},
    {"label": "5:00 PM", "value": "17:00"},
    {"label": "6:00 PM", "value": "18:00"},
    {"label": "7:00 PM", "value": "19:00"},
    {"label": "8:00 PM", "value": "20:00"},
  ];

  List<Map<String, dynamic>> ageOptions = [
    {"label": "18-24 years", "value": "18-24"},
    {"label": "25-65 years", "value": "25-65"},
    {"label": "65+ years", "value": "65+"},
  ];

  List<Map<String, dynamic>> recentSearches = [
    {
      "pickup": "Downtown Hotel",
      "dropoff": "International Airport",
      "date": "Dec 20, 2024",
      "duration": "3 days",
    },
    {
      "pickup": "Airport Terminal",
      "dropoff": "Convention Center", 
      "date": "Dec 15, 2024",
      "duration": "5 days",
    },
    {
      "pickup": "Train Station",
      "dropoff": "City Center Mall",
      "date": "Dec 10, 2024",
      "duration": "2 days",
    },
  ];

  final formKey = GlobalKey<FormState>();

  int get rentalDays {
    return dropoffDate.difference(pickupDate).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Cars"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showRecentSearches();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.directions_car,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Find Your Perfect Car",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Choose from hundreds of vehicles",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (rentalDays > 0) ...[
                      SizedBox(height: spMd),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "$rentalDays day${rentalDays > 1 ? 's' : ''} rental",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Location Section
              Text(
                "Pickup & Drop-off Locations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QTextField(
                label: "Pickup Location",
                value: pickupLocation,
                validator: Validator.required,
                hint: "Enter pickup location",
                onChanged: (value) {
                  pickupLocation = value;
                  setState(() {});
                },
              ),

              QTextField(
                label: "Drop-off Location",
                value: dropoffLocation,
                validator: Validator.required,
                hint: "Enter drop-off location",
                onChanged: (value) {
                  dropoffLocation = value;
                  setState(() {});
                },
              ),

              // Quick Location Suggestions
              Text(
                "Popular Locations",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),

              QHorizontalScroll(
                children: locationSuggestions.map((location) {
                  return Container(
                    width: 180,
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                _getLocationIcon(location["type"] as String),
                                color: primaryColor,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${location["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${location["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${location["address"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: dangerColor,
                              size: 12,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${location["distance"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Date & Time Section
              Text(
                "Pickup Date & Time",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Pickup Date",
                      value: pickupDate,
                      onChanged: (value) {
                        pickupDate = value;
                        // Ensure dropoff is after pickup
                        if (dropoffDate.isBefore(pickupDate)) {
                          dropoffDate = pickupDate.add(Duration(days: 1));
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Pickup Time",
                      items: timeOptions,
                      value: pickupTime,
                      onChanged: (value, label) {
                        pickupTime = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              Text(
                "Drop-off Date & Time",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: QDatePicker(
                      label: "Drop-off Date",
                      value: dropoffDate,
                      onChanged: (value) {
                        dropoffDate = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Drop-off Time",
                      items: timeOptions,
                      value: dropoffTime,
                      onChanged: (value, label) {
                        dropoffTime = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Driver Information
              Text(
                "Driver Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              QDropdownField(
                label: "Driver Age",
                items: ageOptions,
                value: driverAge,
                onChanged: (value, label) {
                  driverAge = value;
                  setState(() {});
                },
              ),

              // Additional Options
              Text(
                "Additional Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Insurance",
                          "value": true,
                          "checked": needInsurance,
                        }
                      ],
                      value: [
                        if (needInsurance)
                          {
                            "label": "Insurance",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          needInsurance = values.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "GPS Navigation",
                          "value": true,
                          "checked": needGPS,
                        }
                      ],
                      value: [
                        if (needGPS)
                          {
                            "label": "GPS Navigation",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        setState(() {
                          needGPS = values.isNotEmpty;
                        });
                      },
                    ),
                  ),
                ],
              ),

              QSwitch(
                items: [
                  {
                    "label": "Child Safety Seat",
                    "value": true,
                    "checked": needChildSeat,
                  }
                ],
                value: [
                  if (needChildSeat)
                    {
                      "label": "Child Safety Seat",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  setState(() {
                    needChildSeat = values.isNotEmpty;
                  });
                },
              ),

              // Search Summary
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search Summary",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    if (pickupLocation.isNotEmpty || dropoffLocation.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(Icons.location_on, color: dangerColor, size: 16),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${pickupLocation.isNotEmpty ? pickupLocation : 'Pickup location'} → ${dropoffLocation.isNotEmpty ? dropoffLocation : 'Drop-off location'}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                    ],
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: infoColor, size: 16),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${pickupDate.dMMMy} at $pickupTime → ${dropoffDate.dMMMy} at $dropoffTime",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.schedule, color: warningColor, size: 16),
                        SizedBox(width: spSm),
                        Text(
                          "$rentalDays day${rentalDays > 1 ? 's' : ''} rental",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Search Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Search Available Cars",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Searching cars...");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getLocationIcon(String type) {
    switch (type) {
      case "Airport":
        return Icons.flight;
      case "Hotel":
        return Icons.hotel;
      case "Train Station":
        return Icons.train;
      case "Shopping Center":
        return Icons.shopping_cart;
      case "Convention":
        return Icons.business;
      default:
        return Icons.location_on;
    }
  }

  void _showRecentSearches() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Recent Searches",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              ...recentSearches.map((search) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.history, color: disabledBoldColor, size: 20),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${search["pickup"]} → ${search["dropoff"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${search["date"]} • ${search["duration"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pickupLocation = search["pickup"] as String;
                          dropoffLocation = search["dropoff"] as String;
                          setState(() {});
                          Navigator.pop(context);
                          ss("Search criteria applied");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.replay,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
