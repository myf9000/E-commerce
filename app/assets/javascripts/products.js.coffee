doSearch = (term, location) ->
  if term.length > 0
    window.location.href = 'http://localhost:3000/products?utf8=✓&search=' + term + '&commit=Search'
  else
    window.location.href = 'http://localhost:3000/products?utf8=✓&search&commit=Search'
  return

jQuery ->
  didSelect = false
  $('#titles').autocomplete(
    source: gon.titles
    minLength: 1
    search: (event, ui) ->
      didSelect = false
      true
    select: (event, ui) ->
      if ui.item
        didSelect = true
        doSearch ui.item.label, ui.item.city
      return
  ).keypress (e) ->
    if e.keyCode == 13
      if !didSelect
        doSearch $('#titles').val()
    return
  return

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


