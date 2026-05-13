import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlInvitation9View extends StatefulWidget {
  @override
  State<GrlInvitation9View> createState() => _GrlInvitation9ViewState();
}

class _GrlInvitation9ViewState extends State<GrlInvitation9View> {
  String invitationCode = "";
  bool isValidating = false;
  bool codeValidated = false;
  String guestName = "";
  String guestEmail = "";
  String guestPhone = "";
  int partySize = 1;
  String dietaryRestrictions = "None";
  String specialRequests = "";
  
  List<Map<String, dynamic>> dietaryOptions = [
    {"label": "None", "value": "None"},
    {"label": "Vegetarian", "value": "Vegetarian"},
    {"label": "Vegan", "value": "Vegan"},
    {"label": "Gluten-Free", "value": "Gluten-Free"},
    {"label": "Halal", "value": "Halal"},
    {"label": "Kosher", "value": "Kosher"},
    {"label": "Allergies", "value": "Allergies"},
  ];

  Map<String, dynamic>? eventDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Event"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildWelcomeHeader(),
            _buildInvitationCodeInput(),
            if (codeValidated && eventDetails != null) ...[
              _buildEventDetails(),
              _buildGuestInformation(),
              _buildPartySize(),
              _buildDietaryPreferences(),
              _buildSpecialRequests(),
              _buildConfirmationButton(),
            ],
            _buildHelpSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          Icon(
            Icons.celebration,
            size: 64,
            color: Colors.white,
          ),
          SizedBox(height: spSm),
          Text(
            "Welcome!",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Enter your invitation code to join the event",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(230),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvitationCodeInput() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invitation Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Enter Code",
            value: invitationCode,
            hint: "e.g., EVENT-2024-ABC123",
            onChanged: (value) {
              invitationCode = value;
              codeValidated = false;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: isValidating ? "Validating..." : "Validate Code",
              size: bs.md,
              onPressed: invitationCode.isNotEmpty && !isValidating ? () => _validateCode() : null,
            ),
          ),
          if (codeValidated && eventDetails != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Code validated successfully! Please fill out your details below.",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
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

  Widget _buildEventDetails() {
    if (eventDetails == null) return SizedBox();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Event Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${eventDetails!["image"]}",
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "${eventDetails!["title"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Hosted by ${eventDetails!["host"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          _buildEventDetailRow(Icons.calendar_today, "Date & Time", 
            "${DateTime.parse(eventDetails!["date"]).dMMMy} at ${eventDetails!["time"]}"),
          _buildEventDetailRow(Icons.location_on, "Location", "${eventDetails!["location"]}"),
          _buildEventDetailRow(Icons.style, "Dress Code", "${eventDetails!["dressCode"]}"),
          _buildEventDetailRow(Icons.people, "Expected Attendees", "${eventDetails!["expectedAttendees"]}"),
          SizedBox(height: spSm),
          Text(
            "${eventDetails!["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuestInformation() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Full Name",
            value: guestName,
            hint: "Enter your full name",
            validator: Validator.required,
            onChanged: (value) {
              guestName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Email Address",
            value: guestEmail,
            hint: "Enter your email",
            validator: Validator.email,
            onChanged: (value) {
              guestEmail = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Phone Number",
            value: guestPhone,
            hint: "Enter your phone number",
            validator: Validator.required,
            onChanged: (value) {
              guestPhone = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPartySize() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Party Size",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Number of Guests (including yourself)",
            value: partySize.toString(),
            onChanged: (value) {
              partySize = int.tryParse(value) ?? 1;
              if (partySize < 1) partySize = 1;
              if (partySize > 10) partySize = 10;
              setState(() {});
            },
          ),
          if (partySize > 1)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "You can bring up to ${partySize - 1} additional guest(s). Please ensure they follow the dress code.",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 12,
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

  Widget _buildDietaryPreferences() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dietary Preferences",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Dietary Restrictions",
            items: dietaryOptions,
            value: dietaryRestrictions,
            onChanged: (value, label) {
              dietaryRestrictions = value;
              setState(() {});
            },
          ),
          if (dietaryRestrictions == "Allergies")
            QMemoField(
              label: "Please specify allergies",
              value: specialRequests,
              hint: "List any food allergies or specific dietary needs",
              onChanged: (value) {
                specialRequests = value;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSpecialRequests() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Special Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Additional Notes",
            value: dietaryRestrictions != "Allergies" ? specialRequests : "",
            hint: "Any special requirements, accessibility needs, or other requests",
            onChanged: (value) {
              if (dietaryRestrictions != "Allergies") {
                specialRequests = value;
              }
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationButton() {
    final isFormValid = guestName.isNotEmpty && 
                       guestEmail.isNotEmpty && 
                       guestPhone.isNotEmpty;
    
    return Column(
      spacing: spSm,
      children: [
        if (!isFormValid)
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: warningColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Please fill out all required fields to confirm your attendance.",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Confirm Attendance",
            size: bs.md,
            onPressed: isFormValid ? () => _confirmAttendance() : null,
          ),
        ),
        Text(
          "By confirming, you agree to attend the event and follow the guidelines.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildHelpSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Need Help?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildHelpItem(
            "Invalid Code",
            "Check your invitation email for the correct code format",
            Icons.error_outline,
          ),
          _buildHelpItem(
            "Lost Invitation",
            "Contact the event host to resend your invitation",
            Icons.help_outline,
          ),
          _buildHelpItem(
            "Technical Issues",
            "Try refreshing the app or contact support",
            Icons.support,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Contact Host",
                  size: bs.sm,
                  onPressed: () => _contactHost(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Get Support",
                  size: bs.sm,
                  onPressed: () => _getSupport(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: infoColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _validateCode() async {
    if (invitationCode.trim().isEmpty) {
      se("Please enter an invitation code");
      return;
    }
    
    setState(() {
      isValidating = true;
    });
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    // Mock validation - in real app, this would call an API
    if (invitationCode.toUpperCase().contains("EVENT")) {
      setState(() {
        codeValidated = true;
        eventDetails = {
          "title": "Annual Corporate Gala 2024",
          "host": "Global Enterprises Ltd.",
          "date": "2024-03-15",
          "time": "18:00",
          "location": "Grand Ballroom, Luxury Hotel",
          "dressCode": "Black Tie",
          "expectedAttendees": "250+ guests",
          "description": "Join us for an elegant evening celebrating our company's achievements and future vision. Enjoy gourmet dining, live entertainment, and networking with industry leaders.",
          "image": "https://picsum.photos/400/200?random=1&keyword=gala"
        };
        isValidating = false;
      });
      ss("Invitation code validated successfully!");
    } else {
      setState(() {
        isValidating = false;
      });
      se("Invalid invitation code. Please check and try again.");
    }
  }

  void _confirmAttendance() {
    ss("Attendance confirmed! You will receive a confirmation email shortly.");
    // Navigate back or to confirmation screen
  }

  void _contactHost() {
    si("Redirecting to host contact information...");
  }

  void _getSupport() {
    si("Opening support chat...");
  }
}
