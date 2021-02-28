# copyright: 2020, Urs Voegele

title "check dnsmasq installation"

# check dnsmasq service
control "dnsmasq-1.0" do                    # A unique ID for this control
  impact 1.0                                # The criticality, if this control fails.
  title "check if dnsmasq is installed"     # A human-readable title
  desc "check dnsmasq service"
  describe packages(/dnsmasq/) do           # The actual test
    its('statuses') { should cmp 'installed' } 
  end
end

# check dnsmasq configuration
control "dnsmasq-2.0" do                    
  impact 1.0                                
  title "check dnsmasq configuration"     
  desc "check dnsmasq configuration"
  describe command('sudo dnsmasq --test') do
    its('stderr') { should eq "dnsmasq: syntax check OK.\n" }
    its('exit_status') { should eq 0 }
  end
end
