require 'puppet/provider/nameservice/objectadd'

Puppet::Type.type(:group).provide :groupadd, :parent => Puppet::Provider::NameService::ObjectAdd do
    desc "Group management via ``groupadd`` and its ilk.  The default
        for most platforms"

    commands :add => "groupadd", :delete => "groupdel", :modify => "groupmod"

    verify :gid, "GID must be an integer" do |value|
        value.is_a? Integer
    end

    def addcmd
        cmd = [command(:add)]
        if gid = @model.should(:gid)
            unless gid == :absent
                cmd << flag(:gid) << gid
            end
        end
        if @model[:allowdupe] == :true
            cmd << "-o"
        end
        cmd << @model[:name]

        return cmd
    end
end

# $Id$
