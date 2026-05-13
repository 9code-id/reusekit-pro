import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaFlightBookingView extends StatefulWidget {
  const TtaFlightBookingView({super.key});

  @override
  State<TtaFlightBookingView> createState() => _TtaFlightBookingViewState();
}

class _TtaFlightBookingViewState extends State<TtaFlightBookingView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;

  // Passenger Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String dateOfBirth = "1990-01-01";
  String nationality = "United States";
  String passportNumber = "";
  String passportExpiry = "2030-01-01";
  String gender = "male";

  // Flight Details
  Map<String, dynamic> flightDetails = {
    "airline": "Emirates",
    "flightNumber": "EK 201",
    "route": "New York → Paris",
    "departureTime": "08:30",
    "arrivalTime": "14:45",
    "date": "June 25, 2024",
    "duration": "7h 15m",
    "class": "Economy",
    "price": 542.00,
  };

  // Contact Information
  String contactEmail = "";
  String contactPhone = "";
  bool receiveUpdates = true;

  // Additional Services
  bool extraBaggage = false;
  bool seatSelection = false;
  bool mealPreference = false;
  bool travelInsurance = false;
  String selectedMeal = "vegetarian";

  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "male"},
    {"label": "Female", "value": "female"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> nationalityOptions = [
    {"label": "United States", "value": "US"},
    {"label": "United Kingdom", "value": "UK"},
    {"label": "Canada", "value": "CA"},
    {"label": "Australia", "value": "AU"},
    {"label": "Germany", "value": "DE"},
  ];

  List<Map<String, dynamic>> mealOptions = [
    {"label": "Vegetarian", "value": "vegetarian"},
    {"label": "Halal", "value": "halal"},
    {"label": "Kosher", "value": "kosher"},
    {"label": "Gluten Free", "value": "gluten_free"},
    {"label": "Hindu", "value": "hindu"},
  ];

  List<Map<String, dynamic>> bookingSteps = [
    {"title": "Passenger Info", "icon": Icons.person},
    {"title": "Contact Details", "icon": Icons.contact_phone},
    {"title": "Add-ons", "icon": Icons.add_circle},
    {"title": "Payment", "icon": Icons.payment},
  ];

  double get totalPrice {
    double total = flightDetails["price"] as double;
    if (extraBaggage) total += 75.00;
    if (seatSelection) total += 35.00;
    if (mealPreference) total += 25.00;
    if (travelInsurance) total += 45.00;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Flight"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // navigateTo(TtaBookingHelpView())
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Flight Summary Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              border: Border(
                bottom: BorderSide(color: primaryColor.withAlpha(30)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${flightDetails["airline"]} ${flightDetails["flightNumber"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${flightDetails["route"]} • ${flightDetails["date"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${totalPrice.currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${flightDetails["class"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: bookingSteps.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> step = entry.value;
                bool isActive = index <= currentStep;
                bool isCurrent = index == currentStep;

                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (index > 0)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: index <= currentStep
                                    ? primaryColor
                                    : disabledColor,
                              ),
                            ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isActive ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              step["icon"],
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          if (index < bookingSteps.length - 1)
                            Expanded(
                              child: Container(
                                height: 2,
                                color: index < currentStep
                                    ? primaryColor
                                    : disabledColor,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${step["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: isCurrent ? primaryColor : disabledBoldColor,
                          fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Step Content
          Expanded(
            child: Form(
              key: formKey,
              child: IndexedStack(
                index: currentStep,
                children: [
                  // Step 1: Passenger Information
                  SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Text(
                          "Passenger Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
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
                              Row(
                                children: [
                                  Expanded(
                                    child: QDatePicker(
                                      label: "Date of Birth",
                                      value: DateTime.parse(dateOfBirth),
                                      onChanged: (value) {
                                        dateOfBirth = value.toString().split(' ')[0];
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QDropdownField(
                                      label: "Gender",
                                      items: genderOptions,
                                      value: gender,
                                      onChanged: (value, label) {
                                        gender = value;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              QDropdownField(
                                label: "Nationality",
                                items: nationalityOptions,
                                value: nationality,
                                onChanged: (value, label) {
                                  nationality = value;
                                  setState(() {});
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: QTextField(
                                      label: "Passport Number",
                                      value: passportNumber,
                                      validator: Validator.required,
                                      onChanged: (value) {
                                        passportNumber = value;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QDatePicker(
                                      label: "Passport Expiry",
                                      value: DateTime.parse(passportExpiry),
                                      onChanged: (value) {
                                        passportExpiry = value.toString().split(' ')[0];
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(color: infoColor.withAlpha(30)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: infoColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "Ensure passenger name matches exactly with passport/ID",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: infoColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Step 2: Contact Details
                  SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Text(
                          "Contact Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              QTextField(
                                label: "Email Address",
                                value: contactEmail,
                                validator: Validator.email,
                                onChanged: (value) {
                                  contactEmail = value;
                                  setState(() {});
                                },
                              ),
                              QTextField(
                                label: "Phone Number",
                                value: contactPhone,
                                validator: Validator.required,
                                onChanged: (value) {
                                  contactPhone = value;
                                  setState(() {});
                                },
                              ),
                              QSwitch(
                                items: [
                                  {
                                    "label": "Receive booking updates via email/SMS",
                                    "value": true,
                                    "checked": receiveUpdates,
                                  }
                                ],
                                value: [
                                  if (receiveUpdates)
                                    {
                                      "label": "Receive booking updates via email/SMS",
                                      "value": true,
                                      "checked": true
                                    }
                                ],
                                onChanged: (values, ids) {
                                  receiveUpdates = values.isNotEmpty;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Step 3: Add-ons
                  SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Text(
                          "Additional Services",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spMd,
                            children: [
                              _buildAddonItem(
                                "Extra Baggage (+23kg)",
                                "\$75.00",
                                Icons.luggage,
                                extraBaggage,
                                (value) {
                                  extraBaggage = value;
                                  setState(() {});
                                },
                              ),
                              _buildAddonItem(
                                "Seat Selection",
                                "\$35.00",
                                Icons.airline_seat_recline_normal,
                                seatSelection,
                                (value) {
                                  seatSelection = value;
                                  setState(() {});
                                },
                              ),
                              _buildAddonItem(
                                "Special Meal",
                                "\$25.00",
                                Icons.restaurant,
                                mealPreference,
                                (value) {
                                  mealPreference = value;
                                  setState(() {});
                                },
                              ),
                              if (mealPreference) ...[
                                QDropdownField(
                                  label: "Meal Preference",
                                  items: mealOptions,
                                  value: selectedMeal,
                                  onChanged: (value, label) {
                                    selectedMeal = value;
                                    setState(() {});
                                  },
                                ),
                              ],
                              _buildAddonItem(
                                "Travel Insurance",
                                "\$45.00",
                                Icons.security,
                                travelInsurance,
                                (value) {
                                  travelInsurance = value;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Step 4: Payment
                  SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        Text(
                          "Payment Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowMd],
                          ),
                          child: Column(
                            spacing: spSm,
                            children: [
                              _buildPriceRow("Base Fare", flightDetails["price"] as double),
                              if (extraBaggage) _buildPriceRow("Extra Baggage", 75.00),
                              if (seatSelection) _buildPriceRow("Seat Selection", 35.00),
                              if (mealPreference) _buildPriceRow("Special Meal", 25.00),
                              if (travelInsurance) _buildPriceRow("Travel Insurance", 45.00),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${totalPrice.currency}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Proceed to Payment",
                            size: bs.md,
                            onPressed: () {
                              // navigateTo(TtaPaymentView())
                            },
                          ),
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            if (currentStep > 0)
              Expanded(
                child: QButton(
                  label: "Previous",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () {
                    if (currentStep > 0) {
                      currentStep--;
                      setState(() {});
                    }
                  },
                ),
              ),
            if (currentStep > 0) SizedBox(width: spMd),
            Expanded(
              child: QButton(
                label: currentStep < 3 ? "Next" : "Complete Booking",
                size: bs.md,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (currentStep < 3) {
                      currentStep++;
                      setState(() {});
                    } else {
                      // Complete booking
                      ss("Booking completed successfully!");
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddonItem(
    String title,
    String price,
    IconData icon,
    bool selected,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: selected ? primaryColor.withAlpha(10) : Colors.transparent,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: selected ? primaryColor.withAlpha(30) : disabledColor.withAlpha(30),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: selected ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: selected ? primaryColor : disabledBoldColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: selected ? primaryColor : disabledBoldColor,
              ),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: selected ? primaryColor : disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => onChanged(!selected),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: selected ? primaryColor : disabledBoldColor,
                  width: 2,
                ),
              ),
              child: selected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "\$${amount.currency}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
