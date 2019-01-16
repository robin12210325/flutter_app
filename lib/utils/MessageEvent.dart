import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();
class MessageEvent{
  String messageKey;
  Object messageValue;
  MessageEvent(this.messageKey,this.messageValue);
}