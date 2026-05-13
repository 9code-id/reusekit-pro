import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaResalePropertiesView extends StatefulWidget {
  const ReaResalePropertiesView({Key? key}) : super(key: key);

  @override
  State<ReaResalePropertiesView> createState() => _ReaResalePropertiesViewState();
}

class _ReaResalePropertiesViewState extends State<ReaResalePropertiesView> {
  String searchQuery = "";
  String selectedLocation = "All Locations";
  String selectedPriceRange = "All Prices";
  String selectedPropertyType = "All Types";
  String selectedBedrooms = "Any";
  String selectedAge = "Any Age";
  String sortBy = "Newest First";
  bool showFilters = false;

  List<Map<String, dynamic>> locationItems = [
    {"label": "All Locations", "value": "All Locations"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Midtown", "value": "Midtown"},
    {"label": "Suburbs", "value": "Suburbs"},
    {"label": "Waterfront", "value": "Waterfront"},
    {"label": "Historic District", "value": "Historic District"},
  ];

  List<Map<String, dynamic>> priceRangeItems = [
    {"label": "All Prices", "value": "All Prices"},
    {"label": "Under \$400K", "value": "Under \$400K"},
    {"label": "\$400K - \$800K", "value": "\$400K - \$800K"},
    {"label": "\$800K - \$1.5M", "value": "\$800K - \$1.5M"},
    {"label": "\$1.5M - \$3M", "value": "\$1.5M - \$3M"},
    {"label": "Above \$3M", "value": "Above \$3M"},
  ];

  List<Map<String, dynamic>> propertyTypeItems = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Apartment", "value": "Apartment"},
    {"label": "Villa", "value": "Villa"},
    {"label": "Townhouse", "value": "Townhouse"},
    {"label": "Condominium", "value": "Condominium"},
    {"label": "Studio", "value": "Studio"},
  ];

  List<Map<String, dynamic>> bedroomItems = [
    {"label": "Any", "value": "Any"},
    {"label": "1 BHK", "value": "1"},
    {"label": "2 BHK", "value": "2"},
    {"label": "3 BHK", "value": "3"},
    {"label": "4+ BHK", "value": "4+"},
  ];

  List<Map<String, dynamic>> ageItems = [
    {"label": "Any Age", "value": "Any Age"},
    {"label": "Under 5 years", "value": "Under 5 years"},
    {"label": "5-10 years", "value": "5-10 years"},
    {"label": "10-20 years", "value": "10-20 years"},
    {"label": "20+ years", "value": "20+ years"},
  ];

  List<Map<String, dynamic>> sortItems = [
    {"label": "Newest First", "value": "Newest First"},
    {"label": "Price: Low to High", "value": "Price: Low to High"},
    {"label": "Price: High to Low", "value": "Price: High to Low"},
    {"label": "Recently Reduced", "value": "Recently Reduced"},
    {"label": "Most Viewed", "value": "Most Viewed"},
  ];

