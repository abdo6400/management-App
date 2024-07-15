part of 'tanks_bloc.dart';

abstract class TanksEvent extends Equatable {
  const TanksEvent();

  @override
  List<Object> get props => [];
}
class GetTanksEvent extends TanksEvent {
  final Map<String, dynamic> options;

  const GetTanksEvent({required this.options});

}