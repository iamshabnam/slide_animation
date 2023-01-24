import 'package:dio/dio.dart';
import 'package:slide_animation/app/data/manager/remote_db.dart';
import 'package:slide_animation/app/data/manager/remote_response.dart';
import 'package:slide_animation/app/domain/slides_model.dart';

class SlidesProvider {
  SlidesProvider._();

  static final instance = SlidesProvider._();

  Future<RemoteResponse<SlidesModel>> fetchSlidesFromApi() async {
    final Response response = await RemoteDB.instance.get('https://smashingpixels.io/api/slides');
    return RemoteResponse(
      body: (response.data == null) ? null : SlidesModel.fromJson(response.data!),
      status: RemoteStatus(
        statusCode: response.statusCode ?? -101,
        statusMessage: response.statusMessage ?? 'Unexpected Error',
      ),
    );
  }
}
