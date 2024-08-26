import 'package:crmo/logic/blocs/room/room_bloc.dart';
import 'package:crmo/ui/screens/rooms_screen/add_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(RoomLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddRoomScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Rooms"),
      ),
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is RoomLoaded) {
            return ListView.builder(
              itemCount: state.groups['data'].length,
              itemBuilder: (context, index) {
                final room = state.groups['data'][index];
                return ListTile(
                  title: Text(room['name']),
                  subtitle: Text('${room['capacity']} persons'),
                  trailing: IconButton(
                    onPressed: () {
                      context
                          .read<RoomBloc>()
                          .add(RoomDeleteEvent(id: room['id']));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text("SMTH WENT WRONG"),
          );
        },
      ),
    );
  }
}
