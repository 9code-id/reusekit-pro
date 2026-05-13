import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSponsorManagementView extends StatefulWidget {
  const EmaSponsorManagementView({super.key});

  @override
  State<EmaSponsorManagementView> createState() => _EmaSponsorManagementViewState();
}

class _EmaSponsorManagementViewState extends State<EmaSponsorManagementView> {
  int currentTab = 0;
  final formKey = GlobalKey<FormState>();
  
  // Form fields
  String sponsorName = "";
  String contactPerson = "";
  String email = "";
  String phone = "";
  String website = "";
  String category = "";
  String tier = "";
  String sponsorshipAmount = "";
  String description = "";
  String logo = "";
  String startDate = "";
  String endDate = "";
  bool isActive = true;

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Technology", "value": "technology"},
    {"label": "Finance", "value": "finance"},
    {"label": "Healthcare", "value": "healthcare"},
    {"label": "Education", "value": "education"},
    {"label": "Energy", "value": "energy"},
    {"label": "Fashion", "value": "fashion"},
    {"label": "Food & Beverage", "value": "food"},
    {"label": "Automotive", "value": "automotive"},
  ];

  List<Map<String, dynamic>> tierItems = [
    {"label": "Platinum", "value": "platinum"},
    {"label": "Gold", "value": "gold"},
    {"label": "Silver", "value": "silver"},
    {"label": "Bronze", "value": "bronze"},
  ];

  List<Map<String, dynamic>> sponsorshipPackages = [
    {
      "id": 1,
      "name": "Platinum Package",
      "tier": "Platinum",
      "amount": 50000,
      "benefits": [
        "Logo on all event materials",
        "Premium booth location",
        "Speaking opportunity",
        "VIP networking access",
        "Social media promotion"
      ],
      "events": ["Main Conference", "Networking Dinner", "Workshop Series"],
      "duration": "12 months",
      "isPopular": true
    },
    {
      "id": 2,
      "name": "Gold Package",
      "tier": "Gold",
      "amount": 30000,
      "benefits": [
        "Logo on event materials",
        "Standard booth location",
        "Networking access",
        "Social media mention"
      ],
      "events": ["Main Conference", "Networking Dinner"],
      "duration": "6 months",
      "isPopular": false
    },
    {
      "id": 3,
      "name": "Silver Package",
      "tier": "Silver",
      "amount": 15000,
      "benefits": [
        "Logo on select materials",
        "Basic booth location",
        "Networking access"
      ],
      "events": ["Main Conference"],
      "duration": "3 months",
      "isPopular": false
    },
    {
      "id": 4,
      "name": "Bronze Package",
      "tier": "Bronze",
      "amount": 8000,
      "benefits": [
        "Logo on website",
        "Basic booth location"
      ],
      "events": ["Workshop Series"],
      "duration": "1 month",
      "isPopular": false
    }
  ];

  Color _getTierColor(String tier) {
    switch (tier) {
      case "Platinum":
        return Colors.purple;
      case "Gold":
        return Colors.orange;
      case "Silver":
        return Colors.grey;
      case "Bronze":
        return Colors.brown;
      default:
        return primaryColor;
    }
  }

  void _saveSponsor() {
    if (formKey.currentState!.validate()) {
      ss("Sponsor information saved successfully!");
      // Process sponsor data
    }
  }

  Widget _buildSponsorForm() {
    return Form(
      key: formKey,
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Sponsor Name",
                  value: sponsorName,
                  validator: Validator.required,
                  onChanged: (value) {
                    sponsorName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryItems,
                  value: category,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    category = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QImagePicker(
            label: "Company Logo",
            value: logo,
            hint: "Upload company logo",
            onChanged: (value) {
              logo = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Contact Person",
                  value: contactPerson,
                  validator: Validator.required,
                  onChanged: (value) {
                    contactPerson = value;
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

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Phone",
                  value: phone,
                  validator: Validator.required,
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Website",
                  value: website,
                  onChanged: (value) {
                    website = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sponsorship Tier",
                  items: tierItems,
                  value: tier,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    tier = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Sponsorship Amount (\$)",
                  value: sponsorshipAmount,
                  validator: Validator.required,
                  onChanged: (value) {
                    sponsorshipAmount = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Start Date",
                  value: startDate.isNotEmpty ? DateTime.parse(startDate) : DateTime.now(),
                  onChanged: (value) {
                    startDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "End Date",
                  value: endDate.isNotEmpty ? DateTime.parse(endDate) : DateTime.now().add(Duration(days: 365)),
                  onChanged: (value) {
                    endDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QMemoField(
            label: "Description",
            value: description,
            hint: "Brief description about the sponsor and partnership...",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),

          QSwitch(
            label: "Active Status",
            items: [
              {
                "label": "Active Sponsor",
                "value": true,
                "checked": isActive,
              }
            ],
            value: [if (isActive) {"label": "Active Sponsor", "value": true, "checked": true}],
            onChanged: (values, ids) {
              isActive = values.isNotEmpty;
              setState(() {});
            },
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Sponsor Information",
              size: bs.md,
              onPressed: _saveSponsor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesTab() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: infoColor.withAlpha(50)),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Choose from our pre-designed sponsorship packages or create custom sponsorship terms.",
                  style: TextStyle(
                    fontSize: 14,
                    color: infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: sponsorshipPackages.length,
          separatorBuilder: (context, index) => SizedBox(height: spSm),
          itemBuilder: (context, index) {
            final package = sponsorshipPackages[index];
            final tierColor = _getTierColor("${package["tier"]}");
            
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: (package["isPopular"] as bool) 
                    ? Border.all(color: primaryColor, width: 2)
                    : null,
              ),
              child: Column(
                children: [
                  if (package["isPopular"] as bool)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                      ),
                      child: Text(
                        "MOST POPULAR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: tierColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${package["tier"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: tierColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${((package["amount"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spXs),
                        Text(
                          "${package["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        SizedBox(height: spXs),
                        Text(
                          "Duration: ${package["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        Text(
                          "Benefits:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        SizedBox(height: spXs),
                        Column(
                          children: (package["benefits"] as List).map((benefit) => 
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.check_circle, size: 16, color: successColor),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "$benefit",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).toList(),
                        ),
                        
                        SizedBox(height: spSm),
                        Text(
                          "Included Events:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        SizedBox(height: spXs),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (package["events"] as List).map((event) => 
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: secondaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$event",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                        
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Select Package",
                            size: bs.sm,
                            onPressed: () {
                              tier = package["tier"];
                              sponsorshipAmount = "${package["amount"]}";
                              currentTab = 0;
                              setState(() {});
                              ss("Package selected! Fill in the sponsor details.");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Sponsor Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Sponsor Form", icon: Icon(Icons.business)),
        Tab(text: "Packages", icon: Icon(Icons.card_giftcard)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildSponsorForm(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildPackagesTab(),
        ),
      ],
    );
  }
}
