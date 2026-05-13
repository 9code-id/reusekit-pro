import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaContractorDirectoryView extends StatefulWidget {
  const ComaContractorDirectoryView({Key? key}) : super(key: key);

  @override
  State<ComaContractorDirectoryView> createState() => _ComaContractorDirectoryViewState();
}

class _ComaContractorDirectoryViewState extends State<ComaContractorDirectoryView> {
  String selectedCategory = "all";
  String selectedRating = "all";
  String selectedLocation = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "General Contractor", "value": "general"},
    {"label": "Electrical", "value": "electrical"},
    {"label": "Plumbing", "value": "plumbing"},
    {"label": "HVAC", "value": "hvac"},
    {"label": "Carpentry", "value": "carpentry"},
    {"label": "Concrete", "value": "concrete"},
    {"label": "Roofing", "value": "roofing"},
    {"label": "Landscaping", "value": "landscaping"},
  ];

  List<Map<String, dynamic>> ratingFilters = [
    {"label": "All Ratings", "value": "all"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4+ Stars", "value": "4"},
    {"label": "3+ Stars", "value": "3"},
    {"label": "2+ Stars", "value": "2"},
    {"label": "1+ Stars", "value": "1"},
  ];

  List<Map<String, dynamic>> locationFilters = [
    {"label": "All Locations", "value": "all"},
    {"label": "Seattle, WA", "value": "seattle"},
    {"label": "Portland, OR", "value": "portland"},
    {"label": "San Francisco, CA", "value": "san_francisco"},
    {"label": "Denver, CO", "value": "denver"},
    {"label": "Phoenix, AZ", "value": "phoenix"},
  ];

  List<Map<String, dynamic>> contractors = [
    {
      "id": "CON-001",
      "company_name": "Elite Construction Group",
      "category": "general",
      "location": "seattle",
      "address": "1234 Construction Ave, Seattle, WA 98101",
      "phone": "+1-555-0123",
      "email": "info@eliteconstruction.com",
      "website": "www.eliteconstruction.com",
      "contact_person": "John Smith",
      "contact_title": "Project Manager",
      "rating": 4.8,
      "total_reviews": 156,
      "years_experience": 25,
      "license_number": "GC-2024-001",
      "license_expiry": "2025-12-31",
      "insurance_coverage": 5000000.0,
      "bonding_capacity": 10000000.0,
      "services": ["New Construction", "Renovation", "Project Management", "Design-Build"],
      "specializations": ["Commercial Buildings", "Residential Complexes", "Industrial Projects"],
      "certifications": ["LEED Certified", "OSHA 30", "Green Building Council"],
      "project_types": ["Office Buildings", "Retail Centers", "Hospitals", "Schools"],
      "service_area": ["Seattle", "Tacoma", "Bellevue", "Spokane"],
      "employees": 85,
      "established_year": 1999,
      "portfolio_projects": [
        {"name": "Seattle Medical Center", "type": "Healthcare", "value": 15000000.0, "year": 2023},
        {"name": "Downtown Office Complex", "type": "Commercial", "value": 25000000.0, "year": 2022},
        {"name": "Residential Tower", "type": "Residential", "value": 18000000.0, "year": 2024},
      ],
      "recent_reviews": [
        {"rating": 5, "comment": "Excellent work quality and on-time delivery", "date": "2024-06-10"},
        {"rating": 4, "comment": "Professional team, minor communication issues", "date": "2024-05-20"},
        {"rating": 5, "comment": "Outstanding project management", "date": "2024-05-15"},
      ],
      "safety_record": {
        "incident_rate": 0.2,
        "safety_score": 98,
        "last_inspection": "2024-06-01",
        "certifications": ["OSHA 30", "Safety Plus"]
      },
      "financial_info": {
        "annual_revenue": 50000000.0,
        "payment_terms": "Net 30",
        "credit_rating": "A+",
        "bonded": true
      },
      "featured": true,
      "verified": true,
    },
    {
      "id": "CON-002",
      "company_name": "Pacific Northwest Electric",
      "category": "electrical",
      "location": "portland",
      "address": "5678 Electric Blvd, Portland, OR 97201",
      "phone": "+1-555-0456",
      "email": "contact@pnwelectric.com",
      "website": "www.pnwelectric.com",
      "contact_person": "Sarah Johnson",
      "contact_title": "Operations Manager",
      "rating": 4.6,
      "total_reviews": 89,
      "years_experience": 18,
      "license_number": "ELC-2024-002",
      "license_expiry": "2025-08-15",
      "insurance_coverage": 3000000.0,
      "bonding_capacity": 5000000.0,
      "services": ["Electrical Installation", "Maintenance", "Emergency Repairs", "Upgrades"],
      "specializations": ["Industrial Electrical", "Solar Systems", "Smart Building Technology"],
      "certifications": ["Master Electrician", "Solar Installation", "Energy Efficiency"],
      "project_types": ["Industrial Plants", "Commercial Buildings", "Renewable Energy"],
      "service_area": ["Portland", "Salem", "Eugene", "Bend"],
      "employees": 42,
      "established_year": 2006,
      "portfolio_projects": [
        {"name": "Manufacturing Plant Electrical", "type": "Industrial", "value": 3500000.0, "year": 2023},
        {"name": "Solar Farm Installation", "type": "Renewable", "value": 5200000.0, "year": 2022},
        {"name": "Office Building Upgrade", "type": "Commercial", "value": 1800000.0, "year": 2024},
      ],
      "recent_reviews": [
        {"rating": 5, "comment": "Expert installation of solar systems", "date": "2024-06-05"},
        {"rating": 4, "comment": "Reliable and professional service", "date": "2024-05-25"},
        {"rating": 5, "comment": "Excellent emergency response time", "date": "2024-05-10"},
      ],
      "safety_record": {
        "incident_rate": 0.1,
        "safety_score": 96,
        "last_inspection": "2024-05-15",
        "certifications": ["NECA Safety", "OSHA 10"]
      },
      "financial_info": {
        "annual_revenue": 12000000.0,
        "payment_terms": "Net 15",
        "credit_rating": "A",
        "bonded": true
      },
      "featured": false,
      "verified": true,
    },
    {
      "id": "CON-003",
      "company_name": "Golden Gate Plumbing",
      "category": "plumbing",
      "location": "san_francisco",
      "address": "9012 Plumber's Way, San Francisco, CA 94105",
      "phone": "+1-555-0789",
      "email": "info@ggplumbing.com",
      "website": "www.goldengoteplumbing.com",
      "contact_person": "Michael Chen",
      "contact_title": "Master Plumber",
      "rating": 4.9,
      "total_reviews": 203,
      "years_experience": 22,
      "license_number": "PLB-2024-003",
      "license_expiry": "2025-10-20",
      "insurance_coverage": 2500000.0,
      "bonding_capacity": 3000000.0,
      "services": ["Commercial Plumbing", "Pipe Installation", "Hydro Jetting", "Leak Detection"],
      "specializations": ["High-Rise Buildings", "Medical Gas Systems", "Green Plumbing"],
      "certifications": ["Master Plumber", "Medical Gas Installer", "Backflow Prevention"],
      "project_types": ["Hospitals", "High-Rise Buildings", "Hotels", "Restaurants"],
      "service_area": ["San Francisco", "Oakland", "San Jose", "Sacramento"],
      "employees": 28,
      "established_year": 2002,
      "portfolio_projects": [
        {"name": "SF General Hospital Plumbing", "type": "Healthcare", "value": 4200000.0, "year": 2023},
        {"name": "Luxury Hotel Renovation", "type": "Hospitality", "value": 2800000.0, "year": 2022},
        {"name": "Tech Campus Plumbing", "type": "Commercial", "value": 3600000.0, "year": 2024},
      ],
      "recent_reviews": [
        {"rating": 5, "comment": "Best plumbing contractor in the bay area", "date": "2024-06-08"},
        {"rating": 5, "comment": "Exceptional work on our hospital project", "date": "2024-05-30"},
        {"rating": 4, "comment": "Professional and reliable team", "date": "2024-05-18"},
      ],
      "safety_record": {
        "incident_rate": 0.05,
        "safety_score": 99,
        "last_inspection": "2024-06-01",
        "certifications": ["OSHA 30", "Confined Space"]
      },
      "financial_info": {
        "annual_revenue": 18000000.0,
        "payment_terms": "Net 20",
        "credit_rating": "A+",
        "bonded": true
      },
      "featured": true,
      "verified": true,
    },
    {
      "id": "CON-004",
      "company_name": "Rocky Mountain HVAC",
      "category": "hvac",
      "location": "denver",
      "address": "3456 Climate Drive, Denver, CO 80201",
      "phone": "+1-555-0321",
      "email": "service@rmhvac.com",
      "website": "www.rockymountainhvac.com",
      "contact_person": "David Wilson",
      "contact_title": "Service Manager",
      "rating": 4.4,
      "total_reviews": 67,
      "years_experience": 15,
      "license_number": "HVAC-2024-004",
      "license_expiry": "2025-09-30",
      "insurance_coverage": 2000000.0,
      "bonding_capacity": 2500000.0,
      "services": ["HVAC Installation", "Maintenance", "Energy Audits", "Controls Systems"],
      "specializations": ["Energy Efficient Systems", "Smart Controls", "Geothermal Systems"],
      "certifications": ["NATE Certified", "EPA 608", "Energy Star Partner"],
      "project_types": ["Office Buildings", "Schools", "Retail Centers", "Manufacturing"],
      "service_area": ["Denver", "Boulder", "Fort Collins", "Colorado Springs"],
      "employees": 35,
      "established_year": 2009,
      "portfolio_projects": [
        {"name": "University HVAC Upgrade", "type": "Education", "value": 2100000.0, "year": 2023},
        {"name": "Shopping Center Climate", "type": "Retail", "value": 1500000.0, "year": 2022},
        {"name": "Office Building HVAC", "type": "Commercial", "value": 1800000.0, "year": 2024},
      ],
      "recent_reviews": [
        {"rating": 4, "comment": "Good work, on schedule delivery", "date": "2024-06-01"},
        {"rating": 5, "comment": "Energy efficient solutions saved us money", "date": "2024-05-22"},
        {"rating": 4, "comment": "Professional installation team", "date": "2024-05-12"},
      ],
      "safety_record": {
        "incident_rate": 0.3,
        "safety_score": 94,
        "last_inspection": "2024-05-20",
        "certifications": ["OSHA 10", "Refrigerant Handling"]
      },
      "financial_info": {
        "annual_revenue": 8500000.0,
        "payment_terms": "Net 30",
        "credit_rating": "B+",
        "bonded": true
      },
      "featured": false,
      "verified": true,
    },
    {
      "id": "CON-005",
      "company_name": "Desert Foundation Works",
      "category": "concrete",
      "location": "phoenix",
      "address": "7890 Foundation Rd, Phoenix, AZ 85001",
      "phone": "+1-555-0654",
      "email": "projects@desertfoundation.com",
      "website": "www.desertfoundationworks.com",
      "contact_person": "Carlos Rivera",
      "contact_title": "Project Supervisor",
      "rating": 4.2,
      "total_reviews": 41,
      "years_experience": 12,
      "license_number": "CON-2024-005",
      "license_expiry": "2024-12-15",
      "insurance_coverage": 1800000.0,
      "bonding_capacity": 2000000.0,
      "services": ["Foundation Work", "Concrete Pouring", "Decorative Concrete", "Repairs"],
      "specializations": ["Large Scale Foundations", "Decorative Finishes", "Precast Systems"],
      "certifications": ["ACI Certified", "Concrete Finisher", "Safety Training"],
      "project_types": ["Foundations", "Parking Structures", "Warehouses", "Residential"],
      "service_area": ["Phoenix", "Tucson", "Mesa", "Scottsdale"],
      "employees": 22,
      "established_year": 2012,
      "portfolio_projects": [
        {"name": "Warehouse Foundation", "type": "Industrial", "value": 980000.0, "year": 2023},
        {"name": "Shopping Center Parking", "type": "Commercial", "value": 1200000.0, "year": 2022},
        {"name": "Residential Complex Foundation", "type": "Residential", "value": 750000.0, "year": 2024},
      ],
      "recent_reviews": [
        {"rating": 4, "comment": "Solid foundation work, no issues", "date": "2024-05-28"},
        {"rating": 4, "comment": "Good quality concrete finishing", "date": "2024-05-15"},
        {"rating": 4, "comment": "Reliable and on time", "date": "2024-05-08"},
      ],
      "safety_record": {
        "incident_rate": 0.4,
        "safety_score": 92,
        "last_inspection": "2024-05-10",
        "certifications": ["OSHA 10", "Fall Protection"]
      },
      "financial_info": {
        "annual_revenue": 5200000.0,
        "payment_terms": "Net 45",
        "credit_rating": "B",
        "bonded": true
      },
      "featured": false,
      "verified": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contractor Directory"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addNewContractor(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.map,
            size: bs.sm,
            onPressed: () => _showContractorMap(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildDirectoryOverview(),
                  _buildFilters(),
                  _buildFeaturedContractors(),
                  _buildContractorsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildDirectoryOverview() {
    int totalContractors = contractors.length;
    int verifiedContractors = contractors.where((c) => c["verified"] == true).length;
    int featuredContractors = contractors.where((c) => c["featured"] == true).length;
    double avgRating = contractors.fold(0.0, (sum, c) => sum + (c["rating"] as double)) / contractors.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.business_center, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Contractor Directory Overview",
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
              _buildOverviewCard("Total", "$totalContractors", Icons.business, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Verified", "$verifiedContractors", Icons.verified, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Featured", "$featuredContractors", Icons.star, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Avg Rating", "${avgRating.toStringAsFixed(1)}", Icons.star_rate, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search contractors...",
                  value: searchQuery,
                  hint: "Search by company name, services, or location",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () => _showAdvancedFilters(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryFilters,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Rating",
                  items: ratingFilters,
                  value: selectedRating,
                  onChanged: (value, label) {
                    selectedRating = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locationFilters,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedContractors() {
    List<Map<String, dynamic>> featuredContractors = contractors.where((c) => c["featured"] == true).toList();

    if (featuredContractors.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Featured Contractors",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          height: 180,
          child: QHorizontalScroll(
            children: featuredContractors.map((contractor) => _buildFeaturedCard(contractor)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(Map<String, dynamic> contractor) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: warningColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "FEATURED",
                  style: TextStyle(
                    fontSize: 9,
                    color: warningColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              if (contractor["verified"] == true)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "VERIFIED",
                    style: TextStyle(
                      fontSize: 9,
                      color: successColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            "${contractor["company_name"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${contractor["category"]}".toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, color: warningColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${contractor["rating"]} (${contractor["total_reviews"]} reviews)",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "${contractor["years_experience"]} years experience",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "${(contractor["services"] as List).take(2).join(", ")}${(contractor["services"] as List).length > 2 ? "..." : ""}",
            style: TextStyle(
              fontSize: 11,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractorsList() {
    List<Map<String, dynamic>> filteredContractors = _getFilteredContractors();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "All Contractors (${filteredContractors.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredContractors.map((contractor) => _buildContractorCard(contractor)),
      ],
    );
  }

  Widget _buildContractorCard(Map<String, dynamic> contractor) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: contractor["featured"] == true
            ? Border.all(color: warningColor.withAlpha(50), width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${contractor["company_name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        if (contractor["featured"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "FEATURED",
                              style: TextStyle(
                                fontSize: 9,
                                color: warningColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (contractor["verified"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "VERIFIED",
                              style: TextStyle(
                                fontSize: 9,
                                color: successColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${contractor["category"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${contractor["rating"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " (${contractor["total_reviews"]})",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${contractor["contact_person"]} - ${contractor["contact_title"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${contractor["address"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${contractor["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.email, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${contractor["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Services: ${(contractor["services"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Specializations: ${(contractor["specializations"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Service Area: ${(contractor["service_area"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Experience: ${contractor["years_experience"]} years",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Employees: ${contractor["employees"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "License: ${contractor["license_number"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Established: ${contractor["established_year"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Insurance: \$${((contractor["insurance_coverage"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if ((contractor["certifications"] as List).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Certifications:",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "${(contractor["certifications"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 11,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Text(
                "Safety Score: ${contractor["safety_record"]["safety_score"]}%",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "Annual Revenue: \$${((contractor["financial_info"]["annual_revenue"] as double) / 1000000).toStringAsFixed(1)}M",
                style: TextStyle(
                  fontSize: 12,
                  color: infoColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Website: ${contractor["website"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewContractorProfile(contractor["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.contact_phone,
                size: bs.sm,
                onPressed: () => _contactContractor(contractor),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showContractorOptions(contractor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredContractors() {
    List<Map<String, dynamic>> filtered = contractors;

    if (selectedCategory != "all") {
      filtered = filtered.where((contractor) => contractor["category"] == selectedCategory).toList();
    }

    if (selectedRating != "all") {
      double minRating = double.parse(selectedRating);
      filtered = filtered.where((contractor) => (contractor["rating"] as double) >= minRating).toList();
    }

    if (selectedLocation != "all") {
      filtered = filtered.where((contractor) => contractor["location"] == selectedLocation).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((contractor) =>
          contractor["company_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (contractor["services"] as List).any((service) => 
              service.toString().toLowerCase().contains(searchQuery.toLowerCase())) ||
          contractor["address"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  void _addNewContractor() {
    ss("Add new contractor to directory");
  }

  void _showContractorMap() {
    ss("Show contractor map view");
  }

  void _showAdvancedFilters() {
    ss("Advanced contractor filters");
  }

  void _showSortOptions() {
    ss("Contractor sort options");
  }

  void _viewContractorProfile(String contractorId) {
    ss("View contractor profile $contractorId");
  }

  void _contactContractor(Map<String, dynamic> contractor) {
    ss("Contact contractor ${contractor["company_name"]}");
  }

  void _showContractorOptions(Map<String, dynamic> contractor) {
    ss("Contractor options for ${contractor["company_name"]}");
  }
}
