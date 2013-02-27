module MCollective
  module Agent
    class Apt<RPC::Agent
      activate_when do
        Facts["osfamily"] == 'Debian'
      end
      
      def apt_run cmdline
        out=`#{cmdline}`.split "\n"
      end

      def waiting_updates
        out=apt_run 'apt-get -q -s dist-upgrade'
        operations = []
        out.each do |line|
          match=line.match /^(\S+) (\S+) (\[(\S+)\] )?\((\S+) (\S+):(\S+)\/(\S+) \[(\S+)\]\)/
          if match then
            operations << { :operation => match[1],
                            :package => match[2],
                            :old_version => match[4],
                            :new_version => match[5],
                            :vendor => match[6],
                            :distribution => match[7],
                            :source => match[8],
                            :architecture => match[9] }
          end
        end
        operations.select { |x| x[:operation] == 'Inst' }
      end
          
      def get_upgrades_action
        reply.data[:packages] = waiting_updates
      end
      
      def standard_apt_action action
        reply[:status] = run(action, :stdout => :out, :stderr => :err, :environment => {'DEBCONF_FRONTEND' => 'noninteractive'})
        reply.fail "Error",1 unless reply[:status] == 0
      end
      
      def update_action
        standard_apt_action "apt-get -q update"
      end
      
      def upgrade_action
        standard_apt_action "apt-get -q -y upgrade"
      end
      
      def distupgrade_action
        standard_apt_action "apt-get -q -y dist-upgrade"
      end
      
      def install_action
        standard_apt_action "apt-get -q -y install #{request.data[:package]}"
      end
      
      def remove_action
        standard_apt_action "apt-get -q -y remove #{request.data[:package]}"
      end
    end
  end
end
