import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

EventBus eventBus = new EventBus();
class LoginEvent {
  var username;
  LoginEvent(this.username);
}