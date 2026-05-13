import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaContactsSyncView extends StatefulWidget {
  const SmaContactsSyncView({super.key});

  @override
  State<SmaContactsSyncView> createState() => _SmaContactsSyncViewState();
}

class _SmaContactsSyncViewState extends State<SmaContactsSyncView> {
  bool syncContacts = false;
  bool syncFromPhone = false;
  bool syncFromEmail = false;
  bool syncFromSocial = false;
  bool allowInvites = true;
  bool findByPhone = true;
  bool findByEmail = true;
  
  List<Map<String, dynamic>> suggestedContacts = [
    {
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "mutualFriends": 12,
      "source": "Phone Contacts",
    },
    {
      "name": "Mike Chen",
      "email": "mike.chen@email.com",
      "phone": "+1 (555) 234-5678",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "mutualFriends": 8,
      "source": "Email Contacts",
    },
    {
      "name": "Emily Rodriguez",
      "email": "emily.rodriguez@email.com",
      "phone": "+1 (555) 345-6789",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "mutualFriends": 15,
      "source": "Social Media",
    },
    {
      "name": "David Thompson",
      "email": "david.thompson@email.com",
      "phone": "+1 (555) 456-7890",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "mutualFriends": 6,
      "source": "Phone Contacts",
    },
    {
      "name": "Lisa Park",
      "email": "lisa.park@email.com",
      "phone": "+1 (555) 567-8901",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=person",
      "mutualFriends": 20,
      "source": "Email Contacts",
    },
  ];
  
  List<String> selectedContacts = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connect with Friends"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProgressIndicator(),
            _buildSyncOptions(),
            _buildPrivacySettings(),
            _buildSuggestedContacts(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Setup Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Step 4 of 4",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSyncOptions() {
    return Container(
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
            "Sync Your Contacts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Find friends who are already on our platform and discover new connections.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          _buildSyncOption(
            Icons.phone,
            "Phone Contacts",
            "Sync contacts from your phone",
            syncFromPhone,
            (value) {
              syncFromPhone = value;
              syncContacts = syncFromPhone || syncFromEmail || syncFromSocial;
              setState(() {});
            },
          ),
          _buildSyncOption(
            Icons.email,
            "Email Contacts",
            "Sync contacts from your email",
            syncFromEmail,
            (value) {
              syncFromEmail = value;
              syncContacts = syncFromPhone || syncFromEmail || syncFromSocial;
              setState(() {});
            },
          ),
          _buildSyncOption(
            Icons.share,
            "Social Media",
            "Connect with friends from social platforms",
            syncFromSocial,
            (value) {
              syncFromSocial = value;
              syncContacts = syncFromPhone || syncFromEmail || syncFromSocial;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildSyncOption(IconData icon, String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacySettings() {
    return Container(
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
            "Privacy Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildPrivacyOption(
            "Allow friend invites",
            "Others can invite you to connect",
            allowInvites,
            (value) {
              allowInvites = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Find by phone number",
            "People can find you using your phone number",
            findByPhone,
            (value) {
              findByPhone = value;
              setState(() {});
            },
          ),
          _buildPrivacyOption(
            "Find by email address",
            "People can find you using your email address",
            findByEmail,
            (value) {
              findByEmail = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildPrivacyOption(String title, String description, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildSuggestedContacts() {
    if (!syncContacts) return SizedBox.shrink();
    
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Suggested Connections",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${selectedContacts.length} selected",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(suggestedContacts.length, (index) {
              final contact = suggestedContacts[index];
              return _buildContactItem(contact);
            }),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContactItem(Map<String, dynamic> contact) {
    final isSelected = selectedContacts.contains(contact["name"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(30) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isSelected ? primaryColor : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("${contact["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${contact["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${contact["mutualFriends"]} mutual friends",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "From ${contact["source"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isSelected) {
                selectedContacts.remove(contact["name"]);
              } else {
                selectedContacts.add(contact["name"]);
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor),
              ),
              child: Icon(
                isSelected ? Icons.check : Icons.add,
                color: isSelected ? Colors.white : primaryColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: syncContacts 
                ? "Complete Setup (${selectedContacts.length} friends)"
                : "Complete Setup",
            onPressed: () {
              ss("Profile setup completed successfully!");
              //navigateTo('HomeFeedView')
            },
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Skip and Continue",
            onPressed: () {
              //navigateTo('HomeFeedView')
            },
          ),
        ),
      ],
    );
  }
}
