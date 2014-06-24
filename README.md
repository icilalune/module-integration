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

Note: You should not cast those objects in your module. See
the Caveats section below. Those interfaces are provided as
documentation purpose only. They are meant to be used on 
the host side only.

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

Platform Caveats
----------------

The Adobe Flash Platform has some caveats when it comes to 
dynamic code loading. Please take a look to Adobe Flash Platform 
documentation.

Long story short : it is advised to treat every reference to
objects retrieved form the host, such as the moduleHost object or
the URL resolver as plain untyped Object classes as class 
definitions may not be shared between module and host, depending
on the loading settings. If the module is loaded in a child or
sibling ApplicationDomain, there's a high probability of any
attempt to cast such objects results to null-references.


