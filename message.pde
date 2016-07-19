class Message{
  String message;
  int alpha;
  
  void render(){
    if(alpha <= 0)
      return;
    
    fill(255, alpha);
    text(message, 10, 30);
    fill(0, alpha);
    text(message, 11, 31);
    alpha -= 2;
  }
  
  void update(String newm){
    message = newm.toLowerCase();
    alpha = 255;
  }
}