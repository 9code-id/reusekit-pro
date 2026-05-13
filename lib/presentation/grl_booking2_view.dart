import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBooking2View extends StatefulWidget {
  @override
  State<GrlBooking2View> createState() => _GrlBooking2ViewState();
}

class _GrlBooking2ViewState extends State<GrlBooking2View> {
  int currentStep = 0;
  
  // Step 1: Service Selection
  String selectedCategory = "";
  List<String> selectedServices = [];
  
  // Step 2: Date & Time
  String selectedDate = DateTime.now().toIso8601String().substring(0, 10);
  String selectedTime = "";
  
  // Step 3: Personal Details
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  String additionalNotes = "";
  
  // Step 4: Payment Details
  String paymentMethod = "card";
  bool agreeToTerms = false;

  List<Map<String, dynamic>> serviceCategories = [
    {
      "name": "Beauty & Spa",
      "value": "beauty",
      "icon": Icons.spa,
      "services": [
        {"name": "Facial Treatment", "price": 85.0, "duration": 60},
        {"name": "Deep Cleansing", "price": 95.0, "duration": 75},
        {"name": "Anti-Aging Treatment", "price": 120.0, "duration": 90},
        {"name": "Hydrating Mask", "price": 70.0, "duration": 45},
      ]
    },
    {
      "name": "Hair Services",
      "value": "hair",
      "icon": Icons.content_cut,
      "services": [
        {"name": "Haircut & Styling", "price": 45.0, "duration": 60},
        {"name": "Hair Coloring", "price": 150.0, "duration": 180},
        {"name": "Hair Treatment", "price": 80.0, "duration": 90},
        {"name": "Hair Extensions", "price": 200.0, "duration": 120},
      ]
    },
    {
      "name": "Nail Care",
      "value": "nails",
      "icon": Icons.back_hand,
      "services": [
        {"name": "Manicure", "price": 35.0, "duration": 45},
        {"name": "Pedicure", "price": 40.0, "duration": 60},
        {"name": "Gel Polish", "price": 25.0, "duration": 30},
        {"name": "Nail Art", "price": 50.0, "duration": 75},
      ]
    },
    {
      "name": "Massage Therapy",
      "value": "massage",
      "icon": Icons.self_improvement,
      "services": [
        {"name": "Swedish Massage", "price": 90.0, "duration": 60},
        {"name": "Deep Tissue Massage", "price": 110.0, "duration": 90},
        {"name": "Hot Stone Massage", "price": 130.0, "duration": 75},
        {"name": "Aromatherapy", "price": 100.0, "duration": 60},
      ]
    },
  ];

  List<String> availableTimeSlots = [
    "09:00", "09:30", "10:00", "10:30", "11:00", "11:30",
    "14:00", "14:30", "15:00", "15:30", "16:00", "16:30",
    "17:00", "17:30", "18:00", "18:30"
  ];

  double get totalPrice {
    double total = 0.0;
    for (String service in selectedServices) {
      for (var category in serviceCategories) {
        for (var categoryService in category["services"]) {
          if (categoryService["name"] == service) {
            total += (categoryService["price"] as double);
            break;
          }
        }
      }
    }
    return total;
  }

  int get totalDuration {
    int duration = 0;
    for (String service in selectedServices) {
      for (var category in serviceCategories) {
        for (var categoryService in category["services"]) {
          if (categoryService["name"] == service) {
            duration += (categoryService["duration"] as int);
            break;
          }
        }
      }
    }
    return duration;
  }

