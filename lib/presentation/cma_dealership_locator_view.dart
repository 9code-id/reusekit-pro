import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaDealershipLocatorView extends StatefulWidget {
  const CmaDealershipLocatorView({super.key});

  @override
  State<CmaDealershipLocatorView> createState() => _CmaDealershipLocatorViewState();
}

class _CmaDealershipLocatorViewState extends State<CmaDealershipLocatorView> {
  int currentTab = 0;
  String selectedRadius = "25 miles";
  String selectedBrand = "All Brands";
  String selectedServices = "All Services";
  String searchQuery = "";

  List<Map<String, dynamic>> dealershipData = [
    {
      "id": "DEAL-001",
      "name": "Premium Commercial Motors",
      "brand": "Ford",
      "address": "1500 Industrial Blvd, Detroit, MI 48201",
      "phone": "(313) 555-0101",
      "email": "sales@premiumcommercial.com",
      "distance": 2.3,
      "rating": 4.8,
      "reviewCount": 156,
      "isOpen": true,
      "hours": "8:00 AM - 7:00 PM",
      "services": ["Sales", "Service", "Parts", "Financing", "Leasing"],
      "specialties": ["Commercial Trucks", "Fleet Sales", "Box Trucks"],
      "certifications": ["Ford Certified", "Commercial Specialist"],
      "inventory": 85,
      "contactPerson": "Michael Rodriguez",
      "website": "www.premiumcommercial.com",
      "coordinates": {"lat": 42.3314, "lng": -83.0458}
    },
    {
      "id": "DEAL-002",
      "name": "Metro Fleet Solutions",
      "brand": "Chevrolet",
      "address": "2250 Commerce Dr, Troy, MI 48084",
      "phone": "(248) 555-0202",
      "email": "info@metrofleet.com",
      "distance": 5.7,
      "rating": 4.6,
      "reviewCount": 89,
      "isOpen": true,
      "hours": "7:30 AM - 6:30 PM",
      "services": ["Sales", "Service", "Parts", "Fleet Management"],
      "specialties": ["Delivery Vans", "Pickup Trucks", "Work Trucks"],
      "certifications": ["Chevrolet Commercial", "Fleet Certified"],
      "inventory": 62,
      "contactPerson": "Sarah Johnson",
      "website": "www.metrofleet.com",
      "coordinates": {"lat": 42.5803, "lng": -83.1498}
    },
    {
      "id": "DEAL-003",
      "name": "Highway Commercial Vehicles",
      "brand": "Ram",
      "address": "850 Automotive Way, Warren, MI 48089",
      "phone": "(586) 555-0303",
      "email": "sales@highwaycommercial.com",
      "distance": 8.1,
      "rating": 4.7,
      "reviewCount": 203,
      "isOpen": false,
      "hours": "Closed - Opens 8:00 AM",
      "services": ["Sales", "Service", "Parts", "Body Work"],
      "specialties": ["Heavy Duty Trucks", "Cargo Vans", "ProMaster"],
      "certifications": ["Ram Commercial", "Mopar Certified"],
      "inventory": 94,
      "contactPerson": "David Thompson",
      "website": "www.highwaycommercial.com",
      "coordinates": {"lat": 42.4834, "lng": -83.0277}
    },
    {
      "id": "DEAL-004",
      "name": "City Commercial Center",
      "brand": "Mercedes-Benz",
      "address": "1750 Luxury Lane, Birmingham, MI 48009",
      "phone": "(248) 555-0404",
      "email": "commercial@citymercedesbenz.com",
      "distance": 12.4,
      "rating": 4.9,
      "reviewCount": 127,
      "isOpen": true,
      "hours": "9:00 AM - 8:00 PM",
      "services": ["Sales", "Service", "Parts", "Financing", "Extended Warranty"],
      "specialties": ["Sprinter Vans", "Premium Commercial", "Luxury Fleet"],
      "certifications": ["Mercedes-Benz Certified", "Sprinter Specialist"],
      "inventory": 47,
      "contactPerson": "Lisa Chen",
      "website": "www.citymercedesbenz.com",
      "coordinates": {"lat": 42.5467, "lng": -83.2813}
    },
    {
      "id": "DEAL-005",
      "name": "Industrial Truck Sales",
      "brand": "Isuzu",
      "address": "3400 Heavy Equipment Rd, Pontiac, MI 48340",
      "phone": "(248) 555-0505",
      "email": "sales@industrialtruck.com",
      "distance": 15.2,
      "rating": 4.5,
      "reviewCount": 74,
      "isOpen": true,
      "hours": "8:00 AM - 6:00 PM",
      "services": ["Sales", "Service", "Parts", "Rentals"],
      "specialties": ["Box Trucks", "NPR Series", "Heavy Duty"],
      "certifications": ["Isuzu Commercial", "Heavy Truck Specialist"],
      "inventory": 38,
      "contactPerson": "Robert Martinez",
      "website": "www.industrialtruck.com",
      "coordinates": {"lat": 42.6389, "lng": -83.2910}
    },
    {
      "id": "DEAL-006",
      "name": "Fleet Direct Motors",
      "brand": "Multi-Brand",
      "address": "950 Fleet Ave, Dearborn, MI 48124",
      "phone": "(313) 555-0606",
      "email": "contact@fleetdirect.com",
      "distance": 18.9,
      "rating": 4.4,
      "reviewCount": 98,
      "isOpen": true,
      "hours": "8:30 AM - 7:30 PM",
      "services": ["Sales", "Trade-ins", "Fleet Consulting", "Financing"],
      "specialties": ["Used Commercial", "Fleet Liquidation", "Multi-Brand"],
      "certifications": ["Used Vehicle Certified", "Fleet Specialist"],
      "inventory": 156,
      "contactPerson": "Jennifer Wang",
      "website": "www.fleetdirect.com",
      "coordinates": {"lat": 42.3223, "lng": -83.1763}
    }
  ];

