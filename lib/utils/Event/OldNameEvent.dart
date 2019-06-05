import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

EventBus eventBus1 = new EventBus();

class OldNameEvent {
  String oldName;
  OldNameEvent(this.oldName);
}