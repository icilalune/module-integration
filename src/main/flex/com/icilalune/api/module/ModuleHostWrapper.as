package com.icilalune.api.module {
  import flash.events.Event;

  /**
   * Wraps a IModuleHost instance and provide convenience methods.
   * <p>
   * This is class aims at remove the burden of handling untyped access
   * to moduleHost references as casting those references is strongly
   * discouraged to avoid cross ApplicationDomain issues.
   * <p>
   * See Caveats section in the README file.
   *
   * @see IModuleHost
   */
  public class ModuleHostWrapper implements IModuleHost {

    /**
     * The reference to the received moduleHost.
     */
    private var _moduleHost:*;

    private var _resourceResolverWrapper:ModuleHostResourceResolverWrapper;

    /**
     * Create a new wrapper from the given moduleHost.
     *
     * @param moduleHost a module host instance.
     */
    public function ModuleHostWrapper(moduleHost:*) {
      this._moduleHost = moduleHost;
    }

    /**
     * Invoke the given method on the moduleHost and return the result.
     *
     * @param fnName the function to invoke
     * @return the result or null if the function doesn't exist or if any
     * error occur
     */
    private function invokeReturn(fnName:String):*{
      try{
        if (_moduleHost && _moduleHost[fnName] is Function) {
          return _moduleHost[fnName];
        }
      } catch (e:Error) {
        // TODO log some debugging information
      }
      return null;
    }

    /**
     * @inheritDoc
     */
    public function get hostWidth():Number {
      return invokeReturn("hostWidth");
    }

    /**
     * @inheritDoc
     */
    public function get hostHeight():Number {
      return invokeReturn("hostHeight");
    }

    /**
     * @inheritDoc
     */
    public function get moduleResourceResolver():IModuleResourceResolver {
      if(!_resourceResolverWrapper){
        var hostResolver:* = invokeReturn("moduleResourceResolver");
        if(hostResolver){
          _resourceResolverWrapper = new ModuleHostResourceResolverWrapper(hostResolver);
        }
      }
      return _resourceResolverWrapper;
    }

    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
      _moduleHost.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
      _moduleHost.removeEventListener(type, listener, useCapture);
    }

    public function dispatchEvent(event:Event):Boolean {
      return _moduleHost.dispatchEvent(event);
    }

    public function hasEventListener(type:String):Boolean {
      return _moduleHost.hasEventListener(type);
    }

    public function willTrigger(type:String):Boolean {
      return _moduleHost.willTrigger(type);
    }

    public function get moduleHost():* {
      return _moduleHost;
    }
  }
}
