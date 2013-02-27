module MCollective
  module Agent
    class Apt<RPC::Agent
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
      
      def update_action
        reply[:status] = run("apt-get -q update", :stdout => :out, :stderr => :err, :environment => {'DEBCONF_FRONTEND' => 'noninteractive'})
        reply.fail "Error",1 unless reply[:status] == 0
      end
      
      def upgrade_action
        reply[:status] = run("apt-get -q -y upgrade", :stdout => :out, :stderr => :err, :environment => {'DEBCONF_FRONTEND' => 'noninteractive'})
        reply.fail "Error",1 unless reply[:status] == 0
      end
      
      def distupgrade_action
        reply[:status] = run("apt-get -q -y dist-upgrade", :stdout => :out, :stderr => :err, :environment => {'DEBCONF_FRONTEND' => 'noninteractive'})
        reply.fail "Error",1 unless reply[:status] == 0
      end
      
      def install_action
        reply[:status] = run("apt-get -q -y install #{request.data[:package]}", :stdout => :out, :stderr => :err, :environment => {'DEBCONF_FRONTEND' => 'noninteractive'})
        reply.fail "Error",1 unless reply[:status] == 0
      end
      
      def remove_action
        reply[:status] = run("apt-get -q -y remove #{request.data[:package]}", :stdout => :out, :stderr => :err, :environment => {'DEBCONF_FRONTEND' => 'noninteractive'})
        reply.fail "Error",1 unless reply[:status] == 0
      end
    end
  end
end
