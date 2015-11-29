
class Button {

  int x, y;
  int buttonWidth;
  int buttonHeight;
  int timer;
  String text;
  color c;
  boolean pressed = false;
  Listener listener = null;

  public Button() {
    this(width/2, height/2);
  }

  public Button(int x, int y) {
    this(x, y, "", color(255));
  }

  public Button(int x, int y, String text, color c) {
    this(x, y, text, 100, 50, c);
  }

  public Button(int x, int y, String text, int buttonWidth, int buttonHeight, color c) {
    this.x = x;
    this.y = y;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
    this.text = text;
    this.c = c;
  }

  void addListener(Listener listener) {
    this.listener = listener;
  }

  boolean isClicked() {
    int absX = x + botUI.x;
    int absY = y + botUI.y;
    return (absX < mouseX && mouseX < absX + buttonWidth)
      && (absY < mouseY && mouseY < absY + buttonHeight);
  }

  void onClick() {
    if (!pressed) {
      pressed = true;
      clickEvent();
    }
  }

  void clickEvent() {
    listener.trigger();
  }

  void unpress() {
    pressed = false;
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    fill(0);
    textAlign(CENTER, BOTTOM);
    textSize(14);
    text(text, buttonWidth / 2, -3);
    if (pressed) {
      fill(c, 140);
    } else {
      fill(c);
    }
    rect(0, 0, buttonWidth, buttonHeight);
    popMatrix();
  }
}

public interface Listener {
  public void trigger();
}

