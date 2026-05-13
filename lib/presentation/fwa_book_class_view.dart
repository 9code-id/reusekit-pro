import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBookClassView extends StatefulWidget {
  const FwaBookClassView({super.key});

  @override
  State<FwaBookClassView> createState() => _FwaBookClassViewState();
}

class _FwaBookClassViewState extends State<FwaBookClassView> {
  int currentStep = 0;
  
  // Class details (simulating passed data)
  Map<String, dynamic> selectedClass = {
    "id": 1,
    "name": "Morning Yoga Flow",
    "instructor": "Sarah Johnson",
    "date": "2024-06-20",
    "time": "07:00",
    "duration": 60,
    "category": "Yoga",
    "level": "Beginner",
    "price": 25.00,
    "spots": 12,
    "maxSpots": 15,
    "image": "https://picsum.photos/300/200?random=1&keyword=yoga",
    "description": "Start your day with a gentle yet energizing yoga flow designed to awaken your body and mind."
  };
  
  // Booking form data
  String participantName = "John Doe";
  String participantEmail = "john.doe@email.com";
  String participantPhone = "+1234567890";
  String emergencyContact = "";
  String emergencyPhone = "";
  String medicalConditions = "";
  bool agreedToTerms = false;
  bool agreedToWaiver = false;
  
  // Payment method
  String selectedPaymentMethod = "card";
  String cardNumber = "";
  String cardExpiry = "";
  String cardCvv = "";
  String cardName = "";
  
  List<Map<String, dynamic>> paymentMethods = [
    {
      "label": "Credit/Debit Card",
      "value": "card",
      "icon": Icons.credit_card,
    },
    {
      "label": "PayPal",
      "value": "paypal", 
      "icon": Icons.payment,
    },
    {
      "label": "Apple Pay",
      "value": "apple_pay",
      "icon": Icons.phone_iphone,
    }
  ];

  Widget _buildClassSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${selectedClass["image"]}",
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${selectedClass["name"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "with ${selectedClass["instructor"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spXs),
          
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${DateTime.parse(selectedClass["date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${selectedClass["time"]} (${selectedClass["duration"]} min)",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "\$${(selectedClass["price"] as double).currency}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Full Name",
          value: participantName,
          validator: Validator.required,
          onChanged: (value) {
            participantName = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Email Address",
          value: participantEmail,
          validator: Validator.email,
          onChanged: (value) {
            participantEmail = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Phone Number",
          value: participantPhone,
          validator: Validator.required,
          onChanged: (value) {
            participantPhone = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        Text(
          "Emergency Contact",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Emergency Contact Name",
          value: emergencyContact,
          validator: Validator.required,
          onChanged: (value) {
            emergencyContact = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Emergency Contact Phone",
          value: emergencyPhone,
          validator: Validator.required,
          onChanged: (value) {
            emergencyPhone = value;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QMemoField(
          label: "Medical Conditions (Optional)",
          value: medicalConditions,
          hint: "Please list any medical conditions or medications we should be aware of",
          onChanged: (value) {
            medicalConditions = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildPaymentStep() {
    return Column(
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
          items: paymentMethods,
          value: selectedPaymentMethod,
          onChanged: (index, label, value, item) {
            selectedPaymentMethod = value;
            setState(() {});
          },
        ),
        
        if (selectedPaymentMethod == "card") ...[
          SizedBox(height: spMd),
          
          QTextField(
            label: "Cardholder Name",
            value: cardName,
            validator: Validator.required,
            onChanged: (value) {
              cardName = value;
              setState(() {});
            },
          ),
          
          SizedBox(height: spSm),
          
          QTextField(
            label: "Card Number",
            value: cardNumber,
            hint: "1234 5678 9012 3456",
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
                  label: "Expiry Date",
                  value: cardExpiry,
                  hint: "MM/YY",
                  validator: Validator.required,
                  onChanged: (value) {
                    cardExpiry = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "CVV",
                  value: cardCvv,
                  hint: "123",
                  validator: Validator.required,
                  onChanged: (value) {
                    cardCvv = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
        
        if (selectedPaymentMethod == "paypal") ...[
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "You will be redirected to PayPal to complete your payment securely.",
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
        
        if (selectedPaymentMethod == "apple_pay") ...[
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Use Touch ID or Face ID to pay securely with Apple Pay.",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildConfirmationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Terms & Confirmation",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        
        SizedBox(height: spSm),
        
        QSwitch(
          items: [
            {
              "label": "I agree to the Terms and Conditions",
              "value": true,
              "checked": agreedToTerms,
            }
          ],
          value: agreedToTerms ? [{"label": "I agree to the Terms and Conditions", "value": true, "checked": true}] : [],
          onChanged: (values, ids) {
            agreedToTerms = values.isNotEmpty;
            setState(() {});
          },
        ),
        
        SizedBox(height: spSm),
        
        QSwitch(
          items: [
            {
              "label": "I agree to the Liability Waiver",
              "value": true,
              "checked": agreedToWaiver,
            }
          ],
          value: agreedToWaiver ? [{"label": "I agree to the Liability Waiver", "value": true, "checked": true}] : [],
          onChanged: (values, ids) {
            agreedToWaiver = values.isNotEmpty;
            setState(() {});
          },
        ),
        
        SizedBox(height: spMd),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: warningColor.withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 20),
                  SizedBox(width: spSm),
                  Text(
                    "Cancellation Policy",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Text(
                "• Free cancellation up to 24 hours before class\n• 50% refund within 12-24 hours\n• No refund within 12 hours of class time",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Class"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Class summary card
            _buildClassSummary(),
            
            SizedBox(height: spMd),
            
            // Progress indicator
            Container(
              padding: EdgeInsets.symmetric(vertical: spSm),
              child: Row(
                children: List.generate(3, (index) {
                  bool isActive = index <= currentStep;
                  bool isCompleted = index < currentStep;
                  
                  return Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: isActive ? primaryColor : disabledOutlineBorderColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                        if (index < 2) SizedBox(width: spXs),
                      ],
                    ),
                  );
                }),
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Step content
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  if (currentStep == 0) _buildPersonalInfoStep(),
                  if (currentStep == 1) _buildPaymentStep(),
                  if (currentStep == 2) _buildConfirmationStep(),
                  
                  SizedBox(height: spMd),
                  
                  // Navigation buttons
                  Row(
                    children: [
                      if (currentStep > 0)
                        Expanded(
                          child: QButton(
                            label: "Previous",
                            size: bs.md,
                            onPressed: () {
                              currentStep--;
                              setState(() {});
                            },
                          ),
                        ),
                      if (currentStep > 0) SizedBox(width: spSm),
                      Expanded(
                        flex: currentStep == 0 ? 1 : 1,
                        child: QButton(
                          label: currentStep == 2 ? "Complete Booking" : "Next",
                          size: bs.md,
                          onPressed: () {
                            if (currentStep < 2) {
                              currentStep++;
                              setState(() {});
                            } else {
                              // Complete booking
                              if (agreedToTerms && agreedToWaiver) {
                                ss("Class booked successfully!");
                                back();
                              } else {
                                se("Please agree to terms and conditions");
                              }
                            }
                          },
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
    );
  }
}
