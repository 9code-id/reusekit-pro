import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaSavedSearchesView extends StatefulWidget {
  const ReaSavedSearchesView({super.key});

  @override
  State<ReaSavedSearchesView> createState() => _ReaSavedSearchesViewState();
}

class _ReaSavedSearchesViewState extends State<ReaSavedSearchesView> {
  String selectedSortBy = "Recently Created";
  bool showActiveOnly = false;

  List<String> sortOptions = ["Recently Created", "Name A-Z", "Name Z-A", "Most Results", "Least Results"];

  List<Map<String, dynamic>> savedSearches = [
    {
      "id": "search_001",
      "name": "Luxury Villas Beverly Hills",
      "description": "High-end villas in Beverly Hills area with pool and garden",
      "criteria": {
        "location": "Beverly Hills, CA",
        "propertyType": "Villa",
        "priceRange": "\$2M - \$5M",
        "bedrooms": "4+",
        "bathrooms": "3+",
        "amenities": ["Swimming Pool", "Garden", "Garage"],
        "yearBuilt": "2010+",
        "area": "3000+ sqft"
      },
      "resultsCount": 23,
      "newListings": 3,
      "priceAlerts": 2,
      "createdDate": "2024-01-20 10:30:00",
      "lastUpdated": "2024-01-21 08:00:00",
      "alertsEnabled": true,
      "emailNotifications": true,
      "pushNotifications": true,
      "isActive": true,
      "totalViews": 156,
      "averagePrice": 3200000,
    },
    {
      "id": "search_002",
      "name": "Downtown Penthouses",
      "description": "Modern penthouses in downtown area with city views",
      "criteria": {
        "location": "Downtown, Manhattan",
        "propertyType": "Penthouse",
        "priceRange": "\$1M - \$3M",
        "bedrooms": "2+",
        "bathrooms": "2+",
        "amenities": ["City View", "Terrace", "Concierge"],
        "yearBuilt": "2015+",
        "area": "1500+ sqft"
      },
      "resultsCount": 15,
      "newListings": 1,
      "priceAlerts": 0,
      "createdDate": "2024-01-18 14:15:00",
      "lastUpdated": "2024-01-21 06:30:00",
      "alertsEnabled": true,
      "emailNotifications": false,
      "pushNotifications": true,
      "isActive": true,
      "totalViews": 89,
      "averagePrice": 1800000,
    },
    {
      "id": "search_003",
      "name": "Family Homes Suburbs",
      "description": "Family-friendly homes in suburban areas with good schools",
      "criteria": {
        "location": "Westfield, NJ",
        "propertyType": "House",
        "priceRange": "\$500k - \$1M",
        "bedrooms": "3+",
        "bathrooms": "2+",
        "amenities": ["Garden", "Garage", "Near Schools"],
        "yearBuilt": "2000+",
        "area": "2000+ sqft"
      },
      "resultsCount": 67,
      "newListings": 8,
      "priceAlerts": 5,
      "createdDate": "2024-01-15 09:45:00",
      "lastUpdated": "2024-01-21 07:15:00",
      "alertsEnabled": false,
      "emailNotifications": true,
      "pushNotifications": false,
      "isActive": true,
      "totalViews": 234,
      "averagePrice": 750000,
    },
    {
      "id": "search_004",
      "name": "Waterfront Condos",
      "description": "Luxury condos with water views and marina access",
      "criteria": {
        "location": "Harbor District",
        "propertyType": "Condo",
        "priceRange": "\$800k - \$2M",
        "bedrooms": "2+",
        "bathrooms": "2+",
        "amenities": ["Water View", "Marina Access", "Pool"],
        "yearBuilt": "2012+",
        "area": "1200+ sqft"
      },
      "resultsCount": 31,
      "newListings": 2,
      "priceAlerts": 1,
      "createdDate": "2024-01-12 16:20:00",
      "lastUpdated": "2024-01-20 09:45:00",
      "alertsEnabled": true,
      "emailNotifications": true,
      "pushNotifications": true,
      "isActive": false,
      "totalViews": 78,
      "averagePrice": 1200000,
    },
    {
      "id": "search_005",
      "name": "Investment Properties",
      "description": "Properties with high rental yield potential",
      "criteria": {
        "location": "Various Locations",
        "propertyType": "Any",
        "priceRange": "Under \$500k",
        "bedrooms": "1+",
        "bathrooms": "1+",
        "amenities": ["Near Public Transport", "Shopping Center"],
        "yearBuilt": "Any",
        "area": "800+ sqft"
      },
      "resultsCount": 145,
      "newListings": 12,
      "priceAlerts": 8,
      "createdDate": "2024-01-10 11:30:00",
      "lastUpdated": "2024-01-21 05:20:00",
      "alertsEnabled": true,
      "emailNotifications": false,
      "pushNotifications": true,
      "isActive": true,
      "totalViews": 345,
      "averagePrice": 350000,
    },
  ];

