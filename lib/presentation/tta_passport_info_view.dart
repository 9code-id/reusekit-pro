import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaPassportInfoView extends StatefulWidget {
  const TtaPassportInfoView({super.key});

  @override
  State<TtaPassportInfoView> createState() => _TtaPassportInfoViewState();
}

class _TtaPassportInfoViewState extends State<TtaPassportInfoView> {
  bool isEditing = false;
  
  Map<String, dynamic> passportInfo = {
    "passportNumber": "US123456789",
    "issuingCountry": "United States",
    "nationality": "American",
    "fullName": "John Michael Smith",
    "dateOfBirth": "1990-03-15",
    "placeOfBirth": "New York, USA",
    "gender": "Male",
    "issueDate": "2020-05-10",
    "expiryDate": "2030-05-09",
    "issuingAuthority": "U.S. Department of State",
    "photo": "https://picsum.photos/150/200?random=1&keyword=passport",
  };

  Map<String, dynamic> editForm = {};

  @override
  void initState() {
    super.initState();
    editForm = Map.from(passportInfo);
  }

  @override
  Widget build(BuildContext context) {
    DateTime expiryDate = DateTime.parse(passportInfo["expiryDate"]);
    DateTime now = DateTime.now();
    int daysUntilExpiry = expiryDate.difference(now).inDays;
    bool isExpiringSoon = daysUntilExpiry <= 180; // 6 months
    bool isExpired = daysUntilExpiry < 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Passport Information"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              if (isEditing) {
                editForm = Map.from(passportInfo);
              }
              isEditing = !isEditing;
              setState(() {});
            },
          ),
          if (isEditing)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _savePassportInfo();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Warning
            if (isExpired || isExpiringSoon)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: isExpired ? dangerColor.withAlpha(30) : warningColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isExpired ? dangerColor : warningColor,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isExpired ? Icons.error : Icons.warning,
                      color: isExpired ? dangerColor : warningColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isExpired ? "Passport Expired" : "Passport Expiring Soon",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isExpired ? dangerColor : warningColor,
                            ),
                          ),
                          Text(
                            isExpired 
                                ? "Your passport expired ${(-daysUntilExpiry)} days ago"
                                : "Your passport expires in ${daysUntilExpiry} days",
                            style: TextStyle(
                              fontSize: 12,
                              color: isExpired ? dangerColor : warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Passport Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PASSPORT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            "${passportInfo["issuingCountry"]}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusXs),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${passportInfo["photo"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "${passportInfo["fullName"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Passport No.",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            "${passportInfo["passportNumber"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date of Birth",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(passportInfo["dateOfBirth"]).dMMMy}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Nationality",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "${passportInfo["nationality"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Expires",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              "${DateTime.parse(passportInfo["expiryDate"]).dMMMy}",
                              style: TextStyle(
                                color: isExpired || isExpiringSoon ? Colors.yellow : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Renew Passport",
                    icon: Icons.refresh,
                    size: bs.md,
                    onPressed: () {
                      _showRenewalInfo();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Copy Details",
                    icon: Icons.copy,
                    size: bs.md,
                    onPressed: () {
                      _copyPassportDetails();
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Detailed Information
            Text(
              "Detailed Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            if (!isEditing) ..._buildViewMode() else ..._buildEditMode(),

            SizedBox(height: spLg),

            // Travel Tips
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Travel Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Keep a copy of your passport in a separate location\n"
                    "• Most countries require 6 months validity from entry date\n"
                    "• Consider expedited renewal if expiring within 6 months\n"
                    "• Register with your embassy when traveling abroad",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                      height: 1.4,
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

  List<Widget> _buildViewMode() {
    return [
      _buildInfoItem("Passport Number", "${passportInfo["passportNumber"]}", Icons.badge),
      _buildInfoItem("Full Name", "${passportInfo["fullName"]}", Icons.person),
      _buildInfoItem("Date of Birth", "${DateTime.parse(passportInfo["dateOfBirth"]).dMMMy}", Icons.cake),
      _buildInfoItem("Place of Birth", "${passportInfo["placeOfBirth"]}", Icons.location_on),
      _buildInfoItem("Gender", "${passportInfo["gender"]}", Icons.people),
      _buildInfoItem("Nationality", "${passportInfo["nationality"]}", Icons.flag),
      _buildInfoItem("Issuing Country", "${passportInfo["issuingCountry"]}", Icons.public),
      _buildInfoItem("Issue Date", "${DateTime.parse(passportInfo["issueDate"]).dMMMy}", Icons.today),
      _buildInfoItem("Expiry Date", "${DateTime.parse(passportInfo["expiryDate"]).dMMMy}", Icons.event),
      _buildInfoItem("Issuing Authority", "${passportInfo["issuingAuthority"]}", Icons.account_balance),
    ];
  }

  List<Widget> _buildEditMode() {
    return [
      QTextField(
        label: "Passport Number",
        value: editForm["passportNumber"],
        onChanged: (value) {
          editForm["passportNumber"] = value;
        },
      ),
      SizedBox(height: spSm),
      QTextField(
        label: "Full Name",
        value: editForm["fullName"],
        onChanged: (value) {
          editForm["fullName"] = value;
        },
      ),
      SizedBox(height: spSm),
      QDatePicker(
        label: "Date of Birth",
        value: DateTime.parse(editForm["dateOfBirth"]),
        onChanged: (value) {
          editForm["dateOfBirth"] = value.toString().split(' ')[0];
          setState(() {});
        },
      ),
      SizedBox(height: spSm),
      QTextField(
        label: "Place of Birth",
        value: editForm["placeOfBirth"],
        onChanged: (value) {
          editForm["placeOfBirth"] = value;
        },
      ),
      SizedBox(height: spSm),
      QDropdownField(
        label: "Gender",
        items: [
          {"label": "Male", "value": "Male"},
          {"label": "Female", "value": "Female"},
          {"label": "Other", "value": "Other"},
        ],
        value: editForm["gender"],
        onChanged: (value, label) {
          editForm["gender"] = value;
          setState(() {});
        },
      ),
      SizedBox(height: spSm),
      QTextField(
        label: "Nationality",
        value: editForm["nationality"],
        onChanged: (value) {
          editForm["nationality"] = value;
        },
      ),
      SizedBox(height: spSm),
      QTextField(
        label: "Issuing Country",
        value: editForm["issuingCountry"],
        onChanged: (value) {
          editForm["issuingCountry"] = value;
        },
      ),
      SizedBox(height: spSm),
      QDatePicker(
        label: "Issue Date",
        value: DateTime.parse(editForm["issueDate"]),
        onChanged: (value) {
          editForm["issueDate"] = value.toString().split(' ')[0];
          setState(() {});
        },
      ),
      SizedBox(height: spSm),
      QDatePicker(
        label: "Expiry Date",
        value: DateTime.parse(editForm["expiryDate"]),
        onChanged: (value) {
          editForm["expiryDate"] = value.toString().split(' ')[0];
          setState(() {});
        },
      ),
      SizedBox(height: spSm),
      QTextField(
        label: "Issuing Authority",
        value: editForm["issuingAuthority"],
        onChanged: (value) {
          editForm["issuingAuthority"] = value;
        },
      ),
    ];
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _savePassportInfo() {
    passportInfo = Map.from(editForm);
    isEditing = false;
    setState(() {});
    ss("Passport information updated successfully");
  }

  void _showRenewalInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Passport Renewal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Renewal Requirements:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spSm),
            Text(
              "• Current passport\n"
              "• Passport application form\n"
              "• Passport photo\n"
              "• Proof of citizenship\n"
              "• Payment for fees",
              style: TextStyle(fontSize: 12, height: 1.4),
            ),
            SizedBox(height: spSm),
            Text(
              "Processing time: 4-6 weeks (standard)\n"
              "Expedited service: 2-3 weeks",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Start Renewal",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Redirecting to renewal process");
            },
          ),
        ],
      ),
    );
  }

  void _copyPassportDetails() {
    String details = """
Passport Number: ${passportInfo["passportNumber"]}
Full Name: ${passportInfo["fullName"]}
Date of Birth: ${DateTime.parse(passportInfo["dateOfBirth"]).dMMMy}
Nationality: ${passportInfo["nationality"]}
Expiry Date: ${DateTime.parse(passportInfo["expiryDate"]).dMMMy}
""";
    
    // Copy to clipboard logic would go here
    ss("Passport details copied to clipboard");
  }
}
