import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../user_repository/model/user.dart';
import '../../user_repository/user_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        MyUser user = await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
