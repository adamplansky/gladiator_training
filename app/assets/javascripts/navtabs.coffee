$(document).on 'ready page:load', ->
  $('.nav-tabs li').click (e) ->
    $('.nav-tabs li').removeClass 'active'
    $(this).addClass 'active'
