package com.icilalune.api.module {
  import flash.events.IEventDispatcher;

  /**
   * Represents the module's host application.
   * <p>
   * This interface allows a module to access host application properties and
   * events such as the screen size the module can use.
   * <p>
   * Please note that you should not cast moduleHost instances received from
   * the host as it may results in a null value. See Caveats section in the
   * README file.
   *
   * @see ModuleHostWrapper
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
     * Gets the URI resource resolver.
     * <p>
     *
     * @return a resolver instance of null if the host does not provide one.
     */
    function get moduleResourceResolver():IModuleResourceResolver;

  }
}
