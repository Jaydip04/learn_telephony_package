// message_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final Telephony telephony = Telephony.instance;

  MessageBloc() : super(MessageInitial()) {
    on<FetchMessages>(_onFetchMessages);
  }

  Future<void> _onFetchMessages(FetchMessages event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      List<SmsMessage> messages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      );

      List<String> creditedTitle = [];
      List<String> creditedMessages = [];
      List<String> debitedMessages = [];

      for (var message in messages) {
        if (message.body != null) {
          if (message.body!.toLowerCase().contains('credited')) {
            creditedTitle.add(message.address!);
            creditedMessages.add(message.body!);
          } else if (message.body!.toLowerCase().contains('debited')) {
            debitedMessages.add(message.body!);
          }
        }
      }

      emit(MessageLoaded(creditedTitle: creditedTitle,creditedMessages: creditedMessages, debitedMessages: debitedMessages));
    } catch (e) {
      emit(MessageError(error: e.toString()));
    }
  }
}




// import 'package:bloc/bloc.dart';
// import 'package:telephony/telephony.dart';
// import 'message_event.dart';
// import 'message_state.dart';
//
// class MessageBloc extends Bloc<MessageEvent, MessageState> {
//   final Telephony telephony;
//
//   MessageBloc(this.telephony) : super(MessageState.initial()) {
//     on<FetchMessages>(_onFetchMessages);
//   }
//
//   void _onFetchMessages(FetchMessages event, Emitter<MessageState> emit) async {
//     emit(state.copyWith(isLoading: true));
//
//     try {
//       List<SmsMessage> messages = await telephony.getInboxSms(
//         columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
//
//         // filter: SmsFilter.where(SmsColumn.ADDRESS).equals("VM-ATMSBI"),
//       );
//       List<String> withdrawnMessages = [];
//
//       for (var message in messages) {
//         if (message.body != null && message.body!.toLowerCase().contains('withdrawn')) {
//           withdrawnMessages.add(message.body!);
//         }
//       }
//       emit(state.copyWith(messages: withdrawnMessages, isLoading: false));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false));
//     }
//   }
// }
