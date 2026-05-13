import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaAddressBookView extends StatefulWidget {
  const SpaAddressBookView({Key? key}) : super(key: key);

  @override
  State<SpaAddressBookView> createState() => _SpaAddressBookViewState();
}

class _SpaAddressBookViewState extends State<SpaAddressBookView> {
  String searchQuery = "";
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> addresses = [
    {
      "id": 1,
      "label": "Home",
      "name": "Sarah Johnson",
      "phone": "+1 (555) 123-4567",
      "address": "123 Oak Street",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States",
      "isDefault": true,
      "type": "home",
      "latitude": 40.7128,
      "longitude": -74.0060,
      "lastUsed": "2024-06-15",
      "instructions": "Ring the doorbell twice",
    },
    {
      "id": 2,
      "label": "Office",
      "name": "Sarah Johnson",
      "phone": "+1 (555) 123-4567",
      "address": "456 Business Ave, Suite 200",
      "city": "New York",
      "state": "NY",
      "zipCode": "10002",
      "country": "United States",
      "isDefault": false,
      "type": "work",
      "latitude": 40.7589,
      "longitude": -73.9851,
      "lastUsed": "2024-06-10",
      "instructions": "Ask for Sarah at reception",
    },
    {
      "id": 3,
      "label": "Mom's House",
      "name": "Margaret Johnson",
      "phone": "+1 (555) 987-6543",
      "address": "789 Family Lane",
      "city": "Brooklyn",
      "state": "NY",
      "zipCode": "11201",
      "country": "United States",
      "isDefault": false,
      "type": "family",
      "latitude": 40.6892,
      "longitude": -73.9442,
      "lastUsed": "2024-06-05",
      "instructions": "Use the back entrance",
    },
    {
      "id": 4,
      "label": "Vacation Home",
      "name": "Sarah Johnson",
      "phone": "+1 (555) 123-4567",
      "address": "321 Beach Road",
      "city": "Miami",
      "state": "FL",
      "zipCode": "33101",
      "country": "United States",
      "isDefault": false,
      "type": "vacation",
      "latitude": 25.7617,
      "longitude": -80.1918,
      "lastUsed": "2024-05-20",
      "instructions": "Key is under the mat",
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Addresses", "value": "all"},
    {"label": "Home", "value": "home"},
    {"label": "Work", "value": "work"},
    {"label": "Family", "value": "family"},
    {"label": "Other", "value": "other"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Book"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              //navigateTo ( SpaAddAddressView )
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search addresses...",
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
                QCategoryPicker(
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (index, label, value, item) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Address Statistics
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Addresses",
                    addresses.length.toString(),
                    Icons.location_on,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Default Address",
                    _getDefaultAddress()["label"],
                    Icons.home,
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Recent Used",
                    _getRecentlyUsedCount().toString(),
                    Icons.history,
                    infoColor,
                  ),
                ),
              ],
            ),
          ),

          // Addresses List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: _getFilteredAddresses().length,
              itemBuilder: (context, index) {
                final address = _getFilteredAddresses()[index];
                return _buildAddressCard(address);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo ( SpaAddAddressView )
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
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
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: (address["isDefault"] as bool)
            ? Border.all(color: primaryColor, width: 2)
            : null,
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (address["isDefault"] as bool)
                  ? primaryColor.withAlpha(25)
                  : Colors.grey[50],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: _getAddressTypeColor(address["type"]).withAlpha(25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getAddressTypeIcon(address["type"]),
                    color: _getAddressTypeColor(address["type"]),
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${address["label"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (address["isDefault"] as bool) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "DEFAULT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: disabledBoldColor),
                  onSelected: (value) {
                    _handleMenuAction(value, address);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "edit",
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: spSm),
                          Text("Edit"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "default",
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 18),
                          SizedBox(width: spSm),
                          Text("Set as Default"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "share",
                      child: Row(
                        children: [
                          Icon(Icons.share, size: 18),
                          SizedBox(width: spSm),
                          Text("Share"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "delete",
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: dangerColor, size: 18),
                          SizedBox(width: spSm),
                          Text("Delete", style: TextStyle(color: dangerColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Address Details
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Full Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 18,
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
                          Text(
                            "${address["country"]}",
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

                // Phone Number
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: infoColor,
                      size: 18,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${address["phone"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // Special Instructions
                if (address["instructions"] != null && 
                    (address["instructions"] as String).isNotEmpty) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: warningColor,
                        size: 18,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${address["instructions"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: warningColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                // Last Used
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Last used: ${_formatDate(address["lastUsed"])}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
                        label: "Use Address",
                        size: bs.sm,
                        onPressed: () {
                          _useAddress(address);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View Map",
                        size: bs.sm,
                        color: infoColor,
                        icon: Icons.map,
                        onPressed: () {
                          _viewOnMap(address);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      color: secondaryColor,
                      onPressed: () {
                        _editAddress(address);
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

  List<Map<String, dynamic>> _getFilteredAddresses() {
    List<Map<String, dynamic>> filtered = List.from(addresses);

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((address) {
        return address["label"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               address["address"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               address["city"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Apply type filter
    if (selectedFilter != "all") {
      filtered = filtered.where((address) => address["type"] == selectedFilter).toList();
    }

    // Sort by default first, then by last used
    filtered.sort((a, b) {
      if (a["isDefault"] as bool && !(b["isDefault"] as bool)) return -1;
      if (!(a["isDefault"] as bool) && b["isDefault"] as bool) return 1;
      return b["lastUsed"].compareTo(a["lastUsed"]);
    });

    return filtered;
  }

  Map<String, dynamic> _getDefaultAddress() {
    return addresses.firstWhere(
      (address) => address["isDefault"] as bool,
      orElse: () => addresses.first,
    );
  }

  int _getRecentlyUsedCount() {
    DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
    return addresses.where((address) {
      DateTime lastUsed = DateTime.parse(address["lastUsed"]);
      return lastUsed.isAfter(oneWeekAgo);
    }).length;
  }

  IconData _getAddressTypeIcon(String type) {
    switch (type) {
      case "home":
        return Icons.home;
      case "work":
        return Icons.work;
      case "family":
        return Icons.family_restroom;
      case "vacation":
        return Icons.beach_access;
      default:
        return Icons.location_on;
    }
  }

  Color _getAddressTypeColor(String type) {
    switch (type) {
      case "home":
        return primaryColor;
      case "work":
        return infoColor;
      case "family":
        return successColor;
      case "vacation":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    int daysDifference = now.difference(date).inDays;

    if (daysDifference == 0) return "Today";
    if (daysDifference == 1) return "Yesterday";
    if (daysDifference < 7) return "$daysDifference days ago";
    if (daysDifference < 30) return "${(daysDifference / 7).floor()} weeks ago";
    return "${date.day}/${date.month}/${date.year}";
  }

  void _handleMenuAction(String action, Map<String, dynamic> address) {
    switch (action) {
      case "edit":
        _editAddress(address);
        break;
      case "default":
        _setAsDefault(address);
        break;
      case "share":
        _shareAddress(address);
        break;
      case "delete":
        _deleteAddress(address);
        break;
    }
  }

  void _useAddress(Map<String, dynamic> address) {
    ss("Using address: ${address["label"]}");
  }

  void _viewOnMap(Map<String, dynamic> address) {
    si("Opening map for ${address["label"]}");
  }

  void _editAddress(Map<String, dynamic> address) {
    //navigateTo ( SpaEditAddressView )
  }

  void _setAsDefault(Map<String, dynamic> address) {
    for (var addr in addresses) {
      addr["isDefault"] = addr["id"] == address["id"];
    }
    setState(() {});
    ss("${address["label"]} set as default address");
  }

  void _shareAddress(Map<String, dynamic> address) {
    si("Address shared: ${address["label"]}");
  }

  void _deleteAddress(Map<String, dynamic> address) async {
    if (address["isDefault"] as bool) {
      se("Cannot delete default address. Please set another address as default first.");
      return;
    }

    bool isConfirmed = await confirm("Are you sure you want to delete this address?");
    if (isConfirmed) {
      addresses.removeWhere((addr) => addr["id"] == address["id"]);
      setState(() {});
      ss("Address deleted successfully");
    }
  }
}
