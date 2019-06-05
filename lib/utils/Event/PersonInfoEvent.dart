import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
EventBus eventBus = new EventBus();
class PersonInfoEvent {
  var username;
  var url;
  String email;
  String signature;
  PersonInfoEvent(this.username,this.url,this.email,this.signature);
}