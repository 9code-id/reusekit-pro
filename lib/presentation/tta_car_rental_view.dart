import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaCarRentalView extends StatefulWidget {
  const TtaCarRentalView({super.key});

  @override
  State<TtaCarRentalView> createState() => _TtaCarRentalViewState();
}

class _TtaCarRentalViewState extends State<TtaCarRentalView> {
  String selectedCategory = "All";
  String searchQuery = "";
  String sortBy = "price";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Economy", "value": "Economy"},
    {"label": "Compact", "value": "Compact"},
    {"label": "SUV", "value": "SUV"},
    {"label": "Luxury", "value": "Luxury"},
    {"label": "Electric", "value": "Electric"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Price (Low to High)", "value": "price"},
    {"label": "Price (High to Low)", "value": "price_desc"},
    {"label": "Rating", "value": "rating"},
    {"label": "Fuel Efficiency", "value": "fuel"},
  ];

  List<Map<String, dynamic>> cars = [
    {
      "id": "1",
      "name": "Toyota Corolla",
      "category": "Economy",
      "brand": "Toyota",
      "year": 2024,
      "pricePerDay": 45.00,
      "rating": 4.5,
      "fuelType": "Gasoline",
      "transmission": "Automatic",
      "seats": 5,
      "bags": 2,
      "fuelEfficiency": "32 MPG",
      "image": "https://picsum.photos/300/200?random=1&keyword=toyota",
      "features": ["GPS", "Bluetooth", "Air Conditioning"],
      "available": true,
      "location": "Downtown Branch",
    },
    {
      "id": "2", 
      "name": "Honda Civic",
      "category": "Compact",
      "brand": "Honda",
      "year": 2024,
      "pricePerDay": 52.00,
      "rating": 4.6,
      "fuelType": "Gasoline",
      "transmission": "Automatic",
      "seats": 5,
      "bags": 3,
      "fuelEfficiency": "30 MPG",
      "image": "https://picsum.photos/300/200?random=2&keyword=honda",
      "features": ["GPS", "Bluetooth", "Air Conditioning", "Backup Camera"],
      "available": true,
      "location": "Airport Branch",
    },
    {
      "id": "3",
      "name": "BMW X3",
      "category": "SUV",
      "brand": "BMW",
      "year": 2024,
      "pricePerDay": 125.00,
      "rating": 4.8,
      "fuelType": "Gasoline",
      "transmission": "Automatic",
      "seats": 5,
      "bags": 4,
      "fuelEfficiency": "25 MPG",
      "image": "https://picsum.photos/300/200?random=3&keyword=bmw",
      "features": ["GPS", "Bluetooth", "Air Conditioning", "Leather Seats", "Sunroof"],
      "available": true,
      "location": "Downtown Branch",
    },
    {
      "id": "4",
      "name": "Mercedes-Benz S-Class",
      "category": "Luxury",
      "brand": "Mercedes-Benz",
      "year": 2024,
      "pricePerDay": 250.00,
      "rating": 4.9,
      "fuelType": "Gasoline",
      "transmission": "Automatic",
      "seats": 5,
      "bags": 3,
      "fuelEfficiency": "22 MPG",
      "image": "https://picsum.photos/300/200?random=4&keyword=mercedes",
      "features": ["GPS", "Bluetooth", "Air Conditioning", "Leather Seats", "Sunroof", "Premium Audio"],
      "available": false,
      "location": "Luxury Branch",
    },
    {
      "id": "5",
      "name": "Tesla Model 3",
      "category": "Electric",
      "brand": "Tesla",
      "year": 2024,
      "pricePerDay": 89.00,
      "rating": 4.7,
      "fuelType": "Electric",
      "transmission": "Automatic",
      "seats": 5,
      "bags": 2,
      "fuelEfficiency": "120 MPGe",
      "image": "https://picsum.photos/300/200?random=5&keyword=tesla",
      "features": ["GPS", "Bluetooth", "Air Conditioning", "Autopilot", "Supercharging"],
      "available": true,
      "location": "Tech Branch",
    },
    {
      "id": "6",
      "name": "Ford Escape",
      "category": "SUV",
      "brand": "Ford",
      "year": 2023,
      "pricePerDay": 75.00,
      "rating": 4.4,
      "fuelType": "Gasoline",
      "transmission": "Automatic",
      "seats": 5,
      "bags": 4,
      "fuelEfficiency": "28 MPG",
      "image": "https://picsum.photos/300/200?random=6&keyword=ford",
      "features": ["GPS", "Bluetooth", "Air Conditioning", "Backup Camera"],
      "available": true,
      "location": "Airport Branch",
    },
    {
      "id": "7",
      "name": "Nissan Versa",
      "category": "Economy",
      "brand": "Nissan",
      "year": 2024,
      "pricePerDay": 38.00,
      "rating": 4.2,
      "fuelType": "Gasoline",
      "transmission": "Manual",
      "seats": 5,
      "bags": 2,
      "fuelEfficiency": "35 MPG",
      "image": "https://picsum.photos/300/200?random=7&keyword=nissan",
      "features": ["GPS", "Bluetooth", "Air Conditioning"],
      "available": true,
      "location": "Downtown Branch",
    },
    {
      "id": "8",
      "name": "Audi A4",
      "category": "Luxury",
      "brand": "Audi",
      "year": 2024,
      "pricePerDay": 180.00,
      "rating": 4.8,
      "fuelType": "Gasoline",
      "transmission": "Automatic",
      "seats": 5,
      "bags": 3,
      "fuelEfficiency": "26 MPG",
      "image": "https://picsum.photos/300/200?random=8&keyword=audi",
      "features": ["GPS", "Bluetooth", "Air Conditioning", "Leather Seats", "Premium Audio"],
      "available": true,
      "location": "Luxury Branch",
    },
  ];

