module AccountManagement
  class Configuration
    attr_accessor :account

    def initialize
      self.account = {}
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
    end

  def self.configure
    yield(configuration) if block_given?
  end
end

