# copyright: 2020, Urs Voegele

title "check dnsmasq installation"

# check standard user
control "dnsmasq-1.0" do                    # A unique ID for this control
  impact 1.0                                # The criticality, if this control fails.
  title "check if dnsmasq is installed"     # A human-readable title
  desc "check dnsmasq"
  describe packages(/dnsmasq/) do           # The actual test
    its('statuses') { should cmp 'installed' } 
  end
end
