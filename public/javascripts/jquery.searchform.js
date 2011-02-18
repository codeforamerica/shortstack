// searchform (add this to a form)
(function($)
{
  var methods = {
    'init': function(options)
    {
      return this.each(function(index, element)
      {
        var timeout,
            needle = '',
            self = this,
           $this = $(this);

        var settings = $.extend({}, sf.options);
        if ( options )  $.extend(settings, options);

        $this.data('searchform', settings);
        settings.search = settings.buildSearch.call(self);

        $this.find('input').keyup(function(event)
        {
          if ( needle != this.value )
          {
            needle = this.value;
            clearTimeout(timeout);

            timeout = setTimeout(function()
            {
              settings.search.call(self);
            }, settings.timeout);

            settings.meanwhile.call(self);
          }
        });
      });
    },
    'search': function()
    {
      var settings = this.data('searchform');
      settings.search.call(this);
    }
  }

  var sf = function(method)
  {
    if ( methods[method] )
      return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
    else if ( typeof(method) === 'object' )
      return methods.init.apply( this, arguments );
    else
      $.error("Searchform: I don't know what you mean by ( " + method + ")");
  }

  sf.options = {
    meanwhile: function() {},
    buildSearch: function()
      {
        return function()
        {
          $.get(this.action, $(this).serialize(), null, 'script');
        }
      },
    timeout: 1000
    }

  $.fn.searchform = sf;
})(jQuery);

// dropdown (add this to an input)
(function($)
{
  var methods = {
    'init': function(options)
    {
      return this.each(function(index, element)
      {
        var settings = $.extend({}, dropdown.options),
            $this = $(this),
            self = this;
        if ( options )  $.extend(settings, options);

        settings._container = $(settings.container_div);
        settings._container.addClass('dropdown_container');
        settings._dropdown = $(settings.dropdown_div);
        settings._dropdown.hide().addClass('dropdown_dropdown');

        $this.data('dropdown', settings);

        $this.bind('focus.dropdown', function(event)
        {
          settings._dropdown.show();

          $(document).bind('click.dropdown', function(event)
          {
            var container = $(event.target).parents('.dropdown_container');
            if ( container.length == 0 || container[0] != settings._container[0] )
            {
              settings._dropdown.hide();
              $(this).unbind(event);
            }
          });
        }).bind('keydown.dropdown', function(event)
        {
          if ( event.keyCode == 27 )
          {
            settings._dropdown.hide();
          }
        });
      });
    },
    'show': function()
    {
      var settings = this.data('dropdown');
      settings.show();
    },
    'hide': function()
    {
      var settings = this.data('dropdown');
      settings.hide();
    },
  }

  var dropdown = function(method)
  {
    if ( methods[method] )
      return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
    else if ( typeof(method) === 'object' )
      return methods.init.apply( this, arguments );
    else
      $.error("Dropdown: I don't know what you mean by ( " + method + ")");
  }

  dropdown.options = {
    }

  $.fn.dropdown = dropdown;
})(jQuery);
