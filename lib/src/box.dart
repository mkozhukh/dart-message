part of message; 

/* Public methods */

Future<String> modalbox(String text, { 
            String header,
            String width,
            String height,
            Map<String, String> buttons }){
  
  MessageBox box = new MessageBox(text, header, "box");
  box.setSize(width, height);
  
  if (buttons != null)
    buttons.forEach((key, value) => box.addButton(value, key));
  
  return box.show();
}

Future<String> confirm(String text, { 
            String header,
            String width,
            String height,
            String okButton : "OK",
            String cancelButton : "Cancel" }){
  
  MessageBox box = new MessageBox(text, header, "confirm");
  box.setSize(width, height);
  box.addButton(okButton, "ok");
  box.addButton(cancelButton, "cancel");
  return box.show();
}

Future<String> alert(String text, { 
            String header,
            String width,
            String height,
            String okButton : "OK" }){
  
  MessageBox box = new MessageBox(text, header, "alert");
  box.setSize(width, height);
  box.addButton(okButton, "ok");
  return box.show();
}

class MessageBox{ 
  DivElement _box;
  var _key_handler;
  StringBuffer html = new StringBuffer();
  Completer<String> _ready;
  NodeValidatorBuilder _validator = new NodeValidatorBuilder.common();
   
  static DivElement _modality;
  static void modality(bool mode){
    if (MessageBox._modality == null){
      MessageBox._modality = new DivElement();
      MessageBox._modality.classes.add("dhx_modal_cover");
      document.body.children.add(_modality);
    }
    
    MessageBox._modality.style.display = mode ? "inline-block" : "none";
  }
  
  _modalKey(Event event){
    var code = event.which;
    if (code == 13 || code == 32)
      hide("ok");
    if (code == 27)
      hide("cancel");
    event.preventDefault();
    event.cancelBubble = true;
    return false;
  }
  
  MessageBox(String text, String header, String css){
    _box = new DivElement();
    
    _box.classes.add("dhtmlx_modal_box");
    _box.classes.add("dhtmlx-"+css);
    _box.attributes["dhxbox"] = "1";
    
    _box.onClick.listen(_clickHandler);
    
    if (header != null)
      html.write("<div class='dhtmlx_popup_title'>$header</div>");
    html.write("<div class='dhtmlx_popup_text'><span>$text</span></div>");
    html.write("<div class='dhtmlx_popup_controls'>");
    
    //Custom html validator
    _validator.allowElement("div", attributes: ["result"]);
  }
  
  String addButton(String text, String result){
    if (html != null){
      html.write("<div class='dhtmlx_popup_button' result='$result' ><div>$text</div></div>");
    } else
      throw new Exception(".addButton must be used before .show"); 
  }
  
  _clickHandler(Event event){
    String result = event.target.attributes["result"];
    if (result == null)
      result = event.target.parent.attributes["result"];
    if (result != null)
      hide(result);
  }
  
  Future<String> show(){
    if (html != null){
      //finalize html initialization
      html.write("</div>");
      _box.setInnerHtml(html.toString(), validator: _validator );
      html = null;
    }
       
    //just ignore second show call, if any
    if (_ready != null)
      return null;
    
    document.body.children.add(_box);
    _position_box();
    modality(true);
    _ready =new Completer<String>();
    _key_handler = document.onKeyDown.listen(_modalKey);
    return _ready.future;
  }
  
  _position_box(){
    var x = ((window.innerWidth - _box.offsetWidth)/2).round();
    var y = ((window.innerHeight - _box.offsetHeight)/2).round();
    _box.style.top = y.toString()+"px";
    _box.style.left = x.toString()+"px";
  }
  
  void hide(String status){
    _box.remove();
    modality(false);
    _key_handler.cancel();
    
    _ready.complete(status);
    _ready = null;
  }
  
  void setSize(String width, String height){
    if (width != null)
      _box.style.width = width;
    if (height != null)
      _box.style.height= height;
  }

}