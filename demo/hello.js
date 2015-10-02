goog.provide('hello');

goog.require('goog.soy');
goog.require('hello.templates');

goog.soy.renderElement(document.body, hello.templates.hello);
