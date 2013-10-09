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

    /**
     * Resolve a resource URI to a real host URI.
     * <p>
     * Asks the module host to convert a context-independant URI to its actual
     * context-dependant counterpart.
     *
     * @param uri the source URI
     * @return the actual loadable URI
     */
    function resolveURI(uri:String):String;

  }
}
