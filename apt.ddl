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
