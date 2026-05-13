import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReferral2View extends StatefulWidget {
  @override
  State<GrlReferral2View> createState() => _GrlReferral2ViewState();
}

class _GrlReferral2ViewState extends State<GrlReferral2View> {
  String friendEmail = "";
  String friendName = "";
  String personalMessage = "";
  
  List<Map<String, dynamic>> referralTemplates = [
    {
      "title": "Casual Invite",
      "message": "Hey! I've been using this amazing app and thought you'd love it too. Use my code to get \$25 bonus when you sign up!",
      "icon": Icons.waving_hand,
    },
    {
      "title": "Direct Benefit",
      "message": "Get \$25 free when you join using my referral code! I'll earn \$25 too when you make your first purchase. Win-win!",
      "icon": Icons.attach_money,
    },
    {
      "title": "Enthusiastic",
      "message": "You HAVE to try this app! It's been a game-changer for me. Plus, we both get \$25 when you sign up with my code. What are you waiting for?",
      "icon": Icons.celebration,
    },
    {
      "title": "Professional",
      "message": "I'd like to recommend this excellent service. Use my referral code to receive a \$25 welcome bonus. I believe you'll find great value in their offerings.",
      "icon": Icons.business,
    },
  ];

  List<Map<String, dynamic>> recentInvites = [
    {
      "name": "John Smith",
      "email": "john@example.com",
      "sent_date": "2024-01-15",
      "status": "pending",
      "opened": true,
      "clicked": false,
    },
    {
      "name": "Emily Johnson",
      "email": "emily@example.com",
      "sent_date": "2024-01-14",
      "status": "accepted",
      "opened": true,
      "clicked": true,
    },
    {
      "name": "Mike Davis",
      "email": "mike@example.com",
      "sent_date": "2024-01-12",
      "status": "pending",
      "opened": false,
      "clicked": false,
    },
  ];

  Map<String, dynamic> inviteStats = {
    "total_sent": 47,
    "opened": 32,
    "clicked": 18,
    "converted": 12,
    "open_rate": 68,
    "click_rate": 38,
    "conversion_rate": 26,
  };

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Friends"),
        actions: [
          IconButton(
            icon: Icon(Icons.contacts),
            onPressed: () => _importFromContacts(),
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () => _showInviteStats(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Invite Statistics Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Invite Performance",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${inviteStats["total_sent"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Sent",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${inviteStats["open_rate"]}%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Open Rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${inviteStats["converted"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Converted",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withAlpha(200),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),

              // Friend Details Section
              Text(
                "Friend's Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "Friend's Name",
                value: friendName,
                hint: "Enter your friend's full name",
                validator: Validator.required,
                onChanged: (value) {
                  friendName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),

              QTextField(
                label: "Friend's Email",
                value: friendEmail,
                hint: "friend@example.com",
                validator: Validator.email,
                onChanged: (value) {
                  friendEmail = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Message Templates
              Text(
                "Choose Message Template",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Column(
                children: referralTemplates.map((template) {
                  bool isSelected = personalMessage == "${template["message"]}";
                  return GestureDetector(
                    onTap: () {
                      personalMessage = "${template["message"]}";
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              template["icon"] as IconData,
                              color: isSelected ? Colors.white : primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${template["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${template["message"]}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: primaryColor,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: spMd),

              // Custom Message
              Text(
                "Personalize Your Message",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              QMemoField(
                label: "Personal Message",
                value: personalMessage,
                hint: "Add your personal touch to the invitation...",
                onChanged: (value) {
                  personalMessage = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Preview Section
              if (personalMessage.isNotEmpty && friendName.isNotEmpty) ...[
                Text(
                  "Message Preview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi $friendName,",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        personalMessage,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Your Referral Code:",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "SARAH2024",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Best regards,\nSarah",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spMd),
              ],

              // Send Options
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: QButton(
                        label: "Save as Draft",
                        size: bs.md,
                        onPressed: () {
                          ss("Invitation saved as draft");
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Send Invitation",
                      size: bs.md,
                      onPressed: () {
                        if (formKey.currentState!.validate() && personalMessage.isNotEmpty) {
                          _sendInvitation();
                        } else {
                          se("Please fill all required fields");
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),

              // Recent Invites
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Invites",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),

              Column(
                children: recentInvites.take(3).map((invite) {
                  Color statusColor;
                  String statusText;
                  IconData statusIcon;

                  switch ("${invite["status"]}") {
                    case "accepted":
                      statusColor = successColor;
                      statusText = "Joined";
                      statusIcon = Icons.check_circle;
                      break;
                    case "pending":
                      statusColor = warningColor;
                      statusText = "Pending";
                      statusIcon = Icons.access_time;
                      break;
                    default:
                      statusColor = disabledBoldColor;
                      statusText = "No Response";
                      statusIcon = Icons.mail_outline;
                  }

                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            statusIcon,
                            color: statusColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${invite["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${invite["email"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    statusText,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Text(
                                    "${invite["sent_date"]}",
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
                            Row(
                              children: [
                                if (invite["opened"] as bool)
                                  Icon(
                                    Icons.mark_email_read,
                                    color: successColor,
                                    size: 16,
                                  )
                                else
                                  Icon(
                                    Icons.mark_email_unread,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                SizedBox(width: spXs),
                                if (invite["clicked"] as bool)
                                  Icon(
                                    Icons.touch_app,
                                    color: successColor,
                                    size: 16,
                                  )
                                else
                                  Icon(
                                    Icons.touch_app,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                              ],
                            ),
                            if ("${invite["status"]}" == "pending")
                              Padding(
                                padding: EdgeInsets.only(top: spXs),
                                child: QButton(
                                  label: "Resend",
                                  size: bs.sm,
                                  onPressed: () => _resendInvite(invite),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendInvitation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: primaryColor),
            SizedBox(height: spMd),
            Text(
              "Sending invitation...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );

    // Simulate sending delay
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: successColor,
              size: 64,
            ),
            SizedBox(height: spMd),
            Text(
              "Invitation Sent!",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Your invitation has been sent to $friendName. You'll be notified when they join!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Great!",
              size: bs.md,
              onPressed: () {
                Navigator.pop(context);
                // Reset form
                friendName = "";
                friendEmail = "";
                personalMessage = "";
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  void _importFromContacts() {
    ss("Importing contacts...");
  }

  void _showInviteStats() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Invitation Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            _buildStatItem("Total Sent", "${inviteStats["total_sent"]}", Icons.send),
            _buildStatItem("Opened", "${inviteStats["opened"]} (${inviteStats["open_rate"]}%)", Icons.mark_email_read),
            _buildStatItem("Clicked", "${inviteStats["clicked"]} (${inviteStats["click_rate"]}%)", Icons.touch_app),
            _buildStatItem("Converted", "${inviteStats["converted"]} (${inviteStats["conversion_rate"]}%)", Icons.person_add),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
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
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _resendInvite(Map<String, dynamic> invite) async {
    bool isConfirmed = await confirm("Resend invitation to ${invite["name"]}?");
    if (isConfirmed) {
      ss("Invitation resent to ${invite["name"]}");
    }
  }
}
