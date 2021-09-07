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
import Rails from '@rails/ujs';
import 'core-js/stable'
import 'regenerator-runtime/runtime'
import "@hotwired/turbo-rails"
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import '@fortawesome/fontawesome-free/js/all'
import 'trix';
import "./application"

Rails.start();

const application = Application.start()
const context = require.context("controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

// Other options: Alert, Autosave, Dropdown, Modal, Popover, Toggle, Slideover
import { Dropdown, Tabs } from "tailwindcss-stimulus-components"
application.register('dropdown', Dropdown)
application.register('tabs', Tabs)

document.addEventListener("turbo:load", function () {
    $(function () {
        $("tr[data-link]").on("click", function () {
            Turbo.visit($(this).data("link"))
        });
    });
});

