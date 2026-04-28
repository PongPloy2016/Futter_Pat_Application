
import 'package:flutter_pat_application/features/shared/domain/repositories/rfid_repo_interface.dart';
import 'package:flutter_pat_application/features/auth/data/models/reqlogin.dart';
import 'package:flutter_pat_application/features/shared/providers/state/login_state.dart';
import 'package:flutter_pat_application/features/shared/data/repositories/rfid_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends Notifier<LoginState> {
  late final AuthRepoInterface _repo;

  @override
  LoginState build() {
    _repo = ref.read(authRepositoryProvider);
    return LoginState.initial();
  }

  Future<void> login(Reqlogin reqLogin) async {
    state = LoginState(
      resLoginModel: null,
      isLoading: true,
      isError: false,
      errorMessage: '',
    );

    try {
      final result = await _repo.getLoginUser(reqLogin);

      if (result.isSuccess == true) {
        state = LoginState(
          resLoginModel: result,
          isLoading: false,
          isError: false,
          errorMessage: '',
        );
      } else {
        state = LoginState(
          resLoginModel: result,
          isLoading: false,
          isError: true,
          errorMessage: result.message ?? "Login failed",
        );
      }
    } catch (e) {
      state = LoginState(
        resLoginModel: null,
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }
}

  final authRepositoryProvider = Provider<RFIDAuthRepository>((ref) {
  return RFIDAuthRepository(); // or inject dio here if needed
});
 

final loginControllerProvider =
    NotifierProvider<LoginController, LoginState>(() => LoginController());
