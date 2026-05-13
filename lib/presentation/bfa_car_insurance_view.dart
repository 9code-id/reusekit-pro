import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCarInsuranceView extends StatefulWidget {
  const BfaCarInsuranceView({super.key});

  @override
  State<BfaCarInsuranceView> createState() => _BfaCarInsuranceViewState();
}

class _BfaCarInsuranceViewState extends State<BfaCarInsuranceView> {
  int currentTab = 0;
  String selectedCoverage = "comprehensive";
  String vehicleType = "sedan";
  int vehicleYear = 2020;
  double vehicleValue = 25000;
  int drivingExperience = 5;
  bool hasAccidents = false;
  String selectedDeductible = "500";
  
  List<Map<String, dynamic>> vehicleInfo = [
    {
      "make": "Toyota",
      "model": "Camry",
      "year": 2020,
      "value": 25000,
      "vin": "1HGCM82633A123456"
    }
  ];

  List<Map<String, dynamic>> coverageOptions = [
    {
      "id": "liability",
      "name": "Liability Only",
      "description": "Covers damage to others",
      "premium": 85.0,
      "icon": Icons.shield_outlined,
      "color": Colors.orange,
      "coverage": [
        "Bodily injury liability",
        "Property damage liability",
        "State minimum requirements"
      ],
      "recommended": false
    },
    {
      "id": "collision",
      "name": "Collision Coverage",
      "description": "Covers your vehicle damage",
      "premium": 145.0,
      "icon": Icons.car_crash,
      "color": Colors.blue,
      "coverage": [
        "All liability coverage",
        "Collision damage to your car",
        "Repair or replacement costs"
      ],
      "recommended": false
    },
    {
      "id": "comprehensive",
      "name": "Comprehensive",
      "description": "Complete protection package",
      "premium": 185.0,
      "icon": Icons.security,
      "color": Colors.green,
      "coverage": [
        "All collision coverage",
        "Theft protection",
        "Weather damage",
        "Vandalism coverage",
        "Glass repair"
      ],
      "recommended": true
    },
    {
      "id": "premium",
      "name": "Premium Plus",
      "description": "Maximum coverage & benefits",
      "premium": 245.0,
      "icon": Icons.star,
      "color": Colors.purple,
      "coverage": [
        "All comprehensive coverage",
        "Rental car coverage",
        "Roadside assistance",
        "Gap insurance",
        "New car replacement"
      ],
      "recommended": false
    },
  ];

  List<Map<String, dynamic>> claimsHistory = [
    {
      "date": "2023-05-15",
      "type": "Minor Fender Bender",
      "amount": 1200.0,
      "status": "Settled",
      "icon": Icons.minor_crash
    },
    {
      "date": "2022-11-08",
      "type": "Windshield Replacement",
      "amount": 350.0,
      "status": "Settled",
      "icon": Icons.screenshot
    }
  ];

  Map<String, dynamic> get selectedCoverageData {
    return coverageOptions.firstWhere((option) => option["id"] == selectedCoverage);
  }

