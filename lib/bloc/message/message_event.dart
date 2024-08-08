import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}
class FetchMessages extends MessageEvent {}


// import 'package:equatable/equatable.dart';
//
// abstract class MessageEvent extends Equatable {
//   const MessageEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class FetchMessages extends MessageEvent {}
