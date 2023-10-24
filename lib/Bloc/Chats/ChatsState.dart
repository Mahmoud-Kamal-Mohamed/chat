abstract class SocialState {}

final class SocialInitial extends SocialState {}

// NavigationBar
class SocialChangeNavigationBar extends SocialState {}

////////////////////////////////////////////////////////////
// GetUserData
class SocialGetUserDataLoading extends SocialState {}

class SocialGetUserDataSuccess extends SocialState {}

class SocialGetUserDataError extends SocialState {
  late final String error;
  SocialGetUserDataError(this.error);
}

// Get All Users
class SocialGetAllUsersLoading extends SocialState {}

class SocialGetAllUsersSuccess extends SocialState {}

class SocialGetAllUsersError extends SocialState {
  late final String error;
  SocialGetAllUsersError(this.error);
}

// UpdateUserData
class SocialUpdateUserDataLoading extends SocialState {}

class SocialUpdateUserDataError extends SocialState {
  late final String error;
  SocialUpdateUserDataError(this.error);
}

////////////////////////////////////////////////////////////////
// NewPost

class SocialNewPostState extends SocialState {}

// Create Post
class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

// Get Image Post
class SocialGetImagePostLoadingState extends SocialState {}

class SocialGetImagePostSuccessState extends SocialState {}

class SocialGetImagePostErrorState extends SocialState {}

// Upload Post Image
class SocialUploadPostImageLoadingState extends SocialState {}

class SocialUploadPostImageSuccessState extends SocialState {}

class SocialUploadPostImageErrorState extends SocialState {}

// Get All Posts
class SocialGetPostLoadingState extends SocialState {}

class SocialGetPostSuccessState extends SocialState {}

class SocialGetPostErrorState extends SocialState {}

// Remove Post
class SocialRemoveImagePostState extends SocialState {}

class SocialRemovePostState extends SocialState {}

/////////////////////////////////////////////////////////////////////
//ProfileImagePicker
class SocialProfileImagePickerLoadingState extends SocialState {}

class SocialProfileImagePickerSuccessState extends SocialState {}

class SocialProfileImagePickerErrorState extends SocialState {}

//UpdateProfileImage
class SocialUpdateProfileImageLoadingState extends SocialState {}

class SocialUpdateProfileImageSuccessState extends SocialState {}

class SocialUpdateProfileImageErrorState extends SocialState {}

/////////////////////////////////////////////////////////////////////
//CoverImagePicker
class SocialCoverImagePickerLoadingState extends SocialState {}

class SocialCoverImagePickerSuccessState extends SocialState {}

class SocialCoverImagePickerErrorState extends SocialState {}

//UpdateCoverImage
class SocialUpdateCoverImageLoadingState extends SocialState {}

class SocialUpdateCoverImageSuccessState extends SocialState {}

class SocialUpdateCoverImageErrorState extends SocialState {}

//Messages
class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}

class SocialGetMessageSuccessState extends SocialState {}
