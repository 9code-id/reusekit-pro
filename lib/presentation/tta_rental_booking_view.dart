import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaRentalBookingView extends StatefulWidget {
  const TtaRentalBookingView({super.key});

  @override
  State<TtaRentalBookingView> createState() => _TtaRentalBookingViewState();
}

class _TtaRentalBookingViewState extends State<TtaRentalBookingView> {
  int currentStep = 0;
  
  // Personal Information
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String driverLicense = "";
  DateTime dateOfBirth = DateTime.now().subtract(Duration(days: 365 * 25));
  
  // Rental Details
  DateTime pickupDate = DateTime.now().add(Duration(days: 1));
  DateTime dropoffDate = DateTime.now().add(Duration(days: 3));
  String pickupTime = "10:00";
  String dropoffTime = "18:00";
  String pickupLocation = "Downtown Branch";
  String dropoffLocation = "Downtown Branch";
  
  // Additional Services
  String selectedInsurance = "basic";
  bool needGPS = false;
  bool needChildSeat = false;
  bool needAdditionalDriver = false;
  
  // Payment Information
  String cardNumber = "";
  String expiryDate = "";
  String cvv = "";
  String cardholderName = "";
  String billingAddress = "";
  
  final formKey = GlobalKey<FormState>();

  Map<String, dynamic> selectedCar = {
    "name": "BMW X3",
    "brand": "BMW",
    "year": 2024,
    "category": "SUV",
    "pricePerDay": 125.00,
    "image": "https://picsum.photos/300/200?random=1&keyword=bmw",
    "features": ["GPS", "Bluetooth", "Air Conditioning", "Leather Seats"],
  };

  List<Map<String, dynamic>> insuranceOptions = [
    {
      "label": "Basic Coverage",
      "value": "basic",
      "price": 0,
      "description": "Standard liability coverage",
    },
    {
      "label": "Premium Coverage",
      "value": "premium", 
      "price": 25,
      "description": "Comprehensive coverage with lower deductible",
    },
    {
      "label": "Full Coverage",
      "value": "full",
      "price": 45,
      "description": "Maximum protection with zero deductible",
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
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "Downtown Branch", "value": "Downtown Branch"},
    {"label": "Airport Terminal", "value": "Airport Terminal"},
    {"label": "Central Station", "value": "Central Station"},
    {"label": "Shopping Mall", "value": "Shopping Mall"},
  ];

  int get rentalDays {
    return dropoffDate.difference(pickupDate).inDays;
  }

  double get subtotal {
    return (selectedCar["pricePerDay"] as double) * rentalDays;
  }

  double get insurancePrice {
    for (var option in insuranceOptions) {
      if (option["value"] == selectedInsurance) {
        return ((option["price"] as int) * rentalDays).toDouble();
      }
    }
    return 0;
  }

  double get addonsPrice {
    double total = 0;
    if (needGPS) total += 15 * rentalDays;
    if (needChildSeat) total += 10 * rentalDays;
    if (needAdditionalDriver) total += 20 * rentalDays;
    return total;
  }

  double get taxes {
    return (subtotal + insurancePrice + addonsPrice) * 0.1;
  }

