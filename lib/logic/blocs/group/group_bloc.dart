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
    on<GroupGetEvent>(_groupsGet);
    on<GroupAddedStudnetsEvent>(_addStundets);
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
      emit(
        GroupError(
          e.toString(),
        ),
      );
    }
  }

  _groupsGet(GroupGetEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');
      if (token == null) {
        return;
      }
      final responce = await groupService.getGroups(token);
      emit(
        GroupsLoaded(groups: responce),
      );
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  _addStundets(GroupAddedStudnetsEvent event, emit) async {
    try {
      Map<String, dynamic> groups = (state as GroupsLoaded).groups;

      // ignore: collection_methods_unrelated_type
      if (groups.containsKey(event.groupId)) {
        // ignore: collection_methods_unrelated_type
        List<dynamic> updatedStudents = groups[event.groupId]['students'];
        updatedStudents.addAll(event.students);
        // ignore: collection_methods_unrelated_type
        groups[event.groupId]['students'] = updatedStudents;
        emit(GroupsLoaded(groups: groups));
      }

      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');
      if (token == null) {
        return;
      }

      await groupService.addStudents(event.students, event.groupId, token);
      emit(GroupsLoaded(groups: groups));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }
}
