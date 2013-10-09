Module Integration
==================

Helper API to build embeddable SWF modules.


Usage
-----

To build an embeddable SWF module, your main class should
implements `com.icilalune.api.module.IModule`, providing the
necessary methods to interact with its host.

When the SWF will be loaded by the host application, the
`moduleInitialize()` method will be invoked, passing an instance
of `com.icilalune.api.module.IModuleHost`.

The `IModuleHost` instance is a bridge to the host application
providing access to properties and allowing the module to
listen to events.

Should the host application want to shut down and unload your
module, it will invoke `moduleDispose()` prior unloading the
code, allowing your module to de-register its event listener
and have a change to save a context, clean up something or
whatever needed.

The `IModuleHost` may provide an
`com.icilalune.api.module.IModuleResourceResolver` which is
responsible for translating context-independent resource
URI to actual loadable URI. It allows you to define portable
URI representation in your data models, such as custom schemes,
and ask the host application to translate it to its actual
representation (real scheme such as file:// or http://).

The provided `com.icilalune.api.module.SpriteModule` may act
as a base class for your module, providing convenience methods
to prepare initialization.

Host Application Runtime
------------------------

The host application honor the following principles.

The initialization method (`moduleInitialize()`) will always be
called prior adding your module to the display list.

Thus, listing to `Event.ADDED` or `Event.ADDED_TO_STAGE` event is
sufficient to trigger startup of your module. Just detect in the
callback if `moduleInitialize()` was called to switch between a
"module" mode and a "standalone" mode.

Platform Caveat
---------------

Please note that this API is heavily based on strongly typed
object and need that its interfaces definitions are shared
between the host application and the plugin.

It basically means that your SWF module and the host application
have to share the same `ApplicationDomain` or be part of linked
`ApplicationDomain`s

Please take a look to Adobe Flash Platform documentation regarding
dynamic code loading.

You could be able to provide module that works with the host
application by providing the exact interface method, without any
strong typing for the argument (use `*` instead). For this
kind of implementation to work, the host application also have
to invoke your methods dynamically, without casting the main
instance to `IModule`.
