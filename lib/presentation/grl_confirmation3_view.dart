import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlConfirmation3View extends StatefulWidget {
  @override
  State<GrlConfirmation3View> createState() => _GrlConfirmation3ViewState();
}

class _GrlConfirmation3ViewState extends State<GrlConfirmation3View> {
  String selectedReservation = "";
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  String specialRequests = "";
  String preferredTime = "";
  bool emailConfirmation = true;
  bool smsConfirmation = false;
  bool termsAccepted = false;
  bool loading = false;

  List<Map<String, dynamic>> reservationOptions = [
    {
      "label": "Dinner for 2 - Table by Window",
      "value": "dinner_table_window",
    },
    {
      "label": "Business Lunch - Private Room",
      "value": "business_lunch_private",
    },
    {
      "label": "Birthday Celebration - Main Hall",
      "value": "birthday_main_hall",
    },
    {
      "label": "Anniversary Dinner - Rooftop Terrace",
      "value": "anniversary_rooftop",
    },
  ];

  List<Map<String, dynamic>> timeSlots = [
    {
      "label": "12:00 PM - 1:00 PM",
      "value": "12:00-13:00",
    },
    {
      "label": "1:00 PM - 2:00 PM",
      "value": "13:00-14:00",
    },
    {
      "label": "6:00 PM - 7:00 PM",
      "value": "18:00-19:00",
    },
    {
      "label": "7:00 PM - 8:00 PM",
      "value": "19:00-20:00",
    },
    {
      "label": "8:00 PM - 9:00 PM",
      "value": "20:00-21:00",
    },
  ];

  Map<String, dynamic> restaurantInfo = {
    "name": "La Belle Cuisine",
    "address": "123 Gourmet Street, Culinary District",
    "phone": "+1 (555) 123-4567",
    "email": "reservations@labelleicuisine.com",
    "image": "https://picsum.photos/400/200?random=1&keyword=restaurant",
    "rating": 4.8,
    "priceRange": "\$\$\$",
    "cuisine": "French Fine Dining",
  };

  List<Map<String, dynamic>> reservationDetails = [
    {
      "icon": Icons.event,
      "label": "Date",
      "value": "March 25, 2024",
    },
    {
      "icon": Icons.schedule,
      "label": "Time",
      "value": "7:00 PM",
    },
    {
      "icon": Icons.people,
      "label": "Party Size",
      "value": "2 Guests",
    },
    {
      "icon": Icons.table_restaurant,
      "label": "Table Type",
      "value": "Window Seating",
    },
  ];

  List<Map<String, dynamic>> confirmationSteps = [
    {
      "title": "Select Reservation",
      "description": "Choose your preferred dining option",
      "completed": false,
    },
    {
      "title": "Guest Information",
      "description": "Provide contact details",
      "completed": false,
    },
    {
      "title": "Special Requests",
      "description": "Add any special requirements",
      "completed": false,
    },
    {
      "title": "Confirmation",
      "description": "Review and confirm booking",
      "completed": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Reservation"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Help information displayed");
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildRestaurantHeader(),
                  _buildReservationSummary(),
                  _buildConfirmationForm(),
                  _buildSpecialRequests(),
                  _buildNotificationPreferences(),
                  _buildTermsAndConditions(),
                  _buildConfirmationButton(),
                ],
              ),
            ),
    );
  }

  Widget _buildRestaurantHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
            child: Image.network(
              "${restaurantInfo["image"]}",
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${restaurantInfo["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${restaurantInfo["cuisine"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${restaurantInfo["rating"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${restaurantInfo["address"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "${restaurantInfo["priceRange"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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

  Widget _buildReservationSummary() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Reservation Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: reservationDetails.map((detail) {
              return Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      detail["icon"],
                      size: 20,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${detail["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${detail["value"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationForm() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Guest Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Reservation Type",
                items: reservationOptions,
                value: selectedReservation,
                onChanged: (value, label) {
                  selectedReservation = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Full Name",
                value: customerName,
                validator: Validator.required,
                onChanged: (value) {
                  customerName = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Email Address",
                value: customerEmail,
                validator: Validator.email,
                onChanged: (value) {
                  customerEmail = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Phone Number",
                value: customerPhone,
                validator: Validator.required,
                onChanged: (value) {
                  customerPhone = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Preferred Time Slot",
                items: timeSlots,
                value: preferredTime,
                onChanged: (value, label) {
                  preferredTime = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialRequests() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
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
            label: "Special Requirements",
            value: specialRequests,
            hint: "Any dietary restrictions, allergies, celebration details, seating preferences...",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: infoColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: infoColor,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "We'll do our best to accommodate your special requests. Please note that some requests may be subject to availability.",
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
      ),
    );
  }

  Widget _buildNotificationPreferences() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Notification Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              QSwitch(
                items: [
                  {
                    "label": "Email Confirmation",
                    "value": true,
                    "checked": emailConfirmation,
                  }
                ],
                value: [
                  if (emailConfirmation)
                    {
                      "label": "Email Confirmation",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  emailConfirmation = values.isNotEmpty;
                  setState(() {});
                },
              ),
              QSwitch(
                items: [
                  {
                    "label": "SMS Reminders",
                    "value": true,
                    "checked": smsConfirmation,
                  }
                ],
                value: [
                  if (smsConfirmation)
                    {
                      "label": "SMS Reminders",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  smsConfirmation = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
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
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: warningColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Cancellation Policy:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
                Text(
                  "• Free cancellation up to 24 hours before reservation\n• Late cancellation may incur charges\n• No-show reservations will be charged 50% of estimated total",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "I accept the terms and conditions",
                "value": true,
                "checked": termsAccepted,
              }
            ],
            value: [
              if (termsAccepted)
                {
                  "label": "I accept the terms and conditions",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              termsAccepted = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationButton() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Confirm Reservation",
            size: bs.md,
            onPressed: _canConfirm() ? _confirmReservation : null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security,
              size: 16,
              color: successColor,
            ),
            SizedBox(width: spXs),
            Text(
              "Secure booking protected by SSL encryption",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool _canConfirm() {
    return selectedReservation.isNotEmpty &&
        customerName.isNotEmpty &&
        customerEmail.isNotEmpty &&
        customerPhone.isNotEmpty &&
        preferredTime.isNotEmpty &&
        termsAccepted;
  }

  Future<void> _confirmReservation() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Restaurant reservation confirmed successfully!");

    // Navigate to confirmation details
    si("Confirmation details sent to ${customerEmail}");
  }
}
