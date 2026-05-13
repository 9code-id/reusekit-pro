import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaBeneficiaryListView extends StatefulWidget {
  const BfaBeneficiaryListView({super.key});

  @override
  State<BfaBeneficiaryListView> createState() => _BfaBeneficiaryListViewState();
}

class _BfaBeneficiaryListViewState extends State<BfaBeneficiaryListView> {
  String searchQuery = "";
  String selectedCategory = "all";
  
  // Sample beneficiaries
  List<Map<String, dynamic>> beneficiaries = [
    {
      "id": "ben001",
      "name": "John Williams",
      "accountNumber": "****1234",
      "bankName": "ABC Bank",
      "bankCode": "ABC001",
      "category": "personal",
      "lastUsed": "2024-12-15T10:30:00Z",
      "isVerified": true,
      "transferCount": 15,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "transferLimit": 10000.0,
    },
    {
      "id": "ben002",
      "name": "Sarah Johnson",
      "accountNumber": "****5678",
      "bankName": "XYZ Bank",
      "bankCode": "XYZ002",
      "category": "business",
      "lastUsed": "2024-12-14T16:45:00Z",
      "isVerified": true,
      "transferCount": 8,
      "avatar": "https://picsum.photos/100/100?random=2&keyword=person",
      "transferLimit": 25000.0,
    },
    {
      "id": "ben003",
      "name": "Michael Brown",
      "accountNumber": "****9012",
      "bankName": "DEF Bank",
      "bankCode": "DEF003",
      "category": "personal",
      "lastUsed": "2024-12-13T09:15:00Z",
      "isVerified": false,
      "transferCount": 3,
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "transferLimit": 5000.0,
    },
    {
      "id": "ben004",
      "name": "Emma Davis",
      "accountNumber": "****3456",
      "bankName": "GHI Bank",
      "bankCode": "GHI004",
      "category": "family",
      "lastUsed": "2024-12-12T14:20:00Z",
      "isVerified": true,
      "transferCount": 22,
      "avatar": "https://picsum.photos/100/100?random=4&keyword=person",
      "transferLimit": 15000.0,
    },
    {
      "id": "ben005",
      "name": "David Wilson",
      "accountNumber": "****7890",
      "bankName": "JKL Bank",
      "bankCode": "JKL005",
      "category": "business",
      "lastUsed": "2024-12-11T11:00:00Z",
      "isVerified": true,
      "transferCount": 12,
      "avatar": "https://picsum.photos/100/100?random=5&keyword=person",
      "transferLimit": 50000.0,
    },
    {
      "id": "ben006",
      "name": "Lisa Anderson",
      "accountNumber": "****2468",
      "bankName": "MNO Bank",
      "bankCode": "MNO006",
      "category": "family",
      "lastUsed": "2024-12-10T13:30:00Z",
      "isVerified": true,
      "transferCount": 18,
      "avatar": "https://picsum.photos/100/100?random=6&keyword=person",
      "transferLimit": 8000.0,
    },
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Beneficiaries", "value": "all"},
    {"label": "Personal", "value": "personal"},
    {"label": "Business", "value": "business"},
    {"label": "Family", "value": "family"},
  ];

