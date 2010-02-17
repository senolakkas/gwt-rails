# Copyright (c) 2007, 2008 Jon Crosby. All rights reserved.
# Portions Copyright 2010 Sean Laurent. All rights reserved.

require 'fileutils'

namespace :<%= gwt_path_name %> do
  desc "compile java to javascript"
  task :compile => :environment do
    sh "<%= gwt_client_path %>/<%= gwt_name %>-compile"
  end
  
  desc "run <%= gwt_package %> module in hosted mode"
  task :hosted => :environment do
    sh "<%= gwt_client_path %>/<%= gwt_name %>-shell"
  end
  
  desc "clean compiled javascript"
  task :clean => :environment do
    rm_rf("<%= RAILS_ROOT %>/public/gwt/<%= gwt_module %>")
  end
end