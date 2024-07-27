import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia/core/settings/bloc/theme_bloc/theme_event.dart';
import 'package:trivia/core/settings/bloc/theme_bloc/theme_mode.dart';
import 'package:trivia/core/settings/bloc/theme_bloc/theme_state.dart';



class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<ToggleThemeEvent>((event, emit) {
      final newStatus = state.status == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
      emit(state.copyWith(status: newStatus));
    });
  }
}
