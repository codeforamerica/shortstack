// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function()
{

  var quick_search_form = $('#quick_search_form');

  if ( quick_search_form )
  {
    quick_search_form.find('input').keyup(function(event)
    {
      $.get(quick_search_form[0].action, quick_search_form.serialize(), null, 'script');
    });
  }
});
