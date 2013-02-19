package
{
   import com.halcyon.layout.common.HalcyonCanvas;
   import com.halcyon.layout.common.HalcyonHGroup;
   import com.halcyon.layout.common.HalcyonLabel;
   import com.halcyon.layout.common.LayoutEvent;
   
   import common.TweenedButton;
   
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TopNavBar extends HalcyonCanvas
   {
      public static const BUTTON_CLICK:String = "buttonClick";
      
      private var _navBar:McTopBar;
      private var _logo:McLogo;
      private var _fileName:HalcyonLabel;
      private var _rightButtonsGroup:HalcyonHGroup;
      private var _zoomInButton:TweenedButton;
      private var _zoomOutButton:TweenedButton;
      private var _zoomFitButton:TweenedButton;
      private var _pointerButton:TweenedButton;
      private var _dragButton:TweenedButton;
      private var _drawButton:TweenedButton;
      private var _closeButton:TweenedButton;
      private var _divider1:McDiv;
      private var _divider2:McDiv;
      private var _preferredButtonWidth:Number = 24;
      private var _preferredButtonHieght:Number = 24;
      
      public function TopNavBar(reference:DisplayObjectContainer, width:Number=15, height:Number=15)
      {
         super(reference, width, height);
         _navBar = new McTopBar();
         this.prepareElementAndPosition(_navBar, 0, 0, 0, 0);
         
         _logo = new McLogo();
         this.prepareElementAndPosition(_logo, 8, NaN, 20, NaN);
         
         _fileName = new HalcyonLabel();
         _fileName.fontSize = 20;
         _fileName.bold = true;
         _fileName.label = "PNG.png";
         this.prepareElementAndPosition(_fileName, 8, NaN, (width - _fileName.width - 100) / 2, NaN);
         
         _rightButtonsGroup = new HalcyonHGroup(this, 295);
         _rightButtonsGroup.horizontalgap = 15;
         
         _zoomInButton = new TweenedButton(McZoomInButton, _preferredButtonWidth, _preferredButtonHieght);
         _zoomInButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _rightButtonsGroup.addChild(_zoomInButton);
         
         _zoomOutButton = new TweenedButton(McZoomOutButton, _preferredButtonWidth, _preferredButtonHieght);
         _zoomOutButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _rightButtonsGroup.addChild(_zoomOutButton);
         
         _zoomFitButton = new TweenedButton(McZoomFitButton, _preferredButtonWidth, _preferredButtonHieght);
         _zoomFitButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _rightButtonsGroup.addChild(_zoomFitButton);
         
         _divider1 = new McDiv();
         _divider1.height = 28;
         _rightButtonsGroup.addChild(_divider1);
         
         _pointerButton = new TweenedButton(McPointerButton, _preferredButtonWidth, _preferredButtonHieght);
         _pointerButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _rightButtonsGroup.addChild(_pointerButton);
         
         _dragButton = new TweenedButton(McDragButton, _preferredButtonWidth, _preferredButtonHieght);
         _dragButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _rightButtonsGroup.addChild(_dragButton);
         
         _drawButton = new TweenedButton(McDrawingButton, _preferredButtonWidth, _preferredButtonHieght);
         _zoomInButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _rightButtonsGroup.addChild(_drawButton);
         
         _divider2 = new McDiv();
         _divider2.height = 28;
         _rightButtonsGroup.addChild(_divider2);
         
         _closeButton = new TweenedButton(McCloseButton, _preferredButtonWidth, _preferredButtonHieght);
         _closeButton.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _rightButtonsGroup.addChild(_closeButton);
         
         this.prepareElementAndPosition(_rightButtonsGroup, 8, NaN, NaN, 20);
      }
      
      public function set fileName(value:String):void
      {
         if(value == null) value = "";
         _fileName.label = value;
      }
      
      private function onButtonClick(event:Event):void {
         var uiEvent:LayoutEvent = new LayoutEvent(BUTTON_CLICK);
         uiEvent.extra = event.currentTarget;
         dispatchEvent(uiEvent);
      }
   }
}