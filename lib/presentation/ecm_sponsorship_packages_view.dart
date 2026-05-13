import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSponsorshipPackagesView extends StatefulWidget {
  const EcmSponsorshipPackagesView({super.key});

  @override
  State<EcmSponsorshipPackagesView> createState() => _EcmSponsorshipPackagesViewState();
}

class _EcmSponsorshipPackagesViewState extends State<EcmSponsorshipPackagesView> {
  String selectedPackage = "";
  bool showComparison = false;

  List<Map<String, dynamic>> packages = [
    {
      "id": 1,
      "name": "Platinum Sponsor",
      "tier": "Platinum",
      "price": 50000.0,
      "duration": "12 months",
      "popularity": "Most Popular",
      "color": Color(0xFF8E44AD),
      "description": "Maximum visibility and premium benefits for your brand",
      "features": [
        "Logo on all event materials",
        "Premium exhibition booth (20x20ft)",
        "5 complimentary delegate passes",
        "Opening ceremony speaking slot",
        "Networking lunch sponsorship",
        "Mobile app banner advertising",
        "Social media promotion",
        "Press release mentions",
        "VIP hospitality suite access",
        "Post-event attendee list"
      ],
      "benefits": [
        "Maximum brand exposure",
        "Lead generation opportunities",
        "Industry networking",
        "Thought leadership positioning"
      ],
      "deliverables": [
        "Logo placement within 48 hours",
        "Booth setup 1 week before event",
        "Speaking slot confirmation",
        "Marketing material inclusion"
      ],
      "isActive": true,
      "currentSponsors": 2,
      "maxSponsors": 3,
    },
    {
      "id": 2,
      "name": "Gold Sponsor",
      "tier": "Gold",
      "price": 30000.0,
      "duration": "12 months",
      "popularity": "Recommended",
      "color": Color(0xFFFFD700),
      "description": "Excellent visibility with premium benefits",
      "features": [
        "Logo on key marketing materials",
        "Standard exhibition booth (15x15ft)",
        "3 complimentary delegate passes",
        "Panel discussion opportunity",
        "Coffee break sponsorship",
        "Mobile app listing",
        "Website promotion",
        "Email campaign inclusion",
        "Networking event access"
      ],
      "benefits": [
        "Strong brand visibility",
        "Networking opportunities",
        "Market positioning",
        "Customer engagement"
      ],
      "deliverables": [
        "Logo placement within 72 hours",
        "Booth confirmation 2 weeks prior",
        "Speaking opportunity scheduling",
        "Promotional material review"
      ],
      "isActive": true,
      "currentSponsors": 4,
      "maxSponsors": 5,
    },
    {
      "id": 3,
      "name": "Silver Sponsor",
      "tier": "Silver",
      "price": 15000.0,
      "duration": "12 months",
      "popularity": "Value Pack",
      "color": Color(0xFFC0C0C0),
      "description": "Great value package with solid benefits",
      "features": [
        "Logo on selected materials",
        "Exhibition booth (10x10ft)",
        "2 complimentary delegate passes",
        "Poster session opportunity",
        "Website listing",
        "Digital program inclusion",
        "Networking access"
      ],
      "benefits": [
        "Brand recognition",
        "Industry presence",
        "Lead generation",
        "Cost-effective exposure"
      ],
      "deliverables": [
        "Logo placement within 1 week",
        "Booth allocation confirmation",
        "Digital asset preparation",
        "Program listing inclusion"
      ],
      "isActive": true,
      "currentSponsors": 6,
      "maxSponsors": 8,
    },
    {
      "id": 4,
      "name": "Bronze Sponsor",
      "tier": "Bronze",
      "price": 8000.0,
      "duration": "12 months",
      "popularity": "Starter",
      "color": Color(0xFFCD7F32),
      "description": "Entry-level sponsorship with essential benefits",
      "features": [
        "Logo on website",
        "Small exhibition space (8x8ft)",
        "1 complimentary delegate pass",
        "Digital program listing",
        "Basic networking access"
      ],
      "benefits": [
        "Brand visibility",
        "Industry participation",
        "Networking start",
        "Budget-friendly option"
      ],
      "deliverables": [
        "Website logo placement",
        "Space allocation",
        "Digital listing setup",
        "Pass distribution"
      ],
      "isActive": true,
      "currentSponsors": 8,
      "maxSponsors": 12,
    },
    {
      "id": 5,
      "name": "Digital Sponsor",
      "tier": "Digital",
      "price": 5000.0,
      "duration": "12 months",
      "popularity": "Online Focus",
      "color": Color(0xFF3498DB),
      "description": "Digital-first sponsorship for online engagement",
      "features": [
        "Mobile app advertising",
        "Social media promotion",
        "Email signature inclusion",
        "Virtual booth access",
        "Digital networking tools",
        "Webinar promotion"
      ],
      "benefits": [
        "Digital reach",
        "Online engagement",
        "Tech-savvy audience",
        "Measurable ROI"
      ],
      "deliverables": [
        "Digital asset setup",
        "App integration",
        "Social media calendar",
        "Virtual space configuration"
      ],
      "isActive": true,
      "currentSponsors": 5,
      "maxSponsors": 10,
    },
  ];

