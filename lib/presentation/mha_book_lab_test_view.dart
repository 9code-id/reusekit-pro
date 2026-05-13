import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaBookLabTestView extends StatefulWidget {
  const MhaBookLabTestView({super.key});

  @override
  State<MhaBookLabTestView> createState() => _MhaBookLabTestViewState();
}

class _MhaBookLabTestViewState extends State<MhaBookLabTestView> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  bool loading = false;
  
  // Test Information
  Map<String, dynamic> selectedTest = {
    "name": "Complete Blood Count (CBC)",
    "description": "Measures different blood cells and their counts",
    "price": 299,
    "duration": "4-6 hours",
    "preparation": "8-12 hours fasting required",
    "category": "Blood",
    "icon": Icons.bloodtype,
    "color": "red",
  };
  
  // Patient Information
  String patientName = "";
  String patientAge = "";
  String patientGender = "";
  String patientPhone = "";
  String patientEmail = "";
  
  // Booking Details
  String selectedDate = "";
  String selectedTime = "";
  String selectedAddress = "";
  String specialInstructions = "";
  
  // Payment
  String selectedPaymentMethod = "";
  bool agreedToTerms = false;
  
  List<Map<String, dynamic>> genderOptions = [
    {"label": "Male", "value": "Male"},
    {"label": "Female", "value": "Female"},
    {"label": "Other", "value": "Other"},
  ];
  
  List<Map<String, dynamic>> timeSlots = [
    {"label": "6:00 AM - 8:00 AM", "value": "06:00-08:00"},
    {"label": "8:00 AM - 10:00 AM", "value": "08:00-10:00"},
    {"label": "10:00 AM - 12:00 PM", "value": "10:00-12:00"},
    {"label": "12:00 PM - 2:00 PM", "value": "12:00-14:00"},
    {"label": "2:00 PM - 4:00 PM", "value": "14:00-16:00"},
    {"label": "4:00 PM - 6:00 PM", "value": "16:00-18:00"},
  ];
  
  List<Map<String, dynamic>> addresses = [
    {
      "label": "Home",
      "address": "123 Main Street, Apartment 4B, New York, NY 10001",
      "value": "home",
    },
    {
      "label": "Office",
      "address": "456 Business Ave, Suite 200, New York, NY 10002",
      "value": "office",
    },
  ];
  
  List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit/Debit Card", "value": "card", "icon": Icons.credit_card},
    {"label": "Digital Wallet", "value": "wallet", "icon": Icons.account_balance_wallet},
    {"label": "Net Banking", "value": "netbanking", "icon": Icons.account_balance},
    {"label": "Pay on Collection", "value": "cash", "icon": Icons.money},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Lab Test"),
        actions: [
          if (currentStep > 0)
            IconButton(
              onPressed: () {
                setState(() {
                  currentStep--;
                });
              },
              icon: Icon(Icons.arrow_back),
            ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  for (int i = 0; i < 4; i++) ...[
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: i <= currentStep ? primaryColor : disabledColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    if (i < 3) SizedBox(width: spXs),
                  ],
                ],
              ),
            ),
            
            // Step content
            Expanded(
              child: _buildStepContent(),
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
                        size: bs.sm,
                        onPressed: () {
                          setState(() {
                            currentStep--;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                  ],
                  Expanded(
                    flex: currentStep == 0 ? 1 : 1,
                    child: QButton(
                      label: currentStep == 3 ? "Confirm Booking" : "Next",
                      size: bs.sm,
                      onPressed: _handleNext,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildTestDetailsStep();
      case 1:
        return _buildPatientInfoStep();
      case 2:
        return _buildBookingDetailsStep();
      case 3:
        return _buildPaymentStep();
      default:
        return Container();
    }
  }

  Widget _buildTestDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Test Information",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Test card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(100)),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        selectedTest["icon"] as IconData,
                        color: dangerColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${selectedTest["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${selectedTest["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "₹${selectedTest["price"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Test details
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Result in: ${selectedTest["duration"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Preparation: ${selectedTest["preparation"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Test instructions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.medical_information,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Test Instructions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Fast for 8-12 hours before the test\n"
                  "• Drink water normally unless instructed otherwise\n"
                  "• Inform the technician about any medications\n"
                  "• Wear loose clothing for easy sample collection",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Home collection info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Home Collection Available",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Our trained phlebotomist will visit your location for sample collection. No additional charges for home collection within city limits.",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfoStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Patient Information",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Please provide patient details for the lab test",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Patient form
          QTextField(
            label: "Full Name",
            value: patientName,
            validator: Validator.required,
            onChanged: (value) {
              patientName = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Age",
                  value: patientAge,
                  validator: Validator.required,
                  onChanged: (value) {
                    patientAge = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Gender",
                  items: genderOptions,
                  value: patientGender,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    patientGender = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Phone Number",
            value: patientPhone,
            validator: Validator.required,
            onChanged: (value) {
              patientPhone = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Email Address",
            value: patientEmail,
            validator: Validator.email,
            onChanged: (value) {
              patientEmail = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Insurance information
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: warningColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Insurance & Discounts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Health insurance accepted (check coverage)\n"
                  "• Senior citizen discount: 10%\n"
                  "• Student discount: 15% with valid ID\n"
                  "• Group booking discount available",
                  style: TextStyle(
                    fontSize: 14,
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

  Widget _buildBookingDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Details",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Select preferred date, time and collection address",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Date selection
          QDatePicker(
            label: "Preferred Date",
            value: selectedDate.isNotEmpty ? DateTime.parse(selectedDate) : DateTime.now().add(Duration(days: 1)),
            validator: Validator.required,
            onChanged: (value) {
              selectedDate = value.toString().split(' ')[0];
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          // Time slot selection
          QDropdownField(
            label: "Preferred Time Slot",
            items: timeSlots,
            value: selectedTime,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedTime = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          // Address selection
          QDropdownField(
            label: "Collection Address",
            items: addresses,
            value: selectedAddress,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedAddress = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          // Special instructions
          QMemoField(
            label: "Special Instructions (Optional)",
            value: specialInstructions,
            hint: "Any specific instructions for the collection team...",
            onChanged: (value) {
              specialInstructions = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spMd),
          
          // Collection info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Collection Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "• Collection team will arrive within the selected time slot\n"
                  "• Please be available 15 minutes before scheduled time\n"
                  "• Collection process takes 5-10 minutes\n"
                  "• You will receive SMS updates about arrival",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
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
            "Review your booking and select payment method",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Booking summary
          Container(
            width: double.infinity,
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
                
                _buildSummaryRow("Test", "${selectedTest["name"]}"),
                _buildSummaryRow("Patient", patientName),
                _buildSummaryRow("Date", selectedDate),
                _buildSummaryRow("Time", selectedTime),
                _buildSummaryRow("Collection", "Home Collection"),
                
                SizedBox(height: spSm),
                Divider(),
                
                Row(
                  children: [
                    Text(
                      "Total Amount:",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "₹${selectedTest["price"]}",
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
          
          SizedBox(height: spMd),
          
          // Payment methods
          Text(
            "Payment Method",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          Column(
            children: paymentMethods.map((method) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = method["value"];
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: selectedPaymentMethod == method["value"] 
                        ? primaryColor.withAlpha(30)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: selectedPaymentMethod == method["value"] 
                          ? primaryColor
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        method["icon"] as IconData,
                        color: selectedPaymentMethod == method["value"] 
                            ? primaryColor
                            : disabledBoldColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${method["label"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: selectedPaymentMethod == method["value"] 
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: selectedPaymentMethod == method["value"] 
                                ? primaryColor
                                : disabledBoldColor,
                          ),
                        ),
                      ),
                      if (selectedPaymentMethod == method["value"])
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Terms and conditions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    agreedToTerms = !agreedToTerms;
                  });
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: agreedToTerms ? primaryColor : Colors.white,
                    border: Border.all(
                      color: agreedToTerms ? primaryColor : disabledOutlineBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: agreedToTerms 
                      ? Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "I agree to the Terms & Conditions and Privacy Policy. I understand the test preparation requirements and collection process.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Spacer(),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
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

  void _handleNext() async {
    if (currentStep < 3) {
      if (_validateCurrentStep()) {
        setState(() {
          currentStep++;
        });
      }
    } else {
      // Final booking confirmation
      if (!agreedToTerms) {
        se("Please agree to terms and conditions");
        return;
      }
      
      if (selectedPaymentMethod.isEmpty) {
        se("Please select a payment method");
        return;
      }
      
      await _confirmBooking();
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 1:
        return patientName.isNotEmpty && 
               patientAge.isNotEmpty && 
               patientGender.isNotEmpty && 
               patientPhone.isNotEmpty && 
               patientEmail.isNotEmpty;
      case 2:
        return selectedDate.isNotEmpty && 
               selectedTime.isNotEmpty && 
               selectedAddress.isNotEmpty;
      default:
        return true;
    }
  }

  Future<void> _confirmBooking() async {
    loading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate booking process
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    hideLoading();
    
    // Show success message and navigate back
    ss("Lab test booked successfully!");
    await Future.delayed(Duration(milliseconds: 500));
    
    // Navigate to confirmation page
    //navigateTo('MhaOrderConfirmationView');
    back();
  }
}
