import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCommercialVehicleView extends StatefulWidget {
  const CmaCommercialVehicleView({super.key});

  @override
  State<CmaCommercialVehicleView> createState() => _CmaCommercialVehicleViewState();
}

class _CmaCommercialVehicleViewState extends State<CmaCommercialVehicleView> {
  int selectedTab = 0;
  String selectedType = "All";
  String searchQuery = "";
  String selectedBrand = "All";
  bool showFilters = false;

  List<Map<String, dynamic>> vehicles = [
    {
      "id": 1,
      "name": "Ford Transit 350",
      "brand": "Ford",
      "type": "Van",
      "price": 45900,
      "year": 2024,
      "engine": "3.5L V6",
      "transmission": "10-speed Automatic",
      "fuel": "Gasoline",
      "capacity": "3,800 lbs",
      "seating": "3 passengers",
      "mileage": "16 mpg city / 22 mpg highway",
      "rating": 4.5,
      "reviews": 89,
      "image": "https://picsum.photos/400/250?random=1&keyword=commercial-van",
      "dealer": "Ford Commercial Center",
      "location": "Chicago, IL",
      "availability": "In Stock",
      "features": ["Sync 4", "Rear View Camera", "Cruise Control", "Power Steering"],
      "isFavorite": false,
      "isNew": true,
      "applications": ["Delivery", "Service", "Cargo Transport"]
    },
    {
      "id": 2,
      "name": "Mercedes Sprinter 3500",
      "brand": "Mercedes-Benz",
      "type": "Van",
      "price": 62500,
      "year": 2024,
      "engine": "2.0L Turbo I4",
      "transmission": "9-speed Automatic",
      "fuel": "Diesel",
      "capacity": "5,000 lbs",
      "seating": "3 passengers",
      "mileage": "19 mpg city / 24 mpg highway",
      "rating": 4.7,
      "reviews": 156,
      "image": "https://picsum.photos/400/250?random=2&keyword=commercial-van",
      "dealer": "Mercedes Commercial",
      "location": "New York, NY",
      "availability": "Limited",
      "features": ["MBUX", "Active Brake Assist", "Crosswind Assist", "LED Headlights"],
      "isFavorite": true,
      "isNew": false,
      "applications": ["Logistics", "Mobile Workshop", "Passenger Transport"]
    },
    {
      "id": 3,
      "name": "Isuzu NPR-HD",
      "brand": "Isuzu",
      "type": "Truck",
      "price": 58900,
      "year": 2024,
      "engine": "5.2L Diesel",
      "transmission": "6-speed Manual",
      "fuel": "Diesel",
      "capacity": "12,000 lbs GVWR",
      "seating": "3 passengers",
      "mileage": "13 mpg combined",
      "rating": 4.6,
      "reviews": 203,
      "image": "https://picsum.photos/400/250?random=3&keyword=commercial-truck",
      "dealer": "Isuzu Commercial Trucks",
      "location": "Los Angeles, CA",
      "availability": "In Stock",
      "features": ["EcoMax Engine", "Advanced Traction Control", "Hill Start Assist"],
      "isFavorite": false,
      "isNew": true,
      "applications": ["Construction", "Landscaping", "Food Service"]
    },
    {
      "id": 4,
      "name": "Chevrolet Express 3500",
      "brand": "Chevrolet",
      "type": "Van",
      "price": 41200,
      "year": 2024,
      "engine": "6.6L V8",
      "transmission": "8-speed Automatic",
      "fuel": "Gasoline",
      "capacity": "4,250 lbs",
      "seating": "3 passengers",
      "mileage": "14 mpg city / 19 mpg highway",
      "rating": 4.3,
      "reviews": 127,
      "image": "https://picsum.photos/400/250?random=4&keyword=commercial-van",
      "dealer": "Chevrolet Fleet",
      "location": "Dallas, TX",
      "availability": "In Stock",
      "features": ["OnStar", "Rear Vision Camera", "Bluetooth", "Power Windows"],
      "isFavorite": true,
      "isNew": false,
      "applications": ["Plumbing", "HVAC", "Electrical Services"]
    },
    {
      "id": 5,
      "name": "Ram ProMaster 3500",
      "brand": "Ram",
      "type": "Van",
      "price": 44800,
      "year": 2024,
      "engine": "3.6L V6",
      "transmission": "9-speed Automatic",
      "fuel": "Gasoline",
      "capacity": "4,680 lbs",
      "seating": "2 passengers",
      "mileage": "17 mpg city / 24 mpg highway",
      "rating": 4.4,
      "reviews": 98,
      "image": "https://picsum.photos/400/250?random=5&keyword=commercial-van",
      "dealer": "Ram Commercial",
      "location": "Phoenix, AZ",
      "availability": "Pre-order",
      "features": ["Uconnect", "ParkView Camera", "Electronic Stability Control"],
      "isFavorite": false,
      "isNew": true,
      "applications": ["Catering", "Mobile Retail", "Equipment Transport"]
    },
    {
      "id": 6,
      "name": "Freightliner Cascadia",
      "brand": "Freightliner",
      "type": "Semi-Truck",
      "price": 165000,
      "year": 2024,
      "engine": "Detroit DD15",
      "transmission": "DT12 Automated",
      "fuel": "Diesel",
      "capacity": "80,000 lbs GCWR",
      "seating": "2 passengers",
      "mileage": "7.5 mpg",
      "rating": 4.8,
      "reviews": 245,
      "image": "https://picsum.photos/400/250?random=6&keyword=semi-truck",
      "dealer": "Freightliner Northwest",
      "location": "Seattle, WA",
      "availability": "Limited",
      "features": ["Detroit Connect", "Collision Mitigation", "Lane Departure Warning"],
      "isFavorite": true,
      "isNew": false,
      "applications": ["Long Haul", "Regional", "Dedicated Route"]
    }
  ];

