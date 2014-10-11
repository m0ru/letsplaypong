import 'dart:html';
import 'dart:web_audio';

class SoundEffect {
  AudioContext ctxt = new AudioContext();
  String path = "sounds/Blop-Mark_DiAngelo.mp3";
  AudioBufferSourceNode src;
  
  SoundEffect() {
    src = ctxt.createBufferSource();
    
    //AudioBuffer buf = ;
    _loadBuffer(path);
  }
  
  void _loadBuffer(String url) {
    // Load the buffer asynchronously.
    var request = new HttpRequest();
    request.open("GET", url, async: true);
    request.responseType = "arraybuffer";
    request.onLoad.listen((e) => _onLoad(request, url));
    // Don't use alert in real life ;)
    request.onError.listen((e) => window.alert("BufferLoader: XHR error"));
    request.send();
  }
  
  void _onLoad(HttpRequest request, String url) {
    // Asynchronously decode the audio file data in request.response.
    //TODO decoding causes uncaught exception
    ctxt.decodeAudioData(request.response).then((AudioBuffer buffer) {
      if (buffer == null) {
        // Don't use alert in real life ;)
        window.alert("Error decoding file data: $url");
        return;
      }

      /*
      src.buffer = buffer;
      src.connectNode(ctxt.destination);
      src.start(0);
      src.loop = true; //TODO deleteme!!*/
    });
  }
}