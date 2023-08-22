import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/upload_reel_use_case.dart';

abstract class BaseRemotlyDataSourceReels {

    Future<String> uploadReel(UploadReelParamiter uploadReelParamiter);
        Future<List<ReelModel>> getReels(String? page);


}

class RemotlyDataSourceReels extends BaseRemotlyDataSourceReels {
  @override
  Future<String> uploadReel(UploadReelParamiter uploadReelParamiter) async{
   Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().post(
        ConstentApi.uploadReel,
        data: {'video': uploadReelParamiter.reel , 
                'description' : uploadReelParamiter.description   },
        options: Options(
          headers: headers,
        ),
      );

      return response.data[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }
  
  @override
  Future<List<ReelModel>> getReels(String? page) async{
     Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get(
        ConstentApi.uploadReel,
   
        options: Options(
          headers: headers,
        ),
      );

      return response.data[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }



}