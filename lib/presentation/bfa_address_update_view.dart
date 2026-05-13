import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaAddressUpdateView extends StatefulWidget {
  const BfaAddressUpdateView({super.key});

  @override
  State<BfaAddressUpdateView> createState() => _BfaAddressUpdateViewState();
}

class _BfaAddressUpdateViewState extends State<BfaAddressUpdateView> {
  final formKey = GlobalKey<FormState>();
  
  // Current Address
  String currentStreet = "123 Main Street";
  String currentApartment = "Apt 4B";
  String currentCity = "New York";
  String currentState = "NY";
  String currentZipCode = "10001";
  String currentCountry = "United States";
  
  // New Address
  String newStreet = "";
  String newApartment = "";
  String newCity = "";
  String newState = "";
  String newZipCode = "";
  String newCountry = "United States";
  
  // Mailing Address
  bool sameAsResidential = true;
  String mailingStreet = "";
  String mailingApartment = "";
  String mailingCity = "";
  String mailingState = "";
  String mailingZipCode = "";
  String mailingCountry = "United States";

  String addressType = "permanent";
  String moveInDate = "";
  String reasonForChange = "";

  List<Map<String, dynamic>> addressTypes = [
    {"label": "Permanent Address", "value": "permanent"},
    {"label": "Temporary Address", "value": "temporary"},
    {"label": "Student Housing", "value": "student"},
    {"label": "Military Housing", "value": "military"},
  ];

  List<Map<String, dynamic>> stateOptions = [
    {"label": "New York", "value": "NY"},
    {"label": "California", "value": "CA"},
    {"label": "Texas", "value": "TX"},
    {"label": "Florida", "value": "FL"},
    {"label": "Illinois", "value": "IL"},
    {"label": "Pennsylvania", "value": "PA"},
    {"label": "Ohio", "value": "OH"},
    {"label": "Georgia", "value": "GA"},
    {"label": "North Carolina", "value": "NC"},
    {"label": "Michigan", "value": "MI"},
  ];

  List<Map<String, dynamic>> countryOptions = [
    {"label": "United States", "value": "United States"},
    {"label": "Canada", "value": "Canada"},
    {"label": "United Kingdom", "value": "United Kingdom"},
    {"label": "Australia", "value": "Australia"},
    {"label": "Germany", "value": "Germany"},
  ];

  List<Map<String, dynamic>> addressHistory = [
    {
      "street": "456 Oak Avenue",
      "city": "Brooklyn",
      "state": "NY",
      "zipCode": "11201",
      "fromDate": "2018-01-01",
      "toDate": "2022-12-31",
      "type": "Rental",
    },
    {
      "street": "789 Pine Street",
      "city": "Queens",
      "state": "NY",
      "zipCode": "11375",
      "fromDate": "2015-06-01",
      "toDate": "2017-12-31",
      "type": "Rental",
    },
  ];

