import 'package:c_hat/database/chat_database.dart';
import 'package:c_hat/model/user/user.dart';
import 'package:c_hat/repository/user_repository.dart';
import 'package:c_hat/ui/shared/user_list_bloc/user_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListBloc extends Bloc<UserListEvent, List<User>> {
  UserRepository? _repository;


  UserListBloc() : super([]) {
    on<UserAddEvent>(((event, emit) async {
      await _repository!.addUser(event.user);
      add(AllUsersRequestedFromDatabaseEvent());
    }));

    on<UserDeleteEvent>(((event, emit) async {
      await _repository!.removeUser(event.user);
    }));

    on<UserEditEvent>(((event, emit) async {
      await _repository!.editUser(event.user);
    }));

    on<AllUsersRequestedFromDatabaseEvent>((event, emit) async {
      _repository ??= UserRepository(
        await getDatabase()
      );

      final users = await _repository!.getAllUsers();
      emit(users);
    });

  }
}