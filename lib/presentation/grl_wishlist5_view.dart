import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist5View extends StatefulWidget {
  @override
  State<GrlWishlist5View> createState() => _GrlWishlist5ViewState();
}

class _GrlWishlist5ViewState extends State<GrlWishlist5View> {
  bool loading = false;
  String selectedView = "grid";
  bool showSharedLists = false;
  
  List<Map<String, dynamic>> myWishlists = [
    {
      "id": 1,
      "name": "Birthday Wishlist 2024",
      "description": "Things I want for my birthday this year",
      "items": 8,
      "totalValue": 1250.00,
      "isPrivate": false,
      "createdDate": "2024-11-15",
      "coverImage": "https://picsum.photos/400/200?random=30&keyword=birthday",
      "category": "Personal",
      "sharedWith": ["mom", "dad", "sister"],
    },
    {
      "id": 2,
      "name": "Home Office Setup",
      "description": "Upgrading my work from home space",
      "items": 12,
      "totalValue": 2899.99,
      "isPrivate": true,
      "createdDate": "2024-12-01",
      "coverImage": "https://picsum.photos/400/200?random=31&keyword=office",
      "category": "Work",
      "sharedWith": [],
    },
    {
      "id": 3,
      "name": "Summer Vacation Gear",
      "description": "Everything needed for the perfect summer trip",
      "items": 15,
      "totalValue": 890.50,
      "isPrivate": false,
      "createdDate": "2024-10-20",
      "coverImage": "https://picsum.photos/400/200?random=32&keyword=vacation",
      "category": "Travel",
      "sharedWith": ["travel_buddy"],
    },
    {
      "id": 4,
      "name": "Fitness Journey 2024",
      "description": "Gear to help me reach my fitness goals",
      "items": 6,
      "totalValue": 567.99,
      "isPrivate": false,
      "createdDate": "2024-09-10",
      "coverImage": "https://picsum.photos/400/200?random=33&keyword=fitness",
      "category": "Health",
      "sharedWith": ["gym_partner"],
    },
  ];

