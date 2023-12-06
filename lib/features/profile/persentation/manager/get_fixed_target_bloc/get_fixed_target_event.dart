

abstract class BaseGetFixedTargetEvent {
  const BaseGetFixedTargetEvent();


}


class GetFixedTargetEvent extends BaseGetFixedTargetEvent {
final String date;
  const GetFixedTargetEvent({required this.date});
}

