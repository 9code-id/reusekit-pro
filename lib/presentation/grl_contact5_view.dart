import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlContact5View extends StatefulWidget {
  @override
  State<GrlContact5View> createState() => _GrlContact5ViewState();
}

class _GrlContact5ViewState extends State<GrlContact5View> {
  Map<String, dynamic> contact = {
    "id": 1,
    "name": "Alexander Mitchell",
    "phone": "+1 (555) 123-4567",
    "email": "alex.mitchell@techcorp.com",
    "avatar": "https://picsum.photos/200/200?random=40&keyword=man",
    "company": "TechCorp Solutions",
    "position": "Senior Software Engineer",
    "department": "Engineering",
    "location": "San Francisco, CA",
    "birthday": DateTime(1988, 6, 15),
    "notes": "Lead developer on mobile applications. Expert in Flutter and React Native. Very responsive and professional.",
    "tags": ["flutter", "mobile", "senior", "reliable"],
    "socialMedia": {
      "linkedin": "alexander-mitchell-dev",
      "twitter": "@alexmitchell_dev",
      "github": "amitchell-dev",
    },
    "favorite": true,
    "blocked": false,
    "category": "work",
    "status": "online",
    "lastContact": DateTime.now().subtract(Duration(hours: 2)),
    "joinedDate": DateTime(2021, 3, 15),
    "totalCalls": 24,
    "totalMessages": 156,
    "totalEmails": 89,
  };

  List<Map<String, dynamic>> contactHistory = [
    {
      "id": 1,
      "type": "call",
      "direction": "outgoing",
      "duration": "12:34",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "status": "completed",
    },
    {
      "id": 2,
      "type": "message",
      "direction": "incoming",
      "content": "Hey, are we still meeting tomorrow?",
      "timestamp": DateTime.now().subtract(Duration(hours: 5)),
      "status": "read",
    },
    {
      "id": 3,
      "type": "email",
      "direction": "outgoing",
      "subject": "Project Update - Mobile App",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "status": "sent",
    },
    {
      "id": 4,
      "type": "call",
      "direction": "incoming",
      "duration": "8:45",
      "timestamp": DateTime.now().subtract(Duration(days: 2)),
      "status": "completed",
    },
    {
      "id": 5,
      "type": "message",
      "direction": "outgoing",
      "content": "Thanks for the code review!",
      "timestamp": DateTime.now().subtract(Duration(days: 3)),
      "status": "delivered",
    },
  ];