  bool get canProceedToNext {
    switch (currentStep) {
      case 0:
        return selectedServices.isNotEmpty;
      case 1:
        return selectedDate.isNotEmpty && selectedTime.isNotEmpty;
      case 2:
        return customerName.isNotEmpty && customerEmail.isNotEmpty && customerPhone.isNotEmpty;
      case 3:
        return paymentMethod.isNotEmpty && agreeToTerms;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (canProceedToNext && currentStep < 3) {
      currentStep++;
      setState(() {});
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  Future<void> _completeBooking() async {
    if (!canProceedToNext) {
      se("Please complete all required fields");
      return;
    }

    showLoading();
    
    // Simulate booking process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    ss("Booking confirmed successfully!");
    
    // Reset all data
    currentStep = 0;
    selectedCategory = "";
    selectedServices = [];
    selectedDate = DateTime.now().toIso8601String().substring(0, 10);
    selectedTime = "";
    customerName = "";
    customerEmail = "";
    customerPhone = "";
    additionalNotes = "";
    paymentMethod = "card";
    agreeToTerms = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Step ${currentStep + 1} of 4",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: List.generate(4, (index) {
                bool isActive = index <= currentStep;
                bool isCurrent = index == currentStep;
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isActive ? primaryColor : disabledColor,
                          shape: BoxShape.circle,
                          border: isCurrent ? Border.all(color: primaryColor, width: 2) : null,
                        ),
                        child: Center(
                          child: isActive
                              ? Icon(Icons.check, color: Colors.white, size: 16)
                              : Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                        ),
                      ),
                      if (index < 3)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: index < currentStep ? primaryColor : disabledColor,
                            margin: EdgeInsets.symmetric(horizontal: spXs),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
          
          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildStepContent(),
            ),
          ),
          
          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      size: bs.md,
                      onPressed: _previousStep,
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spSm),
                Expanded(
                  flex: currentStep == 0 ? 1 : 2,
                  child: QButton(
                    label: currentStep == 3 ? "Complete Booking" : "Next",
                    size: bs.md,
                    onPressed: currentStep == 3 ? _completeBooking : _nextStep,
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
        return _buildServiceSelection();
      case 1:
        return _buildDateTimeSelection();
      case 2:
        return _buildPersonalDetails();
      case 3:
        return _buildPaymentConfirmation();
      default:
        return Container();
    }
  }

  Widget _buildServiceSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Services",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Choose from our professional services. You can select multiple services.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Service Categories
        Column(
          children: serviceCategories.map((category) {
            bool isCategorySelected = selectedCategory == category["value"];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Category Header
                  GestureDetector(
                    onTap: () {
                      selectedCategory = isCategorySelected ? "" : category["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCategorySelected ? primaryColor.withAlpha(10) : null,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            category["icon"],
                            color: isCategorySelected ? primaryColor : disabledBoldColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isCategorySelected ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                          Icon(
                            isCategorySelected ? Icons.expand_less : Icons.expand_more,
                            color: isCategorySelected ? primaryColor : disabledBoldColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Category Services
                  if (isCategorySelected) ...[
                    Divider(height: 1),
                    Column(
                      children: (category["services"] as List).map<Widget>((service) {
                        bool isSelected = selectedServices.contains(service["name"]);
                        return Container(
                          decoration: BoxDecoration(
                            color: isSelected ? successColor.withAlpha(10) : null,
                          ),
                          child: CheckboxListTile(
                            activeColor: successColor,
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${service["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? successColor : disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${(service["price"] as double).toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? successColor : primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              "${service["duration"]} minutes",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            value: isSelected,
                            onChanged: (value) {
                              if (value == true) {
                                selectedServices.add(service["name"]);
                              } else {
                                selectedServices.remove(service["name"]);
                              }
                              setState(() {});
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
        ),
        
        // Selected Services Summary
        if (selectedServices.isNotEmpty) ...[
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor),
                    SizedBox(width: spSm),
                    Text(
                      "Selected Services (${selectedServices.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...selectedServices.map((serviceName) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Text(
                      "• $serviceName",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  );
                }),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Total Duration: ${totalDuration} min",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Total: \$${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDateTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Date & Time",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Choose your preferred appointment date and time slot.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Date Selection
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Date",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QDatePicker(
                label: "Appointment Date",
                value: DateTime.parse(selectedDate),
                onChanged: (value) {
                  selectedDate = value.toIso8601String().substring(0, 10);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Time Selection
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Time Slot",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Duration: ${totalDuration} minutes",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spSm,
                runSpacing: spSm,
                children: availableTimeSlots.map((time) {
                  bool isSelected = selectedTime == time;
                  return GestureDetector(
                    onTap: () {
                      selectedTime = time;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        
        // Appointment Summary
        if (selectedDate.isNotEmpty && selectedTime.isNotEmpty) ...[
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Appointment Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Date: ${DateTime.parse(selectedDate).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Time: $selectedTime (${totalDuration} min)",
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
          ),
        ],
      ],
    );
  }

  Widget _buildPersonalDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Details",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Please provide your contact information for the appointment.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              QTextField(
                label: "Full Name",
                value: customerName,
                validator: Validator.required,
                onChanged: (value) {
                  customerName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Email Address",
                value: customerEmail,
                validator: Validator.email,
                onChanged: (value) {
                  customerEmail = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Phone Number",
                value: customerPhone,
                validator: Validator.required,
                onChanged: (value) {
                  customerPhone = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              QMemoField(
                label: "Additional Notes (Optional)",
                value: additionalNotes,
                hint: "Any special requirements or preferences...",
                onChanged: (value) {
                  additionalNotes = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentConfirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment & Confirmation",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Review your booking details and complete the payment.",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spMd),
        
        // Booking Summary
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
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
              ...selectedServices.map((service) {
                return Padding(
                  padding: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          service,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${_getServicePrice(service).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Divider(),
              Row(
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Payment Method
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QCategoryPicker(
                items: [
                  {"label": "Credit/Debit Card", "value": "card"},
                  {"label": "PayPal", "value": "paypal"},
                  {"label": "Cash (Pay at venue)", "value": "cash"},
                ],
                value: paymentMethod,
                onChanged: (index, label, value, item) {
                  paymentMethod = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Terms and Conditions
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: QSwitch(
            items: [
              {
                "label": "I agree to the terms and conditions and cancellation policy",
                "value": true,
                "checked": agreeToTerms,
              }
            ],
            value: [if (agreeToTerms) {"label": "I agree to the terms and conditions and cancellation policy", "value": true, "checked": true}],
            onChanged: (values, ids) {
              agreeToTerms = values.isNotEmpty;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  double _getServicePrice(String serviceName) {
    for (var category in serviceCategories) {
      for (var service in category["services"]) {
        if (service["name"] == serviceName) {
          return (service["price"] as double);
        }
      }
    }
    return 0.0;
  }
}
