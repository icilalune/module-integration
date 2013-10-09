package com.icilalune.api.module {
  import flash.events.Event;

  /**
   * Event fired by IModuleHost objects.
   * <p>
   * @see IModuleHost
   */
  public class ModuleHostEvent extends Event {

    /**
     * This event type is fired when module available screen size change.
     */
    public static const RESIZE:String = "resize";

    /**
     * @inheritDoc
     */
    public function ModuleHostEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
    }
  }
}
