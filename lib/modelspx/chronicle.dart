
import 'package:cloud_firestore/cloud_firestore.dart';

class Chronicle{

   String format;
   String id;
   String bot;
   String content;
   String header;
   int unseen;
   Timestamp timestamp;


   Chronicle({required this.unseen, required this.format,required this.id,required this.bot,required this.content,required this.header,required this.timestamp});


   Chronicle.fromJson(Map<String, Object?> json)
       : this(
      format: json['format']! as String,
      unseen: json['unseen']!=null?json['unseen']! as int:0,

      bot: json['bot']! as String,
      content: json['content']! as String,
      id: json['id']! as String,
      header: json['header']! as String,

      timestamp: json['timestamp']! as Timestamp,



   );

   Map<String, Object?> toJson() {
      return {
         'id': id!=null?id:"",
         'content': content!=null?content:"",
         'header': header!=null?header:"",
         'bot': bot!=null?bot:"",
         'format': format!=null?format:"",
         'unseen': unseen!=null?unseen:0,

         'timestamp': timestamp!=null?timestamp:Timestamp(0, 0),


      };
   }

}

