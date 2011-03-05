// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function($)
{
  var search_form_options = {
    meanwhile: function()
    {
      $('.search_results').html('<p>Searching...</p>');
    },
    buildSearch: function()
    {
      return function()
      {
        form_fields = $(this).serialize();
        if ( $(this).hasClass('quicksearch') )
        {
          form_fields += '&quicksearch=true';
        }
        $.get(this.action, form_fields, null, 'script');
      }
    }
  }

  var search_form = $('#search_form');
  if ( search_form.length > 0 )
  {
    search_form
      .searchform(search_form_options)
      .find('#search_box').dropdown({
        container_div: '#search_container',
        dropdown_div: '#dropdown_search_results',
        childSelector: 'div.search_result'
        });
  }

  var quick_search_form = $('#quick_search_form');
  if ( quick_search_form.length > 0 )
    quick_search_form.searchform(search_form_options);
});
