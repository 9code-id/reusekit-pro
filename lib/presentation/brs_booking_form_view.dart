import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBookingFormView extends StatefulWidget {
  const BrsBookingFormView({super.key});

  @override
  State<BrsBookingFormView> createState() => _BrsBookingFormViewState();
}

class _BrsBookingFormViewState extends State<BrsBookingFormView> {
  final formKey = GlobalKey<FormState>();
  
  String fullName = "";
  String phoneNumber = "";
  String email = "";
  String specialRequests = "";
  bool hasAllergies = false;
  String allergyDetails = "";
  
  DateTime selectedDate = DateTime.now();
  String selectedTime = "10:00";
  String selectedBarber = "John Smith";
  
  List<Map<String, dynamic>> selectedServices = [
    {
      "name": "Classic Haircut",
      "price": 25.0,
      "duration": 30
    },
    {
      "name": "Beard Trim",
      "price": 15.0,
      "duration": 15
    }
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "label": "Cash Payment",
      "value": "cash",
      "icon": Icons.money,
    },
    {
      "label": "Credit Card",
      "value": "card",
      "icon": Icons.credit_card,
    },
    {
      "label": "Digital Wallet",
      "value": "wallet",
      "icon": Icons.account_balance_wallet,
    }
  ];

  String selectedPayment = "cash";

  @override
  Widget build(BuildContext context) {
    double totalPrice = selectedServices.fold<double>(0, (sum, service) => sum + (service["price"] as double));
    int totalDuration = selectedServices.fold<int>(0, (sum, service) => sum + (service["duration"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Booking Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
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
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Text(
                          "${selectedDate.dMMMy} at $selectedTime",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Text(
                          "Barber: $selectedBarber",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Text(
                          "Duration: $totalDuration minutes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money, size: 16, color: primaryColor),
                        SizedBox(width: spXs),
                        Text(
                          "Total: \$${totalPrice.currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Personal Information
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Full Name",
                      value: fullName,
                      validator: Validator.required,
                      onChanged: (value) {
                        fullName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: phoneNumber,
                      validator: Validator.required,
                      onChanged: (value) {
                        phoneNumber = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Email Address",
                      value: email,
                      validator: Validator.email,
                      onChanged: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Special Requirements
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Special Requirements",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Special Requests",
                      value: specialRequests,
                      hint: "Any specific requests or preferences?",
                      onChanged: (value) {
                        specialRequests = value;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      label: "Do you have any allergies?",
                      items: [
                        {
                          "label": "Yes, I have allergies",
                          "value": true,
                          "checked": hasAllergies,
                        }
                      ],
                      value: [
                        if (hasAllergies)
                          {
                            "label": "Yes, I have allergies",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        hasAllergies = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    if (hasAllergies)
                      QMemoField(
                        label: "Allergy Details",
                        value: allergyDetails,
                        hint: "Please describe your allergies",
                        onChanged: (value) {
                          allergyDetails = value;
                          setState(() {});
                        },
                      ),
                  ],
                ),
              ),

              // Payment Method
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...paymentMethods.map((method) {
                      bool isSelected = selectedPayment == method["value"];
                      
                      return GestureDetector(
                        onTap: () {
                          selectedPayment = "${method["value"]}";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                method["icon"] as IconData,
                                color: isSelected ? primaryColor : disabledBoldColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${method["label"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                    color: isSelected ? primaryColor : primaryColor,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Selected Services List
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Selected Services",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    ...selectedServices.map((service) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: successColor.withAlpha(50)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${service["duration"]} minutes",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(service["price"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
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

              // Confirm Booking Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Confirm Booking",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ss("Booking confirmed successfully!");
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
}
