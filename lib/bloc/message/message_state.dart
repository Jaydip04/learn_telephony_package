import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<String> creditedTitle;
  final List<String> creditedMessages;
  final List<String> debitedMessages;

  const MessageLoaded({required this.creditedTitle,required this.creditedMessages, required this.debitedMessages});

  @override
  List<Object> get props => [creditedTitle,creditedMessages, debitedMessages];
}

class MessageError extends MessageState {
  final String error;

  const MessageError({required this.error});

  @override
  List<Object> get props => [error];
}

// import 'package:equatable/equatable.dart';
// import 'package:telephony/telephony.dart';
//
// class MessageState extends Equatable {
//   final List<SmsMessage> messages;
//   final bool isLoading;
//
//   const MessageState({
//     required this.messages,
//     required this.isLoading,
//   });
//
//   factory MessageState.initial() {
//     return const MessageState(messages: [], isLoading: false);
//   }
//
//   MessageState copyWith({
//     List<SmsMessage>? messages,
//     bool? isLoading,
//   }) {
//     return MessageState(
//       messages: messages ?? this.messages,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
//
//   @override
//   List<Object> get props => [messages, isLoading];
// }
