#
# Cookbook Name:: glusterfs
# Recipe:: default
#
# Copyright (C) 2014 Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

g = node['glusterfs']
minor_version = g['version'] == 'LATEST' ? nil : 'LATEST'
base_url = 'http://download.gluster.org/pub/gluster/glusterfs' \
           "/#{g['version']}/#{minor_version}/EPEL.repo/epel-$releasever"

# Gluster packages to remove if you need an older version
gluster_remove_pkgs = %w(
  glusterfs
  glusterfs-api
  glusterfs-api-devel
  glusterfs-cli
  glusterfs-debuginfo
  glusterfs-devel
  glusterfs-extra-xlators
  glusterfs-fuse
  glusterfs-geo-replication
  glusterfs-libs
  glusterfs-rdma
  glusterfs-regression-tests
  glusterfs-server
)

# Exclude glusterfs from distro repo
%w(base updates extras centosplus contrib).each do |repo|
  excludes = 'glusterfs* ' + node['yum'][repo]['exclude'].to_s
  node.override['yum'][repo]['exclude'] = excludes
end

case node['platform_family']
when 'rhel'
  include_recipe 'yum-centos' unless node['platform'] == 'redhat'
end

yum_repository 'glusterfs-epel' do
  repositoryid 'glusterfs-epel'
  description "GlusterFS upstream $basearch #{g['version']} repo"
  url "#{base_url}/$basearch"
  gpgkey 'http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/pub.key'
  action :create
end

yum_repository 'glusterfs-noarch-epel' do
  repositoryid 'glusterfs-noarch-epel'
  description "GlusterFS upstream noarch #{g['version']} repo"
  url "#{base_url}/noarch"
  gpgkey 'http://download.gluster.org/pub/gluster/glusterfs/LATEST/EPEL.repo/pub.key'
  action :create
end

# If the version is specified, make sure we install that version and not
# something newer.
unless g['version'] == 'LATEST'
  gluster_remove_pkgs.each do |p|
    # XXX: this is a minor hack. We need a way to bump the version by one point
    # to do this correctly.
    package "#{p} >= #{g['version']}.9999" do
      action :remove
    end
  end
end

# Install client libs
%w( glusterfs glusterfs-fuse ).each do |p|
  package p
end
