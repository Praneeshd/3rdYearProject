// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:foodrush/features/auth/domain/use_case/auth_usecase.dart';
// import 'package:foodrush/features/auth/domain/use_case/login_usecase.dart';
// import 'package:foodrush/features/auth/presentation/view_model/auth_viewmodel.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'auth_unit_test.mocks.dart';

// @GenerateNiceMocks([
//   MockSpec<LoginUseCase>(),
//   MockSpec<UserUseCase>(),
//   MockSpec<BuildContext>(),
// ])
// void main() {
//   late LoginUseCase mockLoginUsecase;
//   late UserUseCase mockUserUsecase;
//   late ProviderContainer container;
//   late BuildContext context;

//   setUpAll(() {
//     mockLoginUsecase = MockLoginUseCase();
//     mockUserUsecase = MockUserUseCase();
//     context = MockBuildContext();
//     container = ProviderContainer(
//       overrides: [
//         authViewModelProvider.overrideWith(
//           (ref) => AuthViewModel(mockUserUsecase, mockLoginUsecase),
//         ),
//       ],
//     );
//   });
//   test('check for the initial state', () async {
//     final authState = container.read(authViewModelProvider);
//     expect(authState.isLoading, false);
//     expect(authState.error, null);
//     expect(authState.showMessage, false);
//   });

  
//   ;
//   tearDownAll(() {
//     container.dispose();
//   });
// }
