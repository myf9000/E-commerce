jQuery ->
  $('#product_subcategory').parent().hide()
  states = $('#product_subcategory').html()
  $('#product_category').change ->
    country = $('#product_category :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(states).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#product_subcategory').html(options)
      $('#product_subcategory').parent().show()
    else
      $('#product_subcategory').empty()
      $('#product_subcategory').parent().hide()