  bool isVerificationPending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Update"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showAddressHistory();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              _buildCurrentAddress(),
              _buildNewAddress(),
              _buildMailingAddress(),
              _buildAddressDetails(),
              _buildVerificationRequirements(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentAddress() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.home, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Current Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "VERIFIED",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$currentStreet ${currentApartment.isNotEmpty ? currentApartment : ''}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "$currentCity, $currentState $currentZipCode",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  currentCountry,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "This address has been verified and is on file since March 2019.",
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

  Widget _buildNewAddress() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.add_location, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "New Address",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          QTextField(
            label: "Street Address",
            value: newStreet,
            hint: "Enter your new street address",
            validator: Validator.required,
            onChanged: (value) {
              newStreet = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Apartment/Unit (Optional)",
            value: newApartment,
            hint: "Apt, Suite, Unit, etc.",
            onChanged: (value) {
              newApartment = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "City",
                  value: newCity,
                  validator: Validator.required,
                  onChanged: (value) {
                    newCity = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "State",
                  items: stateOptions,
                  value: newState,
                  onChanged: (value, label) {
                    newState = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "ZIP Code",
                  value: newZipCode,
                  hint: "12345",
                  validator: Validator.required,
                  onChanged: (value) {
                    newZipCode = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                flex: 2,
                child: QDropdownField(
                  label: "Country",
                  items: countryOptions,
                  value: newCountry,
                  onChanged: (value, label) {
                    newCountry = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Verify Address",
                  size: bs.sm,
                  icon: Icons.verified,
                  onPressed: () {
                    _verifyAddress();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Find on Map",
                  size: bs.sm,
                  icon: Icons.map,
                  onPressed: () {
                    _showMap();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMailingAddress() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.mail, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Mailing Address",
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
              Checkbox(
                value: sameAsResidential,
                onChanged: (value) {
                  sameAsResidential = value ?? true;
                  if (sameAsResidential) {
                    mailingStreet = newStreet;
                    mailingApartment = newApartment;
                    mailingCity = newCity;
                    mailingState = newState;
                    mailingZipCode = newZipCode;
                    mailingCountry = newCountry;
                  }
                  setState(() {});
                },
              ),
              Expanded(
                child: Text(
                  "Same as residential address",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          if (!sameAsResidential) ...[
            QTextField(
              label: "Mailing Street Address",
              value: mailingStreet,
              validator: Validator.required,
              onChanged: (value) {
                mailingStreet = value;
                setState(() {});
              },
            ),

            QTextField(
              label: "Apartment/Unit (Optional)",
              value: mailingApartment,
              onChanged: (value) {
                mailingApartment = value;
                setState(() {});
              },
            ),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "City",
                    value: mailingCity,
                    validator: Validator.required,
                    onChanged: (value) {
                      mailingCity = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "State",
                    items: stateOptions,
                    value: mailingState,
                    onChanged: (value, label) {
                      mailingState = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "ZIP Code",
                    value: mailingZipCode,
                    validator: Validator.required,
                    onChanged: (value) {
                      mailingZipCode = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  flex: 2,
                  child: QDropdownField(
                    label: "Country",
                    items: countryOptions,
                    value: mailingCountry,
                    onChanged: (value, label) {
                      mailingCountry = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddressDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Address Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          QDropdownField(
            label: "Address Type",
            items: addressTypes,
            value: addressType,
            onChanged: (value, label) {
              addressType = value;
              setState(() {});
            },
          ),

          QDatePicker(
            label: "Move-in Date",
            value: moveInDate.isNotEmpty ? DateTime.parse(moveInDate) : DateTime.now(),
            onChanged: (value) {
              moveInDate = value.toString().split(' ')[0];
              setState(() {});
            },
          ),

          QMemoField(
            label: "Reason for Address Change",
            value: reasonForChange,
            hint: "Please provide a brief reason for changing your address",
            validator: Validator.required,
            onChanged: (value) {
              reasonForChange = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationRequirements() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Verification Requirements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),

          Text(
            "To complete your address change, you'll need to provide one of the following documents:",
            style: TextStyle(
              fontSize: 14,
              color: warningColor,
              height: 1.4,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRequirementItem("• Utility bill (gas, electric, water, cable)"),
              _buildRequirementItem("• Bank statement from another institution"),
              _buildRequirementItem("• Lease agreement or mortgage statement"),
              _buildRequirementItem("• Government correspondence (tax notice, voter registration)"),
              _buildRequirementItem("• Insurance policy statement"),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Documents must be dated within the last 90 days and show your name and new address.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (!isVerificationPending)
            Container(
              width: double.infinity,
              child: QButton(
                label: "Upload Documents",
                size: bs.md,
                icon: Icons.upload_file,
                onPressed: () {
                  _uploadDocuments();
                },
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Documents uploaded successfully. Verification in progress.",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
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

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: warningColor,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Submit Address Change",
            size: bs.md,
            icon: Icons.send,
            onPressed: () {
              _submitAddressChange();
            },
          ),
        ),
        
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Save as Draft",
                size: bs.md,
                icon: Icons.save,
                onPressed: () {
                  _saveDraft();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: disabledBoldColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: QButton(
                  label: "Cancel",
                  size: bs.md,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _verifyAddress() {
    if (newStreet.isEmpty || newCity.isEmpty || newZipCode.isEmpty) {
      se("Please enter a complete address");
      return;
    }

    showLoading();
    
    // Simulate address verification
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Address verified successfully");
    });
  }

  void _showMap() {
    // Show map with address location
    si("Opening map view for address verification");
  }

  void _uploadDocuments() {
    // Navigate to document upload
    isVerificationPending = true;
    setState(() {});
    ss("Document upload initiated. Please select your verification documents.");
  }

  void _submitAddressChange() {
    if (formKey.currentState!.validate()) {
      if (newStreet.isEmpty) {
        se("Please enter your new address");
        return;
      }

      if (!isVerificationPending) {
        se("Please upload verification documents first");
        return;
      }

      showLoading();
      
      // Simulate address change submission
      Future.delayed(Duration(seconds: 3), () {
        hideLoading();
        ss("Address change request submitted successfully. You'll receive confirmation within 2-3 business days.");
        Navigator.pop(context);
      });
    }
  }

  void _saveDraft() {
    showLoading();
    
    // Simulate saving draft
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Address change saved as draft");
    });
  }

  void _showAddressHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Address History",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
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
            Expanded(
              child: ListView.builder(
                itemCount: addressHistory.length,
                itemBuilder: (context, index) {
                  final address = addressHistory[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${address["street"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${address["city"]}, ${address["state"]} ${address["zipCode"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "${DateTime.parse(address["fromDate"]).dMMMy} - ${DateTime.parse(address["toDate"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${address["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
