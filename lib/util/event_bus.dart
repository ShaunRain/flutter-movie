typedef void EventCallBack(arg);

class EventBus {
  EventBus._internal();

  static EventBus _singleton = new EventBus._internal();

  factory EventBus() => _singleton;

  Map _subMap = new Map<Object, List<EventCallBack>>();

  //添加订阅者
  void on(eventKey, EventCallBack callBack) {
    if (eventKey == null || callBack == null) return;
    _subMap[eventKey] ??= new List<EventCallBack>();
    _subMap[eventKey].add(callBack);
  }

  //通知订阅者
  void emit(eventKey, [arg]) {
    var subList = _subMap[eventKey];
    if (subList == null) return;
    List copySubList = new List(subList.length);
    List.copyRange(copySubList, 0, subList);
    copySubList.forEach((callBack) => callBack(arg));
    copySubList = null;
  }

  //移除订阅者
  void off(eventKey, [EventCallBack callBack]) {
    var subList = _subMap[eventKey];
    if (subList == null) return;
    if (callBack == null) {
      _subMap[eventKey] = null;
    } else {
      subList.remove(callBack);
    }
  }
}

var bus = new EventBus();