  List<Map<String, dynamic>> addOns = [
    {
      "name": "Premium Catering Sponsorship",
      "price": 5000.0,
      "description": "Sponsor VIP dining experience",
      "included": false,
    },
    {
      "name": "Welcome Reception Sponsor",
      "price": 8000.0,
      "description": "Exclusive welcome event sponsorship",
      "included": false,
    },
    {
      "name": "Keynote Speaker Introduction",
      "price": 3000.0,
      "description": "Introduce main keynote speaker",
      "included": false,
    },
    {
      "name": "Mobile App Push Notifications",
      "price": 2000.0,
      "description": "Send branded push notifications",
      "included": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sponsorship Packages"),
        actions: [
          IconButton(
            icon: Icon(showComparison ? Icons.grid_view : Icons.compare_arrows),
            onPressed: () {
              showComparison = !showComparison;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: spMd),
            showComparison ? _buildComparisonView() : _buildPackageGrid(),
            SizedBox(height: spMd),
            _buildAddOns(),
            SizedBox(height: spMd),
            _buildCustomPackageOption(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(100), primaryColor.withAlpha(50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Text(
            "Choose Your Sponsorship Level",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Maximize your brand exposure and connect with industry leaders",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHeaderStat("Active Packages", "${packages.where((p) => p["isActive"]).length}"),
              _buildHeaderStat("Total Sponsors", "${packages.fold(0, (sum, p) => sum + (p["currentSponsors"] as int))}"),
              _buildHeaderStat("Available Spots", "${packages.fold(0, (sum, p) => sum + ((p["maxSponsors"] as int) - (p["currentSponsors"] as int)))}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withAlpha(180),
          ),
        ),
      ],
    );
  }

  Widget _buildPackageGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: packages.map((package) {
        bool isSelected = selectedPackage == package["name"];
        double availability = (package["currentSponsors"] as int) / (package["maxSponsors"] as int);

        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: package["color"].withAlpha(100),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusMd),
                    topRight: Radius.circular(radiusMd),
                  ),
                ),
                child: Column(
                  children: [
                    if (package["popularity"] != "")
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${package["popularity"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: package["color"],
                          ),
                        ),
                      ),
                    SizedBox(height: spXs),
                    Text(
                      "${package["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((package["price"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${package["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${package["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    _buildAvailabilityBar(availability, package["currentSponsors"], package["maxSponsors"]),
                    SizedBox(height: spSm),
                    Text(
                      "Key Features:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(package["features"] as List).take(3).map((feature) {
                      return Row(
                        children: [
                          Icon(Icons.check, color: successColor, size: 14),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "$feature",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    if ((package["features"] as List).length > 3)
                      Text(
                        "+${(package["features"] as List).length - 3} more features",
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: isSelected ? "Selected" : "Select Package",
                        size: bs.sm,
                        onPressed: availability < 1.0 ? () {
                          selectedPackage = package["name"];
                          setState(() {});
                          ss("Selected ${package["name"]} package");
                        } : null,
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

  Widget _buildAvailabilityBar(double availability, int current, int max) {
    Color barColor = availability < 0.5 ? successColor : 
                     availability < 0.8 ? warningColor : dangerColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Availability:",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "$current/$max taken",
              style: TextStyle(
                fontSize: 11,
                color: barColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: availability,
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                "Features",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            ...packages.map((package) {
              return DataColumn(
                label: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${package["tier"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: package["color"],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "\$${((package["price"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
          rows: [
            _buildComparisonRow("Exhibition Booth", ["20x20ft", "15x15ft", "10x10ft", "8x8ft", "Virtual"]),
            _buildComparisonRow("Delegate Passes", ["5", "3", "2", "1", "Digital"]),
            _buildComparisonRow("Speaking Opportunity", ["Opening Ceremony", "Panel Discussion", "Poster Session", "-", "Webinar"]),
            _buildComparisonRow("Logo Placement", ["All Materials", "Key Materials", "Selected", "Website Only", "Digital Only"]),
            _buildComparisonRow("Networking Access", ["VIP Suite", "Premium", "Standard", "Basic", "Virtual"]),
          ],
        ),
      ),
    );
  }

  DataRow _buildComparisonRow(String feature, List<String> values) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            feature,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
              fontSize: 12,
            ),
          ),
        ),
        ...values.map((value) {
          return DataCell(
            Text(
              value,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAddOns() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Sponsorship Opportunities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...addOns.map((addon) {
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: secondaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: secondaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${addon["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${addon["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${((addon["price"] as double) / 1000).toStringAsFixed(0)}K",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Add",
                    size: bs.sm,
                    onPressed: () {
                      ss("Added ${addon["name"]} to package");
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCustomPackageOption() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [secondaryColor.withAlpha(100), secondaryColor.withAlpha(50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Icon(
            Icons.build,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            "Need a Custom Package?",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "We can create a tailored sponsorship package that meets your specific needs and budget",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Request Custom Package",
              size: bs.md,
              onPressed: () {
                ss("Requesting custom sponsorship package");
              },
            ),
          ),
        ],
      ),
    );
  }
}
