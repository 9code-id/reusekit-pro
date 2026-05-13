import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEmptyState2View extends StatefulWidget {
  @override
  State<GrlEmptyState2View> createState() => _GrlEmptyState2ViewState();
}

class _GrlEmptyState2ViewState extends State<GrlEmptyState2View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(10),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              
              // Floating Message Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withAlpha(20),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 60,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Animated Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(120),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(60),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spXl),
              
              // Title
              Text(
                "No Messages Yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Description
              Container(
                padding: EdgeInsets.symmetric(horizontal: spLg),
                child: Text(
                  "Start a conversation with your friends and family. Your messages will appear here.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    height: 1.6,
                  ),
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Message Examples
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Tips for great conversations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    _buildTip("Send a friendly greeting"),
                    _buildTip("Share interesting photos"),
                    _buildTip("Ask about their day"),
                    _buildTip("Be respectful and kind"),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "New Message",
                      size: bs.md,
                      onPressed: () {
                        // navigateTo(NewMessageView());
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Find Friends",
                      size: bs.md,
                      onPressed: () {
                        // navigateTo(FindFriendsView());
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              // Secondary Action
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Import Contacts",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(ImportContactsView());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: successColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
