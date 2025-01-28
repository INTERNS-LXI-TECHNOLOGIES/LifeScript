import 'package:communication/bloc/events/admin_mediaUpload_events/upload_event.dart';

class UploadButtonEvent extends UploadEvent {
  final String? text;
  final DateTime? uploadDateTime;
  final String? language;
  final int? difficultyLevel;
    final String? textAudio;
  final String? textAudioContentType;


UploadButtonEvent({this.text, this.uploadDateTime, this.language, this.difficultyLevel, 
this.textAudio, this.textAudioContentType});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
