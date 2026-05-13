import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCompanyProfileView extends StatefulWidget {
  const EcmCompanyProfileView({super.key});

  @override
  State<EcmCompanyProfileView> createState() => _EcmCompanyProfileViewState();
}

class _EcmCompanyProfileViewState extends State<EcmCompanyProfileView> {
  final formKey = GlobalKey<FormState>();
  String companyName = "EventPro Solutions";
  String companyEmail = "contact@eventpro.com";
  String companyPhone = "+1 (555) 123-4567";
  String website = "https://eventpro.com";
  String description = "Professional event management company specializing in corporate events, conferences, and entertainment shows.";
  String address = "123 Event Street";
  String city = "New York";
  String state = "NY";
  String zipCode = "10001";
  String country = "United States";
  String logoUrl = "";
  String businessLicense = "";
  String insuranceDoc = "";
  bool isEditing = false;
  
  List<Map<String, dynamic>> companyStats = [
    {"title": "Events Organized", "value": "147", "icon": Icons.event, "color": primaryColor},
    {"title": "Happy Clients", "value": "98", "icon": Icons.people, "color": successColor},
    {"title": "Team Members", "value": "12", "icon": Icons.group, "color": infoColor},
    {"title": "Years Active", "value": "5", "icon": Icons.timeline, "color": warningColor},
  ];
  
  List<Map<String, dynamic>> services = [
    {"name": "Corporate Events", "active": true},
    {"name": "Wedding Planning", "active": true},
    {"name": "Conference Management", "active": true},
    {"name": "Product Launches", "active": false},
    {"name": "Entertainment Shows", "active": true},
    {"name": "Sports Events", "active": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Profile"),
        actions: [
          GestureDetector(
            onTap: () {
              isEditing = !isEditing;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                children: [
                  Icon(
                    isEditing ? Icons.close : Icons.edit,
                    size: 20,
                    color: primaryColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    isEditing ? "Cancel" : "Edit",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
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
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      Icons.business,
                      size: 40,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    companyName,
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Professional Event Management",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "4.9 (127 reviews)",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Company stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: companyStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${stat["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),
            
            // Company information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Company Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  if (isEditing) ...[
                    Form(
                      key: formKey,
                      child: Column(
                        spacing: spMd,
                        children: [
                          QTextField(
                            label: "Company Name",
                            value: companyName,
                            validator: Validator.required,
                            onChanged: (value) {
                              companyName = value;
                              setState(() {});
                            },
                          ),
                          
                          QTextField(
                            label: "Email Address",
                            value: companyEmail,
                            validator: Validator.email,
                            onChanged: (value) {
                              companyEmail = value;
                              setState(() {});
                            },
                          ),
                          
                          QTextField(
                            label: "Phone Number",
                            value: companyPhone,
                            validator: Validator.required,
                            onChanged: (value) {
                              companyPhone = value;
                              setState(() {});
                            },
                          ),
                          
                          QTextField(
                            label: "Website",
                            value: website,
                            onChanged: (value) {
                              website = value;
                              setState(() {});
                            },
                          ),
                          
                          QMemoField(
                            label: "Company Description",
                            value: description,
                            validator: Validator.required,
                            onChanged: (value) {
                              description = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    _buildInfoRow("Company Name", companyName, Icons.business),
                    _buildInfoRow("Email", companyEmail, Icons.email),
                    _buildInfoRow("Phone", companyPhone, Icons.phone),
                    _buildInfoRow("Website", website, Icons.language),
                    SizedBox(height: spMd),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Address information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Business Address",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  if (isEditing) ...[
                    Column(
                      spacing: spMd,
                      children: [
                        QTextField(
                          label: "Street Address",
                          value: address,
                          validator: Validator.required,
                          onChanged: (value) {
                            address = value;
                            setState(() {});
                          },
                        ),
                        
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "City",
                                value: city,
                                validator: Validator.required,
                                onChanged: (value) {
                                  city = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: QTextField(
                                label: "State",
                                value: state,
                                onChanged: (value) {
                                  state = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "ZIP Code",
                                value: zipCode,
                                onChanged: (value) {
                                  zipCode = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: QTextField(
                                label: "Country",
                                value: country,
                                validator: Validator.required,
                                onChanged: (value) {
                                  country = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ] else ...[
                    _buildInfoRow("Address", address, Icons.location_on),
                    _buildInfoRow("City", "$city, $state $zipCode", Icons.location_city),
                    _buildInfoRow("Country", country, Icons.flag),
                  ],
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Services
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Services Offered",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: services.map((service) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: (service["active"] as bool)
                              ? primaryColor.withAlpha(20)
                              : disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: (service["active"] as bool)
                                ? primaryColor
                                : disabledColor,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              (service["active"] as bool)
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              size: 16,
                              color: (service["active"] as bool)
                                  ? primaryColor
                                  : disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (service["active"] as bool)
                                    ? primaryColor
                                    : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: spXl),
            
            // Save button (only show when editing)
            if (isEditing) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Changes",
                  size: bs.md,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      isEditing = false;
                      setState(() {});
                      ss("Profile updated successfully!");
                    }
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: primaryColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
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
    );
  }
}
