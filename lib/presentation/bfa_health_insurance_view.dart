import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaHealthInsuranceView extends StatefulWidget {
  const BfaHealthInsuranceView({super.key});

  @override
  State<BfaHealthInsuranceView> createState() => _BfaHealthInsuranceViewState();
}

class _BfaHealthInsuranceViewState extends State<BfaHealthInsuranceView> {
  int currentTab = 0;
  String selectedPlan = "individual";
  int familySize = 1;
  String selectedNetwork = "ppo";
  double deductible = 2500;
  bool includeDental = true;
  bool includeVision = true;

  List<Map<String, dynamic>> healthPlans = [
    {
      "id": "bronze",
      "name": "Bronze Plan",
      "description": "Basic coverage with lower premiums",
      "premium": 180.0,
      "deductible": 6000,
      "outOfPocketMax": 8000,
      "coinsurance": 40,
      "color": Colors.orange,
      "icon": Icons.shield,
      "coverageLevel": "60%",
      "benefits": [
        "Emergency care",
        "Preventive care",
        "Prescription drugs",
        "Mental health services"
      ]
    },
    {
      "id": "silver",
      "name": "Silver Plan",
      "description": "Balanced coverage and costs",
      "premium": 280.0,
      "deductible": 4000,
      "outOfPocketMax": 6000,
      "coinsurance": 30,
      "color": Colors.grey,
      "icon": Icons.favorite,
      "coverageLevel": "70%",
      "benefits": [
        "All Bronze benefits",
        "Specialist visits",
        "Maternity care",
        "Rehabilitation services"
      ]
    },
    {
      "id": "gold",
      "name": "Gold Plan",
      "description": "Comprehensive coverage with higher premiums",
      "premium": 380.0,
      "deductible": 2000,
      "outOfPocketMax": 4000,
      "coinsurance": 20,
      "color": Colors.amber,
      "icon": Icons.star,
      "coverageLevel": "80%",
      "benefits": [
        "All Silver benefits",
        "Lower deductibles",
        "More specialist coverage",
        "Advanced imaging"
      ]
    },
    {
      "id": "platinum",
      "name": "Platinum Plan",
      "description": "Premium coverage with lowest out-of-pocket costs",
      "premium": 480.0,
      "deductible": 1000,
      "outOfPocketMax": 2000,
      "coinsurance": 10,
      "color": Colors.purple,
      "icon": Icons.diamond,
      "coverageLevel": "90%",
      "benefits": [
        "All Gold benefits",
        "Lowest deductibles",
        "Maximum coverage",
        "Premium providers"
      ]
    },
  ];

  List<Map<String, dynamic>> networkProviders = [
    {
      "name": "City General Hospital",
      "specialty": "General Medicine",
      "rating": 4.8,
      "distance": "2.1 miles",
      "accepting": true,
      "icon": Icons.local_hospital
    },
    {
      "name": "Heart Care Specialists",
      "specialty": "Cardiology",
      "rating": 4.9,
      "distance": "3.5 miles",
      "accepting": true,
      "icon": Icons.favorite
    },
    {
      "name": "Family Practice Center",
      "specialty": "Family Medicine",
      "rating": 4.7,
      "distance": "1.8 miles",
      "accepting": true,
      "icon": Icons.family_restroom
    },
    {
      "name": "Women's Health Clinic",
      "specialty": "Women's Health",
      "rating": 4.8,
      "distance": "4.2 miles",
      "accepting": true,
      "icon": Icons.pregnant_woman
    },
  ];

  Map<String, dynamic> get selectedPlanData {
    return healthPlans.firstWhere((plan) => plan["id"] == selectedPlan, orElse: () => healthPlans[1]);
  }

