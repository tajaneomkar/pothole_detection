part of 'admin_detail_view_bloc.dart';

class AdminDetailViewEvent {}

class AdminPanelDetailsInitialEvent extends AdminDetailViewEvent {
  final String id;

  AdminPanelDetailsInitialEvent({
    required this.id,
  });
}

class AdminUpdateStatusEvent extends AdminDetailViewEvent {
  final String? id;
  AdminUpdateStatusEvent({this.id});
}

class VerifyPotholeImageEvent extends AdminDetailViewEvent {
  final String? imageUrl;
  VerifyPotholeImageEvent({this.imageUrl});
}
