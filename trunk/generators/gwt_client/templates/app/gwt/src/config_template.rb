<?xml version="1.0" encoding="UTF-8"?>
<module>
  <!-- Inherit core GWT -->
  <inherits name='com.google.gwt.user.User'/>

  <!-- Inherit REST-related libraries -->
  <inherits name='com.google.gwt.http.HTTP'/>
  <inherits name='com.google.gwt.json.JSON'/>
  <inherits name='com.kaboomerang.gwt.rest.REST'/>
  
  <!-- Specify the app entry point class.  -->
  <entry-point class='<%= gwt_entry_point %>'/> 
</module>
