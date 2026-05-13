import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat7View extends StatefulWidget {
  @override
  State<GrlChat7View> createState() => _GrlChat7ViewState();
}

class _GrlChat7ViewState extends State<GrlChat7View> {
  String message = "";
  List<String> messageAttachments = [];
  
  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "message": "Welcome to AI Assistant! I'm here to help you with various tasks, answer questions, and provide assistance. How can I help you today?",
      "timestamp": "2024-01-15 10:00:00",
      "isMe": false,
      "messageType": "text",
      "thinking": false
    },
    {
      "id": "2",
      "message": "Hi! Can you help me understand machine learning concepts?",
      "timestamp": "2024-01-15 10:02:00",
      "isMe": true,
      "messageType": "text"
    },
    {
      "id": "3",
      "message": "Absolutely! Machine learning is a subset of artificial intelligence that enables computers to learn and improve from experience without being explicitly programmed. Here are the key concepts:\n\n🧠 **Types of Machine Learning:**\n• Supervised Learning - Learning with labeled data\n• Unsupervised Learning - Finding patterns in unlabeled data\n• Reinforcement Learning - Learning through trial and error\n\n📊 **Common Applications:**\n• Image recognition\n• Natural language processing\n• Recommendation systems\n• Predictive analytics\n\nWould you like me to explain any specific aspect in more detail?",
      "timestamp": "2024-01-15 10:03:00",
      "isMe": false,
      "messageType": "text",
      "thinking": false
    },
    {
      "id": "4",
      "message": "That's really helpful! Can you give me a practical example of supervised learning?",
      "timestamp": "2024-01-15 10:05:00",
      "isMe": true,
      "messageType": "text"
    },
    {
      "id": "5",
      "message": "Great question! Here's a practical example:\n\n📧 **Email Spam Detection**\n\n**Training Phase:**\n• Feed the algorithm thousands of emails labeled as 'spam' or 'not spam'\n• The algorithm learns patterns (keywords, sender patterns, etc.)\n\n**Prediction Phase:**\n• When a new email arrives, the trained model predicts if it's spam\n• Based on learned patterns from training data\n\n**Key Features the Model Might Learn:**\n• Suspicious words like 'FREE', 'URGENT', 'WINNER'\n• Unknown sender addresses\n• Excessive capitalization\n• Unusual links or attachments\n\nThe model gets better as it sees more examples! This is why spam filters improve over time.",
      "timestamp": "2024-01-15 10:06:00",
      "isMe": false,
      "messageType": "text",
      "thinking": false
    }
  ];

  List<Map<String, dynamic>> quickPrompts = [
    {
      "title": "Explain a concept",
      "prompt": "Can you explain how",
      "icon": Icons.school
    },
    {
      "title": "Write code",
      "prompt": "Write a code example for",
      "icon": Icons.code
    },
    {
      "title": "Solve problem",
      "prompt": "Help me solve this problem:",
      "icon": Icons.psychology
    },
    {
      "title": "Creative writing",
      "prompt": "Write a creative story about",
      "icon": Icons.edit
    },
    {
      "title": "Data analysis",
      "prompt": "Analyze this data:",
      "icon": Icons.analytics
    },
    {
      "title": "Language translation",
      "prompt": "Translate this to",
      "icon": Icons.translate
    }
  ];

  bool isThinking = false;
  int tokenCount = 0;
  String conversationTopic = "Machine Learning";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.psychology,
                color: Colors.white,
                size: 18,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Assistant",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    isThinking ? "Thinking..." : "Ready to help",
                    style: TextStyle(
                      fontSize: 12,
                      color: isThinking ? warningColor : successColor,
                      fontStyle: isThinking ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              _clearConversation();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              _showSettings();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Conversation Stats Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              border: Border(
                bottom: BorderSide(
                  color: primaryColor.withAlpha(20),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.topic,
                  size: 16,
                  color: primaryColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Topic: $conversationTopic",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.token,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Tokens: ${(tokenCount / 1000).toStringAsFixed(1)}k",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Messages Area
          Expanded(
            child: messages.isEmpty ? _buildWelcomeScreen() : _buildMessagesList(),
          ),
          
          // Quick Prompts (when no conversation)
          if (messages.length <= 1)
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  top: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    child: Text(
                      "Quick Prompts",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: spMd),
                      itemCount: quickPrompts.length,
                      itemBuilder: (context, index) {
                        final prompt = quickPrompts[index];
                        return Container(
                          width: 120,
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              message = "${prompt["prompt"]} ";
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: primaryColor.withAlpha(30),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    prompt["icon"] as IconData,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${prompt["title"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          
          // Message Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                QButton(
                  icon: Icons.image,
                  size: bs.sm,
                  onPressed: () {
                    si("Image analysis coming soon");
                  },
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(text: message),
                            decoration: InputDecoration(
                              hintText: "Ask me anything...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (value) {
                              message = value;
                              setState(() {});
                            },
                            maxLines: null,
                          ),
                        ),
                        QButton(
                          icon: Icons.mic,
                          size: bs.sm,
                          onPressed: () {
                            si("Voice input coming soon");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: isThinking ? Icons.stop : Icons.send,
                  size: bs.sm,
                  onPressed: () {
                    if (isThinking) {
                      _stopGeneration();
                    } else if (message.isNotEmpty) {
                      _sendMessage(message);
                      message = "";
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          SizedBox(height: spXl),
          
          // AI Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.psychology,
              size: 40,
              color: Colors.white,
            ),
          ),
          
          Text(
            "AI Assistant",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "I'm your intelligent assistant powered by advanced AI. I can help you with:\n\n• Answering questions\n• Writing and editing\n• Coding assistance\n• Creative projects\n• Problem solving\n• Data analysis",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          // Capabilities Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildCapabilityCard(Icons.chat, "Natural Conversations", "Have natural conversations on any topic"),
              _buildCapabilityCard(Icons.code, "Code Generation", "Generate and explain code in multiple languages"),
              _buildCapabilityCard(Icons.analytics, "Data Analysis", "Analyze and interpret data patterns"),
              _buildCapabilityCard(Icons.edit, "Creative Writing", "Help with creative writing and storytelling"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCapabilityCard(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: primaryColor.withAlpha(20),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: messages.length + (isThinking ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == messages.length && isThinking) {
          return _buildThinkingIndicator();
        }
        
        final messageData = messages[index];
        final isMe = messageData["isMe"] as bool;
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe) ...[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.psychology,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(width: spSm),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? primaryColor : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${messageData["message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: isMe ? Colors.white : Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${DateTime.parse(messageData["timestamp"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (!isMe) ...[
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.copy,
                            size: bs.sm,
                            onPressed: () {
                              si("Copied to clipboard");
                            },
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.thumb_up,
                            size: bs.sm,
                            onPressed: () {
                              si("Thank you for your feedback!");
                            },
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              if (isMe) ...[
                SizedBox(width: spSm),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage("https://picsum.photos/40/40?random=2&keyword=person"),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildThinkingIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.psychology,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spMd,
              vertical: spSm,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Thinking...",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    final userMessage = {
      "id": "${messages.length + 1}",
      "message": text,
      "timestamp": DateTime.now().toIso8601String(),
      "isMe": true,
      "messageType": "text"
    };
    
    messages.add(userMessage);
    tokenCount += text.length;
    isThinking = true;
    setState(() {});
    
    // Simulate AI thinking time
    Future.delayed(Duration(seconds: 3), () {
      isThinking = false;
      
      final aiResponses = [
        "That's an excellent question! Let me break this down for you step by step.\n\nFirst, let's consider the fundamental principles involved...",
        "I understand what you're looking for. Here's a comprehensive explanation:\n\n🔍 **Key Points:**\n• This relates to several important concepts\n• The implementation involves multiple steps\n• Best practices suggest following these guidelines\n\nWould you like me to elaborate on any specific aspect?",
        "Great question! This is actually a common scenario that many developers encounter. Here's how I would approach it:\n\n**Step 1:** Analyze the requirements\n**Step 2:** Consider the constraints\n**Step 3:** Implement the solution\n\nLet me know if you need more details on any of these steps!",
        "I can definitely help you with that! This involves understanding several interconnected concepts. Let me explain each one:\n\n📚 **Background Information:**\nThis topic has evolved significantly over the years...\n\n💡 **Practical Applications:**\nYou can apply this in various scenarios...\n\nIs there a particular aspect you'd like to explore further?"
      ];
      
      final aiMessage = {
        "id": "${messages.length + 1}",
        "message": aiResponses[messages.length % aiResponses.length],
        "timestamp": DateTime.now().toIso8601String(),
        "isMe": false,
        "messageType": "text",
        "thinking": false
      };
      
      messages.add(aiMessage);
      tokenCount += aiMessage["message"].toString().length;
      setState(() {});
    });
  }

  void _stopGeneration() {
    isThinking = false;
    setState(() {});
    si("Generation stopped");
  }

  void _clearConversation() {
    setState(() {
      messages.clear();
      tokenCount = 0;
      conversationTopic = "General";
    });
    si("Conversation cleared");
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "AI Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  ListTile(
                    leading: Icon(Icons.speed, color: primaryColor),
                    title: Text("Response Speed"),
                    subtitle: Text("Adjust AI response timing"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pop(context);
                      si("Response speed settings");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.language, color: primaryColor),
                    title: Text("Language"),
                    subtitle: Text("Change conversation language"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pop(context);
                      si("Language settings");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.psychology, color: primaryColor),
                    title: Text("AI Personality"),
                    subtitle: Text("Adjust AI conversation style"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pop(context);
                      si("Personality settings");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.history, color: primaryColor),
                    title: Text("Conversation History"),
                    subtitle: Text("Manage chat history"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pop(context);
                      si("History settings");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
