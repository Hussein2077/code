
class GetVipPrevModel {
  final String? key;

  final String? title;

  final String? description;

  final bool? isActive;

  final bool? isAllowToUser;
  final int? mine;
  final int? minPrice;

  GetVipPrevModel(
       {
    this.key,
    this.minPrice,
    this.title,
    this.description,
    this.isActive,
    this.isAllowToUser,
    this.mine,
  });

  factory GetVipPrevModel.fromjosn(Map<String, dynamic> map) {
    return GetVipPrevModel(
      key: map['key'] != null ? map['key'] as String : "",
      title: map['title'] != null ? map['title'] as String : "",
      description: map['description'] ?? "",
      mine: map['min'] ?? 0,
      minPrice: map['min_price'] ?? 0,
      isActive: map['is_active'] != null ? map['is_active'] as bool : false,
      isAllowToUser: map['is_allow_to_user'] != null
          ? map['is_allow_to_user'] as bool
          : false,
    );
  }
}
