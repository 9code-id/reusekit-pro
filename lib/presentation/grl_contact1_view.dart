import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlContact1View extends StatefulWidget {
  @override
  State<GrlContact1View> createState() => _GrlContact1ViewState();
}

class _GrlContact1ViewState extends State<GrlContact1View> {
  String searchQuery = '';
  String selectedCategory = 'all';
  bool isGridView = false;
  
  List<Map<String, dynamic>> contacts = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@email.com",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "company": "Tech Solutions Inc.",
      "position": "Senior Developer",
      "category": "work",
      "favorite": true,
      "lastContact": DateTime.now().subtract(Duration(days: 2)),
      "status": "online",
    },
    {
      "id": 2,
      "name": "Michael Chen",
      "phone": "+1 (555) 987-6543",
      "email": "michael.chen@email.com",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "company": "Design Studio",
      "position": "Art Director",
      "category": "work",
      "favorite": false,
      "lastContact": DateTime.now().subtract(Duration(days: 5)),
      "status": "away",
    },
    {
      "id": 3,
      "name": "Emily Rodriguez",
      "phone": "+1 (555) 456-7890",
      "email": "emily.rodriguez@email.com",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "company": "",
      "position": "",
      "category": "family",
      "favorite": true,
      "lastContact": DateTime.now().subtract(Duration(hours: 3)),
      "status": "online",
    },
    {
      "id": 4,
      "name": "David Wilson",
      "phone": "+1 (555) 321-0987",
      "email": "david.wilson@email.com",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "company": "Marketing Pro",
      "position": "Manager",
      "category": "work",
      "favorite": false,
      "lastContact": DateTime.now().subtract(Duration(days: 1)),
      "status": "offline",
    },
    {
      "id": 5,
      "name": "Lisa Thompson",
      "phone": "+1 (555) 654-3210",
      "email": "lisa.thompson@email.com",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=woman",
      "company": "",
      "position": "",
      "category": "friends",
      "favorite": true,
      "lastContact": DateTime.now().subtract(Duration(hours: 8)),
      "status": "online",
    },
  ];

  List<Map<String, dynamic>> get filteredContacts {
    List<Map<String, dynamic>> filtered = contacts;
    
    if (selectedCategory != 'all') {
      filtered = filtered.where((contact) => contact["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((contact) =>
        (contact["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (contact["phone"] as String).contains(searchQuery) ||
        (contact["email"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort by favorites first, then by name
    filtered.sort((a, b) {
      if (a["favorite"] && !b["favorite"]) return -1;
      if (!a["favorite"] && b["favorite"]) return 1;
      return (a["name"] as String).compareTo(b["name"] as String);
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // navigateTo(AddContactView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Icon(
                            Icons.search,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search contacts...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: disabledBoldColor,
                              ),
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
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showFilterBottomSheet();
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Category Filter
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: [
                'all', 'work', 'family', 'friends'
              ].map((category) => GestureDetector(
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
                    border: Border.all(
                      color: selectedCategory == category ? primaryColor : disabledColor,
                    ),
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
          ),
          
          // Contacts List
          Expanded(
            child: isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AddContactView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                // Avatar with status indicator
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage("${contact["avatar"]}"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _getStatusColor(contact["status"]),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spMd),
                
                // Contact Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${contact["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (contact["favorite"] as bool)
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${contact["phone"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if ((contact["company"] as String).isNotEmpty) ...[
                        SizedBox(height: spXs),
                        Text(
                          "${contact["position"]} at ${contact["company"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                      SizedBox(height: spXs),
                      Text(
                        "Last contact: ${_formatLastContact(contact["lastContact"] as DateTime)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Action Buttons
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: successColor,
                      ),
                      onPressed: () {
                        // Make phone call
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        color: infoColor,
                      ),
                      onPressed: () {
                        // Send message
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 200,
      children: filteredContacts.map((contact) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                // Avatar with status
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage("${contact["avatar"]}"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: _getStatusColor(contact["status"]),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    if (contact["favorite"] as bool)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Contact Info
                Text(
                  "${contact["name"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${contact["phone"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if ((contact["company"] as String).isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${contact["company"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                
                Spacer(),
                
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: successColor,
                      ),
                      onPressed: () {
                        // Make phone call
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        color: infoColor,
                      ),
                      onPressed: () {
                        // Send message
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.email,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        // Send email
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radiusLg),
        ),
      ),
      builder: (context) {
        return Container(
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
              
              // Filter by Category
              Text(
                "Category",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spSm,
                children: ['all', 'work', 'family', 'friends'].map((category) {
                  return FilterChip(
                    label: Text(category.toUpperCase()),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      if (selected) {
                        selectedCategory = category;
                        setState(() {});
                        back();
                      }
                    },
                  );
                }).toList(),
              ),
              
              SizedBox(height: spMd),
              
              // Filter by Status
              Text(
                "Status",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spSm),
              Wrap(
                spacing: spSm,
                children: ['all', 'online', 'away', 'offline'].map((status) {
                  return FilterChip(
                    label: Text(status.toUpperCase()),
                    selected: false,
                    onSelected: (selected) {
                      // Implement status filtering
                    },
                  );
                }).toList(),
              ),
              
              SizedBox(height: spMd),
              
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Clear Filters",
                      onPressed: () {
                        selectedCategory = 'all';
                        setState(() {});
                        back();
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Apply",
                      onPressed: () {
                        back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'online':
        return successColor;
      case 'away':
        return warningColor;
      case 'offline':
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  String _formatLastContact(DateTime lastContact) {
    final now = DateTime.now();
    final difference = now.difference(lastContact);
    
    if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inDays < 1) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return lastContact.dMMMy;
    }
  }
}
