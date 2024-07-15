part of 'tanks_bloc.dart';

abstract class TanksInformationEvent extends Equatable {
  const TanksInformationEvent();

  @override
  List<Object> get props => [];
}
class GetTanksInformationEvent extends TanksInformationEvent {
  final Map<String,dynamic> options;
  const GetTanksInformationEvent({required this.options});
}