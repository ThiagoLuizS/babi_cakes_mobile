import '../../models/budget/budget_body_send.dart';

abstract class ParameterizationEvent {}

class LoadParameterizationEvent extends ParameterizationEvent {
  LoadParameterizationEvent();
}