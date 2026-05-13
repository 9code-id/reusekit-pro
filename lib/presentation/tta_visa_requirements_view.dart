import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaVisaRequirementsView extends StatefulWidget {
  const TtaVisaRequirementsView({super.key});

  @override
  State<TtaVisaRequirementsView> createState() => _TtaVisaRequirementsViewState();
}

class _TtaVisaRequirementsViewState extends State<TtaVisaRequirementsView> {
  String selectedFromCountry = "United States";
  String selectedToCountry = "";
  String selectedTravelPurpose = "";
  bool isLoading = false;

  List<Map<String, dynamic>> countries = [
    {"label": "United States", "value": "US", "code": "🇺🇸"},
    {"label": "United Kingdom", "value": "GB", "code": "🇬🇧"},
    {"label": "Canada", "value": "CA", "code": "🇨🇦"},
    {"label": "Australia", "value": "AU", "code": "🇦🇺"},
    {"label": "Germany", "value": "DE", "code": "🇩🇪"},
    {"label": "France", "value": "FR", "code": "🇫🇷"},
    {"label": "Japan", "value": "JP", "code": "🇯🇵"},
    {"label": "China", "value": "CN", "code": "🇨🇳"},
    {"label": "India", "value": "IN", "code": "🇮🇳"},
    {"label": "Brazil", "value": "BR", "code": "🇧🇷"},
    {"label": "Russia", "value": "RU", "code": "🇷🇺"},
    {"label": "South Africa", "value": "ZA", "code": "🇿🇦"},
    {"label": "Mexico", "value": "MX", "code": "🇲🇽"},
    {"label": "Thailand", "value": "TH", "code": "🇹🇭"},
    {"label": "Singapore", "value": "SG", "code": "🇸🇬"},
  ];

  List<Map<String, dynamic>> travelPurposes = [
    {"label": "Tourism", "value": "tourism"},
    {"label": "Business", "value": "business"},
    {"label": "Study", "value": "study"},
    {"label": "Work", "value": "work"},
    {"label": "Transit", "value": "transit"},
    {"label": "Medical", "value": "medical"},
    {"label": "Family Visit", "value": "family"},
  ];

  Map<String, dynamic>? visaRequirement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visa Requirements"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Check Visa Requirements",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Enter your travel details to check if you need a visa",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "From Country (Your Nationality)",
                    items: countries.map((country) => {
                      "label": "${country["code"]} ${country["label"]}",
                      "value": country["label"],
                    }).toList(),
                    value: selectedFromCountry,
                    onChanged: (value, label) {
                      selectedFromCountry = value;
                      visaRequirement = null;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "To Country (Destination)",
                    items: countries.where((country) => country["label"] != selectedFromCountry).map((country) => {
                      "label": "${country["code"]} ${country["label"]}",
                      "value": country["label"],
                    }).toList(),
                    value: selectedToCountry,
                    onChanged: (value, label) {
                      selectedToCountry = value;
                      visaRequirement = null;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Travel Purpose",
                    items: travelPurposes,
                    value: selectedTravelPurpose,
                    onChanged: (value, label) {
                      selectedTravelPurpose = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isLoading ? "Checking..." : "Check Requirements",
                      icon: Icons.search,
                      size: bs.md,
                      onPressed: selectedToCountry.isNotEmpty && selectedTravelPurpose.isNotEmpty && !isLoading
                          ? () {
                              _checkVisaRequirements();
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),

            if (visaRequirement != null) ...[
              SizedBox(height: spLg),
              _buildVisaRequirementResult(),
            ],

            SizedBox(height: spLg),

            // Popular Destinations
            Text(
              "Popular Destinations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            _buildPopularDestinations(),

            SizedBox(height: spLg),

            // Visa Types Guide
            Text(
              "Common Visa Types",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            _buildVisaTypesGuide(),

            SizedBox(height: spLg),

            // Tips
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
                        "Visa Application Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Apply for your visa well in advance (2-3 months)\n"
                    "• Check passport validity (usually 6+ months required)\n"
                    "• Prepare all required documents before applying\n"
                    "• Consider using official embassy/consulate websites\n"
                    "• Keep copies of all submitted documents",
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

  Widget _buildVisaRequirementResult() {
    bool visaRequired = visaRequirement!["required"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: visaRequired ? warningColor.withAlpha(30) : successColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: visaRequired ? warningColor : successColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                visaRequired ? Icons.assignment : Icons.check_circle,
                color: visaRequired ? warningColor : successColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      visaRequired ? "Visa Required" : "No Visa Required",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: visaRequired ? warningColor : successColor,
                      ),
                    ),
                    Text(
                      "From $selectedFromCountry to $selectedToCountry",
                      style: TextStyle(
                        fontSize: 12,
                        color: visaRequired ? warningColor : successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          if (visaRequired) ...[
            _buildRequirementSection("Visa Type", "${visaRequirement!["visaType"]}"),
            _buildRequirementSection("Processing Time", "${visaRequirement!["processingTime"]}"),
            _buildRequirementSection("Validity", "${visaRequirement!["validity"]}"),
            _buildRequirementSection("Fee", "${visaRequirement!["fee"]}"),
            
            SizedBox(height: spSm),
            Text(
              "Required Documents:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: warningColor,
              ),
            ),
            SizedBox(height: spXs),
            Column(
              children: (visaRequirement!["documents"] as List).map((doc) {
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• ",
                        style: TextStyle(
                          color: warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "$doc",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Apply Now",
                    icon: Icons.launch,
                    size: bs.sm,
                    onPressed: () {
                      ss("Redirecting to visa application");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Embassy Info",
                    icon: Icons.location_on,
                    size: bs.sm,
                    onPressed: () {
                      _showEmbassyInfo();
                    },
                  ),
                ),
              ],
            ),
          ] else ...[
            Text(
              "${visaRequirement!["description"]}",
              style: TextStyle(
                color: successColor,
                height: 1.4,
              ),
            ),
            if (visaRequirement!["maxStay"] != null) ...[
              SizedBox(height: spSm),
              _buildRequirementSection("Maximum Stay", "${visaRequirement!["maxStay"]}"),
            ],
            if (visaRequirement!["conditions"] != null) ...[
              SizedBox(height: spSm),
              Text(
                "Conditions:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${visaRequirement!["conditions"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildRequirementSection(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$title:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularDestinations() {
    List<Map<String, dynamic>> popularDestinations = [
      {"country": "Thailand", "flag": "🇹🇭", "requirement": "Visa on Arrival", "color": successColor},
      {"country": "Japan", "flag": "🇯🇵", "requirement": "Visa Required", "color": warningColor},
      {"country": "United Kingdom", "flag": "🇬🇧", "requirement": "Visa Required", "color": warningColor},
      {"country": "Germany", "flag": "🇩🇪", "requirement": "Visa Free", "color": successColor},
      {"country": "Singapore", "flag": "🇸🇬", "requirement": "Visa Free", "color": successColor},
      {"country": "Australia", "flag": "🇦🇺", "requirement": "eVisa Required", "color": warningColor},
    ];

    return ResponsiveGridView(
      minItemWidth: 150,
      children: popularDestinations.map((destination) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Column(
            children: [
              Text(
                "${destination["flag"]}",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: spXs),
              Text(
                "${destination["country"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: destination["color"].withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${destination["requirement"]}",
                  style: TextStyle(
                    fontSize: 8,
                    color: destination["color"],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVisaTypesGuide() {
    List<Map<String, dynamic>> visaTypes = [
      {
        "type": "Tourist Visa",
        "description": "For leisure travel and sightseeing",
        "icon": Icons.camera_alt,
        "color": primaryColor,
      },
      {
        "type": "Business Visa",
        "description": "For business meetings and conferences",
        "icon": Icons.business_center,
        "color": secondaryColor,
      },
      {
        "type": "Student Visa",
        "description": "For educational purposes and studies",
        "icon": Icons.school,
        "color": successColor,
      },
      {
        "type": "Work Visa",
        "description": "For employment and work activities",
        "icon": Icons.work,
        "color": warningColor,
      },
      {
        "type": "Transit Visa",
        "description": "For passing through a country",
        "icon": Icons.flight_takeoff,
        "color": infoColor,
      },
      {
        "type": "Medical Visa",
        "description": "For medical treatment and care",
        "icon": Icons.local_hospital,
        "color": dangerColor,
      },
    ];

    return Column(
      children: visaTypes.map((visa) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: visa["color"].withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  visa["icon"],
                  color: visa["color"],
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${visa["type"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${visa["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _checkVisaRequirements() async {
    isLoading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Mock visa requirement data
    visaRequirement = _getMockVisaRequirement();
    
    isLoading = false;
    setState(() {});
  }

  Map<String, dynamic> _getMockVisaRequirement() {
    // This would normally come from an API
    Map<String, bool> visaFreeCountries = {
      "United States-Germany": true,
      "United States-United Kingdom": false,
      "United States-Japan": false,
      "United States-Thailand": false,
      "United States-Singapore": true,
      "United States-Australia": false,
    };

    String key = "$selectedFromCountry-$selectedToCountry";
    bool visaRequired = !visaFreeCountries.containsKey(key) || !visaFreeCountries[key]!;

    if (visaRequired) {
      return {
        "required": true,
        "visaType": selectedTravelPurpose == "tourism" ? "Tourist Visa" : "Business Visa",
        "processingTime": "5-15 business days",
        "validity": "90 days",
        "fee": "\$160 USD",
        "documents": [
          "Valid passport (6+ months validity)",
          "Completed visa application form",
          "Passport-sized photographs",
          "Proof of accommodation",
          "Flight itinerary",
          "Bank statements (last 3 months)",
          "Travel insurance",
          "Proof of employment or student status",
        ],
      };
    } else {
      return {
        "required": false,
        "description": "Citizens of $selectedFromCountry can enter $selectedToCountry without a visa for tourism purposes.",
        "maxStay": "90 days",
        "conditions": "Must have valid passport and return ticket. Extension of stay may require separate application.",
      };
    }
  }

  void _showEmbassyInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Embassy Information"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$selectedToCountry Embassy/Consulate",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spSm),
            Text(
              "Address: 123 Embassy Street, Washington DC\n"
              "Phone: +1 (555) 123-4567\n"
              "Email: visa@embassy.gov\n"
              "Website: www.embassy.gov\n\n"
              "Visa Section Hours:\n"
              "Monday-Friday: 9:00 AM - 12:00 PM",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Visit Website",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Opening embassy website");
            },
          ),
        ],
      ),
    );
  }
}