  List<Map<String, dynamic>> get filteredSearches {
    List<Map<String, dynamic>> filtered = savedSearches;
    
    if (showActiveOnly) {
      filtered = filtered.where((search) => search["isActive"] == true).toList();
    }
    
    // Sort searches
    switch (selectedSortBy) {
      case "Recently Created":
        filtered.sort((a, b) => DateTime.parse(b["createdDate"]).compareTo(DateTime.parse(a["createdDate"])));
        break;
      case "Name A-Z":
        filtered.sort((a, b) => a["name"].toString().compareTo(b["name"].toString()));
        break;
      case "Name Z-A":
        filtered.sort((a, b) => b["name"].toString().compareTo(a["name"].toString()));
        break;
      case "Most Results":
        filtered.sort((a, b) => (b["resultsCount"] as int).compareTo(a["resultsCount"] as int));
        break;
      case "Least Results":
        filtered.sort((a, b) => (a["resultsCount"] as int).compareTo(b["resultsCount"] as int));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Searches"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('CreateSearchView');
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Searches",
                    "${savedSearches.length}",
                    Icons.search,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Active Alerts",
                    "${savedSearches.where((s) => s["alertsEnabled"] == true).length}",
                    Icons.notifications_active,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "New Listings",
                    "${savedSearches.fold(0, (sum, s) => sum + (s["newListings"] as int))}",
                    Icons.new_releases,
                    warningColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions.map((option) => {
                      "label": option,
                      "value": option,
                    }).toList(),
                    value: selectedSortBy,
                    onChanged: (value, label) {
                      selectedSortBy = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Active Only",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Switch(
                      value: showActiveOnly,
                      onChanged: (value) {
                        showActiveOnly = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Searches List
          Expanded(
            child: filteredSearches.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.all(spSm),
                    itemCount: filteredSearches.length,
                    itemBuilder: (context, index) {
                      final search = filteredSearches[index];
                      return _buildSearchCard(search);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo('CreateSearchView');
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCard(Map<String, dynamic> search) {
    bool hasNewListings = (search["newListings"] as int) > 0;
    bool hasPriceAlerts = (search["priceAlerts"] as int) > 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: search["isActive"] 
            ? Border.all(color: primaryColor.withAlpha(51))
            : null,
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: search["isActive"] 
                  ? primaryColor.withAlpha(25)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${search["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: search["isActive"] ? successColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              search["isActive"] ? "Active" : "Inactive",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${search["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Search Statistics
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSearchStat(
                        "Results",
                        "${search["resultsCount"]}",
                        Icons.home_work,
                        primaryColor,
                      ),
                    ),
                    Expanded(
                      child: _buildSearchStat(
                        "New Listings",
                        "${search["newListings"]}",
                        Icons.new_releases,
                        hasNewListings ? warningColor : disabledBoldColor,
                      ),
                    ),
                    Expanded(
                      child: _buildSearchStat(
                        "Price Alerts",
                        "${search["priceAlerts"]}",
                        Icons.trending_down,
                        hasPriceAlerts ? dangerColor : disabledBoldColor,
                      ),
                    ),
                    Expanded(
                      child: _buildSearchStat(
                        "Avg Price",
                        "\$${((search["averagePrice"] as int) / 1000).toInt()}k",
                        Icons.attach_money,
                        infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Search Criteria Summary
                Text(
                  "Search Criteria:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spSm,
                  runSpacing: spXs,
                  children: (search["criteria"] as Map<String, dynamic>).entries.map<Widget>((entry) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Text(
                        "${entry.key}: ${entry.value}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: spMd),
                
                // Notification Settings
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            search["alertsEnabled"] ? Icons.notifications_active : Icons.notifications_off,
                            color: search["alertsEnabled"] ? successColor : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Alerts ${search["alertsEnabled"] ? "On" : "Off"}",
                            style: TextStyle(
                              fontSize: 12,
                              color: search["alertsEnabled"] ? successColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            search["emailNotifications"] ? Icons.email : Icons.email_outlined,
                            color: search["emailNotifications"] ? infoColor : disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Email ${search["emailNotifications"] ? "On" : "Off"}",
                            style: TextStyle(
                              fontSize: 12,
                              color: search["emailNotifications"] ? infoColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Created ${search["createdDate"]}".split(' ')[0],
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Results",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('SearchResultsView', arguments: search);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Edit Search",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('EditSearchView', arguments: search);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: search["alertsEnabled"] ? Icons.notifications_off : Icons.notifications_active,
                      size: bs.sm,
                      onPressed: () {
                        _toggleAlerts(search);
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.delete,
                      size: bs.sm,
                      onPressed: () {
                        _deleteSearch(search);
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

  Widget _buildSearchStat(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
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
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: disabledBoldColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Saved Searches",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Create your first search to get notified about new properties that match your criteria",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spLg),
            QButton(
              label: "Create Search",
              size: bs.md,
              onPressed: () {
                // navigateTo('CreateSearchView');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleAlerts(Map<String, dynamic> search) {
    search["alertsEnabled"] = !search["alertsEnabled"];
    setState(() {});
    ss(search["alertsEnabled"] ? "Alerts enabled" : "Alerts disabled");
  }

  void _deleteSearch(Map<String, dynamic> search) async {
    bool isConfirmed = await confirm("Delete this saved search? You will lose all alerts and notifications for this search.");
    if (isConfirmed) {
      savedSearches.remove(search);
      setState(() {});
      ss("Search deleted successfully");
    }
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter & Sort",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Sort By",
              items: sortOptions.map((option) => {
                "label": option,
                "value": option,
              }).toList(),
              value: selectedSortBy,
              onChanged: (value, label) {
                selectedSortBy = value;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Text("Show Active Only"),
                Spacer(),
                Switch(
                  value: showActiveOnly,
                  onChanged: (value) {
                    showActiveOnly = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.sm,
                    onPressed: () {
                      selectedSortBy = "Recently Created";
                      showActiveOnly = false;
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply",
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
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
}
