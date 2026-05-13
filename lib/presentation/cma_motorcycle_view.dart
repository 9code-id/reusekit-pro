import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaMotorcycleView extends StatefulWidget {
  const CmaMotorcycleView({super.key});

  @override
  State<CmaMotorcycleView> createState() => _CmaMotorcycleViewState();
}

class _CmaMotorcycleViewState extends State<CmaMotorcycleView> {
  int selectedTab = 0;
  String selectedCategory = "All";
  String searchQuery = "";
  String sortBy = "price";
  bool showFilters = false;

  List<Map<String, dynamic>> motorcycles = [
    {
      "id": 1,
      "name": "Yamaha YZF-R1",
      "brand": "Yamaha",
      "category": "Sport",
      "price": 18500,
      "year": 2024,
      "engine": "998cc",
      "power": "200 HP",
      "mileage": "15 km/l",
      "transmission": "6-speed",
      "color": "Racing Blue",
      "rating": 4.8,
      "reviews": 142,
      "image": "https://picsum.photos/300/200?random=1&keyword=motorcycle",
      "dealer": "Yamaha Downtown",
      "location": "New York, NY",
      "availability": "In Stock",
      "features": ["ABS", "Traction Control", "Quick Shifter", "LED Headlights"],
      "isFavorite": false,
      "isNew": true
    },
    {
      "id": 2,
      "name": "Honda CBR1000RR",
      "brand": "Honda",
      "category": "Sport",
      "price": 17200,
      "year": 2024,
      "engine": "999cc",
      "power": "189 HP",
      "mileage": "16 km/l",
      "transmission": "6-speed",
      "color": "Pearl White",
      "rating": 4.7,
      "reviews": 98,
      "image": "https://picsum.photos/300/200?random=2&keyword=motorcycle",
      "dealer": "Honda Motors",
      "location": "Los Angeles, CA",
      "availability": "Limited",
      "features": ["Honda Selectable Torque Control", "ABS", "Power Modes"],
      "isFavorite": true,
      "isNew": false
    },
    {
      "id": 3,
      "name": "Kawasaki Ninja H2",
      "brand": "Kawasaki",
      "category": "Hypersport",
      "price": 32500,
      "year": 2024,
      "engine": "998cc Supercharged",
      "power": "228 HP",
      "mileage": "12 km/l",
      "transmission": "6-speed",
      "color": "Emerald Blazed Green",
      "rating": 4.9,
      "reviews": 76,
      "image": "https://picsum.photos/300/200?random=3&keyword=motorcycle",
      "dealer": "Kawasaki Performance",
      "location": "Chicago, IL",
      "availability": "Pre-order",
      "features": ["Supercharged Engine", "Carbon Fiber Bodywork", "Brembo Brakes"],
      "isFavorite": false,
      "isNew": true
    },
    {
      "id": 4,
      "name": "Harley-Davidson Street Glide",
      "brand": "Harley-Davidson",
      "category": "Touring",
      "price": 24500,
      "year": 2024,
      "engine": "1868cc Milwaukee-Eight",
      "power": "90 HP",
      "mileage": "18 km/l",
      "transmission": "6-speed",
      "color": "Vivid Black",
      "rating": 4.6,
      "reviews": 203,
      "image": "https://picsum.photos/300/200?random=4&keyword=motorcycle",
      "dealer": "Harley Heritage",
      "location": "Miami, FL",
      "availability": "In Stock",
      "features": ["Infotainment System", "Cruise Control", "Security System"],
      "isFavorite": true,
      "isNew": false
    },
    {
      "id": 5,
      "name": "BMW S1000RR",
      "brand": "BMW",
      "category": "Sport",
      "price": 21500,
      "year": 2024,
      "engine": "999cc",
      "power": "205 HP",
      "mileage": "14 km/l",
      "transmission": "6-speed",
      "color": "Light White",
      "rating": 4.8,
      "reviews": 89,
      "image": "https://picsum.photos/300/200?random=5&keyword=motorcycle",
      "dealer": "BMW Motorrad",
      "location": "Seattle, WA",
      "availability": "In Stock",
      "features": ["Dynamic Damping Control", "Race Pro Modes", "HP Shift Assistant"],
      "isFavorite": false,
      "isNew": true
    },
    {
      "id": 6,
      "name": "Ducati Panigale V4",
      "brand": "Ducati",
      "category": "Superbike",
      "price": 28900,
      "year": 2024,
      "engine": "1103cc V4",
      "power": "214 HP",
      "mileage": "13 km/l",
      "transmission": "6-speed",
      "color": "Ducati Red",
      "rating": 4.9,
      "reviews": 156,
      "image": "https://picsum.photos/300/200?random=6&keyword=motorcycle",
      "dealer": "Ducati Prestige",
      "location": "San Francisco, CA",
      "availability": "Limited",
      "features": ["Ducati Wheelie Control", "Cornering ABS", "Öhlins Suspension"],
      "isFavorite": true,
      "isNew": false
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Sport", "value": "Sport"},
    {"label": "Touring", "value": "Touring"},
    {"label": "Cruiser", "value": "Cruiser"},
    {"label": "Adventure", "value": "Adventure"},
    {"label": "Superbike", "value": "Superbike"},
    {"label": "Hypersport", "value": "Hypersport"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Price: Low to High", "value": "price"},
    {"label": "Price: High to Low", "value": "price_desc"},
    {"label": "Rating", "value": "rating"},
    {"label": "Year", "value": "year"},
    {"label": "Power", "value": "power"}
  ];

  List<Map<String, dynamic>> get filteredMotorcycles {
    List<Map<String, dynamic>> filtered = motorcycles.where((motorcycle) {
      bool matchesCategory = selectedCategory == "All" || motorcycle["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          "${motorcycle["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${motorcycle["brand"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    // Sort motorcycles
    filtered.sort((a, b) {
      switch (sortBy) {
        case "price":
          return (a["price"] as int).compareTo(b["price"] as int);
        case "price_desc":
          return (b["price"] as int).compareTo(a["price"] as int);
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "year":
          return (b["year"] as int).compareTo(a["year"] as int);
        case "power":
          return int.parse("${b["power"]}".replaceAll(RegExp(r'[^0-9]'), '')).compareTo(
                 int.parse("${a["power"]}".replaceAll(RegExp(r'[^0-9]'), '')));
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Motorcycles"),
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
          // Search and Filter Section
          if (showFilters) _buildFilterSection(),
          
          // Category Filter
          _buildCategoryFilter(),
          
          // Motorcycles List
          Expanded(
            child: _buildMotorcyclesList(),
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
                  label: "Search motorcycles...",
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
            label: "Sort by",
            items: sortOptions,
            value: sortBy,
            onChanged: (value, label) {
              sortBy = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      child: QHorizontalScroll(
        children: categories.map((category) {
          bool isSelected = selectedCategory == category["value"];
          return Container(
            margin: EdgeInsets.only(right: spSm),
            child: FilterChip(
              label: Text("${category["label"]}"),
              selected: isSelected,
              onSelected: (selected) {
                selectedCategory = category["value"];
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

  Widget _buildMotorcyclesList() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredMotorcycles.length,
      itemBuilder: (context, index) {
        final motorcycle = filteredMotorcycles[index];
        return _buildMotorcycleCard(motorcycle);
      },
    );
  }

  Widget _buildMotorcycleCard(Map<String, dynamic> motorcycle) {
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
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    "${motorcycle["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (motorcycle["isNew"] as bool)
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
                      "NEW",
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
                    motorcycle["isFavorite"] = !(motorcycle["isFavorite"] as bool);
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
                      motorcycle["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                      color: motorcycle["isFavorite"] as bool ? dangerColor : disabledBoldColor,
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
                    color: _getAvailabilityColor(motorcycle["availability"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${motorcycle["availability"]}",
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
                            "${motorcycle["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${motorcycle["brand"]} • ${motorcycle["year"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((motorcycle["price"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                
                // Specifications
                Row(
                  children: [
                    _buildSpecItem(Icons.settings, "${motorcycle["engine"]}"),
                    SizedBox(width: spMd),
                    _buildSpecItem(Icons.flash_on, "${motorcycle["power"]}"),
                    SizedBox(width: spMd),
                    _buildSpecItem(Icons.local_gas_station, "${motorcycle["mileage"]}"),
                  ],
                ),
                
                // Rating and Reviews
                Row(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${motorcycle["rating"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "(${motorcycle["reviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${motorcycle["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                
                // Features
                if ((motorcycle["features"] as List).isNotEmpty)
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (motorcycle["features"] as List).take(3).map((feature) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$feature",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                
                // Dealer Info and Action
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${motorcycle["dealer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${motorcycle["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        _showMotorcycleDetails(motorcycle);
                      },
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
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(width: spXs),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
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
        title: Text("Search Motorcycles"),
        content: QTextField(
          label: "Enter motorcycle name or brand",
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

  void _showMotorcycleDetails(Map<String, dynamic> motorcycle) {
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
                    "${motorcycle["name"]}",
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
                          "${motorcycle["image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    Text(
                      "Specifications",
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
                          _buildDetailRow("Engine", "${motorcycle["engine"]}"),
                          _buildDetailRow("Power", "${motorcycle["power"]}"),
                          _buildDetailRow("Mileage", "${motorcycle["mileage"]}"),
                          _buildDetailRow("Transmission", "${motorcycle["transmission"]}"),
                          _buildDetailRow("Color", "${motorcycle["color"]}"),
                          _buildDetailRow("Year", "${motorcycle["year"]}"),
                        ],
                      ),
                    ),
                    
                    Text(
                      "Features",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: (motorcycle["features"] as List).map((feature) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$feature",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
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
            
            Container(
              width: double.infinity,
              child: QButton(
                label: "Contact Dealer",
                onPressed: () {
                  ss("Dealer contact information sent to your email");
                  back();
                },
              ),
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
          width: 100,
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
