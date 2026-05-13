import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsStoreLocatorView extends StatefulWidget {
  const EcsStoreLocatorView({super.key});

  @override
  State<EcsStoreLocatorView> createState() => _EcsStoreLocatorViewState();
}

class _EcsStoreLocatorViewState extends State<EcsStoreLocatorView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool showMap = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Stores", "value": "All"},
    {"label": "Open Now", "value": "Open"},
    {"label": "24/7 Stores", "value": "24/7"},
    {"label": "Drive-thru", "value": "Drive-thru"},
    {"label": "Pharmacy", "value": "Pharmacy"},
  ];

  List<Map<String, dynamic>> stores = [
    {
      "id": "1",
      "name": "Downtown Store",
      "address": "123 Main Street, Downtown",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "phone": "(555) 123-4567",
      "latitude": 40.7589,
      "longitude": -73.9851,
      "distance": 0.5,
      "isOpen": true,
      "is24Hours": false,
      "hasDriveThru": false,
      "hasPharmacy": true,
      "rating": 4.5,
      "reviews": 324,
      "image": "https://picsum.photos/300/200?random=1&keyword=store",
      "openTime": "08:00",
      "closeTime": "22:00",
      "services": ["Pharmacy", "Grocery", "Electronics"],
      "features": ["WiFi", "Parking", "ATM"],
    },
    {
      "id": "2",
      "name": "Westside Mall",
      "address": "456 Shopping Blvd, Westside",
      "city": "New York",
      "state": "NY",
      "zipCode": "10025",
      "phone": "(555) 234-5678",
      "latitude": 40.7831,
      "longitude": -73.9712,
      "distance": 1.2,
      "isOpen": true,
      "is24Hours": false,
      "hasDriveThru": true,
      "hasPharmacy": false,
      "rating": 4.2,
      "reviews": 156,
      "image": "https://picsum.photos/300/200?random=2&keyword=mall",
      "openTime": "09:00",
      "closeTime": "21:00",
      "services": ["Grocery", "Fashion", "Food Court"],
      "features": ["WiFi", "Parking", "Kids Area"],
    },
    {
      "id": "3",
      "name": "Express Station",
      "address": "789 Highway 101, North",
      "city": "New York",
      "state": "NY",
      "zipCode": "10035",
      "phone": "(555) 345-6789",
      "latitude": 40.8176,
      "longitude": -73.9482,
      "distance": 2.8,
      "isOpen": true,
      "is24Hours": true,
      "hasDriveThru": true,
      "hasPharmacy": false,
      "rating": 3.9,
      "reviews": 89,
      "image": "https://picsum.photos/300/200?random=3&keyword=station",
      "openTime": "00:00",
      "closeTime": "23:59",
      "services": ["Gas", "Convenience", "Car Wash"],
      "features": ["24/7", "Drive-thru", "ATM"],
    },
    {
      "id": "4",
      "name": "Central Plaza",
      "address": "321 Central Avenue, Midtown",
      "city": "New York",
      "state": "NY",
      "zipCode": "10018",
      "phone": "(555) 456-7890",
      "latitude": 40.7505,
      "longitude": -73.9934,
      "distance": 0.8,
      "isOpen": false,
      "is24Hours": false,
      "hasDriveThru": false,
      "hasPharmacy": true,
      "rating": 4.7,
      "reviews": 234,
      "image": "https://picsum.photos/300/200?random=4&keyword=plaza",
      "openTime": "07:00",
      "closeTime": "23:00",
      "services": ["Pharmacy", "Grocery", "Banking"],
      "features": ["WiFi", "Parking", "Wheelchair Access"],
    },
    {
      "id": "5",
      "name": "Eastside Market",
      "address": "654 Market Street, Eastside",
      "city": "New York",
      "state": "NY",
      "zipCode": "10009",
      "phone": "(555) 567-8901",
      "latitude": 40.7282,
      "longitude": -73.9942,
      "distance": 1.5,
      "isOpen": true,
      "is24Hours": false,
      "hasDriveThru": false,
      "hasPharmacy": false,
      "rating": 4.3,
      "reviews": 178,
      "image": "https://picsum.photos/300/200?random=5&keyword=market",
      "openTime": "06:00",
      "closeTime": "24:00",
      "services": ["Grocery", "Deli", "Bakery"],
      "features": ["WiFi", "Parking", "Fresh Produce"],
    },
  ];

  List<Map<String, dynamic>> get filteredStores {
    return stores.where((store) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${store["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${store["address"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${store["city"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" ||
          (selectedFilter == "Open" && store["isOpen"] == true) ||
          (selectedFilter == "24/7" && store["is24Hours"] == true) ||
          (selectedFilter == "Drive-thru" && store["hasDriveThru"] == true) ||
          (selectedFilter == "Pharmacy" && store["hasPharmacy"] == true);
      
      return matchesSearch && matchesFilter;
    }).toList()..sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Locator"),
        actions: [
          IconButton(
            icon: Icon(showMap ? Icons.list : Icons.map),
            onPressed: () {
              showMap = !showMap;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search by location or store name",
                    value: searchQuery,
                    hint: "Enter city, zip code, or store name",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.my_location,
                  size: bs.sm,
                  onPressed: () {
                    _getCurrentLocation();
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            QCategoryPicker(
              label: "Filter Stores",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Map Toggle Section
            if (showMap) ...[
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledColor),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        size: 60,
                        color: disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Interactive Map",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Map integration would be implemented here",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: spMd),
            ],
            
            // Results Header
            Row(
              children: [
                Text(
                  "Stores Near You",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredStores.length} found",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Stores List
            if (filteredStores.isEmpty)
              Container(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.store,
                        size: 60,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No stores found",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Try adjusting your search criteria",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredStores.length,
                itemBuilder: (context, index) {
                  final store = filteredStores[index];
                  return _buildStoreCard(store);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: (store["isOpen"] as bool) ? successColor : dangerColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${store["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(store["distance"] as double).toStringAsFixed(1)} mi away",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: (store["isOpen"] as bool) 
                        ? successColor.withAlpha(25) 
                        : dangerColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    (store["isOpen"] as bool) ? "Open" : "Closed",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: (store["isOpen"] as bool) ? successColor : dangerColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Store Image and Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${store["image"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                SizedBox(width: spSm),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${store["address"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${store["city"]}, ${store["state"]} ${store["zipCode"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.star, color: warningColor, size: 14),
                          SizedBox(width: spXs),
                          Text(
                            "${store["rating"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "(${store["reviews"]})",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Store Hours
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    (store["is24Hours"] as bool) 
                        ? "Open 24 hours" 
                        : "${store["openTime"]} - ${store["closeTime"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.phone,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${store["phone"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Features and Services
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (store["features"] as List<String>).take(3).map((feature) => 
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Call Store",
                    icon: Icons.phone,
                    size: bs.sm,
                    onPressed: () {
                      _callStore(store);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Get Directions",
                    icon: Icons.directions,
                    size: bs.sm,
                    onPressed: () {
                      _getDirections(store);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () {
                    _showStoreDetails(store);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getCurrentLocation() {
    si("Getting your current location...");
    // Implement location services
  }

  void _callStore(Map<String, dynamic> store) {
    ss("Calling ${store["name"]} at ${store["phone"]}");
    // Implement phone call functionality
  }

  void _getDirections(Map<String, dynamic> store) {
    ss("Opening directions to ${store["name"]}");
    // Implement maps/navigation integration
  }

  void _showStoreDetails(Map<String, dynamic> store) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${store["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Services Available:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spXs),
            ...(store["services"] as List<String>).map((service) => 
              Text("• $service"),
            ).toList(),
            SizedBox(height: spSm),
            Text(
              "Features:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spXs),
            ...(store["features"] as List<String>).map((feature) => 
              Text("• $feature"),
            ).toList(),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