  List<Map<String, dynamic>> sharedFiles = [
    {
      "id": 1,
      "name": "Mobile_App_Specs.pdf",
      "type": "pdf",
      "size": "2.4 MB",
      "timestamp": DateTime.now().subtract(Duration(days: 2)),
    },
    {
      "id": 2,
      "name": "UI_Designs.zip",
      "type": "zip",
      "size": "15.8 MB",
      "timestamp": DateTime.now().subtract(Duration(days: 5)),
    },
    {
      "id": 3,
      "name": "meeting_notes.docx",
      "type": "doc",
      "size": "1.2 MB",
      "timestamp": DateTime.now().subtract(Duration(days: 7)),
    },
  ];

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${contact["name"]}"),
        actions: [
          IconButton(
            icon: Icon(
              contact["favorite"] ? Icons.star : Icons.star_border,
              color: contact["favorite"] ? warningColor : null,
            ),
            onPressed: () {
              contact["favorite"] = !contact["favorite"];
              setState(() {});
              ss(contact["favorite"] ? "Added to favorites" : "Removed from favorites");
            },
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (isEditing) {
                ss("Contact updated successfully!");
              }
              isEditing = !isEditing;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showContactOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            _buildHeaderSection(),
            
            // Quick Actions
            _buildQuickActions(),
            
            // Contact Details
            _buildContactDetails(),
            
            // Communication History
            _buildCommunicationHistory(),
            
            // Shared Files
            _buildSharedFiles(),
            
            // Statistics
            _buildStatistics(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQuickActionBottomSheet();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Avatar and Status
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
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
                      width: 3,
                    ),
                  ),
                ),
              ),
              if (contact["favorite"] as bool)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: warningColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Name and Position
          Text(
            "${contact["name"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "${contact["position"]}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${contact["company"]}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white60,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Status and Category
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 12,
                      color: _getStatusColor(contact["status"]),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${contact["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${contact["category"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Call",
              icon: Icons.phone,
              onPressed: () {
                // Make call
                ss("Calling ${contact["name"]}...");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Message",
              icon: Icons.message,
              onPressed: () {
                // Send message
                // navigateTo(MessageView());
                ss("Opening messages...");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Email",
              icon: Icons.email,
              onPressed: () {
                // Send email
                ss("Opening email composer...");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetails() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Phone
            _buildDetailRow(
              Icons.phone,
              "Phone",
              "${contact["phone"]}",
              primaryColor,
            ),
            
            SizedBox(height: spMd),
            
            // Email
            _buildDetailRow(
              Icons.email,
              "Email",
              "${contact["email"]}",
              primaryColor,
            ),
            
            SizedBox(height: spMd),
            
            // Location
            _buildDetailRow(
              Icons.location_on,
              "Location",
              "${contact["location"]}",
              primaryColor,
            ),
            
            SizedBox(height: spMd),
            
            // Birthday
            _buildDetailRow(
              Icons.cake,
              "Birthday",
              (contact["birthday"] as DateTime).dMMMy,
              primaryColor,
            ),
            
            SizedBox(height: spMd),
            
            // Department
            _buildDetailRow(
              Icons.business,
              "Department",
              "${contact["department"]}",
              primaryColor,
            ),
            
            SizedBox(height: spMd),
            
            // Tags
            if ((contact["tags"] as List<String>).isNotEmpty) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.tag,
                    size: 20,
                    color: primaryColor,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tags",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spSm,
                          runSpacing: spSm,
                          children: (contact["tags"] as List<String>).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
            ],
            
            // Notes
            if ((contact["notes"] as String).isNotEmpty) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notes,
                    size: 20,
                    color: primaryColor,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${contact["notes"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            
            SizedBox(height: spMd),
            
            // Social Media
            Text(
              "Social Media",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                _buildSocialMediaButton(
                  Icons.business,
                  "LinkedIn",
                  infoColor,
                  (contact["socialMedia"] as Map<String, String>)["linkedin"] ?? "",
                ),
                SizedBox(width: spSm),
                _buildSocialMediaButton(
                  Icons.alternate_email,
                  "Twitter",
                  infoColor,
                  (contact["socialMedia"] as Map<String, String>)["twitter"] ?? "",
                ),
                SizedBox(width: spSm),
                _buildSocialMediaButton(
                  Icons.code,
                  "GitHub",
                  primaryColor,
                  (contact["socialMedia"] as Map<String, String>)["github"] ?? "",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaButton(IconData icon, String platform, Color color, String username) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (username.isNotEmpty) {
            ss("Opening $platform profile...");
          }
        },
        child: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: username.isNotEmpty ? color.withAlpha(20) : Colors.grey[100],
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: username.isNotEmpty ? color : disabledColor,
                size: 20,
              ),
              SizedBox(height: spXs),
              Text(
                platform,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: username.isNotEmpty ? color : disabledColor,
                ),
              ),
              if (username.isNotEmpty)
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommunicationHistory() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Communication History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // View all history
                  },
                  child: Text("View All"),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            ...contactHistory.take(3).map((history) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getHistoryTypeColor(history["type"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getHistoryTypeIcon(history["type"]),
                        color: Colors.white,
                        size: 16,
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
                                "${history["type"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getHistoryTypeColor(history["type"]),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                history["direction"] == "incoming" 
                                    ? Icons.call_received 
                                    : Icons.call_made,
                                size: 12,
                                color: history["direction"] == "incoming" 
                                    ? successColor 
                                    : primaryColor,
                              ),
                            ],
                          ),
                          if (history["duration"] != null)
                            Text(
                              "Duration: ${history["duration"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (history["content"] != null)
                            Text(
                              "${history["content"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (history["subject"] != null)
                            Text(
                              "${history["subject"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          Text(
                            _formatTimestamp(history["timestamp"] as DateTime),
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
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSharedFiles() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Shared Files",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // View all files
                  },
                  child: Text("View All"),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            ...sharedFiles.map((file) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getFileTypeColor(file["type"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getFileTypeIcon(file["type"]),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${file["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                "${file["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                " • ${_formatTimestamp(file["timestamp"] as DateTime)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.download,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        ss("Downloading ${file["name"]}...");
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Communication Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    Icons.phone,
                    "Calls",
                    "${contact["totalCalls"]}",
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    Icons.message,
                    "Messages",
                    "${contact["totalMessages"]}",
                    infoColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    Icons.email,
                    "Emails",
                    "${contact["totalEmails"]}",
                    primaryColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Contact since ${(contact["joinedDate"] as DateTime).dMMMy}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spXs),
            
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Last contact ${_formatTimestamp(contact["lastContact"] as DateTime)}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
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

  void _showContactOptions() {
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
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Contact"),
                onTap: () {
                  back();
                  // navigateTo(EditContactView());
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share Contact"),
                onTap: () {
                  back();
                  ss("Sharing contact...");
                },
              ),
              ListTile(
                leading: Icon(
                  contact["blocked"] ? Icons.person : Icons.block,
                  color: contact["blocked"] ? successColor : dangerColor,
                ),
                title: Text(contact["blocked"] ? "Unblock Contact" : "Block Contact"),
                onTap: () {
                  back();
                  contact["blocked"] = !contact["blocked"];
                  setState(() {});
                  ss(contact["blocked"] ? "Contact blocked" : "Contact unblocked");
                },
              ),
              ListTile(
                leading: Icon(Icons.backup),
                title: Text("Export Contact"),
                onTap: () {
                  back();
                  ss("Exporting contact...");
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete Contact", style: TextStyle(color: dangerColor)),
                onTap: () {
                  back();
                  _showDeleteConfirmation();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showQuickActionBottomSheet() {
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
            children: [
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      Icons.phone,
                      "Call",
                      successColor,
                      () {
                        back();
                        ss("Calling ${contact["name"]}...");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildQuickActionButton(
                      Icons.message,
                      "Message",
                      infoColor,
                      () {
                        back();
                        ss("Opening messages...");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      Icons.email,
                      "Email",
                      primaryColor,
                      () {
                        back();
                        ss("Opening email composer...");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildQuickActionButton(
                      Icons.videocam,
                      "Video Call",
                      warningColor,
                      () {
                        back();
                        ss("Starting video call...");
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

  Widget _buildQuickActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            SizedBox(height: spSm),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation() async {
    bool isConfirmed = await confirm("Are you sure you want to delete this contact?");
    if (isConfirmed) {
      ss("Contact deleted successfully!");
      back();
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'online':
        return successColor;
      case 'busy':
        return dangerColor;
      case 'away':
        return warningColor;
      case 'offline':
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Color _getHistoryTypeColor(String type) {
    switch (type) {
      case 'call':
        return successColor;
      case 'message':
        return infoColor;
      case 'email':
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  IconData _getHistoryTypeIcon(String type) {
    switch (type) {
      case 'call':
        return Icons.phone;
      case 'message':
        return Icons.message;
      case 'email':
        return Icons.email;
      default:
        return Icons.history;
    }
  }

  Color _getFileTypeColor(String type) {
    switch (type) {
      case 'pdf':
        return dangerColor;
      case 'doc':
        return infoColor;
      case 'zip':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  IconData _getFileTypeIcon(String type) {
    switch (type) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
        return Icons.description;
      case 'zip':
        return Icons.archive;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return timestamp.dMMMy;
    }
  }
}
