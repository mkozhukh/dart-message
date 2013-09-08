DartMessage
===========

Port of JsMessage library ( http://dhtmlx.github.io/message/ )  

Nice looking notifications, alerts and confirmations


### How to use

#### Notifications

~~~dart
message.info("This is test Info message");
message.error("This is test Error message");
message.warning("This is test Warning message");
~~~

You can define message expiration time like next

~~~dart
message.info("Will expire in 8 seconds", expire: 8);
~~~

#### Alert
  
~~~dart
	message.alert("Test alert");
~~~

Alert does not block code execution, if you need to catch the alert closing, you can use code like next

~~~dart
	message.alert("Test alert").then(
		(result) => some_code()
	);
~~~

#### Confirm
  
~~~dart
	message.confirm("Are you sure");
~~~

Confirm does not block code execution, To get the confirm result you can use code like next

~~~dart
	message.confirm("Are you sure").then(
		(result) => some_code()
	);
~~~

where result will be an "ok" or "cancel" string


#### Modal Box

When you want to have a custom set of buttons - you can use modal box

~~~dart
  message.modalbox("Custom box", width:"500px", buttons:{ 
    "ok" : "Do It",
    "unsure" : "Not sure",
    "cancel" : "Ignore"
  }).then((result) => message.alert(result));
~~~


### License

Available under MIT license terms