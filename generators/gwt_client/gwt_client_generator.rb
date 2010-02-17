# Copyright (c) 2007, 2008 Jon Crosby. All rights reserved.
# Portions Copyright 2010 Sean Laurent. All rights reserved.

require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'gwt_rails')

class GwtClientGenerator < Rails::Generator::NamedBase
  attr_accessor :gwt_home
  attr_accessor :gwt_entry_point
  attr_accessor :gwt_module
  attr_accessor :gwt_client_path
  attr_accessor :gwt_package
  attr_accessor :gwt_package_path
  attr_accessor :gwt_entry_point_package
  attr_accessor :gwt_client
  attr_accessor :gwt_name
  attr_accessor :gwt_path_name

  # TODO remove unix-y deps in gwt shell, compile, and rake
  
  def initialize(*runtime_args)
    super(*runtime_args)
    @gwt_client = GwtRails::Client.new name
    @gwt_name = gwt_client.name
    @gwt_path_name = gwt_client.path_name
    @gwt_home = args[0]
    @gwt_package = gwt_client.package
    @gwt_package_path = gwt_client.package_path
    @gwt_entry_point_package = gwt_client.entry_point_package
    @gwt_entry_point = gwt_client.entry_point
    @gwt_module = gwt_client.module
    @gwt_client_path = File.join(gwt_client.gwt_root, gwt_client.module)
  end
  
  def gwt_dev_platform
    if RUBY_PLATFORM =~ /mswin|mingw|bccwin|wince/
      'win'
    elsif RUBY_PLATFORM =~ /darwin/
      'mac'
    else
      'linux' # TODO map out possibilities and allow user to override
    end
  end
  
  def manifest
    record do |m|
      m.class_collisions class_name
      
      # create GWT directory structure
      m.directory File.join('app', 'gwt', gwt_module, 'lib')
      m.directory File.join('app', 'gwt', gwt_module, 'src', gwt_package_path, 'client', 'resource')
      
      # generate GWT starter project and module
      m.template "app/gwt/shell_template.rb",
                 "app/gwt/#{gwt_module}/#{gwt_name}-shell",
                 :chmod => 0755
      m.template "app/gwt/compile_template.rb",
                 "app/gwt/#{gwt_module}/#{gwt_name}-compile",
                 :chmod => 0755
      m.template "app/gwt/src/config_template.rb",
                 "app/gwt/#{gwt_module}/src/#{gwt_package_path}/#{gwt_name}.gwt.xml"
      m.template "app/gwt/src/client/entry_point_template.rb",
                 "app/gwt/#{gwt_module}/src/#{gwt_package_path}/client/#{gwt_name}.java"
                 
      # add GWT-REST
      m.file "app/gwt/lib/gwt-rest.jar",
             "app/gwt/#{gwt_module}/lib/gwt-rest.jar"
             
      # build controller, helper and template for GWT module container
      m.template "app/controllers/controller_template.rb",
                 "app/controllers/#{gwt_path_name}_controller.rb"
      m.template "app/helpers/helper_template.rb",
                 "app/helpers/#{gwt_path_name}_helper.rb"
      m.directory File.join('app', 'views', gwt_path_name)
      
      # create GWT bootstrap page
      m.template "app/views/view_template.rb",
                 "app/views/#{gwt_path_name}/index.html.erb"
                 
      # create folder for compiled GWT JavaScript
      m.directory File.join('public', 'gwt', gwt_module)
      
      # create Rake tasks to management development
      m.template "lib/tasks/rake_template.rb",
                 "lib/tasks/#{gwt_path_name}_tasks.rake"
                 
      # mention helpful plugins, etc.
      m.readme "POST_GENERATION_REMINDER"
    end
  end
end
