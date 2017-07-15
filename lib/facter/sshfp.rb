Facter.add("ssh_dsa_fp") do
    confine :kernel => "Linux"
    fqdn=Facter.value("fqdn")
    setcode do
        # good practice is to allways test for a file's existence
        if File.exists? '/etc/ssh/ssh_host_dsa_key.pub'
            fp = %x[ssh-keygen -f /etc/ssh/ssh_host_dsa_key.pub -r #{fqdn} | cut -d ' ' -f 6]
            if not fp
                "unknown"
            else
                fp
            end
        else
            "unknown"
        end
    end
end

Facter.add(:ssh_rsa_fp) do
    confine :kernel => "Linux"
    setcode do
        # good practice is to allways test for a file's existence
        if File.exists? '/etc/ssh/ssh_host_rsa_key.pub'
            fqdn=Facter.value("fqdn")
            fp = %x[ssh-keygen -f /etc/ssh/ssh_host_rsa_key.pub -r #{fqdn} | cut -d ' ' -f 6]
            if not fp
                "unknown"
            else
                fp
            end
        else
            "unknown"
        end
    end
end
