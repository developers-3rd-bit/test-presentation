package
{
   import com.halcyon.layout.common.HalcyonCanvas;
   import com.halcyon.layout.common.LayoutEvent;
   
   import common.TweenedButton;
   
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   [SWF(width="1280", height="700")]
   public class Main extends Sprite
   {
      private var _screenWidth:Number = 1280;
      private var _screenHeight:Number = 700;
      private var _canvas:HalcyonCanvas;
      private var _bg:McBg;
      private var _topNavBar:TopNavBar;
      private var _userFileLoader:Loader;
      private var _bottomSilverNavGroup:BottomSiverNavGroup;
      
      public function Main()
      {
         _canvas = new HalcyonCanvas(this, _screenWidth, _screenHeight);
         _bg = new McBg();
         _canvas.prepareElementAndPosition(_bg, 0, 0, 0, 0);
         
         _topNavBar = new TopNavBar(_canvas, 1280, 50);
         _topNavBar.addEventListener(TopNavBar.BUTTON_CLICK, onButtonClick, false, 0, true);
         _canvas.prepareElementAndPosition(_topNavBar, 0, NaN, 0, 0);
         
         _bottomSilverNavGroup = new BottomSiverNavGroup(_canvas, 1280, 75);
         _bottomSilverNavGroup.userFileNames = ["City night.jpg", "Nice Office.jpg"];
         _bottomSilverNavGroup.addEventListener(BottomSiverNavGroup.BUTTON_CLICK, onButtonClick, false, 0, true);
         _canvas.prepareElementAndPosition(_bottomSilverNavGroup, NaN, 0, 0, 0);
         
         _userFileLoader = new Loader();
         _userFileLoader.load(new URLRequest("./assets/" + _bottomSilverNavGroup.userFileNames[_bottomSilverNavGroup.selectedFileIndex]));
         _userFileLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadingError);
         _userFileLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileLoadCompleted, false, 0, true);
         
         _canvas.prepareElementAndPosition(_userFileLoader, 80, 115, 40, 40);
         
         this.addChild(_canvas);
      }
      
      private function loadingError(event:IOErrorEvent):void 
      {
         trace(event.text);
      }
      
      private function fileLoadCompleted(event:Event):void
      {
         _topNavBar.fileName = _bottomSilverNavGroup.userFileNames[_bottomSilverNavGroup.selectedFileIndex];
         _canvas.prepareElementAndPosition(_userFileLoader, 60, 95, 20, 20);
      }
      
      private function onButtonClick(layoutEvent:LayoutEvent):void 
      {
         var tweenedButton:TweenedButton = layoutEvent.extra as TweenedButton;
         if(tweenedButton == null) return; 
         if(tweenedButton.icon is McBackButton)
         {
            _bottomSilverNavGroup.selectedFileIndex--;
            _userFileLoader.load(new URLRequest("./assets/" + _bottomSilverNavGroup.userFileNames[_bottomSilverNavGroup.selectedFileIndex]));
         } 
         else if(tweenedButton.icon is McNextButton) 
         {
            _bottomSilverNavGroup.selectedFileIndex++;
            _userFileLoader.load(new URLRequest("./assets/" + _bottomSilverNavGroup.userFileNames[_bottomSilverNavGroup.selectedFileIndex]));
         } 
         else if(tweenedButton.icon is McBwBtn) 
         {
         } 
         else if(tweenedButton.icon is McDownloadButton)
         {
         }
         else if(tweenedButton.icon is McChatBtn)
         {
         }
         else if(tweenedButton.icon is McNotesBtn)
         {
         }
         else if(tweenedButton.icon is McZoomInButton)
         {
         }
         else if(tweenedButton.icon is McZoomOutButton)
         {
         }
         else if(tweenedButton.icon is McZoomFitButton)
         {
         }
         else if(tweenedButton.icon is McPointerButton)
         {
         }
         else if(tweenedButton.icon is McDragButton)
         {
         }
         else if(tweenedButton.icon is McDrawingButton)
         {
         }
         else if(tweenedButton.icon is McCloseButton)
         {
         }
      }
   }
}