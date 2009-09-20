begin
	require 'metric_fu'
rescue LoadError
	puts "LoadError while requiring MetricFu."
	puts $!.message
end

if defined? MetricFu
	MetricFu::Configuration.run do |config|
		#define which metrics you want to use
		config.metrics  = [:churn, :saikuro, :stats, :flog, :flay, :reek, :roodi, :rcov]
		config.flay     = { :dirs_to_flay => ['app', 'lib']  }
		config.flog     = { :dirs_to_flog => ['app', 'lib']  }
		config.reek     = { :dirs_to_reek => ['app', 'lib']  }
		config.roodi    = { :dirs_to_roodi => ['app', 'lib'] }
		config.saikuro  = { :output_directory => 'tmp/metric_fu/scratch/saikuro',
												:input_directory => ['app', 'lib'],
												:cyclo => "",
												:filter_cyclo => "0",
												:warn_cyclo => "5",
												:error_cyclo => "7",
												:formater => "text"} #this needs to be set to "text"
		config.churn    = { :start_date => "6 months ago", :minimum_churn_count => 10}
		config.rcov     = { :test_files => ['test/**/*_test.rb', 'spec/**/*_spec.rb'],
												:rcov_opts => [
													"--sort coverage",
													"--no-html",
													"--text-coverage",
													"--no-color",
													"--profile",
													"--rails",
													"--include test",
													"--exclude /gems/,/Library/,spec"]}
	end
end
