import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAddress1View extends StatefulWidget {
  @override
  State<GrlAddress1View> createState() => _GrlAddress1ViewState();
}

class _GrlAddress1ViewState extends State<GrlAddress1View> {
  String selectedAddressType = 'all';
  String searchQuery = '';
  
  List<Map<String, dynamic>> addresses = [
    {
      "id": 1,
      "label": "Home",
      "name": "John Doe",
      "phone": "+1 234 567 8900",
      "address": "123 Main Street, Apt 4B",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States",
      "type": "home",
      "isDefault": true,
      "lastUsed": DateTime.now().subtract(Duration(days: 2)),
    },
    {
      "id": 2,
      "label": "Office",
      "name": "John Doe",
      "phone": "+1 234 567 8900",
      "address": "456 Business Ave, Suite 200",
      "city": "New York",
      "state": "NY",
      "zipCode": "10002",
      "country": "United States",
      "type": "office",
      "isDefault": false,
      "lastUsed": DateTime.now().subtract(Duration(days: 7)),
    },
    {
      "id": 3,
      "label": "Mom's House",
      "name": "Jane Doe",
      "phone": "+1 234 567 8901",
      "address": "789 Family Lane",
      "city": "Brooklyn",
      "state": "NY",
      "zipCode": "11201",
      "country": "United States",
      "type": "family",
      "isDefault": false,
      "lastUsed": DateTime.now().subtract(Duration(days: 15)),
    },
    {
      "id": 4,
      "label": "Vacation Home",
      "name": "John Doe",
      "phone": "+1 234 567 8900",
      "address": "321 Beach Road",
      "city": "Miami",
      "state": "FL",
      "zipCode": "33101",
      "country": "United States",
      "type": "other",
      "isDefault": false,
      "lastUsed": DateTime.now().subtract(Duration(days: 30)),
    },
  ];

  List<Map<String, dynamic>> get filteredAddresses {
    return addresses.where((address) {
      bool matchesType = selectedAddressType == 'all' || address["type"] == selectedAddressType;
      bool matchesSearch = searchQuery.isEmpty || 
                          address["label"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          address["address"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          address["city"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Addresses"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(GrlAddress2View());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search addresses...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: disabledBoldColor),
                            ),
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterBottomSheet();
                  },
                ),
              ],
            ),
          ),
          
          // Address Type Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: [
                {'label': 'All', 'value': 'all'},
                {'label': 'Home', 'value': 'home'},
                {'label': 'Office', 'value': 'office'},
                {'label': 'Family', 'value': 'family'},
                {'label': 'Other', 'value': 'other'},
              ].map((type) => GestureDetector(
                onTap: () {
                  selectedAddressType = type['value']!;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: selectedAddressType == type['value'] ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: selectedAddressType == type['value'] ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    type['label']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selectedAddressType == type['value'] ? Colors.white : disabledBoldColor,
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
          
          // Address Count
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            child: Text(
              "${filteredAddresses.length} address${filteredAddresses.length != 1 ? 'es' : ''} found",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          // Addresses List
          Expanded(
            child: filteredAddresses.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: filteredAddresses.length,
                    itemBuilder: (context, index) {
                      final address = filteredAddresses[index];
                      return _buildAddressCard(address);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(GrlAddress2View());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
        border: address["isDefault"] as bool
            ? Border.all(color: primaryColor, width: 2)
            : null,
      ),
      child: Column(
        children: [
          // Address Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: address["isDefault"] as bool
                  ? primaryColor.withAlpha(20)
                  : Colors.grey[50],
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
                    color: _getAddressTypeColor(address["type"]),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    _getAddressTypeIcon(address["type"]),
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
                            "${address["label"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          if (address["isDefault"] as bool) ...[
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor,
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
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        "${address["type"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: disabledBoldColor,
                  ),
                  onSelected: (value) {
                    _handleAddressAction(value, address);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18, color: primaryColor),
                          SizedBox(width: spSm),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    if (!(address["isDefault"] as bool))
                      PopupMenuItem(
                        value: 'setDefault',
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 18, color: warningColor),
                            SizedBox(width: spSm),
                            Text('Set as Default'),
                          ],
                        ),
                      ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: dangerColor),
                          SizedBox(width: spSm),
                          Text('Delete'),
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
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Phone
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${address["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.phone,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${address["phone"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Full Address
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
                      child: Text(
                        "${address["address"]}\n${address["city"]}, ${address["state"]} ${address["zipCode"]}\n${address["country"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Last Used & Actions
                Row(
                  children: [
                    Text(
                      "Last used: ${_formatLastUsed(address["lastUsed"] as DateTime)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Select",
                      size: bs.sm,
                      onPressed: () {
                        _selectAddress(address);
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
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No addresses found",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Add your first address to get started",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Add Address",
            size: bs.md,
            icon: Icons.add,
            onPressed: () {
              // navigateTo(GrlAddress2View());
            },
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Text("Sort by:"),
            SizedBox(height: spSm),
            ...[
              'Recently Used',
              'Alphabetical',
              'Type',
              'Default First',
            ].map((option) => ListTile(
              title: Text(option),
              leading: Radio<String>(
                value: option.toLowerCase(),
                groupValue: 'recently',
                onChanged: (value) {},
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _handleAddressAction(String action, Map<String, dynamic> address) async {
    switch (action) {
      case 'edit':
        // navigateTo(GrlAddress2View(address: address));
        break;
      case 'setDefault':
        _setAsDefault(address);
        break;
      case 'delete':
        bool isConfirmed = await confirm("Are you sure you want to delete this address?");
        if (isConfirmed) {
          _deleteAddress(address);
        }
        break;
    }
  }

  void _setAsDefault(Map<String, dynamic> address) {
    for (var addr in addresses) {
      addr["isDefault"] = false;
    }
    address["isDefault"] = true;
    setState(() {});
    ss("Address set as default");
  }

  void _deleteAddress(Map<String, dynamic> address) {
    addresses.removeWhere((addr) => addr["id"] == address["id"]);
    setState(() {});
    ss("Address deleted successfully");
  }

  void _selectAddress(Map<String, dynamic> address) {
    // Update last used
    address["lastUsed"] = DateTime.now();
    setState(() {});
    
    // Navigate back with selected address
    back();
    ss("Address selected: ${address["label"]}");
  }

  Color _getAddressTypeColor(String type) {
    switch (type) {
      case 'home':
        return primaryColor;
      case 'office':
        return infoColor;
      case 'family':
        return successColor;
      case 'other':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  IconData _getAddressTypeIcon(String type) {
    switch (type) {
      case 'home':
        return Icons.home;
      case 'office':
        return Icons.business;
      case 'family':
        return Icons.family_restroom;
      case 'other':
        return Icons.location_on;
      default:
        return Icons.location_on;
    }
  }

  String _formatLastUsed(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else {
      return "${(difference.inDays / 30).floor()} months ago";
    }
  }
}