  List<Map<String, dynamic>> get filteredBeneficiaries {
    List<Map<String, dynamic>> filtered = beneficiaries;
    
    // Filter by category
    if (selectedCategory != "all") {
      filtered = filtered.where((b) => b["category"] == selectedCategory).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((b) => 
        (b["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (b["bankName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (b["accountNumber"] as String).contains(searchQuery)
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beneficiaries"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('BfaAddBeneficiaryView')
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stats Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard("Total", "${beneficiaries.length}", Icons.people),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(60),
                  ),
                  Expanded(
                    child: _buildStatCard("Verified", "${beneficiaries.where((b) => b["isVerified"] == true).length}", Icons.verified),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withAlpha(60),
                  ),
                  Expanded(
                    child: _buildStatCard("Active", "${beneficiaries.where((b) => (b["transferCount"] as int) > 5).length}", Icons.trending_up),
                  ),
                ],
              ),
            ),

            // Search and Filter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search beneficiaries...",
                          value: searchQuery,
                          hint: "Name, bank, or account number",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        height: 48,
                        child: QButton(
                          icon: Icons.search,
                          size: bs.sm,
                          onPressed: () {
                            // Search action
                          },
                        ),
                      ),
                    ],
                  ),

                  QCategoryPicker(
                    label: "Filter by Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Add New",
                          icon: Icons.person_add,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('BfaAddBeneficiaryView')
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Import",
                          icon: Icons.upload,
                          size: bs.sm,
                          onPressed: () {
                            ss("Import feature coming soon");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Export",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            ss("Beneficiary list exported");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Beneficiaries List
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spLg),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Beneficiaries (${filteredBeneficiaries.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (filteredBeneficiaries.isNotEmpty) ...[
                          GestureDetector(
                            onTap: () {
                              _showBulkActions();
                            },
                            child: Text(
                              "Bulk Actions",
                              style: TextStyle(
                                fontSize: 14,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  if (filteredBeneficiaries.isEmpty) ...[
                    Padding(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No beneficiaries found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Add beneficiaries to start transferring money easily",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          QButton(
                            label: "Add First Beneficiary",
                            icon: Icons.person_add,
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('BfaAddBeneficiaryView')
                            },
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    ...List.generate(filteredBeneficiaries.length, (index) {
                      final beneficiary = filteredBeneficiaries[index];
                      return _buildBeneficiaryItem(beneficiary, index == filteredBeneficiaries.length - 1);
                    }),
                  ],
                ],
              ),
            ),

            // Recent Activity
            if (filteredBeneficiaries.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Recent Activity",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    ...List.generate(3, (index) {
                      final recentBeneficiary = beneficiaries.where((b) => (b["transferCount"] as int) > 0).toList()[index];
                      return _buildRecentActivityItem(recentBeneficiary);
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Widget _buildBeneficiaryItem(Map<String, dynamic> beneficiary, bool isLast) {
    bool isVerified = beneficiary["isVerified"] as bool;
    String category = beneficiary["category"] as String;
    
    Color categoryColor = category == "personal" ? infoColor : 
                         category == "business" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowXs],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${beneficiary["avatar"]}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: primaryColor.withAlpha(20),
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (isVerified) ...[
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 8,
                    ),
                  ),
                ),
              ],
            ],
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
                        "${beneficiary["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${beneficiary["bankName"]} • ${beneficiary["accountNumber"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.swap_horiz,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${beneficiary["transferCount"]} transfers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${DateTime.parse(beneficiary["lastUsed"]).dMMMy}",
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
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  //navigateTo('BfaTransferMoneyView', beneficiary: beneficiary)
                },
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.send,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () {
                  _showBeneficiaryOptions(beneficiary);
                },
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(40),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityItem(Map<String, dynamic> beneficiary) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor.withAlpha(100),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${beneficiary["avatar"]}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: primaryColor.withAlpha(20),
                    child: Icon(
                      Icons.person,
                      color: primaryColor,
                      size: 16,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transfer to ${beneficiary["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${DateTime.parse(beneficiary["lastUsed"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.trending_up,
            color: successColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sort Beneficiaries",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ListTile(
                leading: Icon(Icons.sort_by_alpha),
                title: Text("Name (A-Z)"),
                onTap: () {
                  beneficiaries.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
                  setState(() {});
                  back();
                },
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text("Last Used"),
                onTap: () {
                  beneficiaries.sort((a, b) => DateTime.parse(b["lastUsed"]).compareTo(DateTime.parse(a["lastUsed"])));
                  setState(() {});
                  back();
                },
              ),
              ListTile(
                leading: Icon(Icons.trending_up),
                title: Text("Most Active"),
                onTap: () {
                  beneficiaries.sort((a, b) => (b["transferCount"] as int).compareTo(a["transferCount"] as int));
                  setState(() {});
                  back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBulkActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Bulk Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ListTile(
                leading: Icon(Icons.download),
                title: Text("Export All"),
                onTap: () {
                  ss("Exporting beneficiaries...");
                  back();
                },
              ),
              ListTile(
                leading: Icon(Icons.verified),
                title: Text("Verify All"),
                onTap: () {
                  ss("Bulk verification initiated");
                  back();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline, color: dangerColor),
                title: Text("Delete Unverified", style: TextStyle(color: dangerColor)),
                onTap: () async {
                  bool isConfirmed = await confirm("Delete all unverified beneficiaries?");
                  if (isConfirmed) {
                    beneficiaries.removeWhere((b) => b["isVerified"] == false);
                    setState(() {});
                    ss("Unverified beneficiaries deleted");
                  }
                  back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBeneficiaryOptions(Map<String, dynamic> beneficiary) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${beneficiary["name"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ListTile(
                leading: Icon(Icons.send),
                title: Text("Transfer Money"),
                onTap: () {
                  back();
                  //navigateTo('BfaTransferMoneyView', beneficiary: beneficiary)
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Details"),
                onTap: () {
                  back();
                  //navigateTo('BfaAddBeneficiaryView', beneficiary: beneficiary)
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("View Transfer History"),
                onTap: () {
                  back();
                  //navigateTo('BfaTransferHistoryView', beneficiary: beneficiary)
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline, color: dangerColor),
                title: Text("Remove Beneficiary", style: TextStyle(color: dangerColor)),
                onTap: () async {
                  bool isConfirmed = await confirm("Remove ${beneficiary["name"]} from beneficiaries?");
                  if (isConfirmed) {
                    beneficiaries.removeWhere((b) => b["id"] == beneficiary["id"]);
                    setState(() {});
                    ss("Beneficiary removed successfully");
                  }
                  back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
