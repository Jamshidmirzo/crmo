import 'package:bloc/bloc.dart';
import 'package:crmo/logic/services/group_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupService groupService = GroupService();
  GroupBloc() : super(GroupInitial()) {
    on<GroupEvent>((event, emit) {});
    on<GroupAddEvent>(_addGroup);
  }

  _addGroup(GroupAddEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');
      if (token == null) {
        return;
      }
      groupService.addGroup(
          token, event.name, event.teacherId, event.assitant_teacher_id);
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }
}
