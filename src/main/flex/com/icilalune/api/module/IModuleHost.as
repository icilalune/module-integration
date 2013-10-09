package com.icilalune.api.module {
  import flash.events.IEventDispatcher;

  /**
   * Represents the module's host application.
   * <p>
   * This interface allows a module to access host application properties and
   * events such as the screen size the module can use.
   */
  [Event(type="com.icilalune.api.module.ModuleHostEvent", name="resize")]
  public interface IModuleHost extends IEventDispatcher{

    /**
     * The available width in pixels
     */
    function get hostWidth():Number;

    /**
     * The available height in pixels
     */
    function get hostHeight():Number;

  }
}
