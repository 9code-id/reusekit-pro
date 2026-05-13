import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaContactMergeView extends StatefulWidget {
  const CmaContactMergeView({super.key});

  @override
  State<CmaContactMergeView> createState() => _CmaContactMergeViewState();
}

class _CmaContactMergeViewState extends State<CmaContactMergeView> {
  int primaryContactIndex = 0;
  Map<String, dynamic> mergedContact = {};
  
  List<Map<String, dynamic>> duplicateContacts = [
    {
      "id": "C001",
      "firstName": "John",
      "lastName": "Doe",
      "email": "john.doe@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Acme Corporation",
      "position": "Software Engineer",
      "address": "123 Main Street, New York, NY 10001",
      "website": "https://johndoe.dev",
      "linkedin": "linkedin.com/in/johndoe",
      "twitter": "@johndoe",
      "notes": "Interested in enterprise solutions. Follow up on Q1 roadmap.",
      "tags": ["VIP", "Premium"],
      "leadScore": 85,
      "source": "Website",
      "createdAt": "2024-12-15",
      "lastContact": "2024-12-18",
      "customFields": {
        "Budget": "\$50,000",
        "Decision Timeline": "Q1 2025"
      }
    },
    {
      "id": "C002",
      "firstName": "John",
      "lastName": "Doe",
      "email": "john.doe@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Acme Corp",
      "position": "Senior Software Engineer",
      "address": "123 Main St, New York, NY 10001",
      "website": "",
      "linkedin": "linkedin.com/in/johndoe",
      "twitter": "",
      "notes": "Upgraded to senior role. Very interested in AI solutions.",
      "tags": ["Premium", "Developer"],
      "leadScore": 88,
      "source": "LinkedIn",
      "createdAt": "2024-12-10",
      "lastContact": "2024-12-17",
      "customFields": {
        "Budget": "\$75,000",
        "Pain Points": "Scalability issues"
      }
    },
    {
      "id": "C003",
      "firstName": "Johnny",
      "lastName": "Doe",
      "email": "john.doe@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Acme Corporation",
      "position": "Software Engineer",
      "address": "",
      "website": "https://johndoe.portfolio.com",
      "linkedin": "",
      "twitter": "@johnny_doe",
      "notes": "Prefers to be called Johnny. Tech lead for mobile team.",
      "tags": ["VIP", "Mobile"],
      "leadScore": 82,
      "source": "Referral",
      "createdAt": "2024-12-08",
      "lastContact": "2024-12-16",
      "customFields": {
        "Team Size": "8 developers",
        "Decision Timeline": "Q2 2025"
      }
    }
  ];

  List<String> fieldNames = [
    "firstName",
    "lastName",
    "email",
    "phone",
    "company",
    "position",
    "address",
    "website",
    "linkedin",
    "twitter",
    "notes",
    "leadScore",
    "source"
  ];

  Map<String, String> fieldLabels = {
    "firstName": "First Name",
    "lastName": "Last Name",
    "email": "Email",
    "phone": "Phone",
    "company": "Company",
    "position": "Position",
    "address": "Address",
    "website": "Website",
    "linkedin": "LinkedIn",
    "twitter": "Twitter",
    "notes": "Notes",
    "leadScore": "Lead Score",
    "source": "Source"
  };

  @override
  void initState() {
    super.initState();
    _initializeMergedContact();
  }

