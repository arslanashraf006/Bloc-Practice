import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetStates{initial, lost, gained}

class InternetCubit extends Cubit<InternetStates>{
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

InternetCubit() : super(InternetStates.initial){
connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
  if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
    emit(InternetStates.gained);
  }else{
    emit(InternetStates.lost);
  }
});
}
@override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}