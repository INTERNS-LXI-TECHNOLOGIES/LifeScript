import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for MediaContentResourceApi
void main() {
  final instance = Openapi().getMediaContentResourceApi();

  group(MediaContentResourceApi, () {
    //Future<MediaContent> createMediaContent(MediaContent mediaContent) async
    test('test createMediaContent', () async {
      // TODO
    });

    //Future deleteMediaContent(int id) async
    test('test deleteMediaContent', () async {
      // TODO
    });

    //Future<BuiltList<MediaContent>> getAllMediaContentsAsStream() async
    test('test getAllMediaContentsAsStream', () async {
      // TODO
    });

    //Future<MediaContent> getMediaContent(int id) async
    test('test getMediaContent', () async {
      // TODO
    });

    //Future<MediaContent> partialUpdateMediaContent(int id, MediaContent mediaContent) async
    test('test partialUpdateMediaContent', () async {
      // TODO
    });

    //Future<MediaContent> updateMediaContent(int id, MediaContent mediaContent) async
    test('test updateMediaContent', () async {
      // TODO
    });

  });
}
