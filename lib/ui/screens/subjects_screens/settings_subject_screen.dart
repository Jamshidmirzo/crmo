import 'package:crmo/logic/blocs/subject/subject_bloc.dart';
import 'package:crmo/ui/widgets/adding_subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SettingsSubjectScreen extends StatefulWidget {
  const SettingsSubjectScreen({super.key});

  @override
  State<SettingsSubjectScreen> createState() => _SettingsSubjectScreenState();
}

class _SettingsSubjectScreenState extends State<SettingsSubjectScreen> {
  final RefreshController _refreshController = RefreshController();

  void _onRefresh() async {
    context.read<SubjectBloc>().add(SubjectGetEvent());
    _refreshController.refreshCompleted();
  }

  addSubject(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddingSubject();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<SubjectBloc>().add(SubjectGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addSubject(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("SETTINGS SUBJECTS"),
      ),
      body: BlocBuilder<SubjectBloc, SubjectState>(
        builder: (context, state) {
          if (state is SubjectError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is SubjectLoaded) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: state.subjects['data'].length,
                itemBuilder: (context, index) {
                  final subject = state.subjects['data'][index];
                  return ListTile(
                    title: Text(
                      subject['name'],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<SubjectBloc>().add(
                              SubjectDeleteEvent(
                                id: subject['id'],
                              ),
                            );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
