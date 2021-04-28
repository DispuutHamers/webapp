/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'jquery'
import 'bootstrap/dist/js/bootstrap';
import 'core-js/stable'
import 'nprogress'
import 'regenerator-runtime/runtime'
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import Flatpickr from 'stimulus-flatpickr'
import '@fortawesome/fontawesome-free/js/all'
import 'bootstrap-select/dist/js/bootstrap-select';
import Tablesort from 'tablesort'

const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
application.register('flatpickr', Flatpickr)

document.addEventListener("turbolinks:load", function() {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
        $("tr[data-link]").click(function() {
            window.location = $(this).data("link")
        })

        const tables = document.getElementsByClassName('tablesorter');
        for (let t of tables) {
            new Tablesort(t);
        }
    })
})