  List<Map<String, dynamic>> radiusItems = [
    {"label": "10 miles", "value": "10 miles"},
    {"label": "25 miles", "value": "25 miles"},
    {"label": "50 miles", "value": "50 miles"},
    {"label": "100 miles", "value": "100 miles"},
  ];

  List<Map<String, dynamic>> brandItems = [
    {"label": "All Brands", "value": "All Brands"},
    {"label": "Ford", "value": "Ford"},
    {"label": "Chevrolet", "value": "Chevrolet"},
    {"label": "Ram", "value": "Ram"},
    {"label": "Mercedes-Benz", "value": "Mercedes-Benz"},
    {"label": "Isuzu", "value": "Isuzu"},
    {"label": "Multi-Brand", "value": "Multi-Brand"},
  ];

  List<Map<String, dynamic>> serviceItems = [
    {"label": "All Services", "value": "All Services"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Service", "value": "Service"},
    {"label": "Parts", "value": "Parts"},
    {"label": "Financing", "value": "Financing"},
    {"label": "Leasing", "value": "Leasing"},
  ];

  List<Map<String, dynamic>> get filteredDealerships {
    return dealershipData.where((dealership) {
      if (selectedBrand != "All Brands" && dealership["brand"] != selectedBrand) return false;
      if (selectedServices != "All Services" && !(dealership["services"] as List).contains(selectedServices)) return false;
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        if (!dealership["name"].toString().toLowerCase().contains(query) &&
            !dealership["brand"].toString().toLowerCase().contains(query) &&
            !dealership["address"].toString().toLowerCase().contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  Widget _buildSearchTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          QTextField(
            label: "Search dealerships...",
            value: searchQuery,
            hint: "Name, brand, location",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Search Radius",
                  items: radiusItems,
                  value: selectedRadius,
                  onChanged: (value, label) {
                    selectedRadius = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Brand",
                  items: brandItems,
                  value: selectedBrand,
                  onChanged: (value, label) {
                    selectedBrand = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QDropdownField(
            label: "Services",
            items: serviceItems,
            value: selectedServices,
            onChanged: (value, label) {
              selectedServices = value;
              setState(() {});
            },
          ),

          // Results Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Found ${filteredDealerships.length} dealerships within $selectedRadius",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Dealership List
          ...filteredDealerships.map((dealership) => _buildDealershipCard(dealership)),
        ],
      ),
    );
  }

  Widget _buildMapTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Map Container
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 64, color: disabledBoldColor),
                  SizedBox(height: spSm),
                  Text(
                    "Interactive Map View",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Dealership locations would be displayed here",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            ),
          ),

          // Map Legend
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
                  "Map Legend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildLegendItem("Open Dealerships", successColor),
                _buildLegendItem("Closed Dealerships", disabledBoldColor),
                _buildLegendItem("Premium Dealers", warningColor),
                _buildLegendItem("Service Centers", infoColor),
              ],
            ),
          ),

