import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaDuplicateContactsView extends StatefulWidget {
  const CmaDuplicateContactsView({super.key});

  @override
  State<CmaDuplicateContactsView> createState() => _CmaDuplicateContactsViewState();
}

class _CmaDuplicateContactsViewState extends State<CmaDuplicateContactsView> {
  List<String> selectedDuplicates = [];
  bool isSelectionMode = false;
  String duplicateAction = "merge";
  
  List<Map<String, dynamic>> duplicateGroups = [
    {
      "id": "group_1",
      "matchField": "Email",
      "matchValue": "john.doe@email.com",
      "duplicateCount": 3,
      "confidence": 95,
      "contacts": [
        {
          "id": "C001",
          "firstName": "John",
          "lastName": "Doe",
          "email": "john.doe@email.com",
          "phone": "+1 (555) 123-4567",
          "company": "Acme Corporation",
          "position": "Software Engineer",
          "createdAt": "2024-12-15",
          "source": "Website",
          "isPrimary": true
        },
        {
          "id": "C002",
          "firstName": "John",
          "lastName": "Doe",
          "email": "john.doe@email.com",
          "phone": "+1 (555) 123-4567",
          "company": "Acme Corp",
          "position": "Senior Software Engineer",
          "createdAt": "2024-12-10",
          "source": "LinkedIn",
          "isPrimary": false
        },
        {
          "id": "C003",
          "firstName": "Johnny",
          "lastName": "Doe",
          "email": "john.doe@email.com",
          "phone": "+1 (555) 123-4567",
          "company": "Acme Corporation",
          "position": "Software Engineer",
          "createdAt": "2024-12-08",
          "source": "Referral",
          "isPrimary": false
        }
      ]
    },
    {
      "id": "group_2",
      "matchField": "Phone",
      "matchValue": "+1 (555) 987-6543",
      "duplicateCount": 2,
      "confidence": 88,
      "contacts": [
        {
          "id": "C004",
          "firstName": "Sarah",
          "lastName": "Wilson",
          "email": "sarah.wilson@tech.com",
          "phone": "+1 (555) 987-6543",
          "company": "Tech Solutions",
          "position": "Product Manager",
          "createdAt": "2024-12-12",
          "source": "Website",
          "isPrimary": true
        },
        {
          "id": "C005",
          "firstName": "Sarah",
          "lastName": "Wilson",
          "email": "s.wilson@techsolutions.com",
          "phone": "+1 (555) 987-6543",
          "company": "Tech Solutions Inc",
          "position": "Senior Product Manager",
          "createdAt": "2024-12-09",
          "source": "Email Campaign",
          "isPrimary": false
        }
      ]
    },
    {
      "id": "group_3",
      "matchField": "Name + Company",
      "matchValue": "Mike Johnson @ StartupIO",
      "duplicateCount": 2,
      "confidence": 92,
      "contacts": [
        {
          "id": "C006",
          "firstName": "Mike",
          "lastName": "Johnson",
          "email": "mike.j@startup.io",
          "phone": "+1 (555) 345-6789",
          "company": "StartupIO",
          "position": "CTO",
          "createdAt": "2024-12-14",
          "source": "Trade Show",
          "isPrimary": true
        },
        {
          "id": "C007",
          "firstName": "Michael",
          "lastName": "Johnson",
          "email": "michael.johnson@startup.io",
          "phone": "+1 (555) 345-6789",
          "company": "StartupIO",
          "position": "Chief Technology Officer",
          "createdAt": "2024-12-11",
          "source": "Social Media",
          "isPrimary": false
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionMode ? "${selectedDuplicates.length} Selected" : "Duplicate Contacts"),
        actions: [
          if (isSelectionMode) ...[
            IconButton(
              icon: Icon(Icons.merge),
              onPressed: () {
                _bulkMergeContacts();
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _showBulkActions();
              },
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                _showDuplicateSettings();
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _scanForDuplicates();
              },
            ),
          ],
        ],
        leading: isSelectionMode ? IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            selectedDuplicates.clear();
            isSelectionMode = false;
            setState(() {});
          },
        ) : null,
      ),
      body: Column(
        children: [
          _buildDuplicateStats(),
          _buildQuickActions(),
          Expanded(
            child: _buildDuplicateList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDuplicateStats() {
    int totalDuplicates = duplicateGroups.fold(0, (sum, group) => sum + (group["duplicateCount"] as int));
    int totalGroups = duplicateGroups.length;
    int highConfidence = duplicateGroups.where((group) => (group["confidence"] as int) >= 90).length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard("Duplicate Groups", "$totalGroups", primaryColor),
              _buildStatCard("Total Duplicates", "$totalDuplicates", warningColor),
              _buildStatCard("High Confidence", "$highConfidence", successColor),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Duplicates are detected based on matching email, phone, or name + company combinations.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Merge All High Confidence",
              size: bs.sm,
              onPressed: () {
                _mergeHighConfidence();
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Delete All Duplicates",
              size: bs.sm,
              onPressed: () {
                _deleteAllDuplicates();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDuplicateList() {
    if (duplicateGroups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 64,
              color: successColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Duplicates Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your contact database is clean!",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            QButton(
              label: "Scan Again",
              size: bs.sm,
              onPressed: () {
                _scanForDuplicates();
              },
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: duplicateGroups.length,
      itemBuilder: (context, index) {
        final group = duplicateGroups[index];
        bool isSelected = selectedDuplicates.contains(group["id"]);
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          ),
          child: Column(
            children: [
              _buildGroupHeader(group),
              ...(group["contacts"] as List).map((contact) {
                return _buildContactItem(contact, group);
              }).toList(),
              _buildGroupActions(group),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGroupHeader(Map<String, dynamic> group) {
    Color confidenceColor = (group["confidence"] as int) >= 90 ? successColor : 
                           (group["confidence"] as int) >= 70 ? warningColor : dangerColor;
    
    return GestureDetector(
      onTap: () {
        if (isSelectionMode) {
          if (selectedDuplicates.contains(group["id"])) {
            selectedDuplicates.remove(group["id"]);
            if (selectedDuplicates.isEmpty) {
              isSelectionMode = false;
            }
          } else {
            selectedDuplicates.add(group["id"]);
          }
          setState(() {});
        }
      },
      onLongPress: () {
        if (!isSelectionMode) {
          isSelectionMode = true;
          selectedDuplicates.add(group["id"]);
          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(20),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusMd),
            topRight: Radius.circular(radiusMd),
          ),
        ),
        child: Row(
          children: [
            if (isSelectionMode)
              Container(
                margin: EdgeInsets.only(right: spSm),
                child: Icon(
                  selectedDuplicates.contains(group["id"]) ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: selectedDuplicates.contains(group["id"]) ? primaryColor : disabledColor,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Duplicate Group",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: confidenceColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${group["confidence"]}% match",
                          style: TextStyle(
                            fontSize: 10,
                            color: confidenceColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Matched by: ${group["matchField"]} (${group["matchValue"]})",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${group["duplicateCount"]} contacts found",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact, Map<String, dynamic> group) {
    bool isPrimary = contact["isPrimary"] == true;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor, width: 0.5),
          left: isPrimary ? BorderSide(color: primaryColor, width: 4) : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: isPrimary ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
            child: Text(
              "${contact["firstName"][0]}${contact["lastName"][0]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isPrimary ? primaryColor : disabledBoldColor,
              ),
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
                      "${contact["firstName"]} ${contact["lastName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isPrimary) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "PRIMARY",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${contact["position"]} at ${contact["company"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.email, size: 10, color: disabledColor),
                    SizedBox(width: 4),
                    Text(
                      "${contact["email"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.phone, size: 10, color: disabledColor),
                    SizedBox(width: 4),
                    Text(
                      "${contact["phone"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${DateTime.parse(contact["createdAt"]).dMMMy}",
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
    );
  }

  Widget _buildGroupActions(Map<String, dynamic> group) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radiusMd),
          bottomRight: Radius.circular(radiusMd),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Merge Contacts",
              size: bs.sm,
              onPressed: () {
                _mergeGroup(group);
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Keep Separate",
              size: bs.sm,
              onPressed: () {
                _keepSeparate(group);
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.visibility,
            size: bs.sm,
            onPressed: () {
              _viewDetails(group);
            },
          ),
        ],
      ),
    );
  }

  void _showBulkActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Bulk Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ListTile(
                leading: Icon(Icons.merge, color: primaryColor),
                title: Text("Merge Selected Groups"),
                onTap: () {
                  back();
                  _bulkMergeContacts();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Duplicates"),
                onTap: () {
                  back();
                  _bulkDeleteContacts();
                },
              ),
              ListTile(
                leading: Icon(Icons.visibility_off, color: disabledBoldColor),
                title: Text("Ignore Selected"),
                onTap: () {
                  back();
                  _bulkIgnoreGroups();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDuplicateSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Duplicate Detection Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              Text("Detection Rules"),
              CheckboxListTile(
                title: Text("Match by Email"),
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text("Match by Phone"),
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text("Match by Name + Company"),
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: Text("Fuzzy Name Matching"),
                value: false,
                onChanged: (value) {},
              ),
              Divider(),
              Text("Confidence Threshold"),
              Slider(
                value: 70,
                min: 50,
                max: 100,
                divisions: 10,
                label: "70%",
                onChanged: (value) {},
              ),
            ],
          ),
        );
      },
    );
  }

  void _mergeGroup(Map<String, dynamic> group) {
    //navigateTo('CmaContactMergeView', arguments: group)
    si("Opening merge view for group");
  }

  void _keepSeparate(Map<String, dynamic> group) {
    duplicateGroups.removeWhere((g) => g["id"] == group["id"]);
    setState(() {});
    si("Contacts marked as separate");
  }

  void _viewDetails(Map<String, dynamic> group) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Group Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Match Field: ${group["matchField"]}"),
              Text("Match Value: ${group["matchValue"]}"),
              Text("Confidence: ${group["confidence"]}%"),
              Text("Contacts: ${group["duplicateCount"]}"),
              SizedBox(height: spSm),
              Text("Contacts in this group:"),
              ...(group["contacts"] as List).map((contact) {
                return Text("• ${contact["firstName"]} ${contact["lastName"]} (${contact["email"]})");
              }).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => back(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _scanForDuplicates() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    si("Duplicate scan completed. ${duplicateGroups.length} groups found.");
  }

  void _mergeHighConfidence() async {
    int highConfidenceGroups = duplicateGroups.where((group) => (group["confidence"] as int) >= 90).length;
    
    bool isConfirmed = await confirm("Merge all $highConfidenceGroups high confidence duplicate groups?");
    if (isConfirmed) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      duplicateGroups.removeWhere((group) => (group["confidence"] as int) >= 90);
      setState(() {});
      
      hideLoading();
      ss("Successfully merged $highConfidenceGroups duplicate groups");
    }
  }

  void _deleteAllDuplicates() async {
    bool isConfirmed = await confirm("Delete all duplicate contacts? This will keep only the primary contact in each group.");
    if (isConfirmed) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      duplicateGroups.clear();
      setState(() {});
      
      hideLoading();
      ss("All duplicate contacts have been deleted");
    }
  }

  void _bulkMergeContacts() async {
    bool isConfirmed = await confirm("Merge ${selectedDuplicates.length} selected duplicate groups?");
    if (isConfirmed) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      duplicateGroups.removeWhere((group) => selectedDuplicates.contains(group["id"]));
      selectedDuplicates.clear();
      isSelectionMode = false;
      setState(() {});
      
      hideLoading();
      ss("Selected duplicate groups have been merged");
    }
  }

  void _bulkDeleteContacts() async {
    bool isConfirmed = await confirm("Delete duplicates from ${selectedDuplicates.length} selected groups?");
    if (isConfirmed) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 2));
      
      duplicateGroups.removeWhere((group) => selectedDuplicates.contains(group["id"]));
      selectedDuplicates.clear();
      isSelectionMode = false;
      setState(() {});
      
      hideLoading();
      ss("Duplicate contacts have been deleted");
    }
  }

  void _bulkIgnoreGroups() {
    duplicateGroups.removeWhere((group) => selectedDuplicates.contains(group["id"]));
    selectedDuplicates.clear();
    isSelectionMode = false;
    setState(() {});
    si("Selected groups have been ignored");
  }
}
