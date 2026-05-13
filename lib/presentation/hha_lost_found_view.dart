import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaLostFoundView extends StatefulWidget {
  const HhaLostFoundView({super.key});

  @override
  State<HhaLostFoundView> createState() => _HhaLostFoundViewState();
}

class _HhaLostFoundViewState extends State<HhaLostFoundView> {
  int selectedTab = 0;
  String itemName = "";
  String itemDescription = "";
  String itemCategory = "";
  String locationFound = "";
  String dateFound = DateTime.now().toString().split(' ')[0];
  String timeFound = "12:00";
  String founderName = "";
  String founderContact = "";
  String storageLocation = "";
  String itemCondition = "";
  
  List<Map<String, dynamic>> lostItems = [
    {
      "id": "LF001",
      "itemName": "iPhone 14 Pro",
      "description": "Black iPhone with cracked screen protector",
      "category": "Electronics",
      "locationFound": "Restaurant - Table 12",
      "dateFound": "2025-06-14",
      "timeFound": "20:30",
      "founderName": "Sarah Wilson",
      "founderContact": "sarah.wilson@hotel.com",
      "status": "Unclaimed",
      "storageLocation": "Lost & Found Room A",
      "condition": "Good",
      "claimInstructions": "Provide purchase receipt or unlock code",
      "estimatedValue": 800,
      "image": "https://picsum.photos/150/150?random=1&keyword=phone"
    },
    {
      "id": "LF002",
      "itemName": "Gold Watch",
      "description": "Men's gold wristwatch with leather strap",
      "category": "Jewelry",
      "locationFound": "Gym - Locker Area",
      "dateFound": "2025-06-13",
      "timeFound": "09:15",
      "founderName": "Mike Johnson",
      "founderContact": "mike.johnson@hotel.com",
      "status": "Claimed",
      "storageLocation": "Lost & Found Room B",
      "condition": "Excellent",
      "claimedBy": "Robert Brown",
      "claimDate": "2025-06-14",
      "estimatedValue": 1200,
      "image": "https://picsum.photos/150/150?random=2&keyword=watch"
    },
    {
      "id": "LF003",
      "itemName": "Red Handbag",
      "description": "Small red leather handbag with silver clasp",
      "category": "Personal Items",
      "locationFound": "Lobby - Seating Area",
      "dateFound": "2025-06-15",
      "timeFound": "16:45",
      "founderName": "Emma Davis",
      "founderContact": "emma.davis@hotel.com",
      "status": "Pending Investigation",
      "storageLocation": "Lost & Found Room A",
      "condition": "Good",
      "claimInstructions": "Describe contents inside bag",
      "estimatedValue": 200,
      "image": "https://picsum.photos/150/150?random=3&keyword=handbag"
    },
    {
      "id": "LF004",
      "itemName": "Reading Glasses",
      "description": "Black frame reading glasses in blue case",
      "category": "Personal Items",
      "locationFound": "Room 205",
      "dateFound": "2025-06-12",
      "timeFound": "11:00",
      "founderName": "Housekeeping Staff",
      "founderContact": "housekeeping@hotel.com",
      "status": "Unclaimed",
      "storageLocation": "Lost & Found Room B",
      "condition": "Good",
      "claimInstructions": "Provide prescription details",
      "estimatedValue": 150,
      "image": "https://picsum.photos/150/150?random=4&keyword=glasses"
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "Electronics", "icon": Icons.phone_android, "count": 8},
    {"name": "Jewelry", "icon": Icons.watch, "count": 5},
    {"name": "Personal Items", "icon": Icons.shopping_bag, "count": 12},
    {"name": "Clothing", "icon": Icons.checkroom, "count": 15},
    {"name": "Documents", "icon": Icons.description, "count": 3},
    {"name": "Keys", "icon": Icons.key, "count": 7},
    {"name": "Sports Equipment", "icon": Icons.sports_tennis, "count": 4},
    {"name": "Other", "icon": Icons.category, "count": 6},
  ];

