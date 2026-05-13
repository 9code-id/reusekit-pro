import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAddress6View extends StatefulWidget {
  @override
  State<GrlAddress6View> createState() => _GrlAddress6ViewState();
}

class _GrlAddress6ViewState extends State<GrlAddress6View> {
  String searchQuery = "";
  String selectedCategory = "all";
  String sortBy = "name";
  
  List<Map<String, dynamic>> savedAddresses = [
    {
      "id": 1,
      "title": "Home Sweet Home",
      "name": "John Doe",
      "phone": "+1 (555) 123-4567",
      "address": "123 Main Street, Apt 4B",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States",
      "category": "home",
      "isDefault": true,
      "isFavorite": true,
      "usageCount": 45,
      "lastUsed": DateTime.now().subtract(Duration(days: 2)),
      "createdAt": DateTime.now().subtract(Duration(days: 180)),
    },
    {
      "id": 2,
      "title": "Corporate Office",
      "name": "John Doe",
      "phone": "+1 (555) 987-6543",
      "address": "456 Business Avenue, Suite 200",
      "city": "New York",
      "state": "NY",
      "zipCode": "10002",
      "country": "United States",
      "category": "work",
      "isDefault": false,
      "isFavorite": true,
      "usageCount": 23,
      "lastUsed": DateTime.now().subtract(Duration(days: 5)),
      "createdAt": DateTime.now().subtract(Duration(days: 120)),
    },
    {
      "id": 3,
      "title": "Mom's Place",
      "name": "Sarah Doe",
      "phone": "+1 (555) 456-7890",
      "address": "789 Family Road",
      "city": "Brooklyn",
      "state": "NY",
      "zipCode": "11201",
      "country": "United States",
      "category": "family",
      "isDefault": false,
      "isFavorite": false,
      "usageCount": 8,
      "lastUsed": DateTime.now().subtract(Duration(days: 30)),
      "createdAt": DateTime.now().subtract(Duration(days: 90)),
    },
    {
      "id": 4,
      "title": "Beach House",
      "name": "John Doe",
      "phone": "+1 (555) 321-0987",
      "address": "321 Beach Drive",
      "city": "Miami",
      "state": "FL",
      "zipCode": "33101",
      "country": "United States",
      "category": "vacation",
      "isDefault": false,
      "isFavorite": true,
      "usageCount": 12,
      "lastUsed": DateTime.now().subtract(Duration(days: 60)),
      "createdAt": DateTime.now().subtract(Duration(days: 45)),
    },
    {
      "id": 5,
      "title": "Gym Location",
      "name": "John Doe",
      "phone": "+1 (555) 111-2222",
      "address": "999 Fitness Street",
      "city": "New York",
      "state": "NY",
      "zipCode": "10003",
      "country": "United States",
      "category": "other",
      "isDefault": false,
      "isFavorite": false,
      "usageCount": 3,
      "lastUsed": DateTime.now().subtract(Duration(days: 90)),
      "createdAt": DateTime.now().subtract(Duration(days: 30)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredAddresses = _getFilteredAddresses();

    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Addresses"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(AddAddressView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: "Search addresses, names, or locations...",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: disabledBoldColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                    ),
                  ),
                ),
                
                // Category Filter
                QHorizontalScroll(
                  children: ['all', 'home', 'work', 'family', 'vacation', 'other']
                      .map((category) => GestureDetector(
                        onTap: () {
                          selectedCategory = category;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: selectedCategory == category ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                            border: selectedCategory != category
                                ? Border.all(color: disabledOutlineBorderColor)
                                : null,
                          ),
                          child: Text(
                            category.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: selectedCategory == category ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      )).toList(),
                ),
              ],
            ),
          ),

          // Stats Row
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total",
                    "${savedAddresses.length}",
                    Icons.location_on,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Favorites",
                    "${savedAddresses.where((a) => a["isFavorite"] as bool).length}",
                    Icons.favorite,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Recent",
                    "${savedAddresses.where((a) => (a["lastUsed"] as DateTime).isAfter(DateTime.now().subtract(Duration(days: 7)))).length}",
                    Icons.access_time,
                    successColor,
                  ),
                ),
              ],
            ),
          ),

          // Address List
          Expanded(
            child: filteredAddresses.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: filteredAddresses.length,
                    itemBuilder: (context, index) {
                      final address = filteredAddresses[index];
                      return _buildAddressCard(address, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
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
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          // Address Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getCategoryColor(address["category"]).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(address["category"]),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    _getCategoryIcon(address["category"]),
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${address["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (address["isDefault"] as bool)
                            Container(
                              margin: EdgeInsets.only(left: spSm),
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "DEFAULT",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${address["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    address["isFavorite"] = !(address["isFavorite"] as bool);
                    setState(() {});
                    ss(address["isFavorite"] as bool ? "Added to favorites" : "Removed from favorites");
                  },
                  child: Icon(
                    address["isFavorite"] as bool ? Icons.favorite : Icons.favorite_border,
                    color: address["isFavorite"] as bool ? dangerColor : disabledBoldColor,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Address Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${address["address"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${address["city"]}, ${address["state"]} ${address["zipCode"]}",
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
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${address["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Used ${address["usageCount"]} times",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Last used: ${(address["lastUsed"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Created: ${(address["createdAt"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo(EditAddressView(address));
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Use",
                        size: bs.sm,
                        onPressed: () {
                          address["usageCount"] = (address["usageCount"] as int) + 1;
                          address["lastUsed"] = DateTime.now();
                          setState(() {});
                          ss("Address selected for delivery");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.delete,
                      size: bs.sm,
                      onPressed: () async {
                        bool isConfirmed = await confirm("Are you sure you want to delete this address?");
                        if (isConfirmed) {
                          savedAddresses.removeWhere((a) => a["id"] == address["id"]);
                          setState(() {});
                          ss("Address deleted successfully");
                        }
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 64,
            color: disabledBoldColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No addresses found",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Try adjusting your search or filter criteria",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Add New Address",
            size: bs.md,
            icon: Icons.add,
            onPressed: () {
              // navigateTo(AddAddressView());
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredAddresses() {
    List<Map<String, dynamic>> filtered = savedAddresses;

    // Filter by category
    if (selectedCategory != 'all') {
      filtered = filtered.where((address) => address["category"] == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((address) {
        return address["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               address["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               address["address"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               address["city"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Sort addresses
    switch (sortBy) {
      case 'name':
        filtered.sort((a, b) => a["title"].compareTo(b["title"]));
        break;
      case 'usage':
        filtered.sort((a, b) => (b["usageCount"] as int).compareTo(a["usageCount"] as int));
        break;
      case 'recent':
        filtered.sort((a, b) => (b["lastUsed"] as DateTime).compareTo(a["lastUsed"] as DateTime));
        break;
      case 'created':
        filtered.sort((a, b) => (b["createdAt"] as DateTime).compareTo(a["createdAt"] as DateTime));
        break;
    }

    return filtered;
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort Addresses",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...['name', 'usage', 'recent', 'created'].map((option) => ListTile(
              title: Text(_getSortOptionTitle(option)),
              leading: Radio<String>(
                value: option,
                groupValue: sortBy,
                onChanged: (value) {
                  sortBy = value!;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  String _getSortOptionTitle(String option) {
    switch (option) {
      case 'name':
        return 'Name (A-Z)';
      case 'usage':
        return 'Most Used';
      case 'recent':
        return 'Recently Used';
      case 'created':
        return 'Recently Added';
      default:
        return option;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'home':
        return primaryColor;
      case 'work':
        return infoColor;
      case 'family':
        return successColor;
      case 'vacation':
        return warningColor;
      default:
        return dangerColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'home':
        return Icons.home;
      case 'work':
        return Icons.business;
      case 'family':
        return Icons.family_restroom;
      case 'vacation':
        return Icons.beach_access;
      default:
        return Icons.location_on;
    }
  }
}
