package com.icilalune.api.module {


  /**
   * Wraps a IModuleResourceResolver instance and provide convenience methods.
   * <p>
   * This is class aims at remove the burden of handling untyped access
   * to resourceResolver references as casting those references is strongly
   * discouraged to avoid cross ApplicationDomain issues.
   * <p>
   * See Caveats section in the README file.
   *
   * @see IModuleResourceResolver
   */
  public class ModuleHostResourceResolverWrapper implements IModuleResourceResolver {
    /**
     * The reference to the received resource resolver.
     */
    private var _resolver:*;


    /**
     * Create a new wrapper from the given resolver.
     *
     * @param resolver a module resource resolver instance.
     */
    public function ModuleHostResourceResolverWrapper(resolver:*) {
      this._resolver = resolver;
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
        if (_resolver && _resolver[fnName] is Function) {
          return _resolver[fnName];
        }
      } catch (e:Error) {
        // TODO log some debugging information
      }
      return null;
    }

    /**
     * @inheritDoc
     */
    public function resolveURI(uri:String):String {
      return invokeReturn("resolveURI");
    }

    public function get resolver():* {
      return _resolver;
    }
  }
}