  List<Map<String, dynamic>> resaleProperties = [
    {
      "id": "1",
      "title": "Charming Victorian House",
      "location": "Historic District, Old Town",
      "price": 950000,
      "originalPrice": 1050000,
      "type": "Villa",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 2100,
      "yearBuilt": 2010,
      "age": "14 years",
      "images": [
        "https://picsum.photos/400/300?random=121&keyword=victorian",
        "https://picsum.photos/400/300?random=122&keyword=historic",
        "https://picsum.photos/400/300?random=123&keyword=house",
      ],
      "features": ["Hardwood Floors", "Fireplace", "Garden", "Garage"],
      "condition": "Excellent",
      "lastSalePrice": 750000,
      "lastSaleYear": 2018,
      "priceReduced": true,
      "daysOnMarket": 45,
      "views": 324,
      "isFeatured": true,
      "owner": {
        "name": "Robert Johnson",
        "ownershipYears": 6,
        "sellingReason": "Relocating for work",
      },
      "agent": {
        "name": "Jennifer Martinez",
        "phone": "+1 234 567 8911",
        "image": "https://picsum.photos/100/100?random=211&keyword=woman",
      },
    },
    {
      "id": "2",
      "title": "Modern Downtown Condo",
      "location": "Downtown, Financial District",
      "price": 725000,
      "originalPrice": 725000,
      "type": "Condominium",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1350,
      "yearBuilt": 2015,
      "age": "9 years",
      "images": [
        "https://picsum.photos/400/300?random=124&keyword=condo",
        "https://picsum.photos/400/300?random=125&keyword=downtown",
        "https://picsum.photos/400/300?random=126&keyword=modern",
      ],
      "features": ["City View", "Balcony", "Gym Access", "Concierge"],
      "condition": "Very Good",
      "lastSalePrice": 650000,
      "lastSaleYear": 2020,
      "priceReduced": false,
      "daysOnMarket": 23,
      "views": 189,
      "isFeatured": false,
      "owner": {
        "name": "Maria Garcia",
        "ownershipYears": 4,
        "sellingReason": "Upgrading to larger home",
      },
      "agent": {
        "name": "Alex Thompson",
        "phone": "+1 234 567 8912",
        "image": "https://picsum.photos/100/100?random=212&keyword=man",
      },
    },
    {
      "id": "3",
      "title": "Waterfront Luxury Apartment",
      "location": "Waterfront, Marina Bay",
      "price": 1450000,
      "originalPrice": 1550000,
      "type": "Apartment",
      "bedrooms": 3,
      "bathrooms": 3,
      "area": 1900,
      "yearBuilt": 2008,
      "age": "16 years",
      "images": [
        "https://picsum.photos/400/300?random=127&keyword=waterfront",
        "https://picsum.photos/400/300?random=128&keyword=luxury",
        "https://picsum.photos/400/300?random=129&keyword=marina",
      ],
      "features": ["Water View", "Private Dock", "Swimming Pool", "Tennis Court"],
      "condition": "Excellent",
      "lastSalePrice": 1200000,
      "lastSaleYear": 2019,
      "priceReduced": true,
      "daysOnMarket": 67,
      "views": 542,
      "isFeatured": true,
      "owner": {
        "name": "David Kim",
        "ownershipYears": 5,
        "sellingReason": "Investment liquidation",
      },
      "agent": {
        "name": "Sarah Williams",
        "phone": "+1 234 567 8913",
        "image": "https://picsum.photos/100/100?random=213&keyword=woman",
      },
    },
    {
      "id": "4",
      "title": "Cozy Suburban Townhouse",
      "location": "Suburbs, Maple Heights",
      "price": 485000,
      "originalPrice": 485000,
      "type": "Townhouse",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1650,
      "yearBuilt": 2012,
      "age": "12 years",
      "images": [
        "https://picsum.photos/400/300?random=130&keyword=townhouse",
        "https://picsum.photos/400/300?random=131&keyword=suburban",
        "https://picsum.photos/400/300?random=132&keyword=cozy",
      ],
      "features": ["Backyard", "Parking", "Storage", "Family Room"],
      "condition": "Good",
      "lastSalePrice": 420000,
      "lastSaleYear": 2016,
      "priceReduced": false,
      "daysOnMarket": 31,
      "views": 156,
      "isFeatured": false,
      "owner": {
        "name": "Linda Brown",
        "ownershipYears": 8,
        "sellingReason": "Empty nest downsizing",
      },
      "agent": {
        "name": "Michael Davis",
        "phone": "+1 234 567 8914",
        "image": "https://picsum.photos/100/100?random=214&keyword=man",
      },
    },
    {
      "id": "5",
      "title": "Vintage Midtown Studio",
      "location": "Midtown, Arts District",
      "price": 320000,
      "originalPrice": 350000,
      "type": "Studio",
      "bedrooms": 1,
      "bathrooms": 1,
      "area": 750,
      "yearBuilt": 2005,
      "age": "19 years",
      "images": [
        "https://picsum.photos/400/300?random=133&keyword=studio",
        "https://picsum.photos/400/300?random=134&keyword=vintage",
        "https://picsum.photos/400/300?random=135&keyword=arts",
      ],
      "features": ["High Ceilings", "Exposed Brick", "Hardwood", "Loft Style"],
      "condition": "Good",
      "lastSalePrice": 280000,
      "lastSaleYear": 2021,
      "priceReduced": true,
      "daysOnMarket": 89,
      "views": 278,
      "isFeatured": false,
      "owner": {
        "name": "Carlos Rodriguez",
        "ownershipYears": 3,
        "sellingReason": "Starting a family",
      },
      "agent": {
        "name": "Emma Wilson",
        "phone": "+1 234 567 8915",
        "image": "https://picsum.photos/100/100?random=215&keyword=woman",
      },
    },
    {
      "id": "6",
      "title": "Executive Family Home",
      "location": "Suburbs, Executive Estates",
      "price": 1250000,
      "originalPrice": 1250000,
      "type": "Villa",
      "bedrooms": 4,
      "bathrooms": 4,
      "area": 3200,
      "yearBuilt": 2006,
      "age": "18 years",
      "images": [
        "https://picsum.photos/400/300?random=136&keyword=executive",
        "https://picsum.photos/400/300?random=137&keyword=family",
        "https://picsum.photos/400/300?random=138&keyword=estate",
      ],
      "features": ["Swimming Pool", "Home Theater", "Wine Cellar", "3-Car Garage"],
      "condition": "Excellent",
      "lastSalePrice": 980000,
      "lastSaleYear": 2017,
      "priceReduced": false,
      "daysOnMarket": 15,
      "views": 432,
      "isFeatured": true,
      "owner": {
        "name": "Patricia Lee",
        "ownershipYears": 7,
        "sellingReason": "Retirement relocation",
      },
      "agent": {
        "name": "James Anderson",
        "phone": "+1 234 567 8916",
        "image": "https://picsum.photos/100/100?random=216&keyword=man",
      },
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    List<Map<String, dynamic>> filtered = List.from(resaleProperties);

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((property) {
        return property["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               property["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedLocation != "All Locations") {
      filtered = filtered.where((property) {
        return property["location"].toString().contains(selectedLocation);
      }).toList();
    }

    if (selectedPropertyType != "All Types") {
      filtered = filtered.where((property) {
        return property["type"] == selectedPropertyType;
      }).toList();
    }

    if (selectedBedrooms != "Any") {
      if (selectedBedrooms == "4+") {
        filtered = filtered.where((property) {
          return (property["bedrooms"] as int) >= 4;
        }).toList();
      } else {
        filtered = filtered.where((property) {
          return property["bedrooms"].toString() == selectedBedrooms;
        }).toList();
      }
    }

    // Sort properties
    if (sortBy == "Price: Low to High") {
      filtered.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
    } else if (sortBy == "Price: High to Low") {
      filtered.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
    } else if (sortBy == "Recently Reduced") {
      filtered.sort((a, b) => (b["priceReduced"] as bool).toString().compareTo((a["priceReduced"] as bool).toString()));
    } else if (sortBy == "Most Viewed") {
      filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resale Properties"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Quick Filters
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search resale properties...",
                        value: searchQuery,
                        hint: "Enter location or property name",
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
                SizedBox(height: spSm),
                
                // Quick Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Location",
                        items: locationItems,
                        value: selectedLocation,
                        onChanged: (value, label) {
                          selectedLocation = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Type",
                        items: propertyTypeItems,
                        value: selectedPropertyType,
                        onChanged: (value, label) {
                          selectedPropertyType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Advanced Filters (Collapsible)
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              color: Colors.grey[50],
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Price Range",
                          items: priceRangeItems,
                          value: selectedPriceRange,
                          onChanged: (value, label) {
                            selectedPriceRange = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Bedrooms",
                          items: bedroomItems,
                          value: selectedBedrooms,
                          onChanged: (value, label) {
                            selectedBedrooms = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Property Age",
                          items: ageItems,
                          value: selectedAge,
                          onChanged: (value, label) {
                            selectedAge = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortItems,
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

          // Results Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "${filteredProperties.length} Resale Properties",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.replay,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Resale",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Properties List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                final priceReduction = (property["originalPrice"] as int) - (property["price"] as int);
                final priceReductionPercent = priceReduction > 0 ? 
                  ((priceReduction / (property["originalPrice"] as int)) * 100).round() : 0;
                
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
                      // Property Image with Badges
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            child: Image.network(
                              "${(property["images"] as List)[0]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: infoColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Resale",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          if (property["priceReduced"] as bool)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$priceReductionPercent% Off",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          if (property["isFeatured"] as bool)
                            Positioned(
                              bottom: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Featured",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${property["views"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Property Title and Days on Market
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${property["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: disabledColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${property["daysOnMarket"]} days",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            
                            // Location and Property Age
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${property["location"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Built ${property["yearBuilt"]} (${property["age"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Current Price and Original Price
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "\$${((property["price"] as int).toDouble()).currency}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                          if (property["priceReduced"] as bool) ...[
                                            SizedBox(width: spXs),
                                            Text(
                                              "\$${((property["originalPrice"] as int).toDouble()).currency}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${property["type"]} • ${property["bedrooms"]} BHK",
                                        style: TextStyle(
                                          fontSize: 14,
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
                                      "${property["area"]} sq ft",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Condition: ${property["condition"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Price History
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    size: 16,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "Last sold in ${property["lastSaleYear"]} for \$${((property["lastSalePrice"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: infoColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            // Features
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (property["features"] as List).take(4).map((feature) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$feature",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spSm),
                            
                            // Owner Info
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Owner: ${property["owner"]["name"]} (${property["owner"]["ownershipYears"]} years)",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Selling reason: ${property["owner"]["sellingReason"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            // Agent Info and Actions
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage("${property["agent"]["image"]}"),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${property["agent"]["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Resale specialist",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  icon: Icons.phone,
                                  size: bs.sm,
                                  onPressed: () {
                                    //call agent
                                  },
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigate to property detail
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
