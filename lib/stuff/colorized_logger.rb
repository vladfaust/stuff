require 'mono_logger' # gem 'mono_logger'
require 'colorized_string' # gem 'colorize'

module Stuff
  class ColorizedLogger
    DEFAULT_LEVEL = MonoLogger::DEBUG
    DEFAULT_PROGNAME = 'LOG'.freeze

    # Available log methods:
    #
    #   info    (green)
    #   warn    (yellow)
    #   success (cyan)
    #   error   (red)
    #   fatal   (red)
    #   debug   (light black background)
    #

    # Creates a new ColorizedMonoLogger
    #
    # @option :level
    # @option :progname
    #
    def initialize(level: DEFAULT_LEVEL, progname: DEFAULT_PROGNAME)
      @logger = MonoLogger.new(STDOUT)
      @logger.level = level
      @logger.progname = progname
      @logger.formatter = proc do |severity, datetime, pname, msg|
        "[#{ severity[0] }] #{ pname }: #{ msg }\n"
      end
      @logger
    end

    %w(debug info warn error fatal success).each do |m|
      define_method m do |message|
        color = case m
        when 'info' then :green
        when 'warn' then :yellow
        when 'success' then :cyan
        end

        background = case m
        when 'error', 'fatal' then :red
        when 'debug' then :light_black
        end

        message = color || background ? ColorizedString.new(message).colorize(color: color, background: background) : message

        _m = m == 'success' ? 'info' : m

        @logger.send(_m, message)
      end
    end
  end
end
