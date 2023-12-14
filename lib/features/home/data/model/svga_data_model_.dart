import 'dart:developer';

class SvgaDataModel {
  List<PKImages> pkIamges;

  List<VIPImage> vipImage;
  DiceModel? diceModel;
  RpsModel? rpsModel;
  SvgaDataModel({
    required this.pkIamges,
    required this.vipImage,
    required this.diceModel,
    required this.rpsModel,
  });

  factory SvgaDataModel.fromJason(Map<String, dynamic> json) {
    log('${json}cccc');
    return SvgaDataModel(
        pkIamges: json['pk_images']!=null? List<PKImages>.from(
            json['pk_images'].map((e) => PKImages.fromJason(e))):[],
        vipImage:json['vip_images']!=null? List<VIPImage>.from(
            json['vip_images'].map((e) => VIPImage.fromJason(e))):[],
      diceModel:json['dice']==null?null: DiceModel.fromJson(json['dice']),
      rpsModel:json['rps']==null?null: RpsModel.fromJson(json['rps']),
    );
  }
}

class PKImages {
  int? id;

  String? name;
  String? url;

  PKImages({this.id, this.name, this.url});

  factory PKImages.fromJason(Map<String, dynamic> json) {
    return PKImages(id: json['id'], name: json['name'], url: json['url']);
  }
}

class VIPImage {
  int? id;

  String? name;
  int? level;
  String? img;
  String? frame;

  int? frameId;

  String? entro;

  int? entroId;

  VIPImage(
      {this.id,
      this.name,
      this.level,
      this.img,
      this.frameId,
      this.entroId,
      this.entro,
      this.frame});

  factory VIPImage.fromJason(Map<String, dynamic> json) {
    return VIPImage(
        name: json['name'],
        id: json['id'],
        img: json['img'],
        level: json['level'],
        frame: json['frame'] == null ? null : json['frame']['img2'],
        entro: json['intro'] == null ? null : json['intro']['img2'],
        frameId: json['frame'] == null ? null : json['frame']['id'],
        entroId: json['intro'] == null ? null : json['intro']['id']);
  }
}

class DiceModel {
  final int id;
  final String image;

  DiceModel({required this.id, required this.image});

  factory DiceModel.fromJson(Map<String, dynamic> json) {
    return DiceModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}

class RpsModel {
  final int id;
  final String image;

  RpsModel({required this.id, required this.image});

  factory RpsModel.fromJson(Map<String, dynamic> json) {
    return RpsModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}


