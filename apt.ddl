metadata    :name        => "APT Agent",
            :description => "APT Agent",
            :author      => "Andrew Beresford",
            :license     => "GPLv2",
            :version     => "0.1",
            :url         => "https://github.com/beezly/mcollective-apt-agent",
            :timeout     => 90

action "get_upgrades", :description => "Get the total number of packages waiting to be upgraded" do
  display :always

  output :packages, 
    :description => "Packages available to upgrade",
    :display_as => "Packages available to upgrade"
end

["update", "upgrade", "distupgrade"].each do |act|
  action act, :description => "Executes an apt-get #{act}" do
    display :always

    output :out, 
      :description => "Output of apt-get #{act}",
      :display_as  => "Command output"

	output :err,
	  :description => "Errors from apt-get #{act}",
	  :display_as  => "Errors"
  end
end

["install", "remove"].each do |act|
  action act, :description => "#{act.capitalize} a package" do
    input :package,
      :prompt		 => 'Package Name',
	  :description   => "The package to #{act}",
	  :type          => :string,
	  :validation	 => '^[a-zA-Z\-_\d]+$',
	  :maxlength     => 100,
	  :optional      => false
	
	output :out,
	  :description => "Output of apt-get #{act}",
	  :display_as  => "Command output"
	
	output :err,
	  :description => "Errors from apt-get #{act}",
	  :display_as  => "Errors"
  end	
end
