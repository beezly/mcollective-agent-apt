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

  end
end
end