          // Nearby Dealerships
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
                  "Nearest Dealerships",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...filteredDealerships.take(3).map((dealership) => _buildNearbyDealershipItem(dealership)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab() {
    final favoriteDealerships = filteredDealerships.where((d) => (d["rating"] as double) >= 4.7).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Favorites Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(Icons.star, color: warningColor),
                SizedBox(width: spSm),
                Text(
                  "Top Rated Dealerships (4.7+ stars)",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Favorite Dealerships
          ...favoriteDealerships.map((dealership) => _buildFavoriteDealershipCard(dealership)),

          if (favoriteDealerships.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(Icons.star_border, size: 64, color: disabledBoldColor),
                  SizedBox(height: spMd),
                  Text(
                    "No favorite dealerships yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Add dealerships to your favorites for quick access",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCompareTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Compare Instructions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(Icons.compare_arrows, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Select up to 3 dealerships to compare their services and ratings",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Comparison Table
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
                  "Dealership Comparison",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildComparisonTable(),
              ],
            ),
          ),

          // Comparison Analysis
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
                  "Comparison Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildAnalysisItem("Best Rating", "City Commercial Center", "4.9 stars", successColor),
                _buildAnalysisItem("Closest Location", "Premium Commercial Motors", "2.3 miles", infoColor),
                _buildAnalysisItem("Largest Inventory", "Fleet Direct Motors", "156 vehicles", warningColor),
                _buildAnalysisItem("Most Services", "Premium Commercial Motors", "5 services", primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealershipCard(Map<String, dynamic> dealership) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: dealership["isOpen"] ? successColor : disabledBoldColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${dealership["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${dealership["brand"]} • ${dealership["distance"]} miles",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${dealership["rating"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        " (${dealership["reviewCount"]})",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dealership["isOpen"] ? successColor : disabledBoldColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      dealership["isOpen"] ? "Open" : "Closed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${dealership["address"]}",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${dealership["phone"]}",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: spMd),
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${dealership["hours"]}",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (dealership["services"] as List).map((service) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Text(
                  "$service",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call Now",
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    ss("Calling ${dealership["name"]}...");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Directions",
                  icon: Icons.directions,
                  size: bs.sm,
                  onPressed: () {
                    ss("Opening directions to ${dealership["name"]}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteDealershipCard(Map<String, dynamic> dealership) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${dealership["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${dealership["rating"]} ★",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${dealership["brand"]} • ${dealership["distance"]} miles",
            style: TextStyle(color: disabledBoldColor),
          ),
          SizedBox(height: spSm),
          Text(
            "Contact: ${dealership["contactPerson"]}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () {
                    ss("Viewing details for ${dealership["name"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.star,
                size: bs.sm,
                onPressed: () {
                  ss("Added to favorites");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyDealershipItem(Map<String, dynamic> dealership) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: dealership["isOpen"] ? successColor : disabledBoldColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.store,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${dealership["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${dealership["distance"]} miles • ${dealership["brand"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.directions, color: infoColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    final topDealerships = filteredDealerships.take(3).toList();
    
    return Column(
      children: [
        // Header Row
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Expanded(child: Text("Dealership", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text("Rating", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text("Distance", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text("Inventory", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        SizedBox(height: spSm),
        // Data Rows
        ...topDealerships.map((dealership) {
          return Container(
            margin: EdgeInsets.only(bottom: spXs),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${dealership["name"]}",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${dealership["rating"]} ★",
                    style: TextStyle(fontSize: 12, color: warningColor),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${dealership["distance"]} mi",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${dealership["inventory"]}",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAnalysisItem(String title, String dealership, String value, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  dealership,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Dealership Locator",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Search", icon: Icon(Icons.search)),
        Tab(text: "Map", icon: Icon(Icons.map)),
        Tab(text: "Favorites", icon: Icon(Icons.star)),
        Tab(text: "Compare", icon: Icon(Icons.compare_arrows)),
      ],
      tabChildren: [
        _buildSearchTab(),
        _buildMapTab(),
        _buildFavoritesTab(),
        _buildCompareTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
