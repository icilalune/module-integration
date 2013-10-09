package com.icilalune.api.module.impl {
  import com.icilalune.api.module.IModule;
  import com.icilalune.api.module.IModuleHost;
  import com.icilalune.api.module.ModuleHostEvent;

  import flash.display.Sprite;
  import flash.events.Event;

  /**
   * Helper base class to implements a module.
   * <p>
   * Subclasses of this module can run in standalone mode and when loaded from
   * a IModuleHost.
   */
  public class SpriteModule extends Sprite implements IModule {

    /**
     * Initialize a new SpriteModule
     */
    public function SpriteModule() {
      if(stage){
        stageInitialize();
      }else{
        addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void{
          removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
          stageInitialize();
        });
      }
    }

    /**
     * Called when the instance is added to the display list.
     */
    protected function stageInitialize():void {
      try{
        stage.addEventListener(Event.RESIZE, handleStageResize);
      }catch(e:Error){
      }
    }

    /**
     * Handle stage's resize events.
     * @param event the event object
     */
    protected function handleStageResize(event:Event):void {
      _moduleWidth = stage.stageWidth;
      _moduleHeight = stage.stageHeight;
    }

    /**
     * The current module host.
     */
    protected var moduleHost:IModuleHost;

    /**
     * Stores the actual module width
     */
    private var _moduleWidth:Number;

    /**
     * Gets the actual module width.
     * <p>
     * This property is updated by the resize events coming either form the
     * stage or the module host if available.
     */
    public function get moduleWidth():Number {
      return _moduleWidth;
    }

    private var _moduleHeight:Number;

    /**
     * Gets the actual module height.
     * <p>
     * This property is updated by the resize events coming either form the
     * stage or the module host if available.
     */
    public function get moduleHeight():Number {
      return _moduleHeight;
    }

    /**
     * Initialize this module bridge to its host.
     *
     * @param moduleHost the host application
     */
    public function moduleInitialize(moduleHost:IModuleHost):void {
      this.moduleHost = moduleHost;
      if (moduleHost) {
        moduleHost.addEventListener(ModuleHostEvent.RESIZE, handleModuleHostResize);
      }
    }

    /**
     * Unregister the current module host.
     */
    public function moduleDispose():void {
      if (moduleHost) {
        moduleHost.removeEventListener(ModuleHostEvent.RESIZE, handleModuleHostResize);
      }
      moduleHost = null;
    }

    /**
     * Handle host resize events.
     * @param event the event object
     */
    protected function handleModuleHostResize(event:ModuleHostEvent):void {
      _moduleWidth = moduleHost.hostWidth;
      _moduleHeight = moduleHost.hostHeight;
    }
  }
}
