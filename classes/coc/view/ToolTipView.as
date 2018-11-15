package coc.view {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	public class ToolTipView extends Block {
		[Embed(source='../../../res/ui/tooltip.png')]
		public static const tooltipBg:Class;
		public var
			bg:Sprite,
			ln:Sprite,
			hd:TextField,
			tf:TextField;

		public function ToolTipView(mainView:MainView) {
			super();

			this.bg = addBitmapDataSprite({
				x:0, y:0,
				width:350,height:239,stretch: true,
				bitmapClass: tooltipBg
			});
			this.ln = addBitmapDataSprite({
				x:15,y:40,
				width:320,height:1,fillColor:'#000000'
			});
			this.hd = addTextField({
				x:15,y:15,
				width:316,height:25.35,
				multiline:true,
				wordWrap:false,
				embedFonts:true,
				defaultTextFormat:{
					size: 18,
					font: CoCButton.BUTTON_LABEL_FONT_NAME
				}
			});
			this.tf = addTextField({
				x:15,y:40,
				width:316,height:176,
				multiline:true,wordWrap:true,
				defaultTextFormat:{
					size:15
				}
			});
		}

		public function showForButton(button:DisplayObject):void {
			var bx:Number = button.x,
				by:Number = button.y;

			bx = (bx >= 688 ? 680: bx);
			this.x = bx - 13;
			var y:Number = by - this.height - 2;
			if (y < 0) y = by + button.height + 6;
			this.y = y;

			this.visible = true;
		}


		public function showForMonster(button:DisplayObject):void {
			var bx:Number = button.x,
				by:Number = button.y;
			this.x = bx + 450;
			this.y = by + 50;
			this.visible = true;
		}
		

		public function hide():void {
			this.visible = false;
		}

		public function set header(newText:String):void {
			this.hd.htmlText = newText || '';
		}

		public function get header():String {
			return this.hd.htmlText;
		}
		
		public function set text(newText:String):void {
			this.tf.htmlText = newText || '';
		}

		public function get text():String {
			return this.tf.htmlText;
		}
	}
}
