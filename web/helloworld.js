console.log("Loading hello world js");

window.helloStr = "Hello world!"

window.sayHello = function(){
	console.log('console.log(helloStr) in helloworld.js -> ');
	console.log(helloStr);
}

window.myPrint = function(str) {
	console.log(str);
}