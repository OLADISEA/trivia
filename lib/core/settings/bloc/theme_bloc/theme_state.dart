  import 'package:equatable/equatable.dart';
import 'package:trivia/core/settings/bloc/theme_bloc/theme_mode.dart';



  class ThemeState extends Equatable {
    final AppThemeMode status;

    @override
    List<Object?> get props => [status];

    ThemeState({this.status = AppThemeMode.light});

      ThemeState copyWith({AppThemeMode? status}) {
        return ThemeState(
          status: status ?? this.status,
        );
      }
    }




