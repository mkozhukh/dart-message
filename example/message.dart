import 'package:message/message.dart' as message;

void main(){
  message.info("This is test Info message");
  message.error("This is test Error message");
  message.warning("This is test Warning message");
  
  message.info("Will expire in 8 seconds", expire: 8);
  
  message.alert("Test alert").then((result) => message.alert(result));
}