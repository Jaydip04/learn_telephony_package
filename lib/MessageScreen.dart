import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/message/message_bloc.dart';
import 'bloc/message/message_state.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // final Telephony telephony = Telephony.instance;
  // @override
  // void initState() {
  //   super.initState();
  //   requestPermissions();
  // }
  // void requestPermissions() async {
  //   bool? permissionsGranted = await telephony.requestSmsPermissions;
  //   if (permissionsGranted != null && permissionsGranted) {
  //     BlocProvider.of<MessageBloc>(context).add(FetchMessages());
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MessageLoaded) {
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                Text(
                  'Credited Messages:',
                  style: commonTextStyle(FontWeight.bold,20.00),
                ),
                ...state.creditedMessages.map(
                  (msg) => Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(msg,style: commonTextStyle(FontWeight.w400,16.00),),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(state.creditedTitle.toString(),
                        //         style: commonTextStyle(FontWeight.bold, 18.00)),
                        //     Text(state.creditedMessages.toString()),
                        //   ],
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Debited Messages:',
                  style: commonTextStyle(FontWeight.bold,20.00),
                ),
                ...state.debitedMessages.map(
                  (msg) => Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(msg,style: commonTextStyle(FontWeight.w400,16.00),),)
                )
              ],
            );
          } else if (state is MessageError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Center(child: Text('Press the button to fetch messages.'));
        },
      ),
      // body: BlocBuilder<MessageBloc, MessageState>(
      //   builder: (context, state) {
      //     if (state.isLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     return ListView.builder(
      //       itemCount: state.messages.length,
      //       itemBuilder: (context, index) {
      //         final message = state.messages[index];
      //         return
      //         Container(
      //           decoration: BoxDecoration(
      //             color: Colors.deepPurpleAccent.withOpacity(0.2),
      //             borderRadius: BorderRadius.circular(20)
      //           ),
      //           margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      //           padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(message.address ?? 'Unknown',style: commonTextStyle(FontWeight.bold,18.00)),
      //               const SizedBox(height: 10,),
      //               // if(message.body?.contains('withdrawn').toString() == true)
      //               Text(message.body?.contains('withdrawn').toString() ?? 'No content',style: commonTextStyle(FontWeight.w400,16.00),),
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }

  TextStyle commonTextStyle(fontWeight, size) {
    return TextStyle(fontWeight: fontWeight, fontSize: size);
  }
}
