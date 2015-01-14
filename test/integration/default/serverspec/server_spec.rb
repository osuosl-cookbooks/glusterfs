require 'serverspec'

set :backend, :exec

%w( glusterfs-epel glusterfs-noarch-epel ).each do |r|
  describe yumrepo(r) do
    it { should exist }
    it { should be_enabled }
  end
end

%w( glusterfs glusterfs-fuse ).each do |p|
  describe package(p) do
    it { should be_installed }
  end
end