  double get totalAmount {
    return subtotal + insurancePrice + addonsPrice + taxes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Rental"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              ss("Help information opened");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
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
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: isCurrent ? Border.all(
                            color: primaryColor,
                            width: 3,
                          ) : null,
                        ),
                        child: Center(
                          child: Text(
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
            child: Form(
              key: formKey,
              child: _buildStepContent(),
            ),
          ),

          // Bottom Navigation
          Container(
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
                      size: bs.md,
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spMd),
                Expanded(
                  flex: 2,
                  child: QButton(
                    label: currentStep == 3 ? "Complete Booking" : "Next",
                    size: bs.md,
                    onPressed: () {
                      if (currentStep == 3) {
                        _completeBooking();
                      } else {
                        if (_validateCurrentStep()) {
                          currentStep++;
                          setState(() {});
                        }
                      }
                    },
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
        return _buildPersonalInfo();
      case 1:
        return _buildRentalDetails();
      case 2:
        return _buildAdditionalServices();
      case 3:
        return _buildPaymentInfo();
      default:
        return Container();
    }
  }

  Widget _buildPersonalInfo() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Information",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

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
              SizedBox(width: spMd),
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

          QTextField(
            label: "Email Address",
            value: email,
            validator: Validator.email,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Phone Number",
            value: phone,
            validator: Validator.required,
            onChanged: (value) {
              phone = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Driver's License Number",
            value: driverLicense,
            validator: Validator.required,
            onChanged: (value) {
              driverLicense = value;
              setState(() {});
            },
          ),

          QDatePicker(
            label: "Date of Birth",
            value: dateOfBirth,
            onChanged: (value) {
              dateOfBirth = value;
              setState(() {});
            },
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spMd),
                Expanded(
                  child: Text(
                    "You must be at least 21 years old to rent a vehicle. A valid driver's license is required.",
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

  Widget _buildRentalDetails() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rental Details",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Selected Car
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusMd),
                  child: Image.network(
                    "${selectedCar["image"]}",
                    width: 80,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${selectedCar["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${selectedCar["brand"]} ${selectedCar["year"]} • ${selectedCar["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${((selectedCar["pricePerDay"] as double)).toStringAsFixed(0)}/day",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Pickup Details
          Text(
            "Pickup Details",
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
                    if (dropoffDate.isBefore(pickupDate)) {
                      dropoffDate = pickupDate.add(Duration(days: 1));
                    }
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
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

          QDropdownField(
            label: "Pickup Location",
            items: locationOptions,
            value: pickupLocation,
            onChanged: (value, label) {
              pickupLocation = value;
              setState(() {});
            },
          ),

          // Drop-off Details
          Text(
            "Drop-off Details",
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
              SizedBox(width: spMd),
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

          QDropdownField(
            label: "Drop-off Location",
            items: locationOptions,
            value: dropoffLocation,
            onChanged: (value, label) {
              dropoffLocation = value;
              setState(() {});
            },
          ),

          // Rental Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: primaryColor, size: 20),
                SizedBox(width: spMd),
                Expanded(
                  child: Text(
                    "$rentalDays day${rentalDays > 1 ? 's' : ''} rental",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "\$${subtotal.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: fsH6,
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

  Widget _buildAdditionalServices() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Services",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Insurance Options
          Text(
            "Insurance Coverage",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...insuranceOptions.map((option) {
            bool isSelected = selectedInsurance == option["value"];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(30) : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                ),
              ),
              child: RadioListTile<String>(
                value: option["value"] as String,
                groupValue: selectedInsurance,
                activeColor: primaryColor,
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${option["label"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if ((option["price"] as int) > 0)
                      Text(
                        "+\$${(option["price"] as int) * rentalDays}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Included",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                subtitle: Text(
                  "${option["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                onChanged: (value) {
                  selectedInsurance = value!;
                  setState(() {});
                },
              ),
            );
          }).toList(),

          // Add-ons
          Text(
            "Optional Add-ons",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          _buildAddonOption(
            "GPS Navigation System",
            15,
            needGPS,
            (value) {
              needGPS = value;
              setState(() {});
            },
          ),

          _buildAddonOption(
            "Child Safety Seat",
            10,
            needChildSeat,
            (value) {
              needChildSeat = value;
              setState(() {});
            },
          ),

          _buildAddonOption(
            "Additional Driver",
            20,
            needAdditionalDriver,
            (value) {
              needAdditionalDriver = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddonOption(String title, int pricePerDay, bool value, Function(bool) onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(30) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: value ? primaryColor : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "\$${pricePerDay}/day • Total: \$${pricePerDay * rentalDays}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Booking Summary
          Container(
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
                  "Booking Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildSummaryRow("Car rental ($rentalDays days)", "\$${subtotal.toStringAsFixed(0)}"),
                if (insurancePrice > 0)
                  _buildSummaryRow("Insurance", "\$${insurancePrice.toStringAsFixed(0)}"),
                if (addonsPrice > 0)
                  _buildSummaryRow("Add-ons", "\$${addonsPrice.toStringAsFixed(0)}"),
                _buildSummaryRow("Taxes & Fees", "\$${taxes.toStringAsFixed(0)}"),
                Divider(),
                _buildSummaryRow(
                  "Total Amount",
                  "\$${totalAmount.toStringAsFixed(0)}",
                  isTotal: true,
                ),
              ],
            ),
          ),

          // Payment Details
          Text(
            "Payment Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          QTextField(
            label: "Cardholder Name",
            value: cardholderName,
            validator: Validator.required,
            onChanged: (value) {
              cardholderName = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Card Number",
            value: cardNumber,
            validator: Validator.required,
            onChanged: (value) {
              cardNumber = value;
              setState(() {});
            },
          ),

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
              SizedBox(width: spMd),
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

          QMemoField(
            label: "Billing Address",
            value: billingAddress,
            validator: Validator.required,
            onChanged: (value) {
              billingAddress = value;
              setState(() {});
            },
          ),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.security, color: warningColor, size: 20),
                SizedBox(width: spMd),
                Expanded(
                  child: Text(
                    "Your payment information is secure and encrypted. You will not be charged until you pick up the vehicle.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
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

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 14 : 12,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? primaryColor : null,
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: FontWeight.bold,
              color: isTotal ? primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }

  bool _validateCurrentStep() {
    if (currentStep == 0) {
      return firstName.isNotEmpty && lastName.isNotEmpty && 
             email.isNotEmpty && phone.isNotEmpty && driverLicense.isNotEmpty;
    } else if (currentStep == 1) {
      return pickupLocation.isNotEmpty && dropoffLocation.isNotEmpty;
    } else if (currentStep == 2) {
      return selectedInsurance.isNotEmpty;
    }
    return true;
  }

  void _completeBooking() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Booking Confirmed!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 64,
              ),
              SizedBox(height: spMd),
              Text(
                "Your car rental has been successfully booked. You will receive a confirmation email shortly.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            QButton(
              label: "View Booking",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                ss("Viewing booking details");
              },
            ),
          ],
        ),
      );
    }
  }
}
