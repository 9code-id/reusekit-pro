import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCompanyProfileView extends StatefulWidget {
  const CrmCompanyProfileView({super.key});

  @override
  State<CrmCompanyProfileView> createState() => _CrmCompanyProfileViewState();
}

class _CrmCompanyProfileViewState extends State<CrmCompanyProfileView> {
  int currentTab = 0;
  final formKey = GlobalKey<FormState>();

  // Company Information
  String companyName = "TechSolutions Inc.";
  String industry = "Technology";
  String companySize = "51-200";
  String website = "https://techsolutions.com";
  String phone = "+1-555-0123";
  String email = "info@techsolutions.com";
  String description = "Leading provider of innovative technology solutions for businesses worldwide.";

  // Address Information
  String street = "123 Business Avenue";
  String city = "San Francisco";
  String state = "California";
  String zipCode = "94105";
  String country = "United States";

  // Social Media
  String linkedinUrl = "https://linkedin.com/company/techsolutions";
  String twitterUrl = "https://twitter.com/techsolutions";
  String facebookUrl = "https://facebook.com/techsolutions";

  // Company Settings
  String timeZone = "PST";
  String currency = "USD";
  String dateFormat = "MM/DD/YYYY";
  String fiscalYearStart = "January";

  // Business Hours
  List<Map<String, dynamic>> businessHours = [
    {"day": "Monday", "open": "09:00", "close": "17:00", "enabled": true},
    {"day": "Tuesday", "open": "09:00", "close": "17:00", "enabled": true},
    {"day": "Wednesday", "open": "09:00", "close": "17:00", "enabled": true},
    {"day": "Thursday", "open": "09:00", "close": "17:00", "enabled": true},
    {"day": "Friday", "open": "09:00", "close": "17:00", "enabled": true},
    {"day": "Saturday", "open": "10:00", "close": "14:00", "enabled": false},
    {"day": "Sunday", "open": "10:00", "close": "14:00", "enabled": false},
  ];

  final List<Map<String, dynamic>> industries = [
    {"label": "Technology", "value": "Technology"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Education", "value": "Education"},
    {"label": "Manufacturing", "value": "Manufacturing"},
    {"label": "Retail", "value": "Retail"},
    {"label": "Real Estate", "value": "Real Estate"},
    {"label": "Consulting", "value": "Consulting"},
  ];

  final List<Map<String, dynamic>> companySizes = [
    {"label": "1-10 employees", "value": "1-10"},
    {"label": "11-50 employees", "value": "11-50"},
    {"label": "51-200 employees", "value": "51-200"},
    {"label": "201-500 employees", "value": "201-500"},
    {"label": "501-1000 employees", "value": "501-1000"},
    {"label": "1000+ employees", "value": "1000+"},
  ];

  final List<Map<String, dynamic>> timeZones = [
    {"label": "Pacific Standard Time (PST)", "value": "PST"},
    {"label": "Mountain Standard Time (MST)", "value": "MST"},
    {"label": "Central Standard Time (CST)", "value": "CST"},
    {"label": "Eastern Standard Time (EST)", "value": "EST"},
  ];

  final List<Map<String, dynamic>> currencies = [
    {"label": "US Dollar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "British Pound (GBP)", "value": "GBP"},
    {"label": "Canadian Dollar (CAD)", "value": "CAD"},
  ];

  void _saveProfile() async {
    if (formKey.currentState!.validate()) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Company profile updated successfully");
    }
  }

  Widget _buildCompanyInfoTab() {
    return Form(
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
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Industry",
                  items: industries,
                  value: industry,
                  onChanged: (value, label) {
                    industry = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Company Size",
                  items: companySizes,
                  value: companySize,
                  onChanged: (value, label) {
                    companySize = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Website",
            value: website,
            onChanged: (value) {
              website = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone",
                  value: phone,
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Email",
                  value: email,
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QMemoField(
            label: "Description",
            value: description,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Company Information",
              size: bs.md,
              onPressed: _saveProfile,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTab() {
    return Column(
      spacing: spMd,
      children: [
        QTextField(
          label: "Street Address",
          value: street,
          onChanged: (value) {
            street = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "City",
                value: city,
                onChanged: (value) {
                  city = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "State/Province",
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
          children: [
            Expanded(
              child: QTextField(
                label: "ZIP/Postal Code",
                value: zipCode,
                onChanged: (value) {
                  zipCode = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Country",
                value: country,
                onChanged: (value) {
                  country = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: infoColor.withAlpha(100)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "This address will be used for billing and official correspondence.",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Address",
            size: bs.md,
            onPressed: _saveProfile,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaTab() {
    return Column(
      spacing: spMd,
      children: [
        QTextField(
          label: "LinkedIn URL",
          value: linkedinUrl,
          onChanged: (value) {
            linkedinUrl = value;
            setState(() {});
          },
        ),
        QTextField(
          label: "Twitter URL",
          value: twitterUrl,
          onChanged: (value) {
            twitterUrl = value;
            setState(() {});
          },
        ),
        QTextField(
          label: "Facebook URL",
          value: facebookUrl,
          onChanged: (value) {
            facebookUrl = value;
            setState(() {});
          },
        ),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: warningColor.withAlpha(100)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.share,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Social media links will be displayed on your public company profile and email signatures.",
                  style: TextStyle(
                    fontSize: 14,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Social Media",
            size: bs.md,
            onPressed: _saveProfile,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Regional Settings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Time Zone",
                items: timeZones,
                value: timeZone,
                onChanged: (value, label) {
                  timeZone = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Currency",
                items: currencies,
                value: currency,
                onChanged: (value, label) {
                  currency = value;
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
                label: "Date Format",
                value: dateFormat,
                onChanged: (value) {
                  dateFormat = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QTextField(
                label: "Fiscal Year Start",
                value: fiscalYearStart,
                onChanged: (value) {
                  fiscalYearStart = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        Text(
          "Business Hours",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...businessHours.map((hour) {
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Text(
                    "${hour["day"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Open",
                        "value": true,
                        "checked": hour["enabled"],
                      }
                    ],
                    value: [
                      if (hour["enabled"])
                        {
                          "label": "Open",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      hour["enabled"] = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
                if (hour["enabled"]) ...[
                  SizedBox(width: spSm),
                  Container(
                    width: 70,
                    child: QTextField(
                      label: "Open",
                      value: hour["open"],
                      onChanged: (value) {
                        hour["open"] = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "to",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    width: 70,
                    child: QTextField(
                      label: "Close",
                      value: hour["close"],
                      onChanged: (value) {
                        hour["close"] = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save Settings",
            size: bs.md,
            onPressed: _saveProfile,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Company Profile",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Company Info", icon: Icon(Icons.business)),
        Tab(text: "Address", icon: Icon(Icons.location_on)),
        Tab(text: "Social Media", icon: Icon(Icons.share)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCompanyInfoTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildAddressTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSocialMediaTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSettingsTab(),
        ),
      ],
      onInit: (tabController) {
        // Access to TabController if needed
      },
    );
  }
}
