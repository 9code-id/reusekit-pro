import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class QChatField extends StatefulWidget {
  final String? label;
  final String value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final Function(String value) onChanged;
  final VoidCallback? onSend;
  final bool showAttachmentButton;
  final bool showEmojiButton;
  final bool showVoiceButton;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final bool showSendButton;
  final List<String> attachments;
  final Function(List<String>)? onAttachmentsChanged;

  const QChatField({
    Key? key,
    this.label,
    required this.value,
    this.hint,
    this.helper,
    this.validator,
    required this.onChanged,
    this.onSend,
    this.showAttachmentButton = true,
    this.showEmojiButton = true,
    this.showVoiceButton = true,
    this.enabled = true,
    this.maxLines = 5,
    this.maxLength,
    this.showSendButton = true,
    this.attachments = const [],
    this.onAttachmentsChanged,
  }) : super(key: key);

  @override
  State<QChatField> createState() => _QChatFieldState();
}

class _QChatFieldState extends State<QChatField> {
  bool isTyping = false;
  bool showEmojiPicker = false;
  bool isRecording = false;
  
  @override
  void initState() {
    super.initState();
    isTyping = widget.value.isNotEmpty;
  }

  @override
  void didUpdateWidget(QChatField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      isTyping = widget.value.isNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),

