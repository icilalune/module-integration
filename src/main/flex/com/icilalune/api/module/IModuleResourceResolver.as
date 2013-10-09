package com.icilalune.api.module {

  /**
   * Defines a resolver able to convert a context-independent URI to its actual
   * loadable counterpart.
   */
  public interface IModuleResourceResolver {
    /**
     * Resolve a resource URI to a real host URI.
     * <p>
     * Asks the module host to convert a context-independent URI to its actual
     * context-dependant counterpart.
     *
     * @param uri the source URI
     * @return the actual loadable URI
     */
    function resolveURI(uri:String):String;
  }
}
