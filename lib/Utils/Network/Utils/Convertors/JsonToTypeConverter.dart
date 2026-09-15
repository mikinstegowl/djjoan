import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:chopper/chopper.dart';
import 'package:new_music_app/Utils/Models/GeneralErrorModel.dart';


typedef JsonConvertorFunction = dynamic Function(Map<String, dynamic>);

class JsonToTypeConverter extends JsonConverter implements ErrorConverter {
  final Map<Type, JsonConvertorFunction> jsonConvertorMap;
  const JsonToTypeConverter({required this.jsonConvertorMap});

  // converts data from api to model based on type
  dynamic decode<BodyType, InnerType>(entity) {
    if (entity is List) return _decodeList<BodyType, InnerType>(entity);
    if (BodyType is List) return _decodeList<BodyType, InnerType>(entity);
    if (entity is Map<String, dynamic>) {
      return _decodeMap<BodyType, InnerType>(entity);
    }
  }

  // decodes map to Model
  BodyType _decodeMap<BodyType, InnerType>(Map<String, dynamic> entity) {
    if (!jsonConvertorMap.containsKey(BodyType)) {
      throw FromJsonMethodNotFound(type: BodyType.toString());
    }
    return jsonConvertorMap[BodyType]!(entity) as BodyType;
  }

  // decodees lsit of Map to List of model
  List<InnerType> _decodeList<BodyType, InnerType>(List entity) {
    // when we want a List<Model> then our BodyType will be List, therefore we are passing InnerType in place of BodyType
    return List.generate(entity.length,
        (index) => _decodeMap<InnerType, InnerType>(entity[index]));
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    // BodyType: Type of model we want are respinse to be converted.

    // InnerType is type of model we want to convert our response from api when we are getting List of Map<String,dynamic>,
    // so in this case our BodyType will be List

    return response.copyWith(
        body: decode<BodyType, InnerType>(json.decode(response.body)));
  }

  @override
  FutureOr<Response> convertError<BodyType, InnerType>(Response response) {
    // if (response.body is String) {
    //   return response.copyWith(
    //       body: decode<GeneralErrorModel, GeneralErrorModel>(
    //           {"error": response.body}));
    // }
    log(response.bodyString, name: "error conv");
    return response.copyWith(
        bodyError: decode<GeneralErrorModel, GeneralErrorModel>(
            json.decode(response.body)));
  }
}
// Exception class for Data class that does not have fromJson method implementation
class FromJsonMethodNotFound implements Exception {
  final String type;
  final String message = "fromJson() method not implemented";

  @override
  String toString() => "$type: $message";
  FromJsonMethodNotFound({required this.type});
}