        // Attachments preview
        if (widget.attachments.isNotEmpty)
          Container(
            margin: EdgeInsets.only(bottom: spSm),
            height: 80,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Row(
                children: widget.attachments.map((attachment) => _buildAttachmentPreview(attachment)).toList(),
              ),
            ),
          ),

        // Main chat input container
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: isTyping ? primaryColor : disabledColor,
              width: isTyping ? 2 : 1,
            ),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Main input row
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Attachment button
                  if (widget.showAttachmentButton && !isTyping)
                    GestureDetector(
                      onTap: widget.enabled ? _showAttachmentOptions : null,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.attach_file,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),

                  if (widget.showAttachmentButton && !isTyping)
                    SizedBox(width: spSm),

                  // Text input field
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 36,
                        maxHeight: widget.maxLines * 20.0,
                      ),
                      child: TextField(
                        enabled: widget.enabled,
                        maxLines: null,
                        maxLength: widget.maxLength,
                        onChanged: (value) {
                          widget.onChanged(value);
                          setState(() {
                            isTyping = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: widget.hint ?? "Type a message...",
                          hintStyle: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spSm,
                          ),
                          counterText: "",
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: spSm),

                  // Action buttons row
                  Row(
                    children: [
                      // Emoji button
                      if (widget.showEmojiButton && !isTyping)
                        GestureDetector(
                          onTap: widget.enabled ? _toggleEmojiPicker : null,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: showEmojiPicker ? primaryColor.withAlpha(30) : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.emoji_emotions,
                              color: showEmojiPicker ? primaryColor : disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ),

                      if (widget.showEmojiButton && !isTyping)
                        SizedBox(width: spXs),

                      // Voice/Send button
                      GestureDetector(
                        onTap: widget.enabled ? (isTyping ? _sendMessage : _startVoiceRecording) : null,
                        onLongPress: widget.enabled && !isTyping ? _startVoiceRecording : null,
                        onLongPressEnd: widget.enabled && !isTyping ? (_) => _stopVoiceRecording() : null,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: isTyping || isRecording ? primaryColor : primaryColor.withAlpha(30),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isTyping ? Icons.send : (isRecording ? Icons.stop : Icons.mic),
                            color: isTyping || isRecording ? Colors.white : primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Quick actions (when not typing)
              if (!isTyping && (widget.showAttachmentButton || widget.showEmojiButton))
                Container(
                  margin: EdgeInsets.only(top: spSm),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildQuickAction(
                          icon: Icons.camera_alt,
                          label: "Camera",
                          color: successColor,
                          onTap: () => _quickAction('camera'),
                        ),
                        SizedBox(width: spSm),
                        _buildQuickAction(
                          icon: Icons.photo_library,
                          label: "Gallery",
                          color: infoColor,
                          onTap: () => _quickAction('gallery'),
                        ),
                        SizedBox(width: spSm),
                        _buildQuickAction(
                          icon: Icons.location_on,
                          label: "Location",
                          color: warningColor,
                          onTap: () => _quickAction('location'),
                        ),
                        SizedBox(width: spSm),
                        _buildQuickAction(
                          icon: Icons.description,
                          label: "Document",
                          color: primaryColor,
                          onTap: () => _quickAction('document'),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Emoji picker
        if (showEmojiPicker)
          Container(
            margin: EdgeInsets.only(top: spSm),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledColor),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Emojis",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showEmojiPicker = false;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(spSm),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      crossAxisSpacing: spXs,
                      mainAxisSpacing: spXs,
                    ),
                    itemCount: _getEmojis().length,
                    itemBuilder: (context, index) {
                      String emoji = _getEmojis()[index];
                      return GestureDetector(
                        onTap: () => _addEmoji(emoji),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Center(
                            child: Text(
                              emoji,
                              style: TextStyle(fontSize: 20),
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

        // Voice recording indicator
        if (isRecording)
          Container(
            margin: EdgeInsets.only(top: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: dangerColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Recording... Release to send",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "00:05",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

        if (widget.helper != null)
          Padding(
            padding: EdgeInsets.only(top: spXs),
            child: Text(
              widget.helper!,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAttachmentPreview(String attachment) {
    String fileName = attachment.split('/').last;
    bool isImage = _isImageFile(attachment);

    return Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: isImage
                ? Image.network(
                    attachment,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 60,
                    height: 60,
                    color: primaryColor.withAlpha(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_drive_file,
                          color: primaryColor,
                          size: 20,
                        ),
                        Text(
                          fileName.length > 8 
                              ? "${fileName.substring(0, 8)}..." 
                              : fileName,
                          style: TextStyle(
                            fontSize: 8,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: GestureDetector(
              onTap: () => _removeAttachment(attachment),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: dangerColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 16,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getEmojis() {
    return [
      '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
      '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
      '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜',
      '🤪', '🤨', '🧐', '🤓', '😎', '🤩', '🥳', '😏',
      '😒', '😞', '😔', '😟', '😕', '🙁', '☹️', '😣',
      '😖', '😫', '😩', '🥺', '😢', '😭', '😤', '😠',
      '👍', '👎', '👌', '🤞', '✌️', '🤟', '🤘', '👊',
      '✊', '🤛', '🤜', '👏', '🙌', '👐', '🤲', '🤝',
      '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
      '💯', '💥', '💫', '⭐', '🌟', '✨', '🔥', '💦',
    ];
  }

  bool _isImageFile(String path) {
    String extension = path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  void _sendMessage() {
    if (widget.onSend != null && widget.value.isNotEmpty) {
      widget.onSend!();
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      showEmojiPicker = !showEmojiPicker;
    });
  }

  void _addEmoji(String emoji) {
    String newValue = widget.value + emoji;
    widget.onChanged(newValue);
  }

  void _startVoiceRecording() {
    setState(() {
      isRecording = true;
    });
    // In real implementation, start voice recording here
    si("Voice recording started");
  }

  void _stopVoiceRecording() {
    setState(() {
      isRecording = false;
    });
    // In real implementation, stop voice recording and process audio
    ss("Voice message sent!");
  }

  void _showAttachmentOptions() {
    if (widget.onAttachmentsChanged != null) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => QAttachmentPicker(
          label: "Attach Files",
          value: widget.attachments,
          onChanged: (attachments) {
            widget.onAttachmentsChanged!(attachments);
            back();
          },
        ),
      );
    }
  }

  void _quickAction(String type) {
    List<String> newAttachments = List.from(widget.attachments);
    
    switch (type) {
      case 'camera':
        newAttachments.add('https://picsum.photos/400/300?random=${DateTime.now().millisecondsSinceEpoch}');
        ss("Photo captured!");
        break;
      case 'gallery':
        newAttachments.add('https://picsum.photos/400/300?random=${DateTime.now().millisecondsSinceEpoch + 1}');
        ss("Image selected from gallery!");
        break;
      case 'location':
        widget.onChanged(widget.value + "📍 Current Location");
        ss("Location shared!");
        return;
      case 'document':
        newAttachments.add('/storage/emulated/0/Documents/document_${DateTime.now().millisecondsSinceEpoch}.pdf');
        ss("Document attached!");
        break;
    }
    
    if (widget.onAttachmentsChanged != null) {
      widget.onAttachmentsChanged!(newAttachments);
    }
  }

  void _removeAttachment(String attachment) {
    if (widget.onAttachmentsChanged != null) {
      List<String> newAttachments = List.from(widget.attachments);
      newAttachments.remove(attachment);
      widget.onAttachmentsChanged!(newAttachments);
    }
  }
}