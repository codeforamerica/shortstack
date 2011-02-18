// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function($)
{
  var quick_search_form = $('#quick_search_form');

  if ( quick_search_form )
  {
    var search_form_options = {
      meanwhile: function()
      {
        $('#search_results').html('<p>Searching...</p>');
      }
    }

    quick_search_form.searchform(search_form_options);
  }
});
