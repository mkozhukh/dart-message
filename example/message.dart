import 'package:message/message.dart' as message;
import 'dart:html';

void main(){
  //add handlers for on-page buttons
  var buttons = queryAll("input");
  buttons[0].onClick.listen(showAlert);
  buttons[1].onClick.listen(showConfirm);
  buttons[2].onClick.listen(showModalBox);
  
  
  //show demo messages
  message.info("This is test Info message");
  message.error("This is test Error message");
  message.warning("This is test Warning message");
  
  message.info("Will expire in 8 seconds", expire: 8);
  
  
}

void showAlert(Event e){
  message.alert("Test Alert", header:"Optional");
}

void showConfirm(Event e){
  message.confirm("Select wisely...").then((result) => message.alert(result));
}

void showModalBox(Event e){
  message.modalbox("Custom box", width:"500px", buttons:{ 
    "ok" : "Do It",
    "unsure" : "Not sure",
    "cancel" : "Ignore"
  }).then((result) => message.alert(result));
}