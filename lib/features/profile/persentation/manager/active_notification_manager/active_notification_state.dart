abstract class ActiveNotificationStates {}

class ActiveNotificationStatesInitial extends ActiveNotificationStates{}
class ActiveNotificationStatesLoading extends ActiveNotificationStates{}
class ActiveNotificationStatesError extends ActiveNotificationStates{
  ActiveNotificationStatesError();
}
class ActiveNotificationStatesSuccess extends ActiveNotificationStates{
  ActiveNotificationStatesSuccess();
}