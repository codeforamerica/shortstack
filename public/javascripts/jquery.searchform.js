(function($)
{
  var methods = {
    'init': function(options)
    {
      return this.each(function(index, element)
      {
        var timeout, needle;
        var $this = $(this);

        var settings = $.extend({}, sf.options);
        if ( options )  $.extend(settings, options);

        methods.search = settings.buildSearch.call(this);

        $this.find('input').keyup(function(event)
        {
          if ( needle != this.value )
          {
            needle = this.value;
            clearTimeout(timeout);

            timeout = setTimeout(function()
            {
              methods.search(needle)
            }, settings.timeout);

            settings.meanwhile();
          }
        });
      });
    }
  }

  var sf = function(method)
  {
    if ( methods[method] )
      return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
    else if ( typeof(method) === 'object' )
      return methods.init.apply( this, arguments );
  }

  sf.options = {
    meanwhile: function () {},
    buildSearch: function ()
      {
        return function(query)
        {
          $.get(this.action, escape('search=' + query), null, 'script');
        }
      },
    timeout: 1000
    }

  $.fn.searchform = sf;
})(jQuery);
