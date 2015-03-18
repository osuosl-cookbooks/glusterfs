require 'serverspec'

set :backend, :exec

describe package('glusterfs-server') do
  it { should be_installed }
end

describe service('glusterd') do
  it { should be_enabled }
  it { should be_running }
end
