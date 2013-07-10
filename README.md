DartMessage
===========

Port of JsMessage ( http://dhtmlx.github.io/message/ ) library 

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
  
~~~
	message.alert("Test alert").then((result) => message.alert(result));
~~~

Alert does not block code execution, if you need to catch the alert closing, you can use code like next

~~~
	message.alert("Test alert").then(
		(result) => some_code()
	);
~~~


### License

Available under MIT license terms (basically you can do nearly anything with it)