  List<Map<String, dynamic>> vehicleTypes = [
    {"label": "All", "value": "All"},
    {"label": "Van", "value": "Van"},
    {"label": "Truck", "value": "Truck"},
    {"label": "Semi-Truck", "value": "Semi-Truck"},
    {"label": "Box Truck", "value": "Box Truck"},
    {"label": "Pickup", "value": "Pickup"}
  ];

  List<Map<String, dynamic>> brands = [
    {"label": "All Brands", "value": "All"},
    {"label": "Ford", "value": "Ford"},
    {"label": "Mercedes-Benz", "value": "Mercedes-Benz"},
    {"label": "Chevrolet", "value": "Chevrolet"},
    {"label": "Ram", "value": "Ram"},
    {"label": "Isuzu", "value": "Isuzu"},
    {"label": "Freightliner", "value": "Freightliner"}
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    return vehicles.where((vehicle) {
      bool matchesType = selectedType == "All" || vehicle["type"] == selectedType;
      bool matchesBrand = selectedBrand == "All" || vehicle["brand"] == selectedBrand;
      bool matchesSearch = searchQuery.isEmpty || 
          "${vehicle["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${vehicle["brand"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesBrand && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commercial Vehicles"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                showFilters = !showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          if (showFilters) _buildFilterSection(),
          
          // Type Filter
          _buildTypeFilter(),
          
          // Vehicles List
          Expanded(
            child: _buildVehiclesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search vehicles...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          QDropdownField(
            label: "Brand",
            items: brands,
            value: selectedBrand,
            onChanged: (value, label) {
              selectedBrand = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTypeFilter() {
    return Container(
      height: 60,
      child: QHorizontalScroll(
        children: vehicleTypes.map((type) {
          bool isSelected = selectedType == type["value"];
          return Container(
            margin: EdgeInsets.only(right: spSm),
            child: FilterChip(
              label: Text("${type["label"]}"),
              selected: isSelected,
              onSelected: (selected) {
                selectedType = type["value"];
                setState(() {});
              },
              backgroundColor: Colors.white,
              selectedColor: primaryColor.withAlpha(30),
              labelStyle: TextStyle(
                color: isSelected ? primaryColor : disabledBoldColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVehiclesList() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredVehicles.length,
      itemBuilder: (context, index) {
        final vehicle = filteredVehicles[index];
        return _buildVehicleCard(vehicle);
      },
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Status
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  child: Image.network(
                    "${vehicle["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (vehicle["isNew"] as bool)
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "NEW 2024",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () {
                    vehicle["isFavorite"] = !(vehicle["isFavorite"] as bool);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      vehicle["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                      color: vehicle["isFavorite"] as bool ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getAvailabilityColor(vehicle["availability"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${vehicle["availability"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Title and Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${vehicle["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${vehicle["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${vehicle["brand"]} • ${vehicle["year"]}",
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
                    Text(
                      "\$${((vehicle["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                
                // Key Specifications
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          _buildSpecItem(Icons.local_gas_station, "${vehicle["fuel"]}"),
                          Spacer(),
                          _buildSpecItem(Icons.settings, "${vehicle["engine"]}"),
                        ],
                      ),
                      Row(
                        children: [
                          _buildSpecItem(Icons.scale, "${vehicle["capacity"]}"),
                          Spacer(),
                          _buildSpecItem(Icons.speed, "${vehicle["mileage"]}"),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Rating and Reviews
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${vehicle["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      " (${vehicle["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                // Applications
                if ((vehicle["applications"] as List).isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Applications:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (vehicle["applications"] as List).map((app) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$app",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                
                // Dealer Info and Actions
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${vehicle["dealer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${vehicle["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        QButton(
                          label: "Quote",
                          size: bs.sm,
                          onPressed: () {
                            _requestQuote(vehicle);
                          },
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Details",
                          size: bs.sm,
                          onPressed: () {
                            _showVehicleDetails(vehicle);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: disabledBoldColor),
        SizedBox(width: spXs),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "In Stock":
        return successColor;
      case "Limited":
        return warningColor;
      case "Pre-order":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Commercial Vehicles"),
        content: QTextField(
          label: "Enter vehicle name or brand",
          value: searchQuery,
          onChanged: (value) {
            searchQuery = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              setState(() {});
              back();
            },
          ),
        ],
      ),
    );
  }

  void _requestQuote(Map<String, dynamic> vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Request Quote"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Request a quote for:"),
            SizedBox(height: spSm),
            Text(
              "${vehicle["name"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text("Our dealer will contact you within 24 hours with pricing and availability."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Request Quote",
            size: bs.sm,
            onPressed: () {
              ss("Quote request sent successfully!");
              back();
            },
          ),
        ],
      ),
    );
  }

  void _showVehicleDetails(Map<String, dynamic> vehicle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${vehicle["name"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => back(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          "${vehicle["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    Text(
                      "Vehicle Specifications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          _buildDetailRow("Type", "${vehicle["type"]}"),
                          _buildDetailRow("Engine", "${vehicle["engine"]}"),
                          _buildDetailRow("Transmission", "${vehicle["transmission"]}"),
                          _buildDetailRow("Fuel Type", "${vehicle["fuel"]}"),
                          _buildDetailRow("Capacity", "${vehicle["capacity"]}"),
                          _buildDetailRow("Seating", "${vehicle["seating"]}"),
                          _buildDetailRow("Fuel Economy", "${vehicle["mileage"]}"),
                          _buildDetailRow("Year", "${vehicle["year"]}"),
                        ],
                      ),
                    ),
                    
                    Text(
                      "Standard Features",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: (vehicle["features"] as List).map((feature) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$feature",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    Text(
                      "Recommended Applications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Column(
                      children: (vehicle["applications"] as List).map((app) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "• $app",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
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
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Request Quote",
                    onPressed: () {
                      back();
                      _requestQuote(vehicle);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Contact Dealer",
                    onPressed: () {
                      ss("Dealer contact information sent!");
                      back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          ":",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
