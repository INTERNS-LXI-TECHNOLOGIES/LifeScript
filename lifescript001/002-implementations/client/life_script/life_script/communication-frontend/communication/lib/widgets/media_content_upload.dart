import 'package:communication_openapi/openapi.dart';
import 'package:flutter/material.dart';

class MediaContentUploadPage extends StatefulWidget {
  @override
  _MediaContentUploadPageState createState() => _MediaContentUploadPageState();
}

class _MediaContentUploadPageState extends State<MediaContentUploadPage> {
  final Openapi _openapi = Openapi();
  final _formKey = GlobalKey<FormState>();
  String? _text;
  String? _audioFilePath;
  String? _language;
  int _difficultyLevel = 1;
  DateTime _uploadDateTime = DateTime.now();

  // List of available languages
  final List<String> _languages = ['English', 'Spanish', 'French', 'German'];

  // OpenAPI client instance

  @override
  void initState() {
    super.initState();
    // Initialize OpenAPI client instance
  }

  // Function to handle form submission and upload content
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // Save form values to the corresponding variables

      try {
        // Create the MediaContent object
        final mediaContent = MediaContentBuilder()
          ..text = _text
          ..textAudio = _audioFilePath
          ..language = _language
          ..difficultyLevel = _difficultyLevel
          ..uploadDateTime = _uploadDateTime.toUtc() as DateTime?;

        // Make the API call to create media content
        final response = await _openapi
            .getMediaContentResourceApi()
            .createMediaContent(
                mediaContent: mediaContent.build(),
                headers: {'Authorization': 'Bearer ${Openapi.jwt}'});
        debugPrint('response: $response');
        // Check the response status
        if (response.statusCode == 200||response.statusCode == 201) {
          // Handle successful response
          print('Media content uploaded successfully: ${response.data}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Media content uploaded successfully!')),
          );
        } else {
          // Handle error response
          print(
              'Failed to upload media content. Status: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload media content.')),
          );
        }
      } catch (e) {
        // Handle exceptions
        print('Error occurred while uploading media content: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Media Content'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Text Field for entering content
              TextFormField(
                decoration: InputDecoration(labelText: 'Text'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _text = value;
                },
              ),
              SizedBox(height: 16),
              // Audio File picker button (optional)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _audioFilePath == null
                        ? 'No audio file selected'
                        : 'File selected',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Language Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Language'),
                items: _languages
                    .map((lang) => DropdownMenuItem<String>(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _language = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a language';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Difficulty Level Slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Difficulty Level: $_difficultyLevel'),
                  Slider(
                    value: _difficultyLevel.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: '$_difficultyLevel',
                    onChanged: (value) {
                      setState(() {
                        _difficultyLevel = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
