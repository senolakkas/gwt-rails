# Summary #

GWT Rails is a plugin for [Ruby on Rails](http://rubyonrails.org/) that combines the [Google Web Toolkit](http://code.google.com/webtoolkit/) for a front-end presentation layer with Ruby on Rails and RESTful web services on the back end. The goal is to leverage the powerful GWT library for easy-to-build and easy-to-maintain Javascript driven websites without losing the rapid development process provided by Rails.

Currently targets the GWT 2.0.x releases.

# Features #

  * GWT client module generator
  * GWT client model generator
  * Extensions to ActiveRecord to keep the GWT models in sync with the Rails models
  * GWT support for REST via [GWT-REST](http://code.google.com/p/gwt-rest/)
  * Rake tasks to compile GWT code and launch GWT HostedMode

# Planned Features #

  * Migrate from unmaintained [GWT-REST](http://code.google.com/p/gwt-rest/) to [Restlet](http://www.restlet.org)
  * Automatically generated REST handlers
  * Associations between models
  * GWT RPC
  * Automatically generated RPC handlers for common search functionality e.g. find\_by
  * Support for external GWT projects

# Status #

  * Upgrading to support GWT 2.0.x
  * Early alpha state - not production ready

# Installation #

To test out the plugin:

```bash
script/plugin install http://gwt-rails.googlecode.com/svn/trunk```

# Generating a GWT Client #

Run the generate script, passing in the desired name for the new client module as well as the location of the GWT libs:
```bash
script/generate gwt_client modulename /opt/java/libs/gwt-2.0.1```

Compile it:
```bash
rake modulename:compile```

Launch HostedMode:
```bash
rake modulename:hosted```

# Generating Models #

To use an ActiveRecord model on the GWT client side, generate the resource:

```bash
script/generate gwt_resource !ModelName modulename```

Run the migration task to _sync_ the ActiveRecord and GWT models:

```bash
rake db:migrate```

# Notes #

This project is a fork of the unmaintained project [gwt-on-rails](http://code.google.com/p/gwt-on-rails/).