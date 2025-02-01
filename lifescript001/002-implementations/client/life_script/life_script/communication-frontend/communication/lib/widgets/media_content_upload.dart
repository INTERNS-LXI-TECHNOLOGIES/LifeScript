import 'package:communication/bloc/blocs/admin_mediaUpload_bloc/media_upload_bloc.dart';
import 'package:communication/bloc/events/admin_mediaUpload_events/upload_button_event.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_failure_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_loading_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_success_state.dart';
import 'package:communication_openapi/openapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MediaContentUploadPage extends StatefulWidget {
  @override
  _MediaContentUploadPageState createState() => _MediaContentUploadPageState();
}

class _MediaContentUploadPageState extends State<MediaContentUploadPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _text = TextEditingController();
  final TextEditingController _textAudio = TextEditingController();
  final TextEditingController _language = TextEditingController();
  final TextEditingController _difficultyLevel = TextEditingController(text: '1');
  final TextEditingController _uploadDateTime = TextEditingController(
    text: DateTime.now().toString(),
  );

  final List<String> _languages = ['English', 'Spanish', 'French', 'German'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Media Content')),
      body: BlocProvider(
        create: (context) => AdminMediaUploadBloc(Openapi()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField(),
                SizedBox(height: 16),
                _buildAudioPicker(),
                SizedBox(height: 16),
                _buildLanguageDropdown(),
                SizedBox(height: 16),
                _buildDifficultySlider(),
                SizedBox(height: 16),
                _buildSubmitButton(),
                _buildStateListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: _text,
      decoration: InputDecoration(labelText: 'Text'),
      maxLines: 3,
      validator: (value) => value == null || value.isEmpty ? 'Please enter some text' : null,
    );
  }

  Widget _buildAudioPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _textAudio.text.isEmpty ? 'No audio file selected' : 'File selected: ${_textAudio.text}',
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.upload_file),
          onPressed: () {
            setState(() {
              _textAudio.text = 'sample_audio.mp3';
            });
          },
        ),
      ],
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Language'),
      items: _languages.map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
      onChanged: (value) => setState(() => _language.text = value ?? ''),
      validator: (value) => value == null ? 'Please select a language' : null,
    );
  }

  Widget _buildDifficultySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Difficulty Level: ${_difficultyLevel.text}'),
        Slider(
          value: double.parse(_difficultyLevel.text),
          min: 1,
          max: 10,
          divisions: 9,
          label: _difficultyLevel.text,
          onChanged: (value) => setState(() => _difficultyLevel.text = value.toString()),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<AdminMediaUploadBloc, UploadState>(
      builder: (context, state) {
        if (state is UploadLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        return ElevatedButton(
          onPressed: () {
            
              context.read<AdminMediaUploadBloc>().add(
                UploadButtonEvent(
                  text: _text.text,
                  textAudio: _textAudio.text,
                  language: _language.text,
                  difficultyLevel: int.parse(_difficultyLevel.text),
                  uploadDateTime: DateTime.parse(_uploadDateTime.text),
                ),
              );
            
          },
          child: Text('Submit'),
        );
      },
    );
  }

  Widget _buildStateListener() {
    return BlocListener<AdminMediaUploadBloc, UploadState>(
      listener: (context, state) {
        if (state is UploadSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload Successful!')),
          );
        } else if (state is UploadFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload Failed: ${state.error}')),
          );
        }
      },
      child: Container(),
    );
  }
}
