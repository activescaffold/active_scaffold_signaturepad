# frozen_string_literal: true

require 'minitest/autorun'
require 'rails'
require 'action_view'

# Minimal ActiveScaffold interface needed while loading the plugin.
module ActiveScaffold
  class << self
    attr_accessor :javascripts, :stylesheets
  end

  self.javascripts = []
  self.stylesheets = []
end

require 'active_scaffold_signaturepad'
