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
   
   public class BottomSiverNavGroup extends HalcyonCanvas
   {
      public static const BUTTON_CLICK:String = "buttonClick";
      
      private var _navBar:McNavBar;
      private var _leftButtonsGroup:HalcyonHGroup;
      private var _chatBtn:TweenedButton;
      private var _notesBtn:TweenedButton;
      private var _middleButtonsGroup:HalcyonHGroup;
      private var _previousBtn:TweenedButton;
      private var _pagerLabel:HalcyonLabel;
      private var _nextBtn:TweenedButton;
      private var _divider1:McDiv;
      private var _divider2:McDiv;
      private var _rightButtonsGroup:HalcyonHGroup;
      private var _downloadFileBtn:TweenedButton;
      private var _bwBtn:TweenedButton;
      private var _userFileNames:Array;
      private var _preferredButtonWidth:Number = 32;
      private var _preferredButtonHieght:Number = 32;
      
      private var _totalFiles:int;
      private var _selectedFileIndex:int;
      
      public function BottomSiverNavGroup(reference:DisplayObjectContainer, width:Number=15, height:Number=15)
      {
         super(reference, width, height);
         
         _userFileNames = new Array();
         
         _navBar = new McNavBar();
         this.prepareElementAndPosition(_navBar, 0, 0, 0, 0);
         
         _leftButtonsGroup = new HalcyonHGroup(this);
         _leftButtonsGroup.horizontalgap = 10;
         _chatBtn = new TweenedButton(McChatBtn, _preferredButtonWidth, _preferredButtonHieght);
         _leftButtonsGroup.addChild(_chatBtn);
         _notesBtn = new TweenedButton(McNotesBtn, _preferredButtonWidth, _preferredButtonHieght);
         _leftButtonsGroup.addChild(_notesBtn);
         
         _middleButtonsGroup = new HalcyonHGroup(this);
         _middleButtonsGroup.paddingTop = -8;
         _middleButtonsGroup.horizontalgap = 20;
         _previousBtn = new TweenedButton(McBackButton, 89, 30, true);
         _previousBtn.enabled = false;
         _pagerLabel = new HalcyonLabel();
         _pagerLabel.fontSize = 20;
         _pagerLabel.bold = true;
         _nextBtn = new TweenedButton(McNextButton, 78, 30, true);
         _nextBtn.enabled = false;
         _divider1 = new McDiv();
         _divider2 = new McDiv();
         _middleButtonsGroup.addChild(_previousBtn);
         _middleButtonsGroup.addChild(_divider1);
         _middleButtonsGroup.addChild(_pagerLabel);
         _middleButtonsGroup.addChild(_divider2);
         _middleButtonsGroup.addChild(_nextBtn);
         
         _rightButtonsGroup = new HalcyonHGroup(this, 220);
         _rightButtonsGroup.horizontalgap = 15;
         _downloadFileBtn = new TweenedButton(McDownloadButton, NaN, 30, true);
         _rightButtonsGroup.addChild(_downloadFileBtn);
         _bwBtn = new TweenedButton(McBwBtn, _preferredButtonWidth, 28);
         _rightButtonsGroup.addChild(_bwBtn);
         
         _chatBtn.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _notesBtn.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _previousBtn.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _nextBtn.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _downloadFileBtn.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         _bwBtn.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
         
         this.prepareElementAndPosition(_leftButtonsGroup, 39, NaN, 20, NaN);
         this.prepareElementAndPosition(_middleButtonsGroup, 30, NaN, _navBar.width / 2 - 152, NaN);
         this.prepareElementAndPosition(_rightButtonsGroup, 39, NaN, NaN, 20);
      }
      
      public function get userFileNames():Array
      {
         return _userFileNames;
      }
      
      public function set userFileNames(value:Array):void
      {
         if(value == null) return;
         if(value.length < 1)
         {
            _previousBtn.enabled = false;
            _nextBtn.enabled = false;
         }
         else
            _nextBtn.enabled = true;
         _userFileNames = value;
         _totalFiles = value.length;
         updatePagerLabel();
      }
      
      public function updatePagerLabel():void
      {
         _pagerLabel.label = _selectedFileIndex + 1 + "/" + _totalFiles;
      }
      
      public function set totalFiles(value:int):void
      {
         _totalFiles = value;
      }
      
      public function get selectedFileIndex():int
      {
         return _selectedFileIndex;
      }
      
      public function set selectedFileIndex(value:int):void
      {
         _selectedFileIndex = value;
         if(_selectedFileIndex == 0)
            _previousBtn.enabled = false;
         else if(_selectedFileIndex == _totalFiles - 1)
            _nextBtn.enabled = false;
         updatePagerLabel();
      }
      
      private function onButtonClick(event:Event):void 
      {
         if(event.currentTarget == _previousBtn)
            _nextBtn.enabled = true;
         else (event.currentTarget == _nextBtn)
            _previousBtn.enabled = true;
         var uiEvent:LayoutEvent = new LayoutEvent(BUTTON_CLICK);
         uiEvent.extra = event.currentTarget;
         dispatchEvent(uiEvent);
      }
   }
}