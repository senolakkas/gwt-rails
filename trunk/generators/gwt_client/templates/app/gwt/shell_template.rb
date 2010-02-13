#!/bin/sh
APPDIR=`dirname $0`;
VENDOR_LIBS="$APPDIR/lib/gwt-rest.jar" # append custom entries here

GWT_HOME="<%= gwt_home %>"
GWT_CP="$GWT_HOME/gwt-user.jar:$GWT_HOME/gwt-dev.jar"

java -cp "$APPDIR/src:$VENDOR_LIBS:$APPDIR/bin:$GWT_CP" com.google.gwt.dev.DevMode -war "<%= RAILS_ROOT %>/public/gwt" "$@" -noserver -port 3000 <%= file_name %>
