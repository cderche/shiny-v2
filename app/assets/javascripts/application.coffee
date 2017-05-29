#= require pace/pace.min
#= require jquery
#= require jquery_ujs
#= require modernizr.custom
#= require bootstrapv3/js/bootstrap.min
#= require jquery-unveil/jquery.unveil.min
#= require jquery-bez/jquery.bez.min
#= require jquery-ios-list/jquery.ioslist.min
#= require imagesloaded/imagesloaded.pkgd.min
#= require jquery-actual/jquery.actual.min
#= require jquery-scrollbar/jquery.scrollbar.min
#= require jquery-inputmask/jquery.inputmask.min.js
#= require pages
#= require turbolinks
#= require_tree .

$(document).on 'turbolinks:load', ->
  $('[data-pages="sidebar"]').sidebar()
  return
