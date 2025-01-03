part of 'terms_of_service_bloc.dart';

sealed class TermsOfServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetPosts extends TermsOfServiceEvent {
  GetPosts();

  @override
  List<Object> get props => [];
}

final class SelectBoard extends TermsOfServiceEvent {
  final PostCategory category;
  SelectBoard({required this.category});

  @override
  List<Object> get props => [];
}
