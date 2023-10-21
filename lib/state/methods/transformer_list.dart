import 'dart:async' show StreamTransformer, EventSink;
import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;

StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
    transformerList<T>(T Function(Map<String, dynamic> json) fromJson) =>
        StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
            List<T>>.fromHandlers(
          handleData: (QuerySnapshot<Map<String, dynamic>> data,
              EventSink<List<T>> sink) {
            final snaps = data.docs.map((doc) => doc.data()).toList();
            final object = snaps.map((json) => fromJson(json)).toList();

            sink.add(object);
          },
        );
