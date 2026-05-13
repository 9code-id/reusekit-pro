# Form Handling Guidelines

## Form Widget Rules

### TextFields

- Use `onChanged` event to capture values
- Set initial values with the `value:` property
- Do NOT use TextEditingController anywhere
- Semua reuseable widget untuk form wajib di isi event onChanged, tidak boleh di null kan

### Buttons

- Always use solid QButton variants
- Never change text color of QButton!
- Avoid outlined button styles
- Jangan mengatur height dari QButton

### Reuseable Widget Rules

Untuk mengatur initialValue, gunakan property value:

```dart
Q...(
  ...
  value: _email,
 ...
)
```

**Aturan untuk Reuseable Widget:**

- Tidak perlu mendefinisikan maxLength atau maxLines
- Tidak perlu mendefinisikan keyboardType
- Tidak perlu mengatur suffixIcon
- Tidak perlu mengatur labelColor pada QButton, QTextField dan lainnya
- Kalau pakai colorset seperti primaryColor, mestinya widget-nya tidak di definsiikan dengan const
- Jangan gunakan property selain yang saya contohkan di dokumentasi reuseable widget

## Form Layout

- Ketika membuat Form yang di dalamnya ada Column atau Row, gunakan spacing: spMd

## Validation

Validation menggunakan class Validator, dan di implementasikan dengan formKey. Jadi tidak perlu diberi IF IF IF lagi.

```dart
final formKey = GlobalKey<FormState>();

// In build method
Form(
  key: formKey,
  child: Column(
    children: [
      // Form fields with validators
    ],
  ),
)

// Validate before submission
if (formKey.currentState!.validate()) {
  // Proceed with submission
}
```

## Form Examples

### QSwitch Example

```dart
QSwitch(
    label: "Status Aktif",
    items: [
        {
        "label": "Aktif",
        "value": true,
        "checked": isActive,
        }
    ],
    value: [if (isActive) {"label": "Aktif", "value": true, "checked": true}],
    onChanged: (values, ids) {
        setState(() {
        isActive = values.isNotEmpty;
        });
    },
)
```

### QDropdownField Example
```dart
List<Map<String,dynamic>> semesterItems = [
  {
    "label": "Semester 1",
    "value": "1",
  },
  {
    "label": "Semester 2",
    "value": "2",
  },
  {
    "label": "Semester 3",
    "value": "3",
  }
];
...
QDropdownField(
    label: "Filter Semester",
    items: semesterItems, // List<Map<String,dynamic>> with label and value key (required)
    value: selectedSemester,
    onChanged: (value, label) {
      selectedSemester = value; // Always use value, not label
      _filterKelas();
    },
)
```



### QImagePicker Example

```dart
String profileImage = "";

QImagePicker(
  label: "Profile Image",
  value: profileImage,
  hint: "Select your profile picture",
  helper: "Image will be uploaded to cloud storage",
  validator: Validator.required,
  onChanged: (value) {
    profileImage = value;
    setState(() {});
  },
)
```

### QMultiImagePicker Example

```dart
List<String> productImages = [];

QMultiImagePicker(
  label: "Product Images",
  value: productImages,
  maxImages: 5,
  hint: "Add product photos",
  helper: "You can upload up to 5 high-quality images",
  validator: (images) {
    if (images == null || images.isEmpty) {
      return "At least one image is required";
    }
    return null;
  },
  onChanged: (value) {
    productImages = value;
    setState(() {});
  },
)
```

### QAttachmentPicker Example

```dart
List<String> attachments = [];

QAttachmentPicker(
  label: "Attachments",
  value: attachments,
  hint: "Attach files to your message",
  helper: "Supports images, documents, videos, and audio files",
  maxAttachments: 10,
  allowedTypes: ['image', 'document', 'video', 'audio'],
  validator: (files) {
    if (files == null || files.isEmpty) {
      return "At least one file is required";
    }
    return null;
  },
  onChanged: (value) {
    attachments = value;
    setState(() {});
  },
)
```

### QChatField Example

```dart
String message = "";
List<String> messageAttachments = [];

QChatField(
  label: "Message",
  value: message,
  hint: "Type your message...",
  helper: "Press and hold mic button to record voice message",
  maxLines: 5,
  maxLength: 1000,
  attachments: messageAttachments,
  showAttachmentButton: true,
  showEmojiButton: true,
  showVoiceButton: true,
  onChanged: (value) {
    message = value;
    setState(() {});
  },
  onSend: () {
    // Handle send message
    if (message.isNotEmpty || messageAttachments.isNotEmpty) {
      _sendMessage(message, messageAttachments);
      message = "";
      messageAttachments = [];
      setState(() {});
    }
  },
  onAttachmentsChanged: (value) {
    messageAttachments = value;
    setState(() {});
  },
)
```