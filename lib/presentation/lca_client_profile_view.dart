import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaClientProfileView extends StatefulWidget {
  const LcaClientProfileView({super.key});

  @override
  State<LcaClientProfileView> createState() => _LcaClientProfileViewState();
}

class _LcaClientProfileViewState extends State<LcaClientProfileView> {
  bool loading = false;
  bool editMode = false;

  // Client Information
  String firstName = "John";
  String lastName = "Mitchell";
  String email = "john.mitchell@email.com";
  String phone = "+1 (555) 123-4567";
  String address = "123 Main Street, Suite 400\nNew York, NY 10001";
  String dateOfBirth = "1985-03-15";
  String occupation = "Business Owner";
  String company = "Mitchell Consulting LLC";

  // Emergency Contact
  String emergencyName = "Sarah Mitchell";
  String emergencyPhone = "+1 (555) 987-6543";
  String emergencyRelation = "Spouse";

  // Client Preferences
  String preferredContact = "email";
  String language = "english";
  bool marketingConsent = true;
  bool dataSharing = false;

  List<Map<String, dynamic>> contactMethods = [
    {"label": "Email", "value": "email"},
    {"label": "Phone", "value": "phone"},
    {"label": "SMS", "value": "sms"},
    {"label": "Mail", "value": "mail"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
  ];

  List<Map<String, dynamic>> documents = [
    {
      "name": "Driver's License Copy",
      "type": "ID",
      "uploadDate": "2024-01-15",
      "status": "verified",
    },
    {
      "name": "Business Registration",
      "type": "Business",
      "uploadDate": "2024-01-10",
      "status": "pending",
    },
    {
      "name": "Tax Return 2023",
      "type": "Financial",
      "uploadDate": "2024-01-08",
      "status": "verified",
    },
  ];

  List<Map<String, dynamic>> caseHistory = [
    {
      "caseNumber": "LC-2024-001",
      "title": "Contract Dispute Resolution",
      "status": "Active",
      "attorney": "Sarah Johnson",
      "startDate": "2024-01-05",
      "priority": "High",
    },
    {
      "caseNumber": "LC-2023-089",
      "title": "Business Partnership Agreement",
      "status": "Closed",
      "attorney": "Michael Chen",
      "startDate": "2023-09-12",
      "priority": "Medium",
    },
    {
      "caseNumber": "LC-2023-067",
      "title": "Employment Law Consultation",
      "status": "Closed",
      "attorney": "Emma Davis",
      "startDate": "2023-07-20",
      "priority": "Low",
    },
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Profile"),
        actions: [
          IconButton(
            icon: Icon(editMode ? Icons.save : Icons.edit),
            onPressed: () {
              if (editMode) {
                _saveProfile();
              } else {
                setState(() {
                  editMode = true;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showOptionsMenu();
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildClientHeader(),
                    _buildPersonalInformation(),
                    _buildEmergencyContact(),
                    _buildPreferences(),
                    _buildDocuments(),
                    _buildCaseHistory(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildClientHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                "${firstName.isNotEmpty ? firstName[0] : 'J'}${lastName.isNotEmpty ? lastName[0] : 'M'}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$firstName $lastName",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.email, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      email,
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
                    Icon(Icons.phone, color: disabledBoldColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      phone,
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
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "Active Client",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.message,
                size: bs.sm,
                onPressed: () {
                  si("Opening client communication");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Personal Information",
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
              Expanded(
                child: editMode
                    ? QTextField(
                        label: "First Name",
                        value: firstName,
                        validator: Validator.required,
                        onChanged: (value) {
                          firstName = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("First Name", firstName),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: editMode
                    ? QTextField(
                        label: "Last Name",
                        value: lastName,
                        validator: Validator.required,
                        onChanged: (value) {
                          lastName = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Last Name", lastName),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: editMode
                    ? QTextField(
                        label: "Email",
                        value: email,
                        validator: Validator.email,
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Email", email),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: editMode
                    ? QTextField(
                        label: "Phone",
                        value: phone,
                        validator: Validator.required,
                        onChanged: (value) {
                          phone = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Phone", phone),
              ),
            ],
          ),
          editMode
              ? QMemoField(
                  label: "Address",
                  value: address,
                  validator: Validator.required,
                  onChanged: (value) {
                    address = value;
                    setState(() {});
                  },
                )
              : _buildInfoItem("Address", address),
          Row(
            children: [
              Expanded(
                child: editMode
                    ? QDatePicker(
                        label: "Date of Birth",
                        value: DateTime.parse(dateOfBirth),
                        onChanged: (value) {
                          dateOfBirth = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Date of Birth", dateOfBirth),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: editMode
                    ? QTextField(
                        label: "Occupation",
                        value: occupation,
                        onChanged: (value) {
                          occupation = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Occupation", occupation),
              ),
            ],
          ),
          editMode
              ? QTextField(
                  label: "Company",
                  value: company,
                  onChanged: (value) {
                    company = value;
                    setState(() {});
                  },
                )
              : _buildInfoItem("Company", company),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.contact_phone, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Emergency Contact",
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
              Expanded(
                child: editMode
                    ? QTextField(
                        label: "Contact Name",
                        value: emergencyName,
                        onChanged: (value) {
                          emergencyName = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Contact Name", emergencyName),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: editMode
                    ? QTextField(
                        label: "Relationship",
                        value: emergencyRelation,
                        onChanged: (value) {
                          emergencyRelation = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Relationship", emergencyRelation),
              ),
            ],
          ),
          editMode
              ? QTextField(
                  label: "Emergency Phone",
                  value: emergencyPhone,
                  onChanged: (value) {
                    emergencyPhone = value;
                    setState(() {});
                  },
                )
              : _buildInfoItem("Emergency Phone", emergencyPhone),
        ],
      ),
    );
  }

  Widget _buildPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Client Preferences",
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
              Expanded(
                child: editMode
                    ? QDropdownField(
                        label: "Preferred Contact Method",
                        items: contactMethods,
                        value: preferredContact,
                        onChanged: (value, label) {
                          preferredContact = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Preferred Contact", preferredContact.toUpperCase()),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: editMode
                    ? QDropdownField(
                        label: "Language",
                        items: languageOptions,
                        value: language,
                        onChanged: (value, label) {
                          language = value;
                          setState(() {});
                        },
                      )
                    : _buildInfoItem("Language", language.toUpperCase()),
              ),
            ],
          ),
          if (editMode) ...[
            QSwitch(
              items: [
                {
                  "label": "Marketing Communications",
                  "value": true,
                  "checked": marketingConsent,
                }
              ],
              value: marketingConsent ? [{"label": "Marketing Communications", "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                marketingConsent = values.isNotEmpty;
                setState(() {});
              },
            ),
            QSwitch(
              items: [
                {
                  "label": "Data Sharing with Partners",
                  "value": true,
                  "checked": dataSharing,
                }
              ],
              value: dataSharing ? [{"label": "Data Sharing with Partners", "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                dataSharing = values.isNotEmpty;
                setState(() {});
              },
            ),
          ] else ...[
            Row(
              children: [
                Expanded(child: _buildInfoItem("Marketing Consent", marketingConsent ? "Yes" : "No")),
                SizedBox(width: spSm),
                Expanded(child: _buildInfoItem("Data Sharing", dataSharing ? "Yes" : "No")),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDocuments() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.folder, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Documents",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  si("Add new document");
                },
              ),
            ],
          ),
          ...documents.map((doc) {
            Color statusColor = doc["status"] == "verified" ? successColor : warningColor;
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.description,
                      color: statusColor,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${doc["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${doc["type"]} • Uploaded ${doc["uploadDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${doc["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCaseHistory() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.gavel, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Case History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.view_list,
                size: bs.sm,
                onPressed: () {
                  si("View all cases");
                },
              ),
            ],
          ),
          ...caseHistory.map((caseItem) {
            Color statusColor = caseItem["status"] == "Active" ? primaryColor : disabledBoldColor;
            Color priorityColor = caseItem["priority"] == "High" ? dangerColor : 
                                 caseItem["priority"] == "Medium" ? warningColor : successColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: statusColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: priorityColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${caseItem["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${caseItem["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Case #${caseItem["caseNumber"]}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "• ${caseItem["attorney"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: priorityColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${caseItem["priority"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: priorityColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Started: ${caseItem["startDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  void _saveProfile() async {
    if (!formKey.currentState!.validate()) {
      se("Please complete all required fields");
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      loading = false;
      editMode = false;
    });

    ss("Client profile updated successfully");
  }

  void _showOptionsMenu() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          value: "print",
          child: Text("Print Profile"),
        ),
        PopupMenuItem(
          value: "export",
          child: Text("Export Data"),
        ),
        PopupMenuItem(
          value: "archive",
          child: Text("Archive Client"),
        ),
      ],
    ).then((value) {
      if (value != null) {
        si("Selected: $value");
      }
    });
  }
}
