import 'package:bloc/bloc.dart';
import 'package:crmo/logic/services/subject_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectService subjectService = SubjectService();
  SubjectBloc() : super(SubjectInitial()) {
    on<SubjectEvent>((event, emit) {});
    on<SubjectAddEvent>(_addSubject);
    on<SubjectGetEvent>(_getSubject);
    on<SubjectDeleteEvent>(_deleteSubject);
  }

  _addSubject(SubjectAddEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');

      if (token == null) {
        emit(
          SubjectError(message: 'Token dont have'),
        );
        return;
      }
      await subjectService.addSubject(event.name, token);
    } catch (e) {
      emit(
        SubjectError(
          message: e.toString(),
        ),
      );
    }
  }

  _deleteSubject(SubjectDeleteEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');

      if (token == null) {
        emit(
          SubjectError(message: 'Token dont have'),
        );
        return;
      }
      await subjectService.deleteSubject(event.id, token);
    } catch (e) {
      emit(
        SubjectError(
          message: e.toString(),
        ),
      );
    }
  }

  _getSubject(SubjectGetEvent event, emit) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final token = shared.getString('token');

      if (token == null) {
        emit(
          SubjectError(message: 'Token dont have'),
        );
        return;
      }
      final responce = await subjectService.getSubjects(token);
      emit(SubjectLoaded(subjects: responce));
    } catch (e) {
      SubjectError(
        message: e.toString(),
      );
    }
  }
}
