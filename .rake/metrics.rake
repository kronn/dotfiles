begin
	require 'metric_fu'
  begin
    require 'RMagick'
  rescue LoadError
    puts "LoadError while requiring RMagick."
    puts $!.message
  end
rescue LoadError
	puts "LoadError while requiring MetricFu."
	puts $!.message
end

if defined? MetricFu
  app_type = ( ENV['TYPE'] || 'rails' ).to_sym
  dirs = ['app', 'lib']

	MetricFu::Configuration.run do |config|
		#define which metrics you want to use
		config.flay     = { :dirs_to_flay => dirs, :minimun_score => 50 }
		config.flog     = { :dirs_to_flog => dirs  }
		config.reek     = { :dirs_to_reek => dirs  }
		config.roodi    = { :dirs_to_roodi => dirs }
		config.saikuro  = { :output_directory => 'tmp/metric_fu/scratch/saikuro',
												:input_directory => dirs,
												:cyclo => "",
												:filter_cyclo => "0",
												:warn_cyclo => "5",
												:error_cyclo => "7",
												:formater => "text"} #this needs to be set to "text"
		config.churn    = { :start_date => "6 months ago", :minimum_churn_count => 10}
    # config.graph_engine = :bluff

    # differences between metriced code
    case app_type
    when :lib
      # config.metrics  = [:churn, :saikuro, :flog, :flay, :reek, :roodi, :rcov]
      # config.graphs   = ( defined? RMagick ) ? [:flog, :flay, :reek, :roodi, :rcov] : []
      config.metrics  = [:churn, :saikuro, :flog, :flay, :roodi, :rcov]
      config.graphs   = ( defined? Magick ) ? [:flog, :flay, :roodi] : []
      config.rcov   = { :environment => 'test', :test_files => ['**/test_*.rb', '**/spec_*.rb'],
        :rcov_opts => [ "--sort coverage", "--no-html", "--text-coverage", "--no-color",
          "--profile", "--include test", "--exclude /gems/,/Library/,spec"]
      }
    else # :rails
      config.metrics  = [:churn, :saikuro, :stats, :flog, :flay, :reek, :roodi, :rcov]
      config.graphs   = ( defined? RMagick ) ? [:flog, :flay, :reek, :roodi, :rcov] : []
      config.rcov   = { :environment => 'test', :test_files => ['test/**/*_test.rb', 'spec/**/*_spec.rb'],
        :rcov_opts => [ "--sort coverage", "--no-html", "--text-coverage", "--no-color",
          "--profile", "--rails", "--include test", "--exclude /gems/,/Library/,spec"]
      }
    end
  end
end