  double calculatePremium() {
    double basePremium = selectedPlanData["premium"] as double;
    
    // Family size multiplier
    if (familySize > 1) {
      basePremium *= (1 + (familySize - 1) * 0.8);
    }
    
    // Add-ons
    if (includeDental) basePremium += 45;
    if (includeVision) basePremium += 25;
    
    return basePremium;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Health Insurance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Plans", icon: Icon(Icons.medical_services)),
        Tab(text: "Network", icon: Icon(Icons.location_on)),
        Tab(text: "Coverage", icon: Icon(Icons.shield)),
      ],
      tabChildren: [
        // Plans Tab
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
                            "Your Health,",
                            style: TextStyle(
                              fontSize: fsH5,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Our Priority",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Comprehensive health insurance plans tailored to your needs",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.health_and_safety,
                      size: 60,
                      color: Colors.white.withAlpha(180),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Plan Customization
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
                      "Customize Your Plan",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    // Family Size
                    Text(
                      "Family Size: $familySize ${familySize == 1 ? 'person' : 'people'}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Slider(
                      value: familySize.toDouble(),
                      min: 1,
                      max: 6,
                      divisions: 5,
                      label: "$familySize",
                      activeColor: primaryColor,
                      onChanged: (value) {
                        familySize = value.toInt();
                        setState(() {});
                      },
                    ),

                    SizedBox(height: spMd),

                    // Add-ons
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: includeDental,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  includeDental = value ?? false;
                                  setState(() {});
                                },
                              ),
                              Text(
                                "Dental (+\$45/mo)",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: includeVision,
                                activeColor: primaryColor,
                                onChanged: (value) {
                                  includeVision = value ?? false;
                                  setState(() {});
                                },
                              ),
                              Text(
                                "Vision (+\$25/mo)",
                                style: TextStyle(
                                  fontSize: 14,
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

              // Health Plans
              Text(
                "Available Health Plans",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...healthPlans.map((plan) {
                final isSelected = selectedPlan == plan["id"];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: GestureDetector(
                    onTap: () {
                      selectedPlan = plan["id"] as String;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isSelected ? (plan["color"] as Color).withAlpha(25) : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? plan["color"] as Color : disabledOutlineBorderColor,
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
                                  color: plan["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  plan["icon"] as IconData,
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
                                          "${plan["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: plan["color"] as Color,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${plan["coverageLevel"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${plan["description"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: plan["color"] as Color,
                                  size: 24,
                                ),
                            ],
                          ),
                          SizedBox(height: spMd),

                          // Plan Details
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Monthly Premium",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((plan["premium"] as double).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: plan["color"] as Color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Deductible",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((plan["deductible"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Out-of-Pocket Max",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((plan["outOfPocketMax"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spMd),

                          // Benefits
                          Text(
                            "Covered Benefits:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (plan["benefits"] as List).map((benefit) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (plan["color"] as Color).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: (plan["color"] as Color).withAlpha(100),
                                  ),
                                ),
                                child: Text(
                                  "$benefit",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: plan["color"] as Color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              // Estimated Total
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
                      "Estimated Monthly Cost",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((calculatePremium()).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Includes ${selectedPlanData["name"]}${includeDental ? ', Dental' : ''}${includeVision ? ', Vision' : ''}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Enroll Now",
                      size: bs.md,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Network Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Provider Network",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Find healthcare providers in your area",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Search providers...",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),

              SizedBox(height: spLg),

              // Network Summary
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.network_check,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "15,000+ Providers",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "In your selected network area",
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
              ),

              SizedBox(height: spLg),

              Text(
                "Nearby Providers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              // Provider List
              ...networkProviders.map((provider) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          provider["icon"] as IconData,
                          color: primaryColor,
                          size: 28,
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
                                    "${provider["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (provider["accepting"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "Accepting",
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
                              "${provider["specialty"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${provider["rating"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${provider["distance"]}",
                                  style: TextStyle(
                                    fontSize: 13,
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
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.phone,
                                color: primaryColor,
                                size: 18,
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.all(spXs),
                              constraints: BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.directions,
                                color: primaryColor,
                                size: 18,
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.all(spXs),
                              constraints: BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        // Coverage Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coverage Details",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Understanding your health insurance benefits",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spLg),

              // Current Plan Summary
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Selection",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${selectedPlanData["name"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Coverage Level",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                              Text(
                                "${selectedPlanData["coverageLevel"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                                "Monthly Premium",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(230),
                                ),
                              ),
                              Text(
                                "\$${((calculatePremium()).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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

              // Coverage Categories
              ...["Emergency Care", "Preventive Care", "Prescription Drugs", "Mental Health", "Maternity Care"].map((category) {
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Covered under your plan",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${selectedPlanData["coinsurance"]}% after deductible",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Key Terms
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Understanding Your Plan",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    ...["Deductible: Amount you pay before insurance kicks in", 
                        "Coinsurance: Your share of costs after deductible",
                        "Out-of-pocket max: Maximum you'll pay in a year",
                        "Premium: Monthly payment for your coverage"].map((term) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                term,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
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
            ],
          ),
        ),
      ],
    );
  }
}
