
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';

class ProfileState {
  final bool isLoading;
  
  final String? imageName;
  final List<ProfileEntity> profiles;
  final String? error;

  ProfileState({
    required this.isLoading,
    required this.profiles,
    this.imageName,
    this.error,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false, 
      imageName: null,
      profiles: [],
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    List<ProfileEntity>? profiles,
    
    String? imageName,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profiles: profiles ?? this.profiles,
       imageName: imageName ?? this.imageName,
      error: error ?? this.error,
    );
  }
}