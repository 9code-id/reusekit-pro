import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaHotelBookingView extends StatefulWidget {
  const TtaHotelBookingView({super.key});

  @override
  State<TtaHotelBookingView> createState() => _TtaHotelBookingViewState();
}

class _TtaHotelBookingViewState extends State<TtaHotelBookingView> {
  final formKey = GlobalKey<FormState>();
  
  // Guest Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String country = "United States";
  
  // Payment Information
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  
  // Booking Preferences
  String arrivalTime = "2:00 PM - 4:00 PM";
  String specialRequests = "";
  bool smokingRoom = false;
  bool earlyCheckIn = false;
  bool lateCheckOut = false;
  bool airportTransfer = false;
  
  // Terms
  bool agreeTerms = false;
  bool subscribeNewsletter = false;

  final Map<String, dynamic> bookingDetails = {
    "hotel": "Grand Palace Hotel",
    "room": "Deluxe Room",
    "checkIn": "2024-07-15",
    "checkOut": "2024-07-17", 
    "nights": 2,
    "guests": 2,
    "roomPrice": 199,
    "totalRoomCost": 398,
    "taxes": 47.76,
    "serviceFee": 25.00,
    "totalAmount": 470.76
  };

  final List<Map<String, dynamic>> countryList = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
    {"label": "France", "value": "France"},
    {"label": "Japan", "value": "Japan"},
    {"label": "Singapore", "value": "Singapore"},
  ];

  final List<Map<String, dynamic>> arrivalTimeList = [
    {"label": "Before 12:00 PM", "value": "Before 12:00 PM"},
    {"label": "12:00 PM - 2:00 PM", "value": "12:00 PM - 2:00 PM"},
    {"label": "2:00 PM - 4:00 PM", "value": "2:00 PM - 4:00 PM"},
    {"label": "4:00 PM - 6:00 PM", "value": "4:00 PM - 6:00 PM"},
    {"label": "After 6:00 PM", "value": "After 6:00 PM"},
    {"label": "Not sure", "value": "Not sure"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Booking"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => back(),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookingSummary(),
              SizedBox(height: spMd),
              _buildGuestInformation(),
              SizedBox(height: spMd),
              _buildPaymentInformation(),
              SizedBox(height: spMd),
              _buildBookingPreferences(),
              SizedBox(height: spMd),
              _buildTermsAndConditions(),
              SizedBox(height: 100), // Space for bottom bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBookingBar(),
    );
  }

  Widget _buildBookingSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "https://picsum.photos/80/60?random=1&keyword=hotel",
                  width: 60,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${bookingDetails["hotel"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${bookingDetails["room"]}",
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
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: primaryColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Check-in: ${DateTime.parse(bookingDetails["checkIn"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: primaryColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Check-out: ${DateTime.parse(bookingDetails["checkOut"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.people, color: primaryColor, size: 16),
                    SizedBox(width: spSm),
                    Text(
                      "${bookingDetails["guests"]} guests • ${bookingDetails["nights"]} nights",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Price Breakdown
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${bookingDetails["roomPrice"]} x ${bookingDetails["nights"]} nights",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${bookingDetails["totalRoomCost"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Taxes & Fees",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${bookingDetails["taxes"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Service Fee",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "\$${bookingDetails["serviceFee"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              
              Divider(height: spMd * 2),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "\$${bookingDetails["totalAmount"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuestInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Guest Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "First Name",
                  value: firstName,
                  validator: Validator.required,
                  onChanged: (value) {
                    firstName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Last Name",
                  value: lastName,
                  validator: Validator.required,
                  onChanged: (value) {
                    lastName = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Email Address",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Phone Number",
            value: phone,
            validator: Validator.required,
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QDropdownField(
            label: "Country/Region",
            items: countryList,
            value: country,
            onChanged: (value, label) {
              country = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInformation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QTextField(
            label: "Card Number",
            value: cardNumber,
            validator: Validator.required,
            onChanged: (value) {
              cardNumber = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Expiry Date (MM/YY)",
                  value: expiryDate,
                  validator: Validator.required,
                  onChanged: (value) {
                    expiryDate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "CVV",
                  value: cvv,
                  validator: Validator.required,
                  onChanged: (value) {
                    cvv = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Cardholder Name",
            value: cardholderName,
            validator: Validator.required,
            onChanged: (value) {
              cardholderName = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.security, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Your payment information is encrypted and secure. We use industry-standard SSL encryption.",
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

  Widget _buildBookingPreferences() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          QDropdownField(
            label: "Expected Arrival Time",
            items: arrivalTimeList,
            value: arrivalTime,
            onChanged: (value, label) {
              arrivalTime = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          QMemoField(
            label: "Special Requests",
            value: specialRequests,
            hint: "Any special requests or preferences for your stay",
            onChanged: (value) {
              specialRequests = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          Text(
            "Additional Services",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            label: "Smoking Room",
            items: [
              {
                "label": "Request smoking room",
                "value": true,
                "checked": smokingRoom,
              }
            ],
            value: [if (smokingRoom) {"label": "Request smoking room", "value": true, "checked": true}],
            onChanged: (values, ids) {
              smokingRoom = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            label: "Early Check-in",
            items: [
              {
                "label": "Request early check-in (additional fee may apply)",
                "value": true,
                "checked": earlyCheckIn,
              }
            ],
            value: [if (earlyCheckIn) {"label": "Request early check-in (additional fee may apply)", "value": true, "checked": true}],
            onChanged: (values, ids) {
              earlyCheckIn = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            label: "Late Check-out",
            items: [
              {
                "label": "Request late check-out (additional fee may apply)",
                "value": true,
                "checked": lateCheckOut,
              }
            ],
            value: [if (lateCheckOut) {"label": "Request late check-out (additional fee may apply)", "value": true, "checked": true}],
            onChanged: (values, ids) {
              lateCheckOut = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            label: "Airport Transfer",
            items: [
              {
                "label": "Add airport transfer service (\$45)",
                "value": true,
                "checked": airportTransfer,
              }
            ],
            value: [if (airportTransfer) {"label": "Add airport transfer service (\$45)", "value": true, "checked": true}],
            onChanged: (values, ids) {
              airportTransfer = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
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
          
          SizedBox(height: spMd),
          
          QSwitch(
            label: "Terms Agreement",
            items: [
              {
                "label": "I agree to the Terms of Service and Privacy Policy",
                "value": true,
                "checked": agreeTerms,
              }
            ],
            value: [if (agreeTerms) {"label": "I agree to the Terms of Service and Privacy Policy", "value": true, "checked": true}],
            onChanged: (values, ids) {
              agreeTerms = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QSwitch(
            label: "Newsletter",
            items: [
              {
                "label": "Subscribe to newsletter for exclusive deals and updates",
                "value": true,
                "checked": subscribeNewsletter,
              }
            ],
            value: [if (subscribeNewsletter) {"label": "Subscribe to newsletter for exclusive deals and updates", "value": true, "checked": true}],
            onChanged: (values, ids) {
              subscribeNewsletter = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cancellation Policy",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Free cancellation until 24 hours before check-in. After that, the first night will be charged.",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowLg],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${bookingDetails["totalAmount"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Complete Booking",
              size: bs.md,
              onPressed: agreeTerms ? () async {
                if (formKey.currentState!.validate()) {
                  showLoading();
                  await Future.delayed(Duration(seconds: 2));
                  hideLoading();
                  
                  ss("Booking confirmed successfully!");
                  // Navigate to confirmation
                }
              } : null,
            ),
          ),
        ],
      ),
    );
  }
}
