# NewArcade17
Class materials

Two Pots (Arduino .ino)
 - Two analog reads outputting to serial

Pong (Processing sketch)
  - Uses Two Pots in arduino to move two paddles in Pong
  
SimpleSerial (Unity C# script)
 - In File > Build Settings, click Player Settings. Set target platform to "PC, Mac, Linux". Go to Inspector on right side of screen and expand Other Settings. Change Api Compatibility Level from '.NET 2.0 Subset' to '.NET 2.0'. Now Unity will recognize System.IO.Ports.
  - Make necessary changes to match it for your use: port, baudrate, parsing of serial input