  List<Map<String, dynamic>> get filteredAndSortedCars {
    List<Map<String, dynamic>> filtered = cars.where((car) {
      bool categoryMatch = selectedCategory == "All" || 
                          car["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty ||
                        (car["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                        (car["brand"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();

    // Sort
    filtered.sort((a, b) {
      switch (sortBy) {
        case "price":
          return (a["pricePerDay"] as double).compareTo(b["pricePerDay"] as double);
        case "price_desc":
          return (b["pricePerDay"] as double).compareTo(a["pricePerDay"] as double);
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "fuel":
          String aFuel = a["fuelEfficiency"] as String;
          String bFuel = b["fuelEfficiency"] as String;
          int aNum = int.tryParse(aFuel.split(' ')[0]) ?? 0;
          int bNum = int.tryParse(bFuel.split(' ')[0]) ?? 0;
          return bNum.compareTo(aNum);
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
        title: Text("Car Rental"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Sort
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search cars...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          SizedBox(height: spSm),

          // Cars List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredAndSortedCars.length,
              itemBuilder: (context, index) {
                final car = filteredAndSortedCars[index];
                final isAvailable = car["available"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: isAvailable 
                          ? disabledOutlineBorderColor 
                          : disabledColor,
                    ),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Car Image
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${car["image"]}",
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            if (!isAvailable)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.black.withAlpha(120),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spMd,
                                        vertical: spSm,
                                      ),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "Not Available",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${car["category"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Car Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
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
                                        "${car["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isAvailable 
                                              ? primaryColor 
                                              : disabledColor,
                                        ),
                                      ),
                                      Text(
                                        "${car["brand"]} • ${car["year"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isAvailable 
                                              ? disabledBoldColor 
                                              : disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${((car["pricePerDay"] as double)).toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isAvailable 
                                            ? primaryColor 
                                            : disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "per day",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isAvailable 
                                            ? disabledBoldColor 
                                            : disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            
                            // Car Stats
                            Row(
                              children: [
                                _buildStatItem(
                                  Icons.star,
                                  "${car["rating"]}",
                                  warningColor,
                                  isAvailable,
                                ),
                                _buildStatItem(
                                  Icons.people,
                                  "${car["seats"]} seats",
                                  infoColor,
                                  isAvailable,
                                ),
                                _buildStatItem(
                                  Icons.luggage,
                                  "${car["bags"]} bags",
                                  successColor,
                                  isAvailable,
                                ),
                                _buildStatItem(
                                  Icons.local_gas_station,
                                  "${car["fuelEfficiency"]}",
                                  secondaryColor,
                                  isAvailable,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Features
                            Text(
                              "Features:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isAvailable 
                                    ? primaryColor 
                                    : disabledColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (car["features"] as List).map((feature) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isAvailable 
                                        ? primaryColor.withAlpha(30) 
                                        : disabledColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$feature",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isAvailable 
                                          ? primaryColor 
                                          : disabledColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Location and Action
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: isAvailable 
                                      ? dangerColor 
                                      : disabledColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${car["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isAvailable 
                                          ? disabledBoldColor 
                                          : disabledColor,
                                    ),
                                  ),
                                ),
                                QButton(
                                  label: isAvailable ? "View Details" : "Unavailable",
                                  size: bs.sm,
                                  onPressed: isAvailable ? () {
                                    ss("Viewing ${car["name"]} details");
                                  } : null,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, Color color, bool isAvailable) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isAvailable ? color : disabledColor,
            size: 14,
          ),
          SizedBox(width: spXs),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 10,
                color: isAvailable ? disabledBoldColor : disabledColor,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Filter & Sort",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Category",
                items: categories,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Sort by",
                items: sortOptions,
                value: sortBy,
                onChanged: (value, label) {
                  sortBy = value;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Apply Filters",
                  size: bs.md,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
