package com.icilalune.api.module {
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
      if (stage) {
        stageInitialize();
      } else {
        addEventListener(Event.ADDED_TO_STAGE, function (e:Event):void {
          removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
          stageInitialize();
        });
      }
    }

    /**
     * The current module host.
     */
    protected var moduleHost:IModuleHost;

    /**
     * Gets the actual module width.
     * <p>
     * This property is updated by the resize events coming either form the
     * stage or the module host if available.
     */
    public function get actualWidth():Number {
      if (moduleHost) {
        return moduleHost.hostWidth;
      } else {
        try {
          return stage.stageWidth;
        } catch (e:Error) {
        }
      }
      try {
        return loaderInfo.width;
      } catch (e:Error) {
      }
      return height;
    }

    /**
     * Gets the actual module height.
     * <p>
     * This property is updated by the resize events coming either form the
     * stage or the module host if available.
     */
    public function get actualHeight():Number {
      if (moduleHost) {
        return moduleHost.hostHeight;
      } else {
        try {
          return stage.stageHeight;
        } catch (e:Error) {
        }
      }
      try {
        return loaderInfo.height;
      } catch (e:Error) {
      }
      return height;
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
     * Called when the instance is added to the display list.
     */
    protected function stageInitialize():void {
      if (!moduleHost) {
        try {
          stage.addEventListener(Event.RESIZE, handleStageResize);
        } catch (e:Error) {
        }
      }
    }

    /**
     * Invoked on resize.
     */
    protected function handleResize():void {
    }

    /**
     * Handle stage's resize events.
     * @param event the event object
     */
    protected function handleStageResize(event:Event):void {
      handleResize();
    }

    /**
     * Handle host resize events.
     * @param event the event object
     */
    protected function handleModuleHostResize(event:ModuleHostEvent):void {
      handleResize();
    }

    /**
     * Resolve a resource URI through the module host.
     *
     * @param uri the resource URI
     * @return the converted URI or the same URI if there is no resolver
     */
    protected function resolveURI(uri:String):String{
      if(moduleHost && moduleHost.moduleResourceResolver){
        return moduleHost.moduleResourceResolver.resolveURI(uri);
      }
      return uri;
    }
  }
}
