import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmEventDetailsView extends StatefulWidget {
  const EcmEventDetailsView({super.key});

  @override
  State<EcmEventDetailsView> createState() => _EcmEventDetailsViewState();
}

class _EcmEventDetailsViewState extends State<EcmEventDetailsView> {
  final formKey = GlobalKey<FormState>();
  
  String eventTitle = "";
  String eventSubtitle = "";
  String selectedCategory = "";
  String selectedType = "Conference";
  String eventDescription = "";
  String organizerName = "";
  String organizerEmail = "";
  String organizerPhone = "";
  String organizerWebsite = "";
  List<String> eventImages = [];
  String logoImage = "";
  List<String> eventTags = [];
  String newTag = "";
  String ticketPrice = "";
  String earlyBirdPrice = "";
  String groupPrice = "";
  bool isPublic = true;
  bool requireApproval = false;
  bool allowGuestRegistration = true;
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Business & Professional", "value": "business"},
    {"label": "Technology", "value": "technology"},  
    {"label": "Education", "value": "education"},
    {"label": "Health & Wellness", "value": "health"},
    {"label": "Arts & Culture", "value": "arts"},
    {"label": "Sports & Recreation", "value": "sports"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "Conference", "value": "Conference"},
    {"label": "Workshop", "value": "Workshop"},
    {"label": "Seminar", "value": "Seminar"},
    {"label": "Webinar", "value": "Webinar"},
    {"label": "Networking", "value": "Networking"},
    {"label": "Trade Show", "value": "Trade Show"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: _saveEventDetails,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBasicInformationSection(),
              _buildOrganizerSection(),
              _buildMediaSection(),
              _buildTagsSection(),
              _buildPricingSection(),
              _buildPrivacySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInformationSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Event Title",
            value: eventTitle,
            hint: "Enter event title",
            validator: Validator.required,
            onChanged: (value) {
              eventTitle = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Event Subtitle",
            value: eventSubtitle,
            hint: "Enter event subtitle (optional)",
            onChanged: (value) {
              eventSubtitle = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Category",
            items: categoryOptions,
            value: selectedCategory,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Event Type",
            items: typeOptions,
            value: selectedType,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedType = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Event Description",
            value: eventDescription,
            hint: "Describe your event in detail",
            validator: Validator.required,
            onChanged: (value) {
              eventDescription = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizerSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Organizer Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Organizer Name",
            value: organizerName,
            hint: "Enter organizer name",
            validator: Validator.required,
            onChanged: (value) {
              organizerName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Contact Email",
            value: organizerEmail,
            hint: "Enter contact email",
            validator: Validator.email,
            onChanged: (value) {
              organizerEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Contact Phone",
            value: organizerPhone,
            hint: "Enter contact phone number",
            onChanged: (value) {
              organizerPhone = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Website",
            value: organizerWebsite,
            hint: "Enter organizer website (optional)",
            onChanged: (value) {
              organizerWebsite = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMediaSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Media & Branding",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QImagePicker(
            label: "Event Logo",
            value: logoImage,
            hint: "Upload event logo",
            onChanged: (value) {
              logoImage = value;
              setState(() {});
            },
          ),
          QMultiImagePicker(
            label: "Event Images",
            value: eventImages,
            hint: "Add event promotional images",
            maxImages: 5,
            onChanged: (value) {
              eventImages = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add Tag",
                  value: newTag,
                  hint: "Enter tag name",
                  onChanged: (value) {
                    newTag = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: _addTag,
              ),
            ],
          ),
          if (eventTags.isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: eventTags.map((tag) => _buildTagChip(tag)).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: spXs),
          GestureDetector(
            onTap: () => _removeTag(tag),
            child: Icon(
              Icons.close,
              size: 16,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pricing Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Regular Ticket Price (\$)",
            value: ticketPrice,
            hint: "Enter regular ticket price",
            onChanged: (value) {
              ticketPrice = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Early Bird Price (\$)",
            value: earlyBirdPrice,
            hint: "Enter early bird price (optional)",
            onChanged: (value) {
              earlyBirdPrice = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Group Price (\$)",
            value: groupPrice,
            hint: "Enter group discount price (optional)",
            onChanged: (value) {
              groupPrice = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Privacy & Registration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Public Event",
                "value": true,
                "checked": isPublic,
              }
            ],
            value: [if (isPublic) {"label": "Public Event", "value": true, "checked": true}],
            onChanged: (values, ids) {
              isPublic = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Require Approval for Registration",
                "value": true,
                "checked": requireApproval,
              }
            ],
            value: [if (requireApproval) {"label": "Require Approval for Registration", "value": true, "checked": true}],
            onChanged: (values, ids) {
              requireApproval = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Allow Guest Registration",
                "value": true,
                "checked": allowGuestRegistration,
              }
            ],
            value: [if (allowGuestRegistration) {"label": "Allow Guest Registration", "value": true, "checked": true}],
            onChanged: (values, ids) {
              allowGuestRegistration = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  void _addTag() {
    if (newTag.trim().isNotEmpty && !eventTags.contains(newTag.trim())) {
      eventTags.add(newTag.trim());
      newTag = "";
      setState(() {});
    }
  }

  void _removeTag(String tag) {
    eventTags.remove(tag);
    setState(() {});
  }

  void _saveEventDetails() {
    if (formKey.currentState!.validate()) {
      ss("Event details saved successfully");
    }
  }
}
