// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require cocoon
import "@hotwired/turbo-rails"
import "controllers"
import "@nathanvda/cocoon"
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
import Rails from "@rails/ujs"
import "preview"

Rails.start()