  List<Map<String, dynamic>> sharedWithMe = [
    {
      "id": 5,
      "name": "Wedding Registry",
      "description": "Sarah & Mike's wedding wishlist",
      "items": 25,
      "totalValue": 4500.00,
      "owner": "Sarah Johnson",
      "ownerAvatar": "https://picsum.photos/60/60?random=35&keyword=woman",
      "coverImage": "https://picsum.photos/400/200?random=34&keyword=wedding",
      "category": "Wedding",
      "accessLevel": "view_contribute",
    },
    {
      "id": 6,
      "name": "Baby Shower List",
      "description": "Everything for the little one",
      "items": 18,
      "totalValue": 1200.00,
      "owner": "Emma Wilson",
      "ownerAvatar": "https://picsum.photos/60/60?random=36&keyword=mother",
      "coverImage": "https://picsum.photos/400/200?random=37&keyword=baby",
      "category": "Baby",
      "accessLevel": "view_only",
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlists"),
        actions: [
          IconButton(
            icon: Icon(selectedView == "grid" ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                selectedView = selectedView == "grid" ? "list" : "grid";
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateWishlistDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Wishlists",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${myWishlists.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(50),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total Items",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${myWishlists.fold(0, (sum, list) => sum + (list["items"] as int))}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(50),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Total Value",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "\$${(myWishlists.fold(0.0, (sum, list) => sum + (list["totalValue"] as double))).currency}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Toggle Buttons
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showSharedLists = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: !showSharedLists ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "My Wishlists",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !showSharedLists ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showSharedLists = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: showSharedLists ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Shared with Me",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: showSharedLists ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Wishlists Content
            if (!showSharedLists)
              _buildMyWishlistsContent()
            else
              _buildSharedWishlistsContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildMyWishlistsContent() {
    if (selectedView == "grid") {
      return ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 200,
        children: myWishlists.map((wishlist) {
          return _buildWishlistCard(wishlist, isOwner: true);
        }).toList(),
      );
    } else {
      return Column(
        spacing: spSm,
        children: myWishlists.map((wishlist) {
          return _buildWishlistListItem(wishlist, isOwner: true);
        }).toList(),
      );
    }
  }

  Widget _buildSharedWishlistsContent() {
    if (sharedWithMe.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.share,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No shared wishlists",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "When someone shares a wishlist with you, it will appear here",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    if (selectedView == "grid") {
      return ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 200,
        children: sharedWithMe.map((wishlist) {
          return _buildSharedWishlistCard(wishlist);
        }).toList(),
      );
    } else {
      return Column(
        spacing: spSm,
        children: sharedWithMe.map((wishlist) {
          return _buildSharedWishlistListItem(wishlist);
        }).toList(),
      );
    }
  }

  Widget _buildWishlistCard(Map<String, dynamic> wishlist, {bool isOwner = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${wishlist["coverImage"]}",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    (wishlist["isPrivate"] as bool) ? Icons.lock : Icons.public,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Category
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${wishlist["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${wishlist["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${wishlist["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                // Stats
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${wishlist["items"]} items",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "\$${(wishlist["totalValue"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!(wishlist["isPrivate"] as bool))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Shared with",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(wishlist["sharedWith"] as List).length} people",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening ${wishlist["name"]}");
                        },
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        _showShareDialog(wishlist);
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        _showEditWishlistDialog(wishlist);
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

  Widget _buildWishlistListItem(Map<String, dynamic> wishlist, {bool isOwner = false}) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${wishlist["coverImage"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${wishlist["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      (wishlist["isPrivate"] as bool) ? Icons.lock : Icons.public,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ],
                ),
                Text(
                  "${wishlist["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${wishlist["items"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(" • "),
                    Text(
                      "\$${(wishlist["totalValue"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  ss("Opening ${wishlist["name"]}");
                },
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showWishlistOptions(wishlist);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSharedWishlistCard(Map<String, dynamic> wishlist) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(
          color: secondaryColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            child: Image.network(
              "${wishlist["coverImage"]}",
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Owner Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage("${wishlist["ownerAvatar"]}"),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${wishlist["owner"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor,
                            ),
                          ),
                          Text(
                            "${wishlist["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Text(
                  "${wishlist["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${wishlist["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                // Stats
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${wishlist["items"]} items",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "\$${(wishlist["totalValue"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: wishlist["accessLevel"] == "view_contribute" 
                            ? successColor.withAlpha(20) 
                            : infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        wishlist["accessLevel"] == "view_contribute" 
                            ? "Can Contribute" 
                            : "View Only",
                        style: TextStyle(
                          fontSize: 10,
                          color: wishlist["accessLevel"] == "view_contribute" 
                              ? successColor 
                              : infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Action Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "View Wishlist",
                    size: bs.sm,
                    onPressed: () {
                      ss("Opening shared wishlist: ${wishlist["name"]}");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharedWishlistListItem(Map<String, dynamic> wishlist) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: secondaryColor,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${wishlist["coverImage"]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${wishlist["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage("${wishlist["ownerAvatar"]}"),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "by ${wishlist["owner"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${wishlist["items"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(" • "),
                    Text(
                      "\$${(wishlist["totalValue"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.visibility,
            size: bs.sm,
            onPressed: () {
              ss("Opening shared wishlist: ${wishlist["name"]}");
            },
          ),
        ],
      ),
    );
  }

  void _showCreateWishlistDialog() {
    String name = "";
    String description = "";
    String category = "Personal";
    bool isPrivate = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Create New Wishlist"),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Wishlist Name",
                      value: name,
                      hint: "Enter wishlist name",
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      hint: "Describe your wishlist",
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                    QDropdownField(
                      label: "Category",
                      items: [
                        {"label": "Personal", "value": "Personal"},
                        {"label": "Work", "value": "Work"},
                        {"label": "Travel", "value": "Travel"},
                        {"label": "Health", "value": "Health"},
                        {"label": "Wedding", "value": "Wedding"},
                        {"label": "Baby", "value": "Baby"},
                      ],
                      value: category,
                      onChanged: (value, label) {
                        category = value;
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Make this wishlist private",
                          "value": true,
                          "checked": isPrivate,
                        }
                      ],
                      value: [
                        if (isPrivate)
                          {
                            "label": "Make this wishlist private",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isPrivate = values.isNotEmpty;
                        setDialogState(() {});
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                QButton(
                  label: "Create",
                  size: bs.sm,
                  onPressed: () {
                    if (name.isNotEmpty) {
                      Navigator.pop(context);
                      ss("Wishlist '$name' created successfully");
                    } else {
                      se("Please enter a wishlist name");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditWishlistDialog(Map<String, dynamic> wishlist) {
    String name = wishlist["name"] as String;
    String description = wishlist["description"] as String;
    String category = wishlist["category"] as String;
    bool isPrivate = wishlist["isPrivate"] as bool;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Edit Wishlist"),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: spSm,
                  children: [
                    QTextField(
                      label: "Wishlist Name",
                      value: name,
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: description,
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                    QDropdownField(
                      label: "Category",
                      items: [
                        {"label": "Personal", "value": "Personal"},
                        {"label": "Work", "value": "Work"},
                        {"label": "Travel", "value": "Travel"},
                        {"label": "Health", "value": "Health"},
                      ],
                      value: category,
                      onChanged: (value, label) {
                        category = value;
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Make this wishlist private",
                          "value": true,
                          "checked": isPrivate,
                        }
                      ],
                      value: [
                        if (isPrivate)
                          {
                            "label": "Make this wishlist private",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        isPrivate = values.isNotEmpty;
                        setDialogState(() {});
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                QButton(
                  label: "Save Changes",
                  size: bs.sm,
                  onPressed: () {
                    Navigator.pop(context);
                    ss("Wishlist updated successfully");
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showShareDialog(Map<String, dynamic> wishlist) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Share Wishlist"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Share '${wishlist["name"]}' with:"),
              SizedBox(height: spSm),
              Text(
                "• Copy link\n• Send via email\n• Share on social media",
                style: TextStyle(color: disabledBoldColor),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Share",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Wishlist shared successfully");
              },
            ),
          ],
        );
      },
    );
  }

  void _showWishlistOptions(Map<String, dynamic> wishlist) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${wishlist["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Wishlist"),
                onTap: () {
                  Navigator.pop(context);
                  _showEditWishlistDialog(wishlist);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share Wishlist"),
                onTap: () {
                  Navigator.pop(context);
                  _showShareDialog(wishlist);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Wishlist"),
                onTap: () async {
                  Navigator.pop(context);
                  bool isConfirmed = await confirm("Delete this wishlist permanently?");
                  if (isConfirmed) {
                    ss("Wishlist deleted");
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
