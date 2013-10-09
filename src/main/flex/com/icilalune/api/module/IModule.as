package com.icilalune.api.module {
  /**
   * This interface is meant to be implemented by module main class.
   * <p>
   * It provides methods to allow module host to communicate information and
   * callbacks to the module.
   */
  public interface IModule {

    /**
     * Called by the host upon initialization.
     *
     * @param host bridge to the host
     */
    function moduleInitialize(moduleHost:IModuleHost):void;

    /**
     * Called by the host upon destruction.
     */
    function moduleDispose():void;

  }
}