  List<Map<String, dynamic>> claimRequests = [
    {
      "id": "CR001",
      "itemId": "LF001",
      "itemName": "iPhone 14 Pro",
      "claimantName": "John Smith",
      "claimantPhone": "+1-555-0123",
      "claimantEmail": "john.smith@email.com",
      "claimDate": "2025-06-15",
      "claimTime": "10:30",
      "roomNumber": "205",
      "description": "Lost my iPhone at dinner last night",
      "verification": "Can provide IMEI number and unlock code",
      "status": "Pending Verification",
      "notes": "Guest claims phone has family photos as wallpaper"
    },
    {
      "id": "CR002",
      "itemId": "LF003",
      "itemName": "Red Handbag",
      "claimantName": "Lisa Johnson",
      "claimantPhone": "+1-555-0456",
      "claimantEmail": "lisa.j@email.com",
      "claimDate": "2025-06-15",
      "claimTime": "17:00",
      "roomNumber": "312",
      "description": "Left my handbag in lobby while checking out",
      "verification": "Contains credit cards and house keys",
      "status": "Approved",
      "notes": "Verification successful - ready for pickup"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Lost & Found",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Report Item", icon: Icon(Icons.add_circle)),
        Tab(text: "Lost Items", icon: Icon(Icons.search)),
        Tab(text: "Claims", icon: Icon(Icons.person_search)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
      ],
      tabChildren: [
        _buildReportItemTab(),
        _buildLostItemsTab(),
        _buildClaimsTab(),
        _buildCategoriesTab(),
      ],
    );
  }

  Widget _buildReportItemTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Item Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Item Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Item Name",
                  value: itemName,
                  hint: "iPhone, Watch, Wallet, etc.",
                  onChanged: (value) {
                    itemName = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Category",
                  items: categories.map((category) => {
                    "label": "${category["name"]}",
                    "value": category["name"],
                  }).toList(),
                  value: itemCategory,
                  onChanged: (value, label) {
                    itemCategory = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Detailed Description",
                  value: itemDescription,
                  hint: "Color, brand, size, distinguishing features, contents, etc.",
                  onChanged: (value) {
                    itemDescription = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Item Condition",
                  items: [
                    {"label": "Excellent", "value": "excellent"},
                    {"label": "Good", "value": "good"},
                    {"label": "Fair", "value": "fair"},
                    {"label": "Damaged", "value": "damaged"},
                  ],
                  value: itemCondition,
                  onChanged: (value, label) {
                    itemCondition = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Location & Time Found
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Found Location & Time",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Location Found",
                  value: locationFound,
                  hint: "Room number, Restaurant, Lobby, Gym, etc.",
                  onChanged: (value) {
                    locationFound = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Date Found",
                        value: DateTime.parse(dateFound),
                        onChanged: (value) {
                          dateFound = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QTimePicker(
                        label: "Time Found",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2025-01-01 $timeFound")),
                        onChanged: (value) {
                          timeFound = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Finder Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Finder Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QTextField(
                  label: "Finder Name",
                  value: founderName,
                  hint: "Staff member or guest who found the item",
                  onChanged: (value) {
                    founderName = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Contact Information",
                  value: founderContact,
                  hint: "Email, phone, or department",
                  onChanged: (value) {
                    founderContact = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Storage Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Storage Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Storage Location",
                  items: [
                    {"label": "Lost & Found Room A", "value": "room_a"},
                    {"label": "Lost & Found Room B", "value": "room_b"},
                    {"label": "Secure Storage", "value": "secure"},
                    {"label": "Refrigerated Storage", "value": "refrigerated"},
                  ],
                  value: storageLocation,
                  onChanged: (value, label) {
                    storageLocation = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Report Summary
          if (itemName.isNotEmpty && locationFound.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.assignment, color: infoColor),
                      SizedBox(width: spSm),
                      Text(
                        "Report Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: infoColor.withAlpha(100)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Item:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("$itemName ($itemCategory)"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Found At:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(locationFound),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date & Time:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("$dateFound at $timeFound"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Finder:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(founderName),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Condition:", style: TextStyle(fontWeight: FontWeight.w600)),
                      Text(itemCondition),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // Action Buttons
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Save Draft",
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: () => sw("Lost item report saved as draft"),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Submit Report",
                  size: bs.md,
                  onPressed: () => ss("Lost item report submitted successfully!"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLostItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatCard("Total Items", "${lostItems.length}", Icons.inventory, primaryColor),
              _buildStatCard("Unclaimed", "${lostItems.where((i) => i["status"] == "Unclaimed").length}", Icons.search, warningColor),
              _buildStatCard("Claimed", "${lostItems.where((i) => i["status"] == "Claimed").length}", Icons.check_circle, successColor),
              _buildStatCard("Investigating", "${lostItems.where((i) => i["status"] == "Pending Investigation").length}", Icons.search, infoColor),
            ],
          ),

          // Search and Filter
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Items",
                  value: "",
                  hint: "Item name, location, description...",
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: [
                    {"label": "All Items", "value": "all"},
                    {"label": "Unclaimed", "value": "unclaimed"},
                    {"label": "Claimed", "value": "claimed"},
                    {"label": "Investigating", "value": "investigating"},
                  ],
                  value: "all",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),

          // Lost Items List
          ...lostItems.map((item) {
            Color statusColor = item["status"] == "Claimed" ? successColor :
                               item["status"] == "Unclaimed" ? warningColor :
                               item["status"] == "Pending Investigation" ? infoColor : dangerColor;
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(width: 4, color: statusColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${item["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${item["itemName"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(100),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    item["status"],
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "ID: ${item["id"]} | ${item["category"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  Row(
                    children: [
                      Icon(Icons.description, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Expanded(child: Text("${item["description"]}")),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Found at: ${item["locationFound"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("${item["dateFound"]} at ${item["timeFound"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Found by: ${item["founderName"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.inventory, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Storage: ${item["storageLocation"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.monetization_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Est. Value: \$${((item["estimatedValue"] as int).toDouble()).currency}"),
                    ],
                  ),
                  if (item["claimInstructions"] != null) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Claim Instructions: ${item["claimInstructions"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  if (item["status"] == "Claimed") ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Claimed by: ${item["claimedBy"]} on ${item["claimDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: spSm),
                  Row(
                    spacing: spXs,
                    children: [
                      if (item["status"] == "Unclaimed") ...[
                        Expanded(
                          child: QButton(
                            label: "Mark Claimed",
                            color: successColor,
                            size: bs.sm,
                            onPressed: () => ss("Item marked as claimed"),
                          ),
                        ),
                      ],
                      Expanded(
                        child: QButton(
                          label: "Edit",
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () => si("Edit item details"),
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Move",
                          color: warningColor,
                          size: bs.sm,
                          onPressed: () => sw("Move item to different location"),
                        ),
                      ),
                      if (item["status"] != "Claimed") ...[
                        Expanded(
                          child: QButton(
                            label: "Dispose",
                            color: dangerColor,
                            size: bs.sm,
                            onPressed: () => se("Item marked for disposal"),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildClaimsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Claims Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildStatCard("Total Claims", "${claimRequests.length}", Icons.person_search, primaryColor),
              _buildStatCard("Pending", "${claimRequests.where((c) => c["status"] == "Pending Verification").length}", Icons.pending, warningColor),
              _buildStatCard("Approved", "${claimRequests.where((c) => c["status"] == "Approved").length}", Icons.check_circle, successColor),
              _buildStatCard("Today", "${claimRequests.where((c) => c["claimDate"] == DateTime.now().toString().split(' ')[0]).length}", Icons.today, infoColor),
            ],
          ),

          // Claims List
          ...claimRequests.map((claim) {
            Color statusColor = claim["status"] == "Approved" ? successColor :
                               claim["status"] == "Pending Verification" ? warningColor : dangerColor;
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(width: 4, color: statusColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Claim #${claim["id"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          claim["status"],
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: disabledColor),
                  Row(
                    children: [
                      Icon(Icons.inventory, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Item: ${claim["itemName"]} (${claim["itemId"]})", 
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Claimant: ${claim["claimantName"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Contact: ${claim["claimantPhone"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Email: ${claim["claimantEmail"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.hotel, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Room: ${claim["roomNumber"]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text("Claimed: ${claim["claimDate"]} at ${claim["claimTime"]}"),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Description: ${claim["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Verification: ${claim["verification"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (claim["notes"].isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Notes: ${claim["notes"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: spSm),
                  Row(
                    spacing: spXs,
                    children: [
                      if (claim["status"] == "Pending Verification") ...[
                        Expanded(
                          child: QButton(
                            label: "Approve",
                            color: successColor,
                            size: bs.sm,
                            onPressed: () => ss("Claim approved"),
                          ),
                        ),
                        Expanded(
                          child: QButton(
                            label: "Reject",
                            color: dangerColor,
                            size: bs.sm,
                            onPressed: () => se("Claim rejected"),
                          ),
                        ),
                      ],
                      Expanded(
                        child: QButton(
                          label: "Contact",
                          color: infoColor,
                          size: bs.sm,
                          onPressed: () => si("Contact claimant"),
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Update",
                          color: warningColor,
                          size: bs.sm,
                          onPressed: () => sw("Update claim status"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Item categories help organize lost items for better management and faster retrieval.",
                    style: TextStyle(color: infoColor),
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: categories.map((category) {
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
                      category["icon"],
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(100),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${category["count"]} items",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Items",
                        color: infoColor,
                        size: bs.sm,
                        onPressed: () => si("View ${category["name"]} items"),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
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
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(width: 3, color: color),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
