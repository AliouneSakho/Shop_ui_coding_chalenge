import 'dart:async' show StreamTransformer, EventSink;
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;

StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, T> transformer<T>(
  T Function(Map<String, dynamic> json) fromJson,
) {
  return StreamTransformer<DocumentSnapshot<Map<String, dynamic>>,
      T>.fromHandlers(
    handleData:
        (DocumentSnapshot<Map<String, dynamic>> snapshot, EventSink<T> sink) {
      final data = snapshot.data();
      final object = fromJson(data!);

      sink.add(object);
    },
  );
}
