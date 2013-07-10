part of message;

/* Public methods */
MessageElement info(String text, { int expire : 4 }){
  return showMessage(text, expire, "info");
}
MessageElement error(String text, { int expire : -1 }){
  return showMessage(text, expire, "error");
}
MessageElement warning(String text, { int expire : 4 }){
  return showMessage(text, expire, "warning");
}


//to separate messages from other html elements
class MessageElement{
  DivElement dom;
  MessageElement(this.dom);
}


Duration _hide_length = const Duration(seconds:2);
DivElement _top_view;

DivElement _get_top_view(){
  if (_top_view == null){
    _top_view = new DivElement();
    _top_view.classes.add("dhtmlx_message_area");
    _top_view.style.top = "5px";
    
    document.body.children.add(_top_view);
  }
  return _top_view;
}

MessageElement _to_html(String text, String css){
  var mesView = new DivElement();
  mesView.classes.add("dhtmlx-info dhtmlx-"+css);
  mesView.innerHtml = text;

  return new MessageElement(mesView);
}

void hideMessage(MessageElement message){
  message.dom.classes.add("hidden");
  new Timer(_hide_length, () => message.dom.remove()); 
}

void hideAllMessages(){
  _top_view.innerHtml = "";
}


MessageElement showMessage(String text, int expire, String css ){
  MessageElement message = _to_html(text, css);
  
  message.dom.onClick.listen( (event) => hideMessage(message) );
  if (expire != -1)
    new Timer( new Duration(seconds:expire), () => hideMessage(message));
  
  _get_top_view().children.add(message.dom);
  return message;
}


 