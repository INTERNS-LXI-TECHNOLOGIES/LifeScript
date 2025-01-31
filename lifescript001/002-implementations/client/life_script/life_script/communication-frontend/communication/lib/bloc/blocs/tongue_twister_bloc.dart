import 'package:communication/widgets/tongue_twister.dart';
import 'package:communication_openapi/openapi.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';


// BLOC
class TongueTwisterBloc extends Bloc<TongueTwisterEvent, TongueTwisterState> {
  final Openapi _openapi;
  final FlutterTts _flutterTts;

  TongueTwisterBloc({required Openapi openapi, required FlutterTts flutterTts})
      : _openapi = openapi,
        _flutterTts = flutterTts,
        super(TongueTwisterInitial()) {
    
    on<FetchText>(_onFetchText);
    on<SpeakTextEvent>(_onSpeakText);
  }

  // FETCH TEXT
  Future<void> _onFetchText(FetchText event, Emitter<TongueTwisterState> emit) async {
    emit(TongueTwisterLoading());
    try {
      final response = await _openapi.getMediaContentResourceApi().getAllMediaContentsAsStream(
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );

      if (response.statusCode == 200) {
        final text = response.data?.isNotEmpty == true 
            ? response.data!.first.text ?? "No text available" 
            : "No text available";

        emit(TongueTwisterLoaded(text));
        
        // Dispatch SpeakTextEvent instead of calling _speakText directly
        add(SpeakTextEvent(text));
      } else {
        throw Exception("Failed to fetch text: ${response.statusCode}");
      }
    } catch (e) {
      emit(TongueTwisterError("Error loading text: $e"));
    }
  }

  // SPEAK TEXT HANDLER
  Future<void> _onSpeakText(SpeakTextEvent event, Emitter<TongueTwisterState> emit) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(event.text);
  }
}




// text_event.dart
abstract class TongueTwisterEvent extends Equatable {
  const TongueTwisterEvent();
  @override
  List<Object> get props => [];
}

class FetchText extends TongueTwisterEvent {}


//speak_event.dart

class SpeakTextEvent extends TongueTwisterEvent {
  final String text;
  SpeakTextEvent(this.text);

  @override
  List<Object> get props => [text];
}



// text_state.dart
abstract class TongueTwisterState extends Equatable {
  const TongueTwisterState();
  @override
  List<Object> get props => [];
}

class TongueTwisterInitial extends TongueTwisterState {}

class TongueTwisterLoading extends TongueTwisterState {}

class TongueTwisterLoaded extends TongueTwisterState {
  final String text;
  const TongueTwisterLoaded(this.text);
  @override
  List<Object> get props => [text];
}

class TongueTwisterError extends TongueTwisterState {
  final String message;
  const TongueTwisterError(this.message);
  @override
  List<Object> get props => [message];
}