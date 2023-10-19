
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/active_notification_manager/active_notification_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/active_notification_manager/active_notification_state.dart';
import '../../../domin/use_case/active_notification_usecase.dart';

class ActiveNotificationBloc extends Bloc<BaseActiveNotificationEvent, ActiveNotificationStates> {
  final ActiveNotificationUseCase activeNotificationUseCase ;
  ActiveNotificationBloc({required this.activeNotificationUseCase}) : super(ActiveNotificationStatesInitial()) {
    on<ActiveNotificationEvent>((event, emit) async{
      emit(ActiveNotificationStatesLoading());
      final result = await activeNotificationUseCase.activeNotification();
      result.fold((r) => emit(ActiveNotificationStatesSuccess()),
              (l) =>  emit(ActiveNotificationStatesError()),
      );
    }
    );
  }
}
