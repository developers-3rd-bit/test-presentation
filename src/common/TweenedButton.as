package common
{
   import com.greensock.TweenMax;
   
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TweenedButton extends Sprite
   {
      private var _tween:TweenMax;
      private var _icon:Sprite;
      
      public function TweenedButton(argClass:Class, argWidth:Number = 12, argHeight:Number = 12, hasLabel:Boolean = false)
      {
         this.buttonMode = true;
         _icon = new argClass();
         if(hasLabel) 
         {
            var movieClip:MovieClip = _icon.getChildAt(i) as MovieClip;
            for(var i:int=0;i<movieClip.numChildren;i++) 
            {
               var textField:TextField = movieClip.getChildAt(i) as TextField;
               if(textField == null) continue;
               textField.mouseEnabled = false;
            }
         }
         _icon.width = argWidth;
         _icon.height = argHeight;
         this.addChild(_icon);
         this.addEventListener(MouseEvent.ROLL_OVER, onMouseOver, false, 0, true);
         this.addEventListener(MouseEvent.ROLL_OUT, onMouseOut, false, 0, true);
      }
      
      public function get icon():Sprite
      {
         return _icon;
      }
      
      public function set enabled(value:Boolean):void
      {
         if(value)
         {
            this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
            this.mouseEnabled = true;
            this.mouseChildren = false;
            alpha = 1;
         } 
         else 
         {
            this.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            this.mouseEnabled = false;
            this.mouseChildren = false;
            alpha = .4;
         }
         onMouseOut(null);
         this.buttonMode = value;
      }
      
      private function onMouseOver(event:Event):void 
      {
         _tween = TweenMax.to(this, .2, {colorMatrixFilter:{colorize:0x0000ff, amount:.3}});
      }
      
      private function onMouseOut(event:Event):void 
      {
         if(_tween)
            _tween.reverse(false);
      }
   }
}