  double calculatePremium() {
    double basePremium = selectedCoverageData["premium"] as double;
    
    // Vehicle age factor
    int vehicleAge = DateTime.now().year - vehicleYear;
    if (vehicleAge > 10) basePremium *= 0.8;
    else if (vehicleAge < 3) basePremium *= 1.2;
    
    // Vehicle value factor
    basePremium *= (vehicleValue / 25000);
    
    // Driving experience factor
    if (drivingExperience < 3) basePremium *= 1.3;
    else if (drivingExperience > 10) basePremium *= 0.9;
    
    // Accidents factor
    if (hasAccidents) basePremium *= 1.4;
    
    // Deductible factor
    switch (selectedDeductible) {
      case "250":
        basePremium *= 1.15;
        break;
      case "1000":
        basePremium *= 0.85;
        break;
      case "2000":
        basePremium *= 0.75;
        break;
    }
    
    return basePremium;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Car Insurance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Coverage", icon: Icon(Icons.security)),
        Tab(text: "Vehicle", icon: Icon(Icons.directions_car)),
        Tab(text: "Claims", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        // Coverage Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Drive with",
                            style: TextStyle(
                              fontSize: fsH5,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Confidence",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Comprehensive car insurance that protects you on every journey",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.directions_car,
                      size: 60,
                      color: Colors.white.withAlpha(180),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Quick Quote Section
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customize Your Coverage",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    // Deductible Selection
                    Text(
                      "Deductible Amount",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: ["250", "500", "1000", "2000"].map((amount) {
                        final isSelected = selectedDeductible == amount;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              selectedDeductible = amount;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: amount != "2000" ? spXs : 0),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: isSelected ? primaryColor : disabledOutlineBorderColor,
                                ),
                              ),
                              child: Text(
                                "\$$amount",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: spMd),

                    // Driving Experience
                    Text(
                      "Driving Experience: $drivingExperience years",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Slider(
                      value: drivingExperience.toDouble(),
                      min: 0,
                      max: 20,
                      divisions: 20,
                      label: "$drivingExperience years",
                      activeColor: primaryColor,
                      onChanged: (value) {
                        drivingExperience = value.toInt();
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Accident History
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Any accidents in last 3 years?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Switch(
                          value: hasAccidents,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            hasAccidents = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Coverage Options
              Text(
                "Coverage Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...coverageOptions.map((option) {
                final isSelected = selectedCoverage == option["id"];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: GestureDetector(
                    onTap: () {
                      selectedCoverage = option["id"] as String;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? (option["color"] as Color).withAlpha(25) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? option["color"] as Color : disabledOutlineBorderColor,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [shadowSm] : [],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: option["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  option["icon"] as IconData,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${option["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (option["recommended"] as bool) ...[
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: successColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "RECOMMENDED",
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      "${option["description"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((option["premium"] as double).toDouble()).currency}/mo",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: option["color"] as Color,
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: option["color"] as Color,
                                      size: 20,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),

                          // Coverage Details
                          Text(
                            "What's included:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          ...(option["coverage"] as List).map((coverage) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    size: 14,
                                    color: option["color"] as Color,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "$coverage",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              // Premium Calculator Result
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [successColor, successColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Text(
                      "Your Estimated Premium",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((calculatePremium()).toDouble()).currency}/month",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${selectedCoverageData["name"]} with \$${selectedDeductible} deductible",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Get Quote",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Vehicle Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vehicle Information",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Manage your insured vehicles",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Current Vehicle
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.directions_car,
                            color: primaryColor,
                            size: 32,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${vehicleInfo[0]["year"]} ${vehicleInfo[0]["make"]} ${vehicleInfo[0]["model"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "VIN: ${vehicleInfo[0]["vin"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Estimated Value: \$${((vehicleInfo[0]["value"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: primaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Vehicle Details
              Text(
                "Vehicle Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Make",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${vehicleInfo[0]["make"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Model",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${vehicleInfo[0]["model"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
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
                                "Year",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${vehicleInfo[0]["year"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((vehicleInfo[0]["value"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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

              // Safety Features
              Text(
                "Safety Features",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    ...["Anti-lock Braking System (ABS)", "Electronic Stability Control", "Airbags (Front & Side)", "Backup Camera", "Blind Spot Monitoring"].map((feature) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Discount",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Add Vehicle Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add Another Vehicle",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),

        // Claims Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Claims History",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Track your insurance claims and file new ones",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // File New Claim Button
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "File a New Claim",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Get help quickly when you need it most",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "File Claim",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Recent Claims
              Text(
                "Recent Claims",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              if (claimsHistory.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 48,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No Claims Filed",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "You haven't filed any claims yet. We hope it stays that way!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...claimsHistory.map((claim) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            claim["icon"] as IconData,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${claim["type"]}",
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
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${claim["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Filed on ${DateTime.parse(claim["date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Amount: \$${((claim["amount"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }).toList(),

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
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.phone,
                            color: primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "24/7 Support",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Get help anytime",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.build,
                            color: primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Find Repair Shop",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Certified mechanics",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