  void _initializeMergedContact() {
    // Start with primary contact as base
    mergedContact = Map.from(duplicateContacts[primaryContactIndex]);
    
    // Merge tags from all contacts
    Set<String> allTags = {};
    for (var contact in duplicateContacts) {
      allTags.addAll(List<String>.from(contact["tags"] ?? []));
    }
    mergedContact["tags"] = allTags.toList();
    
    // Merge custom fields from all contacts
    Map<String, dynamic> allCustomFields = {};
    for (var contact in duplicateContacts) {
      Map<String, dynamic> customFields = contact["customFields"] ?? {};
      allCustomFields.addAll(customFields);
    }
    mergedContact["customFields"] = allCustomFields;
    
    // Use the highest lead score
    int maxLeadScore = duplicateContacts.map((c) => c["leadScore"] as int).reduce((a, b) => a > b ? a : b);
    mergedContact["leadScore"] = maxLeadScore;
    
    // Use the earliest created date
    DateTime earliestDate = duplicateContacts
        .map((c) => DateTime.parse(c["createdAt"]))
        .reduce((a, b) => a.isBefore(b) ? a : b);
    mergedContact["createdAt"] = earliestDate.toIso8601String().split('T')[0];
    
    // Use the latest contact date  
    DateTime latestContact = duplicateContacts
        .map((c) => DateTime.parse(c["lastContact"]))
        .reduce((a, b) => a.isAfter(b) ? a : b);
    mergedContact["lastContact"] = latestContact.toIso8601String().split('T')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Merge Contacts"),
        actions: [
          TextButton(
            onPressed: () {
              _mergeContacts();
            },
            child: Text(
              "Merge",
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildMergeInstructions(),
            _buildPrimaryContactSelector(),
            _buildFieldComparison(),
            _buildTagsMerge(),
            _buildCustomFieldsMerge(),
            _buildMergePreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildMergeInstructions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor),
              SizedBox(width: spSm),
              Text(
                "Contact Merge Instructions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "• Select the primary contact that will be kept\n"
            "• Choose the best value for each field by tapping on it\n"
            "• Tags and custom fields will be automatically merged\n"
            "• The other duplicate contacts will be deleted after merge",
            style: TextStyle(
              fontSize: 12,
              color: infoColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryContactSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Primary Contact",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "The primary contact will be kept and updated with merged data:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ...duplicateContacts.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> contact = entry.value;
            bool isSelected = primaryContactIndex == index;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
              ),
              child: RadioListTile<int>(
                value: index,
                groupValue: primaryContactIndex,
                onChanged: (value) {
                  primaryContactIndex = value!;
                  _initializeMergedContact();
                  setState(() {});
                },
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: primaryColor.withAlpha(20),
                      child: Text(
                        "${contact["firstName"][0]}${contact["lastName"][0]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${contact["firstName"]} ${contact["lastName"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${contact["position"]} at ${contact["company"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Created: ${DateTime.parse(contact["createdAt"]).dMMMy} • Score: ${contact["leadScore"]}",
                            style: TextStyle(
                              fontSize: 10,
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFieldComparison() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Field Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Tap on the value you want to keep for each field:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ...fieldNames.map((fieldName) {
            return _buildFieldRow(fieldName);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFieldRow(String fieldName) {
    String label = fieldLabels[fieldName] ?? fieldName;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: duplicateContacts.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> contact = entry.value;
              String value = "${contact[fieldName] ?? ''}";
              bool isSelected = mergedContact[fieldName] == value;
              bool isEmpty = value.trim().isEmpty;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isEmpty) {
                      mergedContact[fieldName] = value;
                      setState(() {});
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: index < duplicateContacts.length - 1 ? spXs : 0),
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: isEmpty ? Colors.grey.withAlpha(10) :
                             isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact ${index + 1}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          isEmpty ? "No data" : value,
                          style: TextStyle(
                            fontSize: 12,
                            color: isEmpty ? disabledColor : Colors.black87,
                            fontStyle: isEmpty ? FontStyle.italic : FontStyle.normal,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsMerge() {
    Set<String> allTags = {};
    for (var contact in duplicateContacts) {
      allTags.addAll(List<String>.from(contact["tags"] ?? []));
    }
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tags Merge",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "All unique tags will be merged automatically:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          if (allTags.isNotEmpty)
            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: allTags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            )
          else
            Text(
              "No tags found in any contact",
              style: TextStyle(
                color: disabledColor,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomFieldsMerge() {
    Map<String, Set<String>> customFieldValues = {};
    
    // Collect all custom field values
    for (var contact in duplicateContacts) {
      Map<String, dynamic> customFields = contact["customFields"] ?? {};
      customFields.forEach((key, value) {
        if (!customFieldValues.containsKey(key)) {
          customFieldValues[key] = {};
        }
        if (value.toString().isNotEmpty) {
          customFieldValues[key]!.add(value.toString());
        }
      });
    }
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Custom Fields Merge",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Custom fields will be merged. Select the value to keep:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          if (customFieldValues.isNotEmpty)
            ...customFieldValues.entries.map((entry) {
              String fieldName = entry.key;
              Set<String> values = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spSm,
                      children: values.map((value) {
                        bool isSelected = mergedContact["customFields"][fieldName] == value;
                        return GestureDetector(
                          onTap: () {
                            mergedContact["customFields"][fieldName] = value;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                            ),
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList()
          else
            Text(
              "No custom fields found",
              style: TextStyle(
                color: disabledColor,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMergePreview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Merge Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "This is how the merged contact will look:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: primaryColor.withAlpha(20),
                      child: Text(
                        "${mergedContact["firstName"]?[0] ?? ''}${mergedContact["lastName"]?[0] ?? ''}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${mergedContact["firstName"] ?? ''} ${mergedContact["lastName"] ?? ''}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${mergedContact["position"] ?? ''} at ${mergedContact["company"] ?? ''}",
                            style: TextStyle(
                              fontSize: 12,
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
                  "Email: ${mergedContact["email"] ?? ''}",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Phone: ${mergedContact["phone"] ?? ''}",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Lead Score: ${mergedContact["leadScore"] ?? ''}",
                  style: TextStyle(fontSize: 12),
                ),
                if ((mergedContact["tags"] as List?)?.isNotEmpty == true) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Tags: ${(mergedContact["tags"] as List).join(', ')}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: warningColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Warning: ${duplicateContacts.length - 1} duplicate contacts will be permanently deleted after merge.",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Merge Contacts",
              size: bs.md,
              onPressed: () {
                _mergeContacts();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _mergeContacts() async {
    bool isConfirmed = await confirm(
      "Are you sure you want to merge these ${duplicateContacts.length} contacts? "
      "${duplicateContacts.length - 1} duplicate contacts will be permanently deleted."
    );
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate merge process
      await Future.delayed(Duration(seconds: 3));
      
      hideLoading();
      ss("Successfully merged ${duplicateContacts.length} contacts into one");
      
      // Navigate back to previous screen
      back();
    }
  }
}
