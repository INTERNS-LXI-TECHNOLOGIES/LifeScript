import 'package:communication/bloc/states/admin_mediaUpload_states/upload_state.dart';

class UploadSuccessState extends UploadState{
final String? message;

  UploadSuccessState( {required this.message});

  @override
  List<Object> get props => [];
}