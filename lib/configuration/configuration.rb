require 'set'
require 'etc'

module Capistrano

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= ::Capistrano::Configuration.new
    yield(configuration)
  end

  class Configuration

    #
    # These are lazy_evaluated, please
    # see the documentation inline
    #
    lattr_accessor :deploy_as
    lattr_accessor :scm
    lattr_accessor :stages
    lattr_accessor :default_stage
    lattr_accessor :environment_variable
    lattr_accessor :environment
    
    # This doesn't need to be lazy-evaluated, 
    # as Highline takes care of that when using
    # a function that might require color.
    attr_accessor :color

    def initialize
      @deploy_as            = Etc.getlogin
      @scm                  = ::Capistrano::Scm::Git
      @stages               = Set.new(['production', 'staging'])
      @default_stage        = 'production'
      @environment_variable = 'RACK_ENV'
      @environment          = lambda do
                                { 
                                  @environment_variable => 'production',
                                  'PATH'                => '/usr/bin:/bin:/usr/sbin'
                                }
                              end
      @color                = true
      
    end